#$DebugPreference = "Continue"
$DebugPreference = "SilentlyContinue"

#$puzdata = get-content testdata.txt
$puzdata = get-content input8.txt

$sum = 0

foreach ($line in $puzdata) {
	$input = $line.split('|')[0]
	$output = $line.split('|')[1].trim().split(' ')
	
	foreach ($num in $output){
		write-debug ("Num: " + $num)
		if ($num.length -eq 2){
			$digit = 1
			$sum = $sum +1
			write-debug ( "Num: "+$num  +"Digit: "+$digit +"Sum: "+$sum)
		} elseif ($num.length -eq 3){
			$digit = 7
			$sum = $sum +1
			write-debug ( "Num: "+$num  +"Digit: "+$digit +"Sum: "+$sum)
		} elseif ($num.length -eq 4){
			$digit = 4
			$sum = $sum +1
			write-debug ( "Num: "+$num  +"Digit: "+$digit +"Sum: "+$sum)
		} elseif ($num.length -eq 7){
			$digit = 8
			$sum = $sum +1
			write-debug ( "Num: "+$num  +"Digit: "+$digit +"Sum: "+$sum)
		}
	}
}

write-host "Sum: " $sum