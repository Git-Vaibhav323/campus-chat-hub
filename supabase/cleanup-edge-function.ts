// Supabase Edge Function for cleaning up old data
// Deploy this to Supabase Edge Functions and set up a cron job

import { serve } from "https://deno.land/std@0.168.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

const corsHeaders = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Headers":
    "authorization, x-client-info, apikey, content-type",
};

serve(async (req) => {
  // Handle CORS preflight
  if (req.method === "OPTIONS") {
    return new Response("ok", { headers: corsHeaders });
  }

  try {
    // Create Supabase client
    const supabaseClient = createClient(
      Deno.env.get("SUPABASE_URL") ?? "",
      Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? ""
    );

    // Delete messages older than 7 days
    const sevenDaysAgo = new Date();
    sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);
    const isoDate = sevenDaysAgo.toISOString();

    const { data: deletedMessages, error: messagesError } = await supabaseClient
      .from("messages")
      .delete()
      .lt("created_at", isoDate)
      .select();

    // Delete users not seen in 7 days
    const { data: deletedUsers, error: usersError } = await supabaseClient
      .from("users")
      .delete()
      .lt("last_seen", isoDate)
      .select();

    if (messagesError || usersError) {
      throw new Error(
        `Cleanup error: ${messagesError?.message || usersError?.message}`
      );
    }

    return new Response(
      JSON.stringify({
        success: true,
        deleted_messages: deletedMessages?.length || 0,
        deleted_users: deletedUsers?.length || 0,
        timestamp: new Date().toISOString(),
      }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 200,
      }
    );
  } catch (error) {
    return new Response(
      JSON.stringify({
        success: false,
        error: error.message,
      }),
      {
        headers: { ...corsHeaders, "Content-Type": "application/json" },
        status: 500,
      }
    );
  }
});

