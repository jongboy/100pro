$path = 'c:\Users\grew1\Desktop\세월복원 홈페이지\style.css'
$content = Get-Content -Path $path -Encoding UTF8
$newContent = @()
foreach ($line in $content) {
    if ($line -match '/\* --- Premium Background Updates --- \*/') {
        break
    }
    $newContent += $line
}
Set-Content -Path $path -Value $newContent -Encoding UTF8
Write-Host "Reverted successfully"
