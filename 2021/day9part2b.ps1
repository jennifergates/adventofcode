$puzdata = get-content testdata.txt
#$puzdata = get-content input9.txt

$numofrows = $puzdata.length
$numofcolumns = $puzdata[0].length

#write-host $numofrows ", "$numofcolumns

$lowpoints = @()

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
			#write-host "item: $item, above: $above, below: $below, left: $left, right: $right"
			#write-host "Lowpoint: $item Row:$row  Column:$column"
			$lowpoints += [System.Tuple]::Create($item, $row, $column)
		}
		
	}
}

function Get-Objects {
	param (
		$puzdata
	)
	
	$numofrows = $puzdata.length
	$numofcolumns = $puzdata[0].length

	foreach ($row in 0..($numofrows -1)){
		foreach ($column in 0..($numofcolumns -1)){
		
			$item = $puzdata[$row][$column]
			$point = new-object psobject
			$point | add-member NoteProperty 'row' $row
			$point | add-member NoteProperty 'column' $column
			$point | add-member NoteProperty 'value' $item
			
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
				#write-host "item: $item, above: $above, below: $below, left: $left, right: $right"
				#write-host "Lowpoint: $item Row:$row  Column:$column"
				$point | add-member NoteProperty 'isLowpoint' $true
			} else {
				$point | add-member NoteProperty 'isLowpoint' $false
			}
			write-output $point
		}
	}
}



function check-neighbors {
	param (
		$objects,
		$puzdata,
		$point
	)
	
	$basinsum = 0
	write-host "Point: "$point
	
		write-host "check up"	
		if ($point.row -ne 0 ) {
			if ($point.value -lt $puzdata[($point.row - 1)][$point.column] -and $puzdata[($point.row - 1)][$point.column] -ne '9'){
				write-host $point.value " is less than " $puzdata[($point.row - 1)][$point.column]
				$basinsum = $basinsum + 1
				$newpoints = $objects  | where-object {$_.row -eq ($point.row -1) -and $_.column -eq $point.column}
				write-host "NEwpoint" $newpoint
				#$newpoint = [System.Tuple]::Create($puzdata[($point.row - 1)][$point.column], $point.row -1, $point.column)
				foreach ($newpoint in $newpoints){
					$basinsum = $basinsum + (check-neighbors -point $newpoint -puzdata $puzdata  )
				}
			}
		}
		write-host "check down"
		$lastrow = $puzdata.length -1
		if ($point.row -ne $lastrow ) {
			if ($point.value -lt $puzdata[($point.row + 1)][$point.column] -and $puzdata[($point.row + 1)][$point.column] -ne '9'){
				$basinsum = $basinsum + 1
				write-host $point.value " is less than " $puzdata[($point.row + 1)][$point.column]
				$newpoint = $objects  | where-object {$_.row -eq $point.row -1 -and $_.column -eq $point.column}
				#$newpoint = [System.Tuple]::Create($puzdata[($point.row + 1)][$point.column], $point.row +1, $point.column)
				$basinsum = $basinsum + (check-neighbors -point $newpoint -puzdata $puzdata  )
			}
		}
	
		write-host "check right"
		$lastcol = $puzdata[0].length -1
		if ($point.column -ne $lastcol ) {
			if ($point.value -lt $puzdata[$point.row][($point.column +1)] -and $puzdata[$point.row][($point.column +1)] -ne '9'){
				$basinsum = $basinsum + 1
				write-host $point.value " is less than " $puzdata[$point.row][($point.column +1)]
				$newpoint = $objects  | where-object {$_.row -eq $point.row -1 -and $_.column -eq $point.column}
				#$newpoint = [System.Tuple]::Create($puzdata[$point.row][$point.column +1], $point.row, $point.column +1)
				$basinsum = $basinsum + (check-neighbors -point $newpoint -puzdata $puzdata )
			}
		}
	
		write-host "check left"
		if ($point.column -ne 0 ) {
			if ($point.value -lt $puzdata[$point.row][($point.column -1)] -and $puzdata[$point.row][($point.column -1)] -ne '9'){
				$basinsum = $basinsum + 1
				write-host $point.value " is less than " $puzdata[$point.row][($point.column -1)]
				$newpoint = $objects  | where-object {$_.row -eq $point.row -1 -and $_.column -eq $point.column}
				#$newpoint = [System.Tuple]::Create($puzdata[$point.row][$point.column -1], $point.row, $point.column -1)
				$basinsum = $basinsum + (check-neighbors -point $newpoint -puzdata $puzdata  )
			}
		}
	
	return $basinsum
}

$objects = get-objects -puzdata $puzdata



$objects | where-object {$_.isLowpoint -eq $true} | foreach-object{
	#$lowint = [convert]::ToInt32($low.value,10)
	write-host "Lowpoint: "$_.value
	#$triedpoints = $triedpoints + $low
	#$basinsum = (check-neighbors -point $_ -puzdata $puzdata -objects $objects )
	
	#write-host "Low: "$low "Sum: $basinsum"

}

$objects | where-object {$_.isLowpoint -eq $true}


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
	#>
	