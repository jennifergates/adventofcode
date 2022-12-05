#$puzdata = get-content testdata.txt
$puzdata = get-content input2.txt

$depth = 0
$horiz = 0
$aim = 0

Foreach ($cmd in $puzdata) {
	$direction, [int]$distance = $cmd.split(' ')
	$direction = $direction.tolower()
	if ($direction -eq 'forward') { 
		$horiz = $horiz + $distance
		$depth = $depth + ($aim * $distance)
	}
	elseif ($direction -eq 'down') {$aim = $aim + $distance}
	elseif ($direction -eq 'up') {$aim = $aim - $distance}
	else { write-host "New direction $direction"}
}

$answer = $depth * $horiz

write-host "Depth: $depth  Horizontal: $horiz Aim: $aim"
write-host "answer: $answer"
