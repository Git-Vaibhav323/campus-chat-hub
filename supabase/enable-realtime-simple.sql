-- Simple version - just run these two commands
-- If you get an error that table is already added, that's fine - it means it's already enabled!

-- Enable Realtime for messages table
ALTER PUBLICATION supabase_realtime ADD TABLE messages;

-- Enable Realtime for users table
ALTER PUBLICATION supabase_realtime ADD TABLE users;

-- Verify (optional - to check if it worked)
SELECT tablename 
FROM pg_publication_tables 
WHERE pubname = 'supabase_realtime'
ORDER BY tablename;

