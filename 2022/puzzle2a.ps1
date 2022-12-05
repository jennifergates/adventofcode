<#

A for Rock, B for Paper, and C for Scissors.
X for Rock, Y for Paper, and Z for Scissors
The score for a single round is the score for the shape you selected 
(1 for Rock, 2 for Paper, and 3 for Scissors) 
plus the score for the outcome of the round 
(0 if you lost, 3 if the round was a draw, and 6 if you won)


paper beats rock  2 beats 1
rock beats scissors 1 beats 3
scissors beats paper  3 beats 2

#>

$i = get-content .\input2.txt -encoding utf8

$n = $i.replace('A', 1).replace('B', 2).replace('C', 3).replace('X', 1).replace('Y', 2).replace('Z', 3)

$totalscore = 0

foreach ($round in $n){
	$roundscore = 0
	write-host "ROUND: $round"
	$opp, [int]$me = $round.split(' ')
 
	write-host "Opp: $opp and Me: $me"

	switch ($round)
	{
		("1 1") {$roundscore = $me +3; write-host "Draw $roundscore"; }
		("2 2") {$roundscore = $me +3; write-host "Draw $roundscore"; }
		("3 3") {$roundscore = $me +3; write-host "Draw $roundscore"; }
		("2 1") {$roundscore = $me +0; write-host "Lost $roundscore";}
		("1 3") {$roundscore = $me +0; write-host "Lost $roundscore";}
		("3 2") {$roundscore = $me +0; write-host "Lost $roundscore";}
		("1 2") {$roundscore = $me +6; write-host "Win $roundscore";}
		("3 1") {$roundscore = $me +6; write-host "Win $roundscore";}
		("2 3") {$roundscore = $me +6; write-host "Win $roundscore";}
	}

	write-host "totalscore: $totalscore"
	write-host "roundscore: $roundscore"
	$totalscore = $totalscore + $roundscore
	write-host "totalscore: $totalscore"
}
	
write-host "Score: $totalscore"
