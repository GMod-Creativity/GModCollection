param(
    [string]$FilePath = $args[0]
)

if (-not (Test-Path $FilePath)) {
    Write-Host "Drag and drop a .txt file onto the .bat file to extract URLs."
    pause
    exit
}

$content = Get-Content $FilePath -Raw
$regex = [regex]'"(http[s]?://[^"]+)"'
$matches = $regex.Matches($content)

$urls = @()
foreach ($match in $matches) {
    $urls += $match.Groups[1].Value
}

# Remove duplicates and strip trailing ?dl=0 (case-insensitive)
$cleanUrls = $urls | Sort-Object -Unique | ForEach-Object {
    $_ -replace '\?dl=0$', ''
}

# Format output
$outputLines = @("PAC FILES:`r`n")
foreach ($url in $cleanUrls) {
    $fileName = [System.IO.Path]::GetFileNameWithoutExtension($url)
    $extension = [System.IO.Path]::GetExtension($url)
    $cleanName = "$fileName$extension"
    $outputLines += $cleanName
    $outputLines += $url
    $outputLines += "-" * 100
}

$tempFile = "$env:TEMP\extracted_urls.txt"
$outputLines | Set-Content $tempFile
Start-Process cmd.exe "/k type `"$tempFile`" & pause"
