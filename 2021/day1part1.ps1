$puzdata = get-content input1.txt
$increase = 0

0..$puzdata.Length  | foreach-object {
	if ([int]$puzdata[$_] -gt [int]$puzdata[$_-1]){ 
		$increase = $increase + 1
	} 	
}
write-host $increase
