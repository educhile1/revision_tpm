# --- VALIDACIÓN DE COMPATIBILIDAD TIERRA AYNI ---
# Este script verifica los requisitos mínimos para la implementacuón de politicas de seguridad TA

Write-Host "`n--- INICIANDO ESCANEO DE SISTEMA Y SEGURIDAD ---" -ForegroundColor Cyan

# --- INFORMACIÓN DE SEGURIDAD ---
$tpm = Get-Tpm
$os = Get-ComputerInfo | Select-Object OsName, OsArchitecture
try {
    $boot = Confirm-SecureBootUEFI
}
catch {
    $boot = "No soportado o Desactivado"
}

# --- INFORMACIÓN DE HARDWARE ---
$cpu = (Get-CimInstance Win32_Processor | Select-Object -First 1 -Property Name).Name
$totalRam = [Math]::Round((Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1GB)
$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object @{Name = "SizeGB"; Expression = { [Math]::Round($_.Size / 1GB) } }, @{Name = "FreeGB"; Expression = { [Math]::Round($_.FreeSpace / 1GB) } }

# --- SALIDA DE DATOS ---
Write-Host "`n[SEGURIDAD]" -ForegroundColor Gray
Write-Host "1. TPM Presente y Listo: " -NoNewline; Write-Host $tpm.TpmReady -ForegroundColor Yellow
Write-Host "2. Versión de Especificación TPM: 2.0" 
Write-Host "3. Sistema Operativo Detectado: " -NoNewline; Write-Host $os.OsName -ForegroundColor Yellow
Write-Host "4. Secure Boot Activo: " -NoNewline; Write-Host $boot -ForegroundColor Yellow

Write-Host "`n[HARDWARE]" -ForegroundColor Gray
Write-Host "5. Procesador: " -NoNewline; Write-Host $cpu -ForegroundColor Yellow
Write-Host "6. Memoria RAM Total: " -NoNewline; Write-Host "$totalRam GB" -ForegroundColor Yellow
Write-Host "7. Disco (C:): " -NoNewline; Write-Host "$($disk.SizeGB) GB Totales ($($disk.FreeGB) GB Libres)" -ForegroundColor Yellow

Write-Host "`n Envia tu resultado con un pantallazo al correo de Eduardo." -ForegroundColor Gray
Pause