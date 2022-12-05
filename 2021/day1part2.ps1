$puzdata = get-content input1.txt
$increase = 0

0..($puzdata.Length - 4)  | foreach-object {
	if (([int]$puzdata[$_] + [int]$puzdata[$_+1] + [int]$puzdata[$_+2] ) -lt ( [int]$puzdata[$_+1] + [int]$puzdata[$_+2] + [int]$puzdata[$_+3])){ 
		$increase = $increase + 1;
	} 	
}
write-host "increase $increase"
