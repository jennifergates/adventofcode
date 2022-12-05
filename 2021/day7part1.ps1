#$puzdata = get-content testdata.txt
$puzdata = get-content input7.txt

# Median value in list of numbers with an odd count is the number at the index of count/2 +1
# Median value in list of numbers with an even count is the number at index of count/2 plus number at index of count/2 +1 all divided by 2


$crabhorz = $puzdata.split(',')
$crabhorz = $crabhorz | foreach {[int]$_} | sort
write-host $crabhorz

if ($crabhorz.count %2 -ne 0) {
	$mediani = $crabhorz.count /2
	$median = $crabhorz[$mediani]
} else {
	$median1 = $crabhorz.count /2 
	$median2 = $median1 - 1
	$median = ($crabhorz[$median1] + $crabhorz[$median2] )/ 2
}

write-host $median

$fuel = 1
$totalfuel = 0

foreach ($crab in $crabhorz ){
	$fuelsteps = [Math]::abs($crab - $median)
	$totalfuel = $totalfuel + $fuelsteps
}

write-host $totalfuel