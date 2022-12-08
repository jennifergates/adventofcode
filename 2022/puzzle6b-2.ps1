$i = get-content .\input6.txt -encoding utf8

for ($startwin = 0; $startwin -lt $i.length -13; $startwin = $startwin +1){
	$slice = $i.substring($startwin,14)
	write-host "`nnew slice: $slice"
	

	$unique = ($slice.tochararray() | sort -unique)
	write-host $unique
	if ($slice.length -eq $unique.length){
		write-host "first non-duplicate slice $slice ends at $startwin plus 14?"
		break
	}

	
	
}