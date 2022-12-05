#$puzdata = get-content testdata.txt
$puzdata = get-content input3.txt

$gamma = ''
$epsilon = ''

foreach($position in (0..($puzdata[0].length - 1))) {
	$posones = 0
	$poszeros = 0
	foreach ($binary in $puzdata) {
		if ($binary[$position] -eq '1') {
			$posones = $posones + 1
		} else {
			$poszeros = $poszeros +1
		}
	}
	if ($posones -gt $poszeros) {
		$gamma = $gamma + '1'
		$epsilon = $epsilon + '0'
	} else {
		$gamma = $gamma + '0'
		$epsilon = $epsilon + '1'
	}

}

write-host "Gamma: $gamma Epsilon: $epsilon"
$gint = [convert]::ToInt32("$gamma",2)
$eint = [convert]::ToInt32("$epsilon",2)
$mult = $gint * $eint
write-host $mult