@echo off
title Flash Feed - Stopper
color 0c

echo.
echo  ===================================================================
echo                   STOPPING FLASH FEED STACK
echo  ===================================================================
echo.

powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "$ports = @(5173, 5000, 8000, 27017); " ^
    "$names = @{5173='Frontend (Vite)'; 5000='Backend (Express)'; 8000='AI Service (FastAPI)'; 27017='MongoDB'}; " ^
    "foreach ($p in $ports) { " ^
    "    $conns = Get-NetTCPConnection -LocalPort $p -State Listen -ErrorAction SilentlyContinue; " ^
    "    if ($conns) { " ^
    "        $pids = $conns.OwningProcess | Select-Object -Unique; " ^
    "        foreach ($id in $pids) { " ^
    "            try { " ^
    "                Stop-Process -Id $id -Force -ErrorAction SilentlyContinue; " ^
    "                Write-Host \"  * Stopped $($names[$p]) on port $p (PID: $id)\" -ForegroundColor Yellow; " ^
    "            } catch {} " ^
    "        } " ^
    "    } else { " ^
    "        Write-Host \"  * Port $p is already clear ($($names[$p]))\" -ForegroundColor Gray; " ^
    "    } " ^
    "}"

echo.
echo  ===================================================================
echo                  ALL FLASH FEED SERVICES STOPPED
echo  ===================================================================
echo.
ping -n 3 127.0.0.1 >nul
exit /b 0
