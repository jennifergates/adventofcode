
## thanks to greggelong for the example in python. couldn't have done it without it.

$i = get-content .\input7.txt -encoding utf8 -raw
$commands = $i.split("`n")

$dirstack = New-Object System.Collections.Stack
$sizestack = New-Object System.Collections.Stack

function Go-up {
	write-host "size" $sizestack -foregroundcolor yellow
	write-host "stack" $dirstack 
	
	$sizestack.push($dirstack.pop())
	if ($dirstack.count -ne 0) {
		$tmp = $dirstack.pop() + $sizestack.peek()
		$dirstack.push($tmp)
	}
}


foreach ($c  in $commands) {
	#write-host "COMMAND: $c"
	if ($c -match 'cd \.\.') {Go-up}
	elseif ($c -match "^\$ cd "){ write-host "Push 0" -foregroundcolor cyan; $dirstack.push(0)}
	elseif ($c -match "^\d+") {
		[int]$filesize, $filename = $c.split(' ')
		$temp = $filesize + $dirstack.pop()
		$dirstack.push($temp) 
		
		$toshow = $dirstack.peek()
		write-host "dirstack last number is $toshow" -foregroundcolor green
	}
	
} 


while ($dirstack.count -ne 0){
	Go-up
}

$sum = 0
foreach ($s in $sizestack) {
	#write-host "size: $s"
	if ($s -le 100000) {$sum += $s}
}
write-host "part one sum: $sum"  -foregroundcolor red

$sizearray = $sizestack.toarray()

$max = $sizearray | measure-object -maximum
$currentfreespace  = 70000000 -  $max.maximum
write-host "Current free: $currentfreespace " 
$needed = 30000000 - $currentfreespace
write-host "Needed more: $needed" 
$possible = $sizearray | where-object {$_ -ge $needed}
$best = $possible | sort-object -descending |select-object -last 1
write-host "part two: $best"  -foregroundcolor red


