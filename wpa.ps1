# Dump saved WPA passphrases
#

$out = netsh.exe wlan show profiles | Select-String "All"

foreach ($line in $out)
{
    $arr = $line -split ':'
    $network = $arr[1]

    $cmd = "netsh.exe wlan show profiles name=" + $network.trim() + " key=clear"
    
    $password = Invoke-Expression $cmd | Select-String "Key Content"
    
    $arr = $password -split ':'
    $result = $network + ":" + $arr[1]

    echo $result
}
