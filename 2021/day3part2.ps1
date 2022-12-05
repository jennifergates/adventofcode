#$puzdata = get-content testdata.txt
$puzdata = get-content input3.txt

$mostpool = [System.Collections.ArrayList]@($puzdata)
$leastpool = [System.Collections.ArrayList]@($puzdata)
$generator = 'START'
$scrubber = 'START'
$positions = $puzdata[0].length 


function Get-Commons($binaries) {
	$mostcommons = ''
	$leastcommons = ''
	$binarylength = $binaries[0].length

	foreach($position in (0..($binarylength - 1))) {
		$posones = 0
		$poszeros = 0
		foreach ($binary in $binaries) {
			if ($binary[$position] -eq '1') {
				$posones = $posones + 1
			} else {
				$poszeros = $poszeros +1
			}
		}
		if ($posones -ge $poszeros) {
			$mostcommons = $mostcommons + '1'
			$leastcommons = $leastcommons + '0'
		} else {
			$mostcommons = $mostcommons + '0'
			$leastcommons = $leastcommons + '1'
		}
	}
	
	return ($mostcommons, $leastcommons)
}


function Reduce-Pool($pool, $common, $pos){
	$retpool = [System.Collections.ArrayList]@($pool)
	foreach ($p in $pool){
		if ($p[$pos] -ne $common[$pos]) {
			$retpool.remove($p)
		}
	}
	return $retpool
	
}
	

foreach($position in (0..$positions)){
	if ($mostpool.count -eq 1 ){
		$generator = $mostpool[0]
	}
	if ($leastpool.count -eq 1 ){
		$scrubber = $leastpool[0]
	}
	$mc = Get-Commons $mostpool
	$mostpool = @(Reduce-Pool $mostpool $mc[0] $position)
	$lc = Get-Commons $leastpool
	$leastpool = @(Reduce-Pool $leastpool $lc[1] $position)
}
write-host "Generator: $generator"
write-host "Scrubber: $scrubber"

$gint = [convert]::ToInt32("$generator",2)
$sint = [convert]::ToInt32("$scrubber",2)
$lifesupport = $gint * $sint
write-host $lifesupport 