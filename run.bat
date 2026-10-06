@echo off
setlocal enabledelayedexpansion
title Flash Feed - Launcher
color 0b

echo.
echo  ===================================================================
echo                   FLASH FEED - FULL STACK LAUNCHER
echo  ===================================================================
echo.

set "ROOT=%~dp0"
cd /d "%ROOT%"

:: Ensure Node.js and system tools are in PATH
set "PATH=C:\Program Files\nodejs;%SystemRoot%\System32;%SystemRoot%;%PATH%"

:: 1. Check & Start MongoDB (Port 27017)
echo [1/4] Checking MongoDB (Port 27017)...
netstat -ano | findstr ":27017 " | findstr "LISTENING" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo       * MongoDB is already running on port 27017.
) else (
    echo       * Starting local MongoDB instance...
    if not exist "%ROOT%mongodb_data" mkdir "%ROOT%mongodb_data"
    start "Flash Feed - MongoDB" /min "%ROOT%mongodb_bin\MongoDB\Server\8.2\bin\mongod.exe" --dbpath "%ROOT%mongodb_data" --bind_ip 127.0.0.1 --port 27017
    ping -n 4 127.0.0.1 >nul
)

:: 2. Check & Start AI Service (Port 8000)
echo [2/4] Checking AI Service (Port 8000)...
netstat -ano | findstr ":8000 " | findstr "LISTENING" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo       * AI Service is already running on port 8000.
) else (
    echo       * Starting FastAPI AI Service...
    start "Flash Feed - AI Service" cmd /k "title Flash Feed - AI Service && cd /d "%ROOT%ai-service" && "%ROOT%ai-service\venv\Scripts\python.exe" -m uvicorn main:app --host 127.0.0.1 --port 8000"
    ping -n 3 127.0.0.1 >nul
)

:: 3. Check & Start Backend API (Port 5000)
echo [3/4] Checking Backend API (Port 5000)...
netstat -ano | findstr ":5000 " | findstr "LISTENING" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo       * Backend server is already running on port 5000.
) else (
    echo       * Starting Express Backend server...
    start "Flash Feed - Backend" cmd /k "title Flash Feed - Backend && cd /d "%ROOT%flash-feed-backend" && node server.js"
    ping -n 3 127.0.0.1 >nul
)

:: 4. Check & Start Frontend (Port 5173)
echo [4/4] Checking Frontend (Port 5173)...
netstat -ano | findstr ":5173 " | findstr "LISTENING" >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo       * Frontend server is already running on port 5173.
) else (
    echo       * Starting Vite Frontend dev server...
    start "Flash Feed - Frontend" cmd /k "title Flash Feed - Frontend && cd /d "%ROOT%flash-feed-frontend" && npm.cmd run dev"
    ping -n 4 127.0.0.1 >nul
)

echo.
echo  ===================================================================
echo                     ALL SERVICES ARE RUNNING!
echo  ===================================================================
echo.
echo   * Web App:       http://localhost:5173
echo   * Backend API:   http://localhost:5000
echo   * AI Docs:       http://localhost:8000/docs
echo   * Database:      mongodb://127.0.0.1:27017/ai_news_db
echo.
echo   * Default Login:
echo     - Email:    test@example.com
echo     - Password: password123
echo.
echo   (To stop all services anytime, run stop.bat)
echo  ===================================================================
echo.

start http://localhost:5173

ping -n 4 127.0.0.1 >nul
exit /b 0
