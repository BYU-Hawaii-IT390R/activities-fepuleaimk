#### **For VirtualBox:** (`build-vbox.ps1`)

# Set variables for paths and VM name
$VBoxManage = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
$VMName = "AutomatedWin10"
$VDIFile = "C:\ISO Folder\AutomatedWin10.vdi"
$ISOFile = "C:\ISO Folder\en-us_windows_10_consumer_editions_version_22h2_x64_dvd_8da72ab3.iso"
$AnswerFile = "C:\ISO Folder\answer.iso"

# Create a new virtual machine
& $VBoxManage createvm --name $VMName --register

# Modify VM settings: memory, CPUs, and OS type
& $VBoxManage modifyvm $VMName --memory 4096 --cpus 2 --ostype "Windows10_64"

# Create a virtual hard drive
& $VBoxManage createmedium disk --filename $VDIFile --size 40000

# Add SATA controller and attach virtual hard drive
& $VBoxManage storagectl $VMName --name "SATA Controller" --add sata --controller IntelAhci
& $VBoxManage storageattach $VMName --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $VDIFile

# Add IDE controller and attach ISO files
& $VBoxManage storagectl $VMName --name "IDE Controller" --add ide
& $VBoxManage storageattach $VMName --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $ISOFile
& $VBoxManage storageattach $VMName --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium $AnswerFile

# Start the virtual machine
& $VBoxManage startvm $VMName
