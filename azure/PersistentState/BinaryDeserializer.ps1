param($fullNameDatFile)

[System.IO.FileStream]$fs = New-Object -TypeName System.IO.FileStream -ArgumentList @($fullNameDatFile, [System.IO.FileMode]::Open)
[System.Runtime.Serialization.Formatters.Binary.BinaryFormatter]$formatter = New-Object -TypeName System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
try
{
    [System.Collections.ArrayList]$rehydrated=($formatter.Deserialize($fs))
    return $rehydrated
    
}
finally
{
    if($fs){$fs.Close()}
    $fs=$null
}
