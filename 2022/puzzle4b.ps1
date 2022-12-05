<#

#>
$i = get-content .\input4.txt -encoding utf8

$sum = 0

foreach ($pair in $i) {
	
	$r1, $r2 = $pair.split(',')
	
	$r1begin = [int]$r1.split('-')[0]
	$r1end = [int]$r1.split('-')[1]
	$r2begin = [int]$r2.split('-')[0]
	$r2end = [int]$r2.split('-')[1]
	
<# 	write-host $pair
	write-host $r1begin
	write-host $r1end
	write-host $r2begin
	write-host $r2end #>
	
	if ( ($r1begin -ge $r2begin -and $r1begin -le $r2end) -or ( $r2begin -ge $r1begin -and $r2begin -le $r1end) ) {
		write-host "$pair overlaps"
		$sum = $sum +1
	}
}

write-host $sum


