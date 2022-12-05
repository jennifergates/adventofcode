#$puzdata = get-content testdata.txt
$puzdata = get-content input8.txt

$sum = 0

function get-codes1478 {
	param(
		$leftside
	)
	#write-host $leftside
	$ret = @{}
	foreach ($num in $leftside){
		#write-host "Num: "  $num
		if ($num.length -eq 2){
			$digit = '1'
			$ret[$digit]=$num
			#write-host ( "Num: $num  Digit: $digit" )
		} elseif ($num.length -eq 3){
			$digit = '7'
			$ret[$digit]=$num
			#write-host ( "Num: $num  Digit: $digit" )
		} elseif ($num.length -eq 4){
			$digit = '4'
			$ret[$digit]=$num
			#write-host ( "Num: $num  Digit: $digit" )
		} elseif ($num.length -eq 7){
			$digit = '8'
			$ret[$digit]=$num
			#write-host ( "Num: $num  Digit: $digit" )
		}
		
	}
	
	return $ret
}

function get-topbar {
	param (
		$one,
		$seven
	)

	foreach ($i in 0..($seven.length-1)){ 
		if (! $one.contains($seven[$i])){
			$topbar = $seven[$i]
		}
	}
	return $topbar
}

function get-nine {
	param (
		$four,
		$topbar,
		$sixdigits
	)
	
	foreach ($sixdigit in $sixdigits) {
		$count = 0
		foreach ($i in 0..($four.length-1)){
			if ($sixdigit.contains($four[$i])){
				$count = $count +1
			}
		}
		if ($sixdigit.contains($topbar)){
			$count = $count +1
		}
		
		if ($count -eq 5){
			$nine = $sixdigit
			return $nine
		} else {
			$nine = 'Not Found'
		}
	
	}	
	return $nine
}

function get-zero {
	param (
		$eight,
		$one,
		$sixdigits
	)
	foreach ($sixdigit in $sixdigits) {
		$count = 0
		foreach ($i in 0..($sixdigit.length-1)){
			if ($eight.contains($sixdigit[$i])){
				$count = $count +1
			}
			if ($one.contains($sixdigit[$i])) {
				$count = $count +1
			}
		}
		
		if ($count -eq 8){
			$zero = $sixdigit
			return $zero
		} else {
			$zero = 'Not Found'
		}
	}
	return $zero
}

function get-three {
	param (
		$nine,
		$one,
		$fivedigits
	)
	foreach ($fivedigit in $fivedigits) {
		$count = 0
		foreach ($i in 0..($fivedigit.length-1)){
			if ($nine.contains($fivedigit[$i])){
				$count = $count +1
			}
		}
		foreach ($i in 0..($one.length-1)){
			if ($fivedigit.contains($one[$i])){
				$count = $count +1
			}
		}
		
		if ($count -eq 7){
			$three = $fivedigit
			return $three
		} else {
			$three = 'Not Found'
		}
	}
	return $three
}

function get-two {
	param (
		$leftbottombar,
		$fivedigits
	)
	
	foreach ($fivedigit in $fivedigits){
		if ($fivedigit.contains($leftbottombar)){
			$two = $fivedigit
			return $two
		} else {
			$two = 'Not Found'
		}
	}
	return $two
}

function get-middlebar {
	param (
		$eight,
		$zero
	)
	foreach ($i in 0..($eight.length-1)){
		if (!$zero.contains($eight[$i])){
			$middlebar = $eight[$i]
		}
	}
	return $middlebar

}



function get-bottombar {
	param (
		$nine,
		$four,
		$topbar
	)
	$bottombar = "Not Found"
	
	foreach ($i in 0..($nine.length-1)) {
	if (!$four.contains($nine[$i]) -and $topbar -ne $nine[$i]){
			$bottombar = $nine[$i]
		}
	}
	
	return $bottombar
}

function get-leftbottombar {
	param (
		$nine,
		$eight
	)
	
	$leftbottombar = "Not Found"
	foreach ($i in 0..($eight.length-1)){
		if (!$nine.contains($eight[$i])){
			$leftbottombar = $eight[$i]
		}
	}
	
	return $leftbottombar
}



