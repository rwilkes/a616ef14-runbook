param([System.Collections.ArrayList]$data, $fullNameDatFile)



[System.IO.FileStream]$fs = New-Object -TypeName System.IO.FileStream -ArgumentList @($fullNameDatFile, [System.IO.FileMode]::Create)
[System.Runtime.Serialization.Formatters.Binary.BinaryFormatter]$formatter = New-Object -TypeName System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
try
{
    $formatter.Serialize($fs, $data)
    
}
finally
{
    if($fs){$fs.Close()}
    $fs=$null
}
