# Variables (edit these paths as needed)
$vmName     = "AutomatedWin10"
$vhdPath    = "C:\ISO Folder\AutomatedWin10.vhdx"
$windowsISO = "C:\ISO Folder\en-us_windows_10_consumer_editions_version_22h2_x64_dvd_8da72ab3.iso"
$answerISO  = "C:\ISO Folder\answer.iso"
$vmMemory   = 2GB  # Reduced memory allocation to 2 GB

# Create a new dynamic VHDX (40 GB)
New-VHD -Path $vhdPath -SizeBytes 40GB -Dynamic

# Create a Generation 2 VM with specified memory and attach the VHDX
New-VM -Name $vmName -Generation 2 -MemoryStartupBytes $vmMemory -VHDPath $vhdPath

# Start the VM to initialize it
Start-VM -Name $vmName

# Now modify firmware settings (Disable Secure Boot)
Set-VMFirmware -VMName $vmName -EnableSecureBoot Off

# Attach the Windows installation ISO and the answer file ISO
Add-VMDvdDrive -VMName $vmName -Path $windowsISO
Add-VMDvdDrive -VMName $vmName -Path $answerISO

# Start the VM (if not already started) to initiate installation
Start-VM -Name $vmName
