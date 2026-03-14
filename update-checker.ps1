$TempFolder = Join-Path ([System.IO.Path]::GetTempPath()) 'packwiz-update-checker'
New-Item -Path $TempFolder -ItemType Directory -Force | Out-Null
$OS = @{
    macOS   = @{
        URI = 'https://nightly.link/packwiz/packwiz/workflows/go/main/macOS%2064-bit%20x86.zip'
        Path = Join-Path $PSScriptRoot 'bin/macOS/packwiz'
    }
    Linux   = @{
        URI = 'https://nightly.link/packwiz/packwiz/workflows/go/main/Linux%2064-bit%20x86.zip'
        Path = Join-Path $PSScriptRoot 'bin/Linux/packwiz'
    }
    Windows = @{
        URI = 'https://nightly.link/packwiz/packwiz/workflows/go/main/Windows%2064-bit.zip'
        Path = Join-Path $PSScriptRoot 'bin/Windows/packwiz.exe'
    }
}

$r = $false # update required?

# extract to temp for hash checking
$OS.GetEnumerator() | ForEach-Object {
    Write-Information "Checking for updates for $($_.Key)..." -InformationAction Continue

    $Archive = Join-Path $TempFolder "packwiz-$($_.Key).zip"

    Invoke-WebRequest -Uri $_.Value.URI -OutFile $Archive -UseBasicParsing

    $NewBin = Expand-Archive -Path $Archive -DestinationPath $TempFolder -Force -PassThru

    $NewHash = Get-FileHash -Path $NewBin.FullName -Algorithm SHA256
    $CurrentHash = Get-FileHash -Path $_.Value.Path -Algorithm SHA256

    # if different, update the file
    if($NewHash.Hash -ne $CurrentHash.Hash) {
        $r = $true # update req'd
        Write-Information "  - Updating $($_.Key)." -InformationAction Continue
        Remove-Item -Path $_.Value.Path -Force -ErrorAction Stop
        Copy-Item -Path $NewBin.FullName -Destination $_.Value.Path -Force -ErrorAction Stop
    } else {
        Write-Information "  - No update needed for $($_.Key)." -InformationAction Continue
    }
    Remove-Item -Path $Archive, $NewBin.FullName -Force
}
Remove-Item $TempFolder -Force -Recurse -ErrorAction SilentlyContinue
return $r

#Requires -Version 7
