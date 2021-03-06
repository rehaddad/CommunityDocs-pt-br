
$Title = ""
$logFile = "MDFileList.csv"

#cd "C:\BUILD\Microsoft\ES-Community-Content\MSDN"

Get-ChildItem *.md -Exclude TOC.md -Recurse | 
#ForEach-Object {
#	$Title = Get-Content  $_.FullName -Encoding UTF8 -ReadCount 30  |  foreach { $_ -match "#" } | select -First 1
#	# remove '#' [ and ] chars form the title
#	$Title = $Title.Replace("#","")
#	
#	Write-Output ($Title + "; "+$_.BaseName+".md; "+ $_.DirectoryName )
#	} |  
#Out-File $logFile -Encoding UTF8
#


ForEach-Object {
	$block = Get-Content  $_.FullName -Encoding UTF8 -ReadCount 50  
	
	# identify the title as the line which starts with '#'
	$Title = $block | foreach { $_ -match "^#" } | select -First 1
	
	# remove '#' [ and ] chars form the title
	#removing it only from beginning of string
	$Title = ($Title -replace '^#','').Trim()
	
	#to handle titles that contain e.g. C# written as C\#
	$Title = $Title.Replace("\#", "#")
	
	$RelativePath =  $_.DirectoryName.Replace($PWD.Path,'')
	#$RelativePath = $RelativePath.Substring(1,$RelativePath.LastIndexOf("\"))
	Write-Output ($Title + "; "+$_.BaseName+".md; "+ $RelativePath )
	} |  
Out-File $logFile -Encoding UTF8
