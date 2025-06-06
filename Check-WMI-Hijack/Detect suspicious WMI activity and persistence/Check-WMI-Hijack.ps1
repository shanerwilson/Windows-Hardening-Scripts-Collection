# Check-WMI-Hijack.ps1
# Script to detect suspicious WMI hijacking and persistence points on Windows

Write-Host "[!] Starting WMI and Persistence Check..." -ForegroundColor Cyan

# Store anomalies for summary later
$anomalies = @()

# Helper function to record and print anomalies
function Report-Anomaly {
    param($message)
    Write-Host $message -ForegroundColor Red
    $anomalies += $message
}

# Check WMI Event Filters
Write-Host "[*] Checking for WMI Event Filters..."
try {
    $filters = Get-CimInstance -Namespace "root\subscription" -ClassName __EventFilter -ErrorAction Stop
    foreach ($f in $filters) {
        if ($f.Name -match ".*") { # Add your own suspicious pattern if needed
            Report-Anomaly "Suspicious WMI Event Filter: $($f.Name)"
        }
    }
} catch {
    Write-Host "Failed to query WMI Event Filters: $_" -ForegroundColor Yellow
}

# Check WMI Event Consumers
Write-Host "[*] Checking for WMI Event Consumers..."
try {
    $consumers = Get-CimInstance -Namespace "root\subscription" -ClassName __EventConsumer -ErrorAction Stop
    foreach ($c in $consumers) {
        if ($c.Name -match ".*") {
            Report-Anomaly "Suspicious WMI Event Consumer: $($c.Name)"
        }
    }
} catch {
    Write-Host "Failed to query WMI Event Consumers: $_" -ForegroundColor Yellow
}

# Check Filter to Consumer Bindings
Write-Host "[*] Checking for Filter to Consumer Bindings..."
try {
    $bindings = Get-CimInstance -Namespace "root\subscription" -ClassName __FilterToConsumerBinding -ErrorAction Stop
    foreach ($b in $bindings) {
        Report-Anomaly "Suspicious FilterToConsumerBinding found: $($b.Filter) -> $($b.Consumer)"
    }
} catch {
    Write-Host "Failed to query Filter to Consumer Bindings: $_" -ForegroundColor Yellow
}

# Check suspicious WMI namespaces/classes
$namespaces = @("root\subscription","root\default","root\cimv2","root\wmi")
Write-Host "[*] Checking for suspicious namespaces or extra WMI classes..."
foreach ($ns in $namespaces) {
    try {
        $classes = Get-CimClass -Namespace $ns -ErrorAction Stop
        # Example simple check: list classes containing suspicious keywords
        foreach ($class in $classes) {
            if ($class.CimClassName -match "(ActiveScript|EventFilter|CommandLine)") {
                Report-Anomaly "Suspicious WMI Class in ${ns}: $($class.CimClassName)"
            }
        }
    } catch {
        Write-Host "Failed to query namespace ${ns}: $_" -ForegroundColor Yellow
    }
}

# Check startup folders for suspicious executables
$startupPaths = @(
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup",
    "$env:PROGRAMDATA\Microsoft\Windows\Start Menu\Programs\Startup"
)

Write-Host "[*] Checking startup folders..."
foreach ($path in $startupPaths) {
    if (Test-Path $path) {
        $files = Get-ChildItem -Path $path -File -ErrorAction SilentlyContinue
        foreach ($file in $files) {
            if ($file.Extension -match "\.exe|\.bat|\.ps1|\.cmd") {
                Report-Anomaly "Suspicious startup file: $($file.FullName)"
            }
        }
    }
}

# Check common Registry autorun locations
$autorunKeys = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
)

Write-Host "[*] Checking registry autorun keys..."
foreach ($key in $autorunKeys) {
    try {
        $values = Get-ItemProperty -Path $key -ErrorAction Stop
        foreach ($name in $values.PSObject.Properties.Name) {
            $val = $values.$name
            if ($val -match "powershell|wmi|wmic|eventvwr|cmd|schtasks") {
                Report-Anomaly "Suspicious autorun entry in ${key}: $name -> $val"
            }
        }
    } catch {
        Write-Host "Failed to access registry key ${key}: $_" -ForegroundColor Yellow
    }
}

# Check suspicious services running commands involving powershell or wmi
Write-Host "[*] Checking suspicious services..."
try {
    $services = Get-WmiObject -Class Win32_Service -Filter "State='Running'"
    foreach ($svc in $services) {
        if ($svc.PathName -match "powershell|wmiprvse|wmic|eventvwr") {
            Report-Anomaly "Suspicious running service: $($svc.Name) Path: $($svc.PathName)"
        }
    }
} catch {
    Write-Host "Failed to query running services: $_" -ForegroundColor Yellow
}

# Final summary
if ($anomalies.Count -gt 0) {
    Write-Host "`n[!] Anomalies detected:" -ForegroundColor Red
    foreach ($a in $anomalies) {
        Write-Host " - $a" -ForegroundColor Red
    }
} else {
    Write-Host "`n[*] No suspicious anomalies detected." -ForegroundColor Green
}
