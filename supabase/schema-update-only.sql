-- This script adds only the new tables (comments and votes) to existing schema
-- Run this if you already have the base schema set up

-- Create comments table
CREATE TABLE IF NOT EXISTS comments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  username TEXT NOT NULL,
  content TEXT NOT NULL,
  avatar_color TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create votes table (for likes/dislikes on messages)
CREATE TABLE IF NOT EXISTS message_votes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  session_id TEXT NOT NULL,
  vote_type TEXT NOT NULL CHECK (vote_type IN ('like', 'dislike')),
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(message_id, session_id)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_comments_message_id ON comments(message_id);
CREATE INDEX IF NOT EXISTS idx_comments_created_at ON comments(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_message_votes_message_id ON message_votes(message_id);
CREATE INDEX IF NOT EXISTS idx_message_votes_session_id ON message_votes(session_id);

-- Enable Row Level Security (RLS)
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE message_votes ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if they exist, then create new ones
DROP POLICY IF EXISTS "Allow all operations on comments" ON comments;
DROP POLICY IF EXISTS "Allow all operations on message_votes" ON message_votes;

-- Create policies to allow all operations (since we want anonymous access)
CREATE POLICY "Allow all operations on comments" ON comments
  FOR ALL
  USING (true)
  WITH CHECK (true);

CREATE POLICY "Allow all operations on message_votes" ON message_votes
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- Enable Realtime for comments table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables 
    WHERE pubname = 'supabase_realtime' 
    AND tablename = 'comments'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE comments;
  END IF;
END $$;

-- Enable Realtime for message_votes table
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables 
    WHERE pubname = 'supabase_realtime' 
    AND tablename = 'message_votes'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE message_votes;
  END IF;
END $$;

