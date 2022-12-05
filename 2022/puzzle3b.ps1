<#

#>
$alphaprio = "0abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
$i = get-content .\input3.txt -encoding utf8

$sum = 0
$increment = 0

while ($increment -lt $i.count -2) {
	
	$group = $i[$increment] + $i[$increment+1] + $i[$increment+2]
	write-host $group
	write-host $uniquegroup
	$uniquegroup = $group.tochararray() | select -unique
	
	foreach ($letter in $uniquegroup) {
		if ( $i[$increment].contains($letter)  -and $i[$increment+1].contains($letter) -and $i[$increment+2].contains($letter) ){
			write-host "In 3 times: $letter" 
			#write-host $group
			$sum = $sum + ($alphaprio.indexof($letter))
		}
	}
	
	
	$increment = $increment + 3
}

	
	write-host $sum


