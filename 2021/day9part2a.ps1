$puzdata = get-content testdata.txt
#$puzdata = get-content input9.txt

$numofrows = $puzdata.length
$numofcolumns = $puzdata[0].length

write-host $numofrows ", "$numofcolumns

$lowpoints = @()

#$a = New-Object 'object[,]' $numofrows, $numofcolumns
foreach ($row in 0..($numofrows -1)){
	foreach ($column in 0..($numofcolumns -1)){
		
		$item = $puzdata[$row][$column]
		if ($row -ne 0){
			$above = $puzdata[$row -1][$column]
		} else {
			$above = '9'
		}
		if ($row -ne $numofrows -1) {
			$below = $puzdata[$row +1][$column]
		} else {
			$below = '9'
		}
		if ($column -ne 0) {
			$left = $puzdata[$row][$column -1]
		} else {
			$left = '9'
		}
		if ($column -ne $numofcolumns -1){
			$right = $puzdata[$row][$column +1]
		} else {
			$right = '9'
		}
		
		if ($item -lt $left -and $item -lt $right -and $item -lt $above -and $item -lt $below){
			write-host "item: $item, above: $above, below: $below, left: $left, right: $right"
			write-host "Lowpoint: $item Row:$row  Column:$column"
			$lowpoints += [System.Tuple]::Create($item, $row, $column)
		}
		
	}
}

function check-neighbors {
	param (
		$point,
		$puzdata,
		$dirs
	)
	
	$basinsum = 0
	

	if($dirs.contains('up')){
		write-host "check up"	
		if ($point.item2 -ne 0 ) {
			if ($point.item1 -lt $puzdata[($point.item2 - 1)][$point.item3] -and $puzdata[($point.item2 - 1)][$point.item3] -ne '9'){
				write-host $point.item1 " is less than " $puzdata[($point.item2 - 1)][$point.item3]
				$basinsum = $basinsum + 1
				$newpoint = [System.Tuple]::Create($puzdata[($point.item2 - 1)][$point.item3], $point.item2 -1, $point.item3)
				$basinsum = $basinsum + (check-neighbors -point $newpoint -puzdata $puzdata -dirs ('left', 'down','up', 'right') )
			}
		}
	}
	if($dirs.contains('down')){
		write-host "check down"
		$lastrow = $puzdata.length -1
		if ($point.item2 -ne $lastrow ) {
			if ($point.item1 -lt $puzdata[($point.item2 + 1)][$point.item3] -and $puzdata[($point.item2 + 1)][$point.item3] -ne '9'){
				$basinsum = $basinsum + 1
				write-host $point.item1 " is less than " $puzdata[($point.item2 + 1)][$point.item3]
				$newpoint = [System.Tuple]::Create($puzdata[($point.item2 + 1)][$point.item3], $point.item2 +1, $point.item3)
				$basinsum = $basinsum + (check-neighbors -point $newpoint -puzdata $puzdata -dirs ('left', 'down') )
			}
		}
	}
	
	if($dirs.contains('right')){
		write-host "check right"
		$lastcol = $puzdata[0].length -1
		if ($point.item3 -ne $lastcol ) {
			if ($point.item1 -lt $puzdata[$point.item2][($point.item3 +1)] -and $puzdata[$point.item2][($point.item3 +1)] -ne '9'){
				$basinsum = $basinsum + 1
				write-host $point.item1 " is less than " $puzdata[$point.item2][($point.item3 +1)]
				$newpoint = [System.Tuple]::Create($puzdata[$point.item2][$point.item3 +1], $point.item2, $point.item3 +1)
				$basinsum = $basinsum + (check-neighbors -point $newpoint -puzdata $puzdata -dirs ('left', 'down', 'up', 'right') )
			}
		}
	}
	
	if($dirs.contains('left')){
		write-host "check left"
		if ($point.item3 -ne 0 ) {
			if ($point.item1 -lt $puzdata[$point.item2][($point.item3 -1)] -and $puzdata[$point.item2][($point.item3 -1)] -ne '9'){
				$basinsum = $basinsum + 1
				write-host $point.item1 " is less than " $puzdata[$point.item2][($point.item3 -1)]
				$newpoint = [System.Tuple]::Create($puzdata[$point.item2][$point.item3 -1], $point.item2, $point.item3 -1)
				$basinsum = $basinsum + (check-neighbors -point $newpoint -puzdata $puzdata -dirs ('left', 'down', 'up', 'right') )
			}
		}
	}
	return $basinsum
}




foreach ($low in $lowpoints){
	#$lowint = [convert]::ToInt32($low.item1,10)
	write-host "Lowpoint: "$low.item1
	$triedpoints = @()
	$basinsum = (check-neighbors -point $low -puzdata $puzdata -dirs ('up', 'down', 'left', 'right') )
	
	write-host "Low: "$low "Sum: $basinsum"

}



<# $sum = 0
foreach ($low in $lowpoints) {
	$lowint = [convert]::ToInt32($low, 10)
	$risk = $lowint + 1
	write-host "Low: $low, Risk: $risk"
	$sum += $risk
	write-host "Sum: $sum"
} #>


<# start list of points added to the basinsum
For each low point tuple
	add the lowpoint to the basinsum
	for