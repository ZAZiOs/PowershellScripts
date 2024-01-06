$resultFolder = './'
if ($args.length -eq 0) {
	Write-Host "`n                    =====mid2mp3====" -ForegroundColor Red
	Write-Host "                    This tool needs:" -ForegroundColor Red
	Write-Host "         Chocolatey | winget install chocolatey" -ForegroundColor DarkGray
	Write-Host "         FluidSynth | choco  install fluidsynth" -ForegroundColor Green
	Write-Host "         FFmpeg     | winget install ffmpeg`n" -ForegroundColor Blue
	Write-Host "Usage: " -NoNewLine
	Write-Host "mid2mp3 " -ForegroundColor Yellow -NoNewLine
	Write-Host "SoundFont.sf2 " -ForegroundColor Red -NoNewLine
	Write-Host "NoteFile1.mid NoteFile2.mid...`n" -ForegroundColor DarkCyan
} elseif ($args.length -lt 2) {
	Write-Host "`nERROR: Not enough arguments!" -ForegroundColor Red
	Write-Host "Usage: " -NoNewLine
	Write-Host "mid2mp3 " -ForegroundColor Yellow -NoNewLine
	Write-Host "SoundFont.sf2 " -ForegroundColor Red -NoNewLine
	Write-Host "NoteFile1.mid NoteFile2.mid...`n" -ForegroundColor DarkCyan
} else {
	$resultStr = ""
	$toFolder = $resultFolder + $args[0].replace('.sf2', '/').replace('.\', "")
	md -Force $resultFolder | Out-Null
	md -Force $toFolder | Out-Null
	
	for (($i = 1); $i -lt $args.length; $i++)
	{
		fluidsynth -F .\temp.wav $args[0] $args[$i]
		$result = $args[0].replace('.sf2', '') + '-' + $args[$i].replace('.mid','').replace('.\', "") + ".mp3"
		$filepath = $toFolder + $result.replace('.\', '')
		ffmpeg -i temp.wav -vn -ar 44100 -ac 2 -b:a 192k $filepath
		rm 'temp.wav'
		$resultStr = $resultStr + "$($result.replace('.\', ''))`n"
		
	}
	Write-Host "Done:`n$($resultStr)"
}