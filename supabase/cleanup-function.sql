-- This function deletes messages and users older than 7 days
-- You can call this via Supabase Edge Functions or set up a cron job

CREATE OR REPLACE FUNCTION cleanup_old_data()
RETURNS json AS $$
DECLARE
  deleted_messages INTEGER;
  deleted_users INTEGER;
BEGIN
  -- Delete messages older than 7 days
  DELETE FROM messages 
  WHERE created_at < NOW() - INTERVAL '7 days';
  GET DIAGNOSTICS deleted_messages = ROW_COUNT;

  -- Delete users not seen in 7 days
  DELETE FROM users 
  WHERE last_seen < NOW() - INTERVAL '7 days';
  GET DIAGNOSTICS deleted_users = ROW_COUNT;

  RETURN json_build_object(
    'deleted_messages', deleted_messages,
    'deleted_users', deleted_users,
    'timestamp', NOW()
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Grant execute permission
GRANT EXECUTE ON FUNCTION cleanup_old_data() TO anon, authenticated;

