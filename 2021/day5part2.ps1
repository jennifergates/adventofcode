
#$puzdata = get-content testdata.txt
$puzdata = get-content input5.txt

function Get-Coordinates{
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$True)]
		$InputCoords
	)

	foreach ($line in $InputCoords){
		[int]$startx, [int]$starty = $line.split()[0].split(',')
		[int]$endx, [int]$endy = $line.split()[2].split(',')
		
		#write-host $startx $starty $endx $endy
	
		# vertical like 2,2 -> 2,1
		if ($startx -eq $endx){
			#write-host "vertical" $startx $starty $endx $endy
			foreach ($y in $starty..$endy){
				$tuple = "$startx $y"
				write-output $tuple
			}
		# horizontal like 0,9 -> 5,9
		} elseif ($starty -eq $endy ){
			#write-host "horizontal" $startx $starty $endx $endy
			foreach ($x in $startx..$endx){
				$tuple = "$x $starty"
				write-output $tuple   
			}
		# diagonal like 0,0 -> 8,8
		} elseif ($startx -eq $starty -and $endx -eq $endy) { 
			if ($startx -lt $endx){				
			#write-host "Diagonal-1a" $startx $starty $endx $endy 
				foreach ($c in 0..($endx - $startx)) {
					[int]$tx = $startx + $c
					[int]$ty = $starty + $c
					$tuple = "$tx $ty"
					write-output $tuple
				}
			} elseif ($startx -gt $endx) {
				#write-host "Diagonal-1b" $startx $starty $endx $endy 
				foreach ($c in 0..($startx - $endx)) {
					[int]$tx = $startx - $c
					[int]$ty = $starty - $c
					$tuple = "$tx $ty"
					write-output $tuple
				}
			}
		# Diagonal like 8,0 -> 0,8
		} elseif ($startx -eq $endy -and $starty -eq $endx) { 
			if ($startx -gt $endx){
				#write-host "Diagonal-2a" $startx $starty $endx $endy 
				foreach ($c in 0..($startx - $endx)) {
					[int]$tx = $startx - $c
					[int]$ty = $starty + $c
					$tuple = "$tx $ty"
					write-output $tuple
				}
			} elseif ($startx -lt $endx){
				#write-host "Diagonal-2b" $startx $starty $endx $endy 
				foreach ($c in 0..($endx - $startx)) {
					[int]$tx = $startx + $c
					[int]$ty = $starty - $c
					$tuple = "$tx $ty"
					write-output $tuple
				}
			}
		# Diagonal like 6,4 -> 2,0
		} elseif ([Math]::Abs($endx - $startx) -eq [Math]::Abs($endy - $starty)){
			if ($startx -lt $endx -and $starty -lt $endy) {
				#write-host "Diagonal-3a" $startx $starty $endx $endy 
				foreach ($c in 0..($endx - $startx)) {
					[int]$tx = $startx + $c
					[int]$ty = $starty + $c
					$tuple = "$tx $ty"
					write-output $tuple
				}
			} elseif ($startx -gt $endx -and $starty -gt $endy) {
				#write-host "Diagonal-3b" $startx $starty $endx $endy 
				foreach ($c in 0..($startx - $endx)) {
					[int]$tx = $startx - $c
					[int]$ty = $starty - $c
					$tuple = "$tx $ty"
					write-output $tuple
				}
			} elseif ($startx -gt $endx -and $starty -lt $endy) {
				#write-host "Diagonal-3c" $startx $starty $endx $endy 
				foreach ($c in 0..($startx - $endx)) {
					[int]$tx = $startx - $c
					[int]$ty = $starty + $c
					$tuple = "$tx $ty"
					write-output $tuple
				}
			} elseif ($startx -lt $endx -and $starty -gt $endy) {
				#write-host "Diagonal-3d" $startx $starty $endx $endy 
				foreach ($c in 0..($endx - $startx)) {
					[int]$tx = [int]$startx + [int]$c
					[int]$ty = $starty - $c
					$tuple = "$tx $ty"
					write-output $tuple
				}
			} else {
				write-host "Uncat" $startx $starty $endx $endy 
			}
		}
	}

}



$coordinates = get-coordinates -inputcoords $puzdata
#write-host $coordinates
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



