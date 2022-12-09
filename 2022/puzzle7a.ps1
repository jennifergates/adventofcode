$i = get-content .\input7.txt -encoding utf8 -raw

Class Afile {
	[String]$name
	[String]$size
	[Adir]$parentdir
}

Class Adir {
	[String]$name
	[Adir]$parentdir
	[Adir[]]$childdirs
	[Afile[]]$childfiles
}

$dirstack = New-Object System.Collections.Stack

$commands = $i.split('$ cd ')

$root = new object Adir
$root.name = '/'

$parentdir = "/"
$currentdir = "/"

$parenthash = @{}
$sizehash = @{}
$parenthash2 = @{}

foreach ($c in $commands) {
	#write-host $c -foregroundcolor yellow
	write-host "`nCommands: cd " $c.split("`n") -foregroundcolor cyan
		$csplitted = $c.split("`n")
		$changeddir = $csplitted[0]
		#write-host "changed directory : $changeddir :"
		if ($changeddir -ne "..") {
			$dirstack.push($changeddir)
			$currentdir = $changeddir
		} elseif ($changeddir -eq ".."){
			$popped = $dirstack.pop()
			$currentdir = $dirstack.peek()
		}
		
		write-host "Current directory is $currentdir"
		
		if ($csplitted.count -gt 1){
			foreach ($cs in $csplitted){
				#write-host $cs
				if ($cs -match "^\d+ "){
					#write-host "$cs starts with a number"
					[int]$filesize, $filename = $cs.split(' ')
					write-host "$filename is a child of $dirparent and is $filesize bytes" 
					
					$sizehash[$dirparent] = $sizehash[$dirparent] + $filesize
				} elseif ($cs -match "^dir "){
					$dirname = $cs.split(' ')[1]
					$dirparent = $currentdir
					write-host "$dirname is a child of $dirparent" 
					$parenthash[$dirname] = $dirparent
					write-host "here" $parenthash2[$dirparent] -foregroundcolor green
					if ($parenthash2[$dirparent] -ne $null) {
						$parenthash2[$dirparent] += $dirname
					} else {
						write-host "else $dirname"
						$parenthash2[$dirparent] = @($dirname)
					}
				}
			}
		}
}


$sizehash.GetEnumerator() | sort-Object -Property Value -Descending

$parenthash.GetEnumerator() | Sort-object -property Value -Descending
<# 
foreach ($dir in $parenthash.keys){
	write-host $dir "is a size " $sizehash[$dir] "and its parent is "$parenthash[$dir] "and it's size is "$sizehash[$parenthash[$dir]]
} #>

<# $rootdirs = $parenthash.getenumerator() | where-object {$_.Value -eq "/"}

$rootdirs = $rootdirs.key
write-host "rootdirs:"
$rootdirs
 #>
$parenthash2