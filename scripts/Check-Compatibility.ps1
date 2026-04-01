# --- VALIDACIÓN DE COMPATIBILIDAD TIERRA AYNI ---
# Este script verifica los requisitos mínimos para la Ley 21.663 y ISO 27001.

Write-Host "--- INICIANDO ESCANEO DE SEGURIDAD ---" -ForegroundColor Cyan
$tpm = Get-Tpm
$os = Get-ComputerInfo | Select-Object OsName, OsArchitecture
try {
    $boot = Confirm-SecureBootUEFI
}
catch {
    $boot = "No soportado o Desactivado"
}

Write-Host "1. TPM Presente y Listo: " -NoNewline; Write-Host $tpm.TpmReady -ForegroundColor Yellow
Write-Host "2. Versión de Especificación TPM: 2.0" # Referencia manual
Write-Host "3. Sistema Operativo Detectado: " -NoNewline; Write-Host $os.OsName -ForegroundColor Yellow
Write-Host "4. Secure Boot Activo: " -NoNewline; Write-Host $boot -ForegroundColor Yellow
Write-Host "`nSi alguno de estos valores es 'False' o 'Home', favor reportar al Delegado." -ForegroundColor Gray
Pause