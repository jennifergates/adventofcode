$i = get-content .\input1.txt -encoding utf8

$highest = 0;
$sum = 0;
$elves = @()
$num = 0
foreach ($c in $i) { 
	#write-host $c
	if ($c -ne '') { 
		#write-host "Adding"
		$sum = $sum + $c
		#write-host $sum
	} 	
	elseif ($c -eq '' ) {
		write-host "new elf $num"
		write-host "Sum: $sum"
		$num = $num + 1
		$elves = $elves + $sum
		$sum = 0;
	}	

	
}
	$elves | sort-object | select-object -last 3
	$a, $b, $c = $elves | sort-object | select-object -last 3
	write-host $a, $b, $c
	$top3 = $a + $b + $c
	write-host $top3
	
	