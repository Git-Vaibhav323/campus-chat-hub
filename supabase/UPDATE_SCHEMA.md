# Update Database Schema for Comments and Votes

## Step 1: Run the Updated Schema

Go to your Supabase SQL Editor and run the contents of `supabase/schema-with-comments.sql`.

This will create:
- `comments` table - for storing comments on messages
- `message_votes` table - for storing likes/dislikes on messages
- Indexes for performance
- Realtime subscriptions for both tables

## Step 2: Enable Realtime for New Tables

After running the schema, enable Realtime for the new tables:

```sql
-- Enable Realtime for comments table
ALTER PUBLICATION supabase_realtime ADD TABLE comments;

-- Enable Realtime for message_votes table
ALTER PUBLICATION supabase_realtime ADD TABLE message_votes;
```

## Step 3: Verify

Check that all tables are in Realtime:

```sql
SELECT tablename 
FROM pg_publication_tables 
WHERE pubname = 'supabase_realtime'
ORDER BY tablename;
```

You should see:
- comments
- message_votes
- messages
- users

## That's it! 🎉

Your database is now ready for comments and voting functionality!

