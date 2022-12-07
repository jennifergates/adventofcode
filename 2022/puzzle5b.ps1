<#

#>
# get input data
$i = get-content .\input5.txt -encoding utf8

#create stack variables
for ($num = 1; $num -lt 10; $num++){
	new-variable -name "s$num" -value (New-Object System.Collections.Stack)
}


# populate stacks
for ($start = 7; $start -gt -1; $start--){
	write-host $i[$start]
	if ( $i[$start][1] -ne ' ') {$s1.push($i[$start][1])}
	if ( $i[$start][5] -ne ' ') {$s2.push($i[$start][5])}
	if ( $i[$start][9] -ne ' ') {$s3.push($i[$start][9])}
	if ( $i[$start][13] -ne ' ') {$s4.push($i[$start][13])}
	if ( $i[$start][17] -ne ' ') {$s5.push($i[$start][17])}
	if ( $i[$start][21] -ne ' ') {$s6.push($i[$start][21])}
	if ( $i[$start][25] -ne ' ') {$s7.push($i[$start][25])}
	if ( $i[$start][29] -ne ' ') {$s8.push($i[$start][29])}
	if ( $i[$start][33] -ne ' ') {$s9.push($i[$start][33])}
	
}

for ($c = 1; $c -lt 10; $c++){
	write-host (get-variable -name s$c -valueonly)
}


#run instructions
for ($inst = 10; $inst -lt $i.count; $inst++) {
#for ($inst = 10; $inst -lt 15; $inst++) {
	write-host " "
	write-host $i[$inst].split(' ')
	
	$loop = [int]($i[$inst].split(' '))[1]
	$fromstack = ($i[$inst].split(' '))[3]
	$tostack = ($i[$inst].split(' '))[5]
	
	#write-host "loop: $loop   fromstack: $fromstack   tostack: $tostack"
	$movingstack = New-Object System.Collections.Stack
	for ($l = 1; $l -le $loop; $l++ ) {
				 
		$movingbox =  (get-variable -name "s$fromstack" -valueonly).pop()
		$movingstack.push($movingbox)
		#(get-variable -name "s$tostack" -valueonly).push($movingbox)
		write-host "$l) moved $movingbox from $fromstack to movingstack"
		
		#print out current stacks
		write-host "`nSTACKS"
		for ($c = 1; $c -lt 10; $c++){
			write-host (get-variable -name s$c -valueonly)
		}
	}
	write-host "`nMOVINGSTACK"
	write-host $movingstack
	for ($l = 1;$l -le $loop; $l++){
		$movingbox = $movingstack.pop()
		(get-variable -name "s$tostack" -valueonly).push($movingbox)
		write-host "$l) moved $movingbox from movingstack to $tostack"
	}
}

write-host "`n`nending stacks, top on left"
for ($c = 1; $c -lt 10; $c++){
	write-host "Stack $c "(get-variable -name s$c -valueonly)
}

