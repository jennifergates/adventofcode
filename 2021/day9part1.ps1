#$puzdata = get-content testdata.txt
$puzdata = get-content input9.txt

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
			$lowpoints += $item
		}
		
	}
}





$sum = 0
foreach ($low in $lowpoints) {
	$lowint = [convert]::ToInt32($low, 10)
	$risk = $lowint + 1
	write-host "Low: $low, Risk: $risk"
	$sum += $risk
	write-host "Sum: $sum"
}