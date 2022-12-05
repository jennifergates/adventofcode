#$puzdata = get-content testdata.txt
$puzdata = get-content input2.txt

$depth = 0
$horiz = 0

Foreach ($cmd in $puzdata) {
	$direction, [int]$distance = $cmd.split(' ')
	$direction = $direction.tolower()
	if ($direction -eq 'forward') { $horiz = $horiz + $distance}
	elseif ($direction -eq 'down') {$depth = $depth + $distance}
	elseif ($direction -eq 'up') {$depth = $depth - $distance}
	else { write-host "New direction $direction"}
}

$answer = $depth * $horiz

write-host "Depth: $depth  Horizontal $horiz"
write-host "answer: $answer"
