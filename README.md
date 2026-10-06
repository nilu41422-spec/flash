# Flash Feed ⚡

Flash Feed is an AI-powered personalized news aggregation and discovery platform built with React 19, Tailwind CSS v4, Node.js Express, Python FastAPI, and MongoDB.

---

## 🚀 Quick Start (1-Click Run)

To start the entire application stack:

### Windows Command Prompt / File Explorer:
Double-click or run:
```bat
run.bat
```

### PowerShell:
```powershell
.\run.ps1
```

The script will automatically:
1. Verify and start **MongoDB** on port `27017` (data persisted in `mongodb_data/`).
2. Verify and start **AI Service (FastAPI)** on port `8000`.
3. Verify and start **Backend API (Node.js Express)** on port `5000`.
4. Verify and start **Frontend Web App (Vite React)** on port `5173`.
5. Open your default web browser directly to `http://localhost:5173`.

---

## 🛑 How to Stop the Project

To stop all running services cleanly:

### Windows Command Prompt / File Explorer:
Double-click or run:
```bat
stop.bat
```

### PowerShell:
```powershell
.\stop.ps1
```

---

## 🔑 Login Credentials

The local database comes preloaded with an active user account:
- **Email:** `test@example.com`
- **Password:** `password123`

You can also register a new account from the Sign Up page at `http://localhost:5173/register`.

---

## 🌐 Services & Ports

| Service | Technology | Port / URL | Description |
| :--- | :--- | :--- | :--- |
| **Frontend** | React 19 + Vite + Tailwind CSS v4 | [http://localhost:5173](http://localhost:5173) | Responsive web client with light/dark theme |
| **Backend API** | Node.js Express | [http://localhost:5000](http://localhost:5000) | REST API, Auth, News management, MongoDB models |
| **AI Service** | Python FastAPI + Gemini Embeddings | [http://localhost:8000](http://localhost:8000) (Docs at `/docs`) | Semantic recommendations, summary, embeddings |
| **Database** | MongoDB 8.2 | `mongodb://127.0.0.1:27017/ai_news_db` | News articles, user profiles, likes, bookmarks |

---

## 📁 Project Structure

```
D:\Flash Feed\
├── run.bat                   # 1-Click launcher (Batch)
├── run.ps1                   # 1-Click launcher (PowerShell)
├── stop.bat                  # 1-Click stopper (Batch)
├── stop.ps1                  # 1-Click stopper (PowerShell)
├── README.md                 # Project documentation
│
├── flash-feed-frontend/      # React 19 + Tailwind v4 Web Client
│   ├── src/
│   │   ├── context/          # ThemeContext, AuthContext, LikedContext, BookmarkContext
│   │   ├── component/        # Header, Sidebar, Card, ThemeSwitcher, etc.
│   │   ├── pages/            # Home, Article, Trending, SavedNews, History, Profile
│   │   └── index.css         # Tailwind v4 theme tokens & dark variant
│   └── package.json
│
├── flash-feed-backend/       # Express.js REST API
│   ├── models/               # Article, User, History schemas
│   ├── routes/               # Auth, Article, Recommendation routes
│   ├── .env                  # Backend configuration (PORT, MONGO_URI, JWT_SECRET)
│   └── server.js             # Server entry point
│
├── ai-service/               # Python FastAPI Recommendation Engine
│   ├── venv/                 # Pre-configured Python virtual environment
│   ├── services/             # Gemini embeddings (384-dim) & cosine similarity
│   ├── .env                  # AI Service configuration
│   └── main.py               # FastAPI entry point
│
├── mongodb_bin/              # Portable MongoDB 8.2 binaries
└── mongodb_data/             # Local database data files
```

---

## 🎨 Features
- **Instant Dark / Light Mode:** Fully adaptive high-contrast theme with persistent storage in `localStorage`.
- **AI-Powered Summarization & Tags:** Key takeaways and topic extraction.
- **Smart Recommendations:** Semantic vector embeddings using Google Gemini.
- **Personalized Feed:** Tracks reading history, bookmarks, and likes.
- **Original Source Links:** Click through to publishers directly from article view.
