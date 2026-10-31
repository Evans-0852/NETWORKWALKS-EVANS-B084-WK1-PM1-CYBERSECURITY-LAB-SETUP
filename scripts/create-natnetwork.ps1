# Creates the lab NAT Network. Run in PowerShell on the host.
# Note: DHCP is on, so make sure no VM is ever leased an address you assigned by hand (e.g. 10.0.0.2).
$vbm = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
$name = "NatNetwork"
$cidr = "10.0.0.0/24"

if (& $vbm list natnetworks | Select-String "NetworkName:\s+$name") {
    Write-Host "$name already exists."
} else {
    & $vbm natnetwork add --netname $name --network $cidr --enable --dhcp on
}
& $vbm list natnetworks
