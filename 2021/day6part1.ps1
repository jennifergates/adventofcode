
#puzdata = get-content testdata.txt
$puzdata = get-content input6.txt


function Get-NewDayState {
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$True)]
		$lanternfish
	)
	$lanternfish = [int]$lanternfish 
	#write-host "Fish: " $lanternfish
	
	if ($lanternfish -eq 0){
		#write-host "0 day" -foregroundcolor red
		write-output 6, 8
	} else {
		$out = $lanternfish - 1
		write-output $out
	}
}


$lanternfishes = $puzdata.split(',')

	
#write-host "Fishes" $lanternfishes

foreach ($day in 1..256){
	$lanternfishes = foreach ($fish in $lanternfishes) {
		Get-NewDayState $fish
	}
	write-host "Day "$day " Fishes: " $lanternfishes.count -foregroundcolor yellow

}

write-host "Answer: " $lanternfishes.count