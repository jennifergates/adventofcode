
$puzdata = get-content testdata.txt
#$puzdata = get-content input5.txt

function Get-Coordinates{
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$True)]
		$InputCoords
	)

	foreach ($line in $InputCoords){
		$startx, $starty = $line.split()[0].split(',')
		$endx, $endy = $line.split()[2].split(',')
		
		write-host $startx $starty $endx $endy
	
		if ($startx -eq $endx){
			foreach ($y in $starty..$endy){
				#$tuple = [System.Tuple]::Create($startx, $y)
				$tuple = "$startx $y"
				write-output $tuple
			}
		} elseif ($starty -eq $endy ){
			foreach ($x in $startx..$endx){
				#$tuple = [System.Tuple]::Create($x, $starty)
				$tuple = "$x $starty"
				write-output $tuple   
			}
		}
		
	}

}



$coordinates = get-coordinates -inputcoords $puzdata
#write-host $coordinates[0]
$hashtable = @{}
foreach ($coord in $coordinates){
	$key = $coord
	if ($hashtable.Containskey($key) -eq $false ){
		$hashtable[$key] = 1}
	else {
		$hashtable[$key] = $hashtable[$key] + 1
	}
}

$hashtable.values |Where-Object {$_ -ge 2} | measure-object



