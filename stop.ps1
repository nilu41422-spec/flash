# Flash Feed - Full Stack Stopper
Write-Host ""
Write-Host " ===================================================================" -ForegroundColor Red
Write-Host "                   STOPPING FLASH FEED STACK" -ForegroundColor Red
Write-Host " ===================================================================" -ForegroundColor Red
Write-Host ""

$ports = @(5173, 5000, 8000, 27017)
$names = @{5173='Frontend (Vite)'; 5000='Backend (Express)'; 8000='AI Service (FastAPI)'; 27017='MongoDB'}

foreach ($p in $ports) {
    $conns = Get-NetTCPConnection -LocalPort $p -State Listen -ErrorAction SilentlyContinue
    if ($conns) {
        $pids = $conns.OwningProcess | Select-Object -Unique
        foreach ($id in $pids) {
            try {
                Stop-Process -Id $id -Force -ErrorAction SilentlyContinue
                Write-Host "  * Stopped $($names[$p]) on port $p (PID: $id)" -ForegroundColor Yellow
            } catch {}
        }
    } else {
        Write-Host "  * Port $p is already clear ($($names[$p]))" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host " ===================================================================" -ForegroundColor Green
Write-Host "                  ALL FLASH FEED SERVICES STOPPED" -ForegroundColor Green
Write-Host " ===================================================================" -ForegroundColor Green
Write-Host ""
