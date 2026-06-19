# 🏀 BBA Stats

Full-stack web app to track and manage live statistics for **BBA** basketball league games — teams, players, plays and box scores.

Built as a real-world full-stack project: a **Ruby on Rails 7 API** backend with JWT auth, paired with a **React** single-page frontend.

## Stack

- **Backend** — Ruby on Rails 7 (API mode) · PostgreSQL · Devise + devise-jwt (JWT auth) · rack-cors
- **Frontend** — React · React Router · Axios · react-dnd (drag & drop) · react-youtube

## What it does

- Track teams, players and individual plays per game
- Live scoring and box-score style stats
- Drag-and-drop play management
- Embedded game footage via YouTube
- Token-based (JWT) authentication

## Running locally

**Backend (Rails API)**
```bash
cd backend
bundle install
rails db:setup
rails s
```

**Frontend (React)**
```bash
cd frontend
npm install
npm start
```

---

🇩🇴 Proyecto personal para llevar las estadísticas de los juegos de la liga BBA. Backend en Rails 7 (API) + frontend en React, con autenticación JWT.
