param (
    [string]$Action,
    [string]$Param1,
    [string]$Param2
)

function Add-LocalUser {
    param ($Username)
    if (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue) {
        Write-Output "User '$Username' exist."
    } else {
        New-LocalUser -Name $Username -NoPassword
        Write-Output "User '$Username' added successfully."
    }
}

function Check-Service {
    param ($ServiceName)
    $svc = Get-Service -Name $ServiceName -ErrorAction SilentlyContinue
    if ($null -ne $svc) {
        Write-Output "Service '$ServiceName' status: $($svc.Status)"
    } else {
        Write-Output "Service '$ServiceName' didnt find."
    }
}

function Take-Backup {
    param (
        [string]$Source,
        [string]$Destination
    )

    if (-not (Test-Path $Source)) {
        Write-Error "❌ Source folder did not find: $Source"
        return
    }

    if (-not (Test-Path $Destination)) {
        New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    }

    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupPath = Join-Path $Destination "backup_$timestamp.zip"

    try {
        Compress-Archive -Path "$Source\*" -DestinationPath $backupPath -Force
        Write-Host "✅ Backup is done: $backupPath"
    } catch {
        Write-Error "❌ ZIP could not create file!"
    }
}

switch ($Action) {
    "adduser" { Add-LocalUser -Username $Param1 }
    "checkservice" { Check-Service -ServiceName $Param1 }
    "backup" { Take-Backup -Source $Param1 -Destination $Param2 }
    default {
        Write-Output "To use:"
        Write-Output "  .\myscript.ps1 adduser <user_name>"
        Write-Output "  .\myscript.ps1 checkservice <service_name>"
        Write-Output "  .\myscript.ps1 backup <source_folder> <destination_folder>"
    }
}
