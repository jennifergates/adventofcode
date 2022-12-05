
#$puzdata = get-content testdata.txt
$puzdata = get-content input6.txt


function NewDay {
	param (
		$prevdayarray
	)
	#write-host "Previous Day: "$prevdayarray
	
	$newdayarray = 0,0,0,0,0,0,0,0,0
	$newdayarray[8] = $prevdayarray[0]
	$newdayarray[7] = $prevdayarray[8] 
	$newdayarray[6] = $prevdayarray[7] + $prevdayarray[0]
	$newdayarray[5] = $prevdayarray[6]
	$newdayarray[4] = $prevdayarray[5]
	$newdayarray[3] = $prevdayarray[4]
	$newdayarray[2] = $prevdayarray[3]
	$newdayarray[1] = $prevdayarray[2]
	$newdayarray[0] = $prevdayarray[1]
	
	#write-host "New Day: "$newdayarray
	
	return $newdayarray
}


$lanternfishes = $puzdata.split(',')

	
write-host "Fishes" $lanternfishes

$countarray = 0,0,0,0,0,0,0,0,0


foreach ($fish in $lanternfishes){
	$i = [int]$fish
	$countarray[$i] = $countarray[$i] + 1
}

write-host "Day 1 Numbers: " $countarray

foreach ($d in 1..256){
	
$countarray = NewDay -prevdayarray $countarray
}

$sum = 0
foreach ($c in $countarray) { 
	$sum = $sum + $c
}


write-host $countarray
write-host "Answer: " $sum
