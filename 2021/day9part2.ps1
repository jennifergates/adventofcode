$puzdata = get-content testdata.txt
#$puzdata = get-content input9.txt
$numofrows = $puzdata.length
$numofcolumns = $puzdata[0].length
	
	
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
				$point | add-member NoteProperty 'inBasin' $true
			} else {
				$point | add-member NoteProperty 'isLowpoint' $false
				$point | add-member NoteProperty 'inBasin' $false
			}
			write-output $point
		}
	}
}

function markBasin($matrix, $puzdata, $numofrows, $numofcolumns, $i, $j) {
  if ($matrix[$i,$j] -eq 9 -or $puzdata[$i][$j] -eq 1) {
    return
  }
  $puzdata[$i][$j] = 1

  if ($i - 1 -ge 0) {
    markBasin($matrix, $puzdata, $numofrows, $numofcolumns, $i - 1, $j)
  }
  if ($i + 1 -lt $numofrows) {
    markBasin($matrix, $puzdata, $numofrows, $numofcolumns, $i + 1, $j)
  }
  if ($j - 1 -ge 0) {
    markBasin($matrix, $puzdata, $numofrows, $numofcolumns, $i, $j - 1)
  }
  if ($j + 1 -lt $numofcolumns) {
    markBasin($matrix, $puzdata, $numofrows, $numofcolumns, $i, $j + 1)
  }
}
 



$objects = get-objects -puzdata $puzdata
$lowpoints = $objects | where-object {$_.isLowpoint -eq $true}
  
$matrix = New-Object 'object[,]' $numofrows,$numofcolumns
foreach ($r in  0..($numofrows -1)){
	foreach ($c in 0..($numofcolumns -1)){
		$matrix[$r, $c] = 0	
	}
}

foreach ($lowpoint in $lowpoints){
	markBasin($matrix, $puzdata, $numofrows, $numofcolumns, $lowpoint.row, $lowpoint.column)
}



<#
start at low point
add low point to basin sum
go 1 to the left (col -1), if value not 9 add 1 to sum and mark point tried.
	if 9, just mark point tried


#>
	