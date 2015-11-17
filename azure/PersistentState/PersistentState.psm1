[System.Collections.ArrayList]$SCRIPT:memory = $null


#$null=Register-EngineEvent -SourceIdentifier ([System.Management.Automation.PSEngineEvent]::Exiting) -Action {if($Script:memory -ne $null) { Invoke-BinarySerializer -data $Script:memory }} 

<#
 if(Test-Path -Path $SCRIPT:fullNameDatFile -PathType Leaf)
{
    $SCRIPT:memory=(Invoke-BinaryDeserializer)
    Remove-Item -Path $SCRIPT:fullNameDatFile -Force
} 
#>

function Set-Memory
{
    param(
        [Parameter(ValueFromPipeline = $true)]
        $item
    )

    begin { Clear-Memory }
    process { $null=$SCRIPT:memory.Add($item) }
}

function Get-Memory
{
    $SCRIPT:memory.ToArray()
}

function Update-Memory
{
      param(
        [Parameter(ValueFromPipeline = $true)]
        $item
    )

    begin { [System.Collections.ArrayList]$PRIVATE:tmpMemory = New-Object System.Collections.ArrayList }
    process { $null=$PRIVATE:tmpMemory.Add($item) }
    end 
	{ 
		if(($SCRIPT:memory) -and ($SCRIPT:memory.Count -gt 0))
		{
			$SCRIPT:memory+=$PRIVATE:tmpMemory
		}
		else
		{
			Clear-Memory
			$SCRIPT:memory=$PRIVATE:tmpMemory
		}	
	}
}

Function Clear-Memory {

		[System.Collections.ArrayList]$SCRIPT:memory = New-Object -TypeName System.Collections.ArrayList
}


Set-Alias remember Set-Memory 
Set-Alias recall Get-Memory 
Set-Alias update Update-Memory 
Set-Alias clean Clear-Memory 

Export-ModuleMember -Function Set-Memory,Get-Memory,Update-Memory,Clear-Memory
Export-ModuleMember -Alias remember,recall,update,clean