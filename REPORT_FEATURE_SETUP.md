# Report Feature Setup Guide

## Step 1: Create Reports Table

Run this SQL in your Supabase SQL Editor:

```sql
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

-- Create policy to allow all operations
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
```

Or simply run the file: `supabase/add-reports-table.sql`

## Features

✅ **Report Button** - Three-dot menu on each message
✅ **Report Dialog** - Modal with optional reason field
✅ **One Report Per User** - Each user can only report a message once
✅ **Toast Notifications** - Feedback when reporting
✅ **Database Storage** - All reports saved in Supabase `reports` table
✅ **Visual Feedback** - "Already Reported" shown if user already reported

## How It Works

1. **Click the three-dot menu** (⋯) on any message
2. **Select "Report Message"** from the dropdown
3. **Optional: Add a reason** for reporting
4. **Click "Report"** to submit
5. **Report is saved** to Supabase `reports` table
6. **Toast notification** confirms the report

## Database Schema

### `reports` table
- `id` (UUID) - Primary key
- `message_id` (UUID) - Reference to the reported message
- `session_id` (TEXT) - User's session (prevents duplicate reports)
- `reason` (TEXT) - Optional reason for reporting
- `reported_at` (TIMESTAMPTZ) - When the report was made
- **Unique constraint**: `(message_id, session_id)` - ensures one report per user per message

## Viewing Reports in Supabase

1. Go to your Supabase Dashboard
2. Navigate to **Table Editor** → **reports**
3. You'll see all reported messages with:
   - Message ID
   - Session ID (anonymous user identifier)
   - Reason (if provided)
   - Timestamp

## Admin Features (Future)

You can extend this to:
- Create an admin dashboard to view reports
- Add moderation actions (delete message, ban user, etc.)
- Set up alerts for messages with multiple reports
- Add report categories/types

## That's it! 🎉

Your report feature is now ready. Users can report inappropriate messages, and all reports are stored in Supabase for review.