function get-set{
	param(
		$letters
	)
	
	$set = $letters.split()
}

$finalsum = 0
foreach ($line in $puzdata) {
	$input = $line.split('|')[0].trim().split(' ')
	$output = $line.split('|')[1].trim().split(' ')
	write-host "`n*******************************************************************************`n"
	write-host "Input: " $input
	
	$hash = get-codes1478 -leftside $input
	
	$topbar = get-topbar -one $hash['1'] -seven $hash['7']
	
	$sixdigits = $input | where-object {$_.length -eq 6}
	write-host "Six Digits: $sixdigits"
	$hash['9'] = get-nine -four $hash['4'] -topbar $topbar -sixdigit $sixdigits 
	$sixdigits = $sixdigits | where-object {$_ -ne $hash['9']}
	write-host "Sixdigits without Nine: "$sixdigits
	$bottombar = get-bottombar -four $hash['4'] -nine $hash['9'] -topbar $topbar
	$leftbottombar = get-leftbottombar -eight $hash['8'] -nine $hash['9']

	$hash['0'] = get-zero -sixdigits $sixdigits -eight $hash['8'] -one $hash['1']
	$middlebar = get-middlebar -zero $hash['0'] -eight $hash['8']
	$hash['6'] = $sixdigits | where-object {$_ -ne $hash['0']}
	write-host "Sixdigits without Zero: "$sixdigits

	$fivedigits = $input | where-object {$_.length -eq 5}
	$hash['3'] = get-three -nine $hash['9'] -fivedigits $fivedigits -one $hash['1']
	$fivedigits = $fivedigits | where-object {$_ -ne $hash['3']}
	$hash['2'] = get-two -fivedigits $fivedigits -leftbottombar $leftbottombar
	$hash['5'] = $fivedigits | where-object {$_ -ne $hash['2']}

	$hash['0']=[string]::Join('',($hash['0'].ToCharArray() | sort-object))
	$hash['1']=[string]::Join('',($hash['1'].ToCharArray() | sort-object))
	$hash['2']=[string]::Join('',($hash['2'].ToCharArray() | sort-object))
	$hash['3']=[string]::Join('',($hash['3'].ToCharArray() | sort-object))
	$hash['4']=[string]::Join('',($hash['4'].ToCharArray() | sort-object))
	$hash['5']=[string]::Join('',($hash['5'].ToCharArray() | sort-object))
	$hash['6']=[string]::Join('',($hash['6'].ToCharArray() | sort-object))
	$hash['7']=[string]::Join('',($hash['7'].ToCharArray() | sort-object))
	$hash['8']=[string]::Join('',($hash['8'].ToCharArray() | sort-object))
	$hash['9']=[string]::Join('',($hash['9'].ToCharArray() | sort-object))


	write-host "Keys: "$hash.keys
	write-host "Values: "$hash.values
	write-host "Zero: `t"$hash['0']
	write-host "One: `t"$hash['1']
	write-host "Two: `t"$hash['2']
	write-host "Three: `t"$hash['3']
	write-host "Four: `t"$hash['4']
	write-host "Five: `t"$hash['5']
	write-host "Six: `t"$hash['6']
	write-host "Seven: `t"$hash['7']
	write-host "Eight: `t"$hash['8']
	write-host "Nine: `t"$hash['9']

	write-host "Topbar: $topbar"
	write-host "Bottombar: $bottombar"	
	write-host "Leftbottombar: $leftbottombar"
	write-host "Middlebar: $middlebar"
	
	

#determine digits in output
	$finaldigits = ""
	foreach ($num in $output){
		$sortednum = [string]::Join('',($num.ToCharArray() | sort-object))
		$hash.GetEnumerator() | foreach-object{
			if ($_.value -eq $sortednum) {
				$finaldigits = $finaldigits + $_.key
			}
		}
	} 
	write-host "Finaldigits: $finaldigits"
	$finalsum = $finalsum + [int]$finaldigits
}

write-host "FinalSum = $finalsum"
