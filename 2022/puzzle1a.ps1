$i = get-content .\input1.txt -encoding utf8
#$i = $i.split('\r\n')
<# write-host $i[2] 
break; #>
$highest = 0;
$sum = 0;
foreach ($c in $i) { 
	#write-host $c
	if ($c -ne '') { 
		#write-host "Adding"
		$sum = $sum + $c
		#write-host $sum
	} 	
	elseif ($c -eq '' ) {
		<# write-host "new elf"
		write-host "Sum: $sum"
		write-host "Highest: $highest"#>
		if ($sum -gt $highest){ 
			$highest = $sum
		}
		$sum = 0;
	}	

	
}
	write-host "Highest: $highest"