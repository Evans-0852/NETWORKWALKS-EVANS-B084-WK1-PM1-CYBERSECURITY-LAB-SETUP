# Applies lab settings to the Kali VM. Power the VM off first.
param([string]$VmName = "Kali_Machine")
$vbm = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

& $vbm modifyvm $VmName --nic1 natnetwork --nat-network1 NatNetwork --nicpromisc1 allow-all --cableconnected1 on
& $vbm modifyvm $VmName --clipboard-mode bidirectional --drag-and-drop bidirectional
& $vbm sharedfolder add $VmName --name Downloads --hostpath "$env:USERPROFILE\Downloads" --automount

& $vbm showvminfo $VmName --machinereadable | Select-String "nic1|natnet1|clipboard|draganddrop|SharedFolder"
