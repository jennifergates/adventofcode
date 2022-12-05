<#

#>
$alphaprio = "0abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
$i = get-content .\input3.txt -encoding utf8

$sum = 0

foreach ($ruck in $i){
	write-host $ruck
	$halflength = ($ruck.length)/2
	$first = $ruck.substring(0,$halflength)
	$second = $ruck.substring($halflength)
	write-host $first
	write-host $second
	
	$uniquefirst = $first.tochararray() | select -unique
	
	foreach ($letter in $uniquefirst) {
		if ($second.contains($letter)) {
			write-host "second contains $letter"
			write-host $alphaprio.indexof($letter)
			$sum = $sum + ($alphaprio.indexof($letter))
		}
	}
	
	write-host $sum
}

