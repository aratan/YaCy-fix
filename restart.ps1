@echo off
rem Ejecutar el script de PowerShell para lanzar YaCy
powershell -ExecutionPolicy Bypass -File "./stopYacyByPID.ps1"

# Encuentra el PID que estÃ¡ usando el puerto 8090
$pid = netstat -ano | findstr ":8090" | ForEach-Object {
    # Extrae el PID del proceso
    $_.Split()[-1]
}

# Verifica si se ha encontrado el PID
if ($pid) {
    Write-Host "Deteniendo el proceso con PID: $pid"

    # Mata el proceso usando el PID
    taskkill /PID $pid /F
    Write-Host "Proceso detenido exitosamente."

    # Elimina el archivo de bloqueo y reinicia YaCy
    Remove-Item -Path "./DATA/yacy.running" -Force
    Start-Process -FilePath "./startYACY_debug.bat"
} else {
    Write-Host "No se encontrÃ³ ningÃºn proceso utilizando el puerto 8090."
}
