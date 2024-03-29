# Script created with love by ZAZiOs   

$dloadfolder = ".\download"
if (!$args -or ($args[0] -eq 'help')) {
Write-Host "                   ================== yt-dlp easifier ==================" -ForegroundColor Magenta

if (!($args[0] -eq 'help')) {
""
Write-Host "                                          Warning!" -ForegroundColor Red
Write-Host "                     YT-DLP and ffmpeg is required to run this script."
""
"                                          --Help--"
}

""

Write-Host "        Download Video: " -NoNewLine -ForegroundColor Green
Write-Host "ydle.ps1" -NoNewLine -ForegroundColor Yellow
Write-Host "        vid " -NoNewLine -ForegroundColor Green
Write-Host "(link) " -NoNewLine -ForegroundColor DarkGray
Write-Host "<format-id>" -ForegroundColor Yellow

Write-Host "        Download Audio: " -NoNewLine -ForegroundColor Red
Write-Host "ydle.ps1" -NoNewLine -ForegroundColor Yellow
Write-Host "    aud     " -NoNewLine -ForegroundColor Red
Write-Host "(link) " -NoNewLine -ForegroundColor DarkGray
Write-Host "<format-id>" -ForegroundColor Yellow

Write-Host "     Download Fragment: " -NoNewLine -ForegroundColor DarkCyan
Write-Host "ydle.ps1" -NoNewLine -ForegroundColor Yellow
Write-Host " fr " -NoNewLine
Write-Host "aud" -NoNewLine -ForegroundColor Red
Write-Host "/" -NoNewLine -ForegroundColor DarkCyan
Write-Host "vid " -NoNewLine -ForegroundColor Green
Write-Host "(link) " -NoNewLine -ForegroundColor DarkGray
Write-Host "(from XX:XX:XX) " -NoNewLine -ForegroundColor Blue
Write-Host "(to XX:XX:XX) " -NoNewLine -ForegroundColor DarkYellow
Write-Host "<format-id>" -ForegroundColor Yellow

Write-Host "   List of <format-id>: " -NoNewLine -ForegroundColor DarkYellow
Write-Host "ydle.ps1" -NoNewLine -ForegroundColor Yellow
Write-Host " lf         " -NoNewLine
Write-Host "(link) " -ForegroundColor DarkGray

""

Write-Host "                     *Note: If you want to mix certain audio and video
                        from format list you can enter it like that: " -ForegroundColor DarkGray
Write-Host "      Download and mix: " -NoNewLine -ForegroundColor Green
Write-Host "ydle.ps1" -NoNewLine -ForegroundColor Yellow
Write-Host "        vid " -NoNewLine -ForegroundColor Green
Write-Host "(link) " -NoNewLine -ForegroundColor DarkGray
Write-Host "<videoFormatID>+<audioFormatID>" -ForegroundColor Yellow

if (!($args[0] -eq 'help')) {
""
"                                          --------"
""
Write-Host "                    Caution: " -NoNewLine -ForegroundColor Red
Write-Host "Download Fragmet " -NoNewLine -ForegroundColor DarkCyan
Write-Host "works kinda buggy, so the
                         result can be a little broken at the start."
}

""

Write-Host "                   =====================================================" -ForegroundColor Magenta
}


if ($args[0] -eq 'vid') {
	if ($args.length -lt 2) {
		""
		Write-Host "Error: " -NoNewLine -ForegroundColor Red
		"Insufficient arguments entered."
		""
	} else {
		$link = $args[1]
		$format = $args[2]
		if ($format) {
			yt-dlp $link -f $format -o "$dloadfolder\%(title)s.%(ext)s"
		} else {
			yt-dlp $link -f best -o "$dloadfolder\%(title)s.%(ext)s"
		}
	}
} 

if ($args[0] -eq 'aud') {
	if ($args.length -lt 2) {
		""
		Write-Host "Error: " -NoNewLine -ForegroundColor Red
		"Insufficient arguments entered."
		""
	} else {
		$link = $args[1]
		$format = $args[2]
		if ($format) {
			yt-dlp $link -f $format --extract-audio --audio-format mp3 -o "$dloadfolder\%(title)s.%(ext)s"
		} else {
			yt-dlp $link -f "bestaudio" --extract-audio --audio-format mp3 -o "$dloadfolder\%(title)s.%(ext)s"
		}
	}
} 

if ($args[0] -eq 'fr') {
	if ($args.length -lt 5) {
		""
		Write-Host "Error: " -NoNewLine -ForegroundColor Red
		"Insufficient arguments entered."
		""
	} else {
		if ($args[1] -eq 'vid') {
			$link = $args[2]
			$startTime = $args[3]
			$endTime = $args[4]
			$format = $args[5]
			if ($format) {
				yt-dlp $link --download-sections "*$startTime-$endTime" -f $format -o "$dloadfolder\%(title)s.%(ext)s"
			} else {
				yt-dlp $link --download-sections "*$startTime-$endTime" -f mp4 -o "$dloadfolder\%(title)s.%(ext)s"
			}
		}
		if ($args[1] -eq 'aud') {
			$link = $args[2]
			$startTime = $args[3]
			$endTime = $args[4]
			$format = $args[5]
			if ($format) {
				yt-dlp $link --download-sections "*$startTime-$endTime" -f $format --extract-audio --audio-format mp3 -o "$dloadfolder\%(title)s.%(ext)s"
			} else {
				yt-dlp $link --download-sections "*$startTime-$endTime" -f "bestaudio" --extract-audio --audio-format mp3 -o "$dloadfolder\%(title)s.%(ext)s"
			}
		}
		if ($args[1] -eq 'aud/vid') {
			""
			Write-Host "Please, choose" -NoNewLine
			Write-Host " AUDIO " -NoNewLine -ForegroundColor Red
			Write-Host "or" -NoNewLine -ForegroundColor DarkCyan
			Write-Host " VIDEO " -NoNewLine -ForegroundColor Green
			Write-Host "and then input" -NoNewLine
			Write-Host " aud " -NoNewLine -ForegroundColor Red
			Write-Host "or" -NoNewLine -ForegroundColor DarkCyan
			Write-Host " vid " -ForegroundColor Green
			""
		}
	}
} 

if ($args[0] -eq 'lf') {
	if ($args.length -lt 2) {
		""
		Write-Host "Error: " -NoNewLine -ForegroundColor Red
		"Insufficient arguments entered."
		""
	} else {
		$link = $args[1]
		yt-dlp --list-formats $link
	}
} 