# Flash Feed - Full Stack PowerShell Launcher
Write-Host ""
Write-Host " ===================================================================" -ForegroundColor Cyan
Write-Host "                FLASH FEED - FULL STACK LAUNCHER" -ForegroundColor Cyan
Write-Host " ===================================================================" -ForegroundColor Cyan
Write-Host ""

$root = $PSScriptRoot
Set-Location $root

# Ensure Node.js and system tools are in PATH
$env:Path = "C:\Program Files\nodejs;" + [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

function Test-PortListening ($port) {
    $conn = Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue
    return ($null -ne $conn)
}

# 1. MongoDB (Port 27017)
Write-Host "[1/4] Checking MongoDB (Port 27017)..." -ForegroundColor Yellow
if (Test-PortListening 27017) {
    Write-Host "      * MongoDB is already running on port 27017." -ForegroundColor Green
} else {
    Write-Host "      * Starting local MongoDB instance..." -ForegroundColor Gray
    if (-not (Test-Path "$root\mongodb_data")) {
        New-Item -ItemType Directory -Path "$root\mongodb_data" | Out-Null
    }
    Start-Process -FilePath "$root\mongodb_bin\MongoDB\Server\8.2\bin\mongod.exe" -ArgumentList "--dbpath `"$root\mongodb_data`" --bind_ip 127.0.0.1 --port 27017" -WindowStyle Minimized
    Start-Sleep -Seconds 3
}

# 2. AI Service (Port 8000)
Write-Host "[2/4] Checking AI Service (Port 8000)..." -ForegroundColor Yellow
if (Test-PortListening 8000) {
    Write-Host "      * AI Service is already running on port 8000." -ForegroundColor Green
} else {
    Write-Host "      * Starting FastAPI AI Service..." -ForegroundColor Gray
    Start-Process -FilePath "cmd.exe" -ArgumentList "/k title Flash Feed - AI Service && cd /d `"$root\ai-service`" && `"$root\ai-service\venv\Scripts\python.exe`" -m uvicorn main:app --host 127.0.0.1 --port 8000"
    Start-Sleep -Seconds 2
}

# 3. Backend (Port 5000)
Write-Host "[3/4] Checking Backend API (Port 5000)..." -ForegroundColor Yellow
if (Test-PortListening 5000) {
    Write-Host "      * Backend server is already running on port 5000." -ForegroundColor Green
} else {
    Write-Host "      * Starting Express Backend server..." -ForegroundColor Gray
    Start-Process -FilePath "cmd.exe" -ArgumentList "/k title Flash Feed - Backend && cd /d `"$root\flash-feed-backend`" && node server.js"
    Start-Sleep -Seconds 2
}

# 4. Frontend (Port 5173)
Write-Host "[4/4] Checking Frontend (Port 5173)..." -ForegroundColor Yellow
if (Test-PortListening 5173) {
    Write-Host "      * Frontend is already running on port 5173." -ForegroundColor Green
} else {
    Write-Host "      * Starting Vite Frontend dev server..." -ForegroundColor Gray
    Start-Process -FilePath "cmd.exe" -ArgumentList "/k title Flash Feed - Frontend && cd /d `"$root\flash-feed-frontend`" && npm.cmd run dev"
    Start-Sleep -Seconds 3
}

Write-Host ""
Write-Host " ===================================================================" -ForegroundColor Green
Write-Host "                    ALL SERVICES ARE RUNNING!" -ForegroundColor Green
Write-Host " ===================================================================" -ForegroundColor Green
Write-Host "  * Web App:       http://localhost:5173" -ForegroundColor White
Write-Host "  * Backend API:   http://localhost:5000" -ForegroundColor White
Write-Host "  * AI Docs:       http://localhost:8000/docs" -ForegroundColor White
Write-Host "  * Database:      mongodb://127.0.0.1:27017/ai_news_db" -ForegroundColor White
Write-Host ""
Write-Host "  * Default Login:" -ForegroundColor Cyan
Write-Host "    - Email:    test@example.com" -ForegroundColor White
Write-Host "    - Password: password123" -ForegroundColor White
Write-Host ""
Write-Host "  (To stop all services anytime, run .\stop.ps1 or stop.bat)" -ForegroundColor Gray
Write-Host " ===================================================================" -ForegroundColor Green
Write-Host ""

Start-Process "http://localhost:5173"
