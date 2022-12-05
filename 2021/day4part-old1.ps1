$puzdata = get-content testdata.txt
#$puzdata = get-content input4.txt

$drawingnumbers = $puzdata[0]
$boarddata = $puzdata[2..($puzdata.length)]

$numberofboards = ($boarddata.count + 1) /6
#write-host $numberofboards

function Get-Row {
	param (
	$rowdata,
	$rownumber
	)

	if (($rownumber % 6) -eq 0){
		return
	}
	
	$row = $rowdata.trim().split().trim()
	
	$board = [math]::ceiling($rownumber / 5)
	<# write-host "board: "$board
	write-host "row: "$rownumber
	wri te-host "data: "$rowdata#>
	
	$newrow = 
		# row, column, int, marked/unmarked
		($rownumber,1,[int]$row[0],'U',$board),
		($rownumber,2,[int]$row[1],'U',$board),
		($rownumber,3,[int]$row[2],'U',$board),
		($rownumber,4,[int]$row[3],'U',$board),
		($rownumber,5,[int]$row[4],'U',$board)

	return $newrow
}
	

function Get-Board {
	
	param (
	$boarddata,
	$boardnumber
	)
	
	
	$newboard = New-Object -TypeName PSObject -Property @{
		board = $boardnumber
		
	}
	
	return $newboard
}


$board = foreach ($line in $boarddata){
	get-row $line ($boarddata.indexof($line) +1)
}
$board[0]


<# function Get-Boards {
		param (
		$boarddata
	)
	
	$boards = @()
	
	foreach($b in (1..$numberofboards+1)){
		$board = New-Object PSObject
		$board | Add-Member -MemberType NoteProperty -name "board$b" -Value $b
		# read in each row to an array
		foreach ($r in (($b+0)..($b+4))){
			#write-host $r ":" $boarddata[$r]
			$row = $boarddata[$r].trim().split().trim()
			$newrow = @()
			foreach ($n in $row) {
				$newrow = $newrow + ([int]$n, 'U')
			}
			$board | Add-Member -MemberType NoteProperty -name "row$r" -Value $newrow
			
		}
		$boards = $boards + $board
	}
	
	write-host $boards
} #>

