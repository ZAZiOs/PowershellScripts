# Created by ZAZiOs

# HELP:
if ($args.length -lt 1) {
""
Write-Host "             ================== Subtitle Tool ==================" -ForegroundColor DarkYellow
""
Write-Host "                                    Warning!" -ForegroundColor DarkGray
Write-Host "               YT-DLP and ffmpeg is required to run this script" -ForegroundColor DarkGray
""

Write-Host "                    HardSub: " -NoNewLine -ForegroundColor Red
Write-Host "subtool.ps1 " -NoNewLine -ForegroundColor Yellow
Write-Host "hs  " -NoNewLine -ForegroundColor Red
Write-Host "in-video  " -NoNewLine -ForegroundColor Magenta
Write-Host "in-subs    " -NoNewLine -ForegroundColor Blue
Write-Host "out-video" -ForegroundColor DarkYellow

Write-Host "              Get lang-code: " -NoNewLine -ForegroundColor Green
Write-Host "subtool.ps1 " -NoNewLine -ForegroundColor Yellow
Write-Host "ls            " -NoNewLine -ForegroundColor Green
Write-Host "video-link" -ForegroundColor DarkGray

Write-Host "          Download Subtitle: " -NoNewLine -ForegroundColor Cyan
Write-Host "subtool.ps1 " -NoNewLine -ForegroundColor Yellow
Write-Host "dl  " -NoNewLine -ForegroundColor Cyan
Write-Host "lang-code " -NoNewLine -ForegroundColor Green
Write-Host "video-link " -NoNewLine -ForegroundColor DarkGray
Write-Host "<subformat>" -ForegroundColor Yellow

Write-Host "  Download Autogen Subtitle: " -NoNewLine -ForegroundColor DarkCyan
Write-Host "subtool.ps1 " -NoNewLine -ForegroundColor Yellow
Write-Host "adl " -NoNewLine -ForegroundColor DarkCyan
Write-Host "lang-code " -NoNewLine -ForegroundColor Green
Write-Host "video-link " -NoNewLine -ForegroundColor DarkGray
Write-Host "<subformat>" -ForegroundColor Yellow

""
Write-Host "             ===================================================" -ForegroundColor DarkYellow

	
# Hardsub
} elseif ($args[0] -eq "hs") {
	if ($args.length -lt 4) {
		Write-Host "Usage: subtool.ps1 hs in-video in-subs out-video"
	} else {
		$video = $args[1]
		$sub = $args[2]
		$out = $args[3]
		ffmpeg -i $video -vf subtitles=$sub $out
	}
# List subs
} elseif ($args[0] -eq "ls") {
	$video = $args[1]
	yt-dlp --list-subs $video
# Subtitle Download
} elseif ($args[0] -eq "dl") {
	if ($args.length -lt 3) {
		Write-Host "Usage: subtool.ps1 dl lang-code video <subformat>"
	} elseif ($args.length -lt 4) {
		$lang = $args[1]
		$video = $args[2]
		yt-dlp --write-sub --sub-lang $lang --skip-download --convert-subs=srt $video 
	} else {
		$lang = $args[1]
		$video = $args[2]
		$subformat = $args[3]
		yt-dlp --write-sub --sub-lang $lang --skip-download --convert-subs=$subformat $video 
	}
# Autosubs Download
} elseif ($args[0] -eq "adl") {
	if ($args.length -lt 3) {
		Write-Host "Usage: subtool.ps1 dl lang-code video <subformat>"
	} elseif ($args.length -lt 4) {
		$lang = $args[1]
		$video = $args[2]
		yt-dlp --write-auto-sub --sub-lang $lang --skip-download --convert-subs=srt $video 
	} else {
		$lang = $args[1]
		$video = $args[2]
		$subformat = $args[3]
		yt-dlp --write-auto-sub --sub-lang $lang --skip-download --convert-subs=$subformat $video 
	}
}

