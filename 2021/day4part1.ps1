

function Get-Numbers{
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$True)]
		[string[]]$rowofnum,
		
		$row,
		$board
	)
	
	$numbers = $rowofnum.split()
	$columncount = 1
	foreach ($num in $numbers){
		if ($num -ne ' ' -and $num -ne '') {
			$props = @{'integer' = [int]$num;
					'row' = $row;
					'column' = $columncount;
					'board' = $board;
					'marked' = 0 
			}	
			$obj = New-Object -TypeName PSObject -Property $props
			write-output $obj
			
			if ($columncount -eq 5 ){
				$columncount = 1
			}else {
				$columncount = $columncount + 1
			}
		}
	}
}

function Mark-Boards {
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$True)]
		$numberobjects,
		
		[string]$numdrawn
	)
	
	foreach ($obj in $numberobjects) {
		if([int]$numdrawn -eq $obj.integer){
			$obj.marked = 1
		}
		write-output $obj
	}
}

function Calculate-winner {
	[CmdletBinding()]
	param(
		[Parameter(ValueFromPipeline=$True)]
		$winningboard,
		
		$markedboards,
		
		$lastdraw
	)
	
	$tocalculate = $markedboards | where-object {$_.board -eq $winningboard -and $_.marked -eq 0}
	$sum = 0
	foreach ($num in $tocalculate){
		$sum = $sum + $num.integer
	}
	$answer = $sum * $lastdraw
	write-host "Sum:" $sum
	write-host "Last drawn number: "$lastdraw
	write-host "Answer: " $answer
}

#pull in board data
#$puzdata = get-content testdata.txt
$puzdata = get-content input4.txt
write-host "data in"

#get numbers drawn
$drawings = $puzdata[0].split(',')
write-host "numbers drawn"

#setup bingo boards
$boarddata = $puzdata[2..($puzdata.length)]


$rowcount = 1
$boardcount = 1
$bingoboards = foreach ($rowofnum in $boarddata) {
	if ($rowofnum -eq '') {
		$boardcount = $boardcount + 1
	} else {
		get-numbers -board $boardcount -row $rowcount -rowofnum $rowofnum
		if ($rowcount -eq 5) {
			$rowcount = 1
		} else {
			$rowcount = $rowcount + 1
		}
	}
}

write-host "boards setup"

#draw numbers, mark boards, check for bingo
$markedboards = $bingoboards
foreach ($draw in $drawings.split()){
	$markedboards = Mark-Boards -numdrawn $draw -numberobjects $markedboards
	write-host "board marked"
	#check for full rows in each board
	foreach ($b in 1..$boardcount) {
		write-host "Board: " $b
		foreach ($i in 1..5){
			#write-host "Row: " $i
			$markedrow =$markedboards | where-object {$_.board -eq $b -and $_.row -eq $i -and $_.marked -eq 1} 
			if (($markedrow | measure-object).count -eq 5){
				write-host "BBBBBINGO!" -foregroundcolor yellow
				write-host "board: "$markedrow[0].board "row: "$markedrow[0].row  "numbers: "$markedrow.integer
				Calculate-winner -winningboard $b -markedboards $markedboards -lastdraw $draw
				exit  
			}
			
			#write-host "Column: "$i
			$markedcolumn = $markedboards | where-object {$_.board -eq $b -and $_.column -eq $i -and $_.marked -eq 1} 
			if (($markedcolumn | measure-object).count -eq 5){
				write-host "BBBBBINGO!" -foregroundcolor yellow
				write-host "board: "$markedcolumn[0].board "column: "$markedcolumn[0].row  "numbers: "$markedcolumn.integer
				Calculate-winner -winningboard $b -markedboards $markedboards -lastdraw $draw
				exit 
			}
		}
	}
	
}

#write-output $markedboards