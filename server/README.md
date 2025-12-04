# Chat Server

Real-time chat server using Express, Socket.io, and SQLite.

## Features

- Real-time messaging with Socket.io
- Auto-generated usernames (no login required)
- SQLite database for message persistence
- Automatic cleanup of messages older than 1 week
- User presence tracking

## Setup

1. Install dependencies:
```bash
npm install
```

2. Start the server:
```bash
npm run dev:server
```

The server will run on port 3000 by default.

## Environment Variables

- `PORT` - Server port (default: 3000)
- `FRONTEND_URL` - Frontend URL for CORS (default: http://localhost:8081)

## Database

The server uses SQLite and automatically creates a `chat.db` file in the server directory.

Tables:
- `messages` - Stores all chat messages
- `users` - Stores user information (auto-generated usernames)

## Data Retention

Messages and inactive users are automatically deleted after 1 week. The cleanup job runs every hour.

