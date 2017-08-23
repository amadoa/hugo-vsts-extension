$latestRelease = Invoke-WebRequest https://github.com/spf13/hugo/releases/latest -Headers @{"Accept"="application/json"}

# The releases are returned in the format {"id":3622206,"tag_name":"hello-1.0.0.11",...}, we have to extract the tag_name.
$json = $latestRelease.Content | ConvertFrom-Json
$latestVersion = $json.tag_name
$trimLatestVersion = $latestVersion.Substring(1)
$url = "https://github.com/spf13/hugo/releases/download/" + $latestVersion + "/hugo_" + $trimLatestVersion + "_Windows-64bit.zip"

Write-Host "Downloading Hugo " $trimLatestVersion
Invoke-WebRequest -Uri $url -OutFile hugo.zip

expand-archive -path "hugo.zip" -DestinationPath ".\ExtractedHugo"

Write-Host "Building website"
.\ExtractedHugo\hugo.exe -v