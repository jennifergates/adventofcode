$i = get-content .\input6.txt -encoding utf8

for ($startwin = 0; $startwin -lt $i.length -3; $startwin = $startwin +1){
	$slice = $i.substring($startwin,4)
	write-host "`nnew slice: $slice"
	
	$duplicated = "False"
	foreach ($x in $slice.tochararray()){
		
		#write-host $slice.indexof($x)
		#write-host $slice.lastindexof($x)
		if ($slice.indexof($x) -ne $slice.lastindexof($x)){
			$duplicated = "True"
			write-host "$x is duplicated in $slice"
		} else {
			write-host "$x is not duplicated in $slice"
		}
	}
	
	if ($duplicated -eq "False") {
		write-host "first non-duplicate slice $slice ends at $startwin plus 4?" 
		break
	} else {
		write-host "there is a duplicate in $slice, continuing"
	}
	
	
}