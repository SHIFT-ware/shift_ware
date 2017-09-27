### UnZip Scripts ###

$Expcom = New-Object -ComObject Shell.Application

$changed = ""

$zipFile = $Expcom.NameSpace($args[0])

if ( $zipFile -eq $Null ) {
    $changed = "failed"
    echo $changed
    exit 1
}

$tgtDir = $Expcom.NameSpace($args[1])

if ( $tgtDir -eq $Null ) {
    $changed = "failed"
    echo $changed
    exit 1
}

$zipFile.Items() | ForEach-Object {
    $tgtDir.CopyHere($_.path, 0x14)
    $changed = "changed"
}

echo $changed
exit 0

    
