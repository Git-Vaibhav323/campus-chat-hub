# Supabase Setup Guide

## 🚀 Quick Setup

### Step 1: Create a Supabase Project

1. Go to [https://supabase.com](https://supabase.com)
2. Sign up or log in
3. Click "New Project"
4. Fill in your project details:
   - **Name**: campus-chat-hub (or any name you prefer)
   - **Database Password**: Choose a strong password (save it!)
   - **Region**: Choose the closest region to your users
5. Click "Create new project"
6. Wait for the project to be created (takes ~2 minutes)

### Step 2: Get Your API Keys

1. In your Supabase project dashboard, go to **Settings** → **API**
2. Copy the following:
   - **Project URL** (this is your `VITE_SUPABASE_URL`)
   - **anon/public key** (this is your `VITE_SUPABASE_ANON_KEY`)

### Step 3: Set Up Database Schema

1. In your Supabase dashboard, go to **SQL Editor**
2. Click "New query"
3. Copy and paste the contents of `supabase/schema.sql`
4. Click "Run" to execute the SQL
5. This will create:
   - `users` table
   - `messages` table
   - Indexes for performance
   - Row Level Security policies
   - Realtime subscriptions

### Step 4: Enable Realtime

1. Go to **Database** → **Replication** in your Supabase dashboard
2. Enable replication for both `messages` and `users` tables
3. This enables real-time updates

### Step 5: Set Up Environment Variables

Create a `.env` file in the root of your project:

```env
VITE_SUPABASE_URL=https://your-project-id.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here
```

Replace with your actual values from Step 2.

### Step 6: Set Up Auto-Cleanup (Optional but Recommended)

You have two options:

#### Option A: Supabase Edge Function (Recommended)

1. Go to **Edge Functions** in your Supabase dashboard
2. Create a new function called `cleanup-old-data`
3. Use the code from `supabase/cleanup-edge-function.ts` (create this file)
4. Set up a cron job to call it daily

#### Option B: External Cron Job

Use a service like [cron-job.org](https://cron-job.org) to call:
```
POST https://your-project-id.supabase.co/rest/v1/rpc/cleanup_old_data
```

With headers:
```
apikey: your-anon-key
Authorization: Bearer your-anon-key
```

## ✅ Verify Setup

1. Install dependencies:
```bash
npm install
```

2. Start the app:
```bash
npm run dev
```

3. Open http://localhost:8081
4. You should see the chat interface
5. Try sending a message - it should appear instantly!

## 🔧 Troubleshooting

### "Missing Supabase environment variables"
- Make sure your `.env` file exists in the root directory
- Check that variable names start with `VITE_`
- Restart your dev server after adding environment variables

### "Failed to fetch messages"
- Check that you've run the SQL schema in Supabase
- Verify your API keys are correct
- Check the browser console for detailed error messages

### "Realtime not working"
- Go to **Database** → **Replication** in Supabase dashboard
- Make sure replication is enabled for `messages` table
- Check that Realtime is enabled in your project settings

### Messages not syncing fast enough
- Supabase Realtime is already very fast (sub-second latency)
- Make sure you're using the latest version of `@supabase/supabase-js`
- Check your network connection

## 📊 Database Schema

### `users` table
- `id` (UUID) - Primary key
- `session_id` (TEXT) - Unique session identifier
- `username` (TEXT) - Auto-generated username
- `avatar_color` (TEXT) - Avatar color class
- `created_at` (TIMESTAMPTZ) - Creation timestamp
- `last_seen` (TIMESTAMPTZ) - Last activity timestamp

### `messages` table
- `id` (UUID) - Primary key
- `username` (TEXT) - Username who sent the message
- `content` (TEXT) - Message content
- `avatar_color` (TEXT) - Avatar color class
- `created_at` (TIMESTAMPTZ) - Creation timestamp

## 🎯 Benefits of Supabase

- ⚡ **Faster sync** - Sub-second real-time updates
- ☁️ **Cloud database** - No local files, accessible from anywhere
- 📈 **Scalable** - Handles thousands of concurrent users
- 🔒 **Secure** - Built-in authentication and security
- 🗑️ **Auto-cleanup** - Easy to set up scheduled cleanup jobs
- 📱 **Mobile ready** - Works on all devices

## 💰 Pricing

Supabase has a generous free tier:
- 500 MB database
- 2 GB bandwidth
- 50,000 monthly active users
- Perfect for development and small projects

For production with more users, check their [pricing page](https://supabase.com/pricing).

