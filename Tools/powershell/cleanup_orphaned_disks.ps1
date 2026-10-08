<#
.SYNOPSIS
    Automates the detection and reporting of orphaned, unattached Azure Managed Disks.
.DESCRIPTION
    This script establishes a secure session context with a specified Azure subscription,
    queries the tenant for all managed virtual hard disks, isolates those with an
    'Unattached' operational state, logs their details to an output trail, and presents 
    a structured array for billing optimization.
.NOTES
    Directory: JASPER/Tools/powershell/
    Use Case: Azure Cloud Governance & Cost Optimization (AZ-104 Alignment)
#>

# Enforce strict error handling parameters
$ErrorActionPreference = "Stop"

# Define local auditing parameters
$LogPath = "$HOME\jasper_azure_audit.log"
Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [INFO] - Starting J.A.S.P.E.R. Cloud Resource Audit..." | Out-File -FilePath $LogPath -Append

# 🔄 Step 1: Pre-flight Module & Connection Verification
Write-Output "[*] Verifying local Azure Az.Compute module dependencies..."
if (-not (Get-Module -ListAvailable -Name Az.Compute)) {
    Write-Error "[ERROR] The required Microsoft Azure 'Az.Compute' module is missing. Run 'Install-Module Az' to initialize."
    exit 1
}

# 🚧 Step 2: Querying the Azure Tenant Environment
Write-Output "[*] Fetching global Managed Disk allocation matrix..."
try {
    # Query all managed disks across the active subscription scope
    $AllDisks = Get-AzDisk
    $OrphanedDisks = @()
    
    # Filter for disks that are completely disconnected from any active VM node
    foreach ($Disk in $AllDisks) {
        if ($Disk.DiskState -eq "Unattached") {
            $DiskDetails = [PSCustomObject]@{
                DiskName      = $Disk.Name
                ResourceGroup = $Disk.ResourceGroupName
                SizeGB        = $Disk.DiskSizeGB
                StorageSku    = $Disk.Sku.Name
                Location      = $Disk.Location
            }
            $OrphanedDisks += $DiskDetails
        }
    }
}
catch {
    Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [ERROR] - Failed to query Azure resource tables. Verify login context." | Out-File -FilePath $LogPath -Append
    throw $_
}

# 📊 Step 3: Presenting Audit Output Analytics
if ($OrphanedDisks.Count -eq 0) {
    Write-Output "[SUCCESS] Zero unattached resources discovered. Tenant cost footprints optimized."
    Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [SUCCESS] - Tenant sweep complete. No leaks found." | Out-File -FilePath $LogPath -Append
} else {
    Write-Output "`n[!] ATTENTION: Discovered ($($OrphanedDisks.Count)) Orphaned Cloud Disks silently draining infrastructure budget:"
    Write-Output "--------------------------------------------------------------------------------"
    $OrphanedDisks | Format-Table -AutoSize
    Write-Output "--------------------------------------------------------------------------------"
    
    # Log findings to local storage archive
    foreach ($OrphanedDisk in $OrphanedDisks) {
        Write-Output "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [WARN] - Orphaned Resource Found: Name=$($OrphanedDisk.DiskName) | RG=$($OrphanedDisk.ResourceGroup) | Size=$($OrphanedDisk.SizeGB)GB" | Out-File -FilePath $LogPath -Append
    }
    Write-Output "[+] Detailed audit logs compiled at: $LogPath"
}
