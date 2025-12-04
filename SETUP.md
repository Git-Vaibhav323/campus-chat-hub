# Quick Setup Guide

## 🚀 Getting Started

### Step 1: Install Dependencies
```bash
npm install
```

### Step 2: Start the Application

You have two options:

#### Option A: Run Both Servers Together (Recommended)
```bash
npm run dev:all
```
This will start both the frontend (port 8081) and backend (port 3000) servers.

#### Option B: Run Servers Separately

**Terminal 1 - Backend:**
```bash
npm run dev:server
```

**Terminal 2 - Frontend:**
```bash
npm run dev
```

### Step 3: Open Your Browser
Navigate to: **http://localhost:8081**

## ✨ Features

- ✅ **No Login Required** - Username is auto-generated when you open the app
- ✅ **Real-time Chat** - Messages appear instantly for all users
- ✅ **Persistent Storage** - Messages are saved in SQLite database
- ✅ **Auto-cleanup** - Messages older than 1 week are automatically deleted
- ✅ **Online Users** - See how many people are currently online

## 📝 How It Works

1. When you open the app, you're automatically assigned a unique username (e.g., "MysticPhoenix1234")
2. Type a message and press Enter or click Send
3. Your message appears instantly for all connected users
4. All messages are stored in the database
5. Messages older than 1 week are automatically deleted

## 🔧 Troubleshooting

### Server won't start
- Make sure port 3000 is not in use
- Check that all dependencies are installed: `npm install`

### Frontend can't connect to backend
- Make sure the backend server is running on port 3000
- Check the browser console for connection errors
- Verify `VITE_SOCKET_URL` in your `.env` file (if using custom URL)

### Database errors
- The database file (`server/chat.db`) is created automatically
- If you encounter issues, delete `server/chat.db` and restart the server

## 📦 Production Build

To build for production:
```bash
npm run build
```

The built files will be in the `dist` directory.

