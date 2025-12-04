-- Create reports table
CREATE TABLE IF NOT EXISTS reports (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  message_id UUID NOT NULL REFERENCES messages(id) ON DELETE CASCADE,
  session_id TEXT NOT NULL,
  reason TEXT,
  reported_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(message_id, session_id)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_reports_message_id ON reports(message_id);
CREATE INDEX IF NOT EXISTS idx_reports_reported_at ON reports(reported_at DESC);

-- Enable Row Level Security (RLS)
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;

-- Create policy to allow all operations (since we want anonymous access)
DROP POLICY IF EXISTS "Allow all operations on reports" ON reports;
CREATE POLICY "Allow all operations on reports" ON reports
  FOR ALL
  USING (true)
  WITH CHECK (true);

-- Enable Realtime for reports table (optional - for admin monitoring)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables 
    WHERE pubname = 'supabase_realtime' 
    AND tablename = 'reports'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE reports;
  END IF;
END $$;

