-- If messages is already enabled but users is not, run this:

-- Enable Realtime for users table
ALTER PUBLICATION supabase_realtime ADD TABLE users;

-- Then verify with:
SELECT tablename 
FROM pg_publication_tables 
WHERE pubname = 'supabase_realtime'
ORDER BY tablename;

