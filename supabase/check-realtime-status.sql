-- Check which tables have Realtime enabled
-- Run this to see the current status

SELECT 
  schemaname, 
  tablename 
FROM pg_publication_tables 
WHERE pubname = 'supabase_realtime'
ORDER BY tablename;

-- If you see both 'messages' and 'users', you're all set! ✅
-- If you only see 'messages', run the users command below

