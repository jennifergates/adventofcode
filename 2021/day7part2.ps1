#$puzdata = get-content testdata.txt
$puzdata = get-content input7.txt

# Median value in list of numbers with an odd count is the number at the index of count/2 +1
# Median value in list of numbers with an even count is the number at index of count/2 plus number at index of count/2 +1 all divided by 2


$crabhorz = $puzdata.split(',')
$crabhorz = $crabhorz | foreach {[int]$_} | sort
#write-host "crab positions: "$crabhorz

if ($crabhorz.count %2 -ne 0) {
	$mediani = $crabhorz.count /2
	$median = $crabhorz[$mediani]
} else {
	$median1 = $crabhorz.count /2 
	$median2 = $median1 - 1
	$median = ($crabhorz[$median1] + $crabhorz[$median2] )/ 2
}

write-host "Median: " $median
$average = 0
foreach ($crab in $crabhorz){ $average = $average + $crab}
$av = $average/$crabhorz.count
write-host "AVERAGE: " $av
$average = [math]::Floor($average/$crabhorz.count)
write-host "Average: " $average


$fuel = 1
$totalfuel = 0
function Test-Averages {
	param(
		$average
	)
		
	foreach ($crab in $crabhorz ){
		#write-host "Crab: "$crab
		$fuelsteps = [Math]::abs($crab - $average)
		#write-host "Fuel Steps: " $fuelsteps
		foreach ($step in 0..$fuelsteps){
			$totalfuel = $totalfuel + $step
			#write-host "Step: " $step  "totalfuel: " $totalfuel
		}
		#$totalfuel = $totalfuel + $fuelsteps
	}
	return $totalfuel
}

#off by one test. found that math round was not right, but floor was.
<# foreach ($test in ($average-1)..($average +1)){
	$testans = Test-Averages -average $test
	write-host "Average: " $test "Fuel: "$testans
} #>
$Answer = Test-Averages -average $average
write-host $Answer

