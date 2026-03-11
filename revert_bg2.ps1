$path = 'c:\Users\grew1\Desktop\세월복원 홈페이지\style.css'
$content = Get-Content -Path $path
$newContent = @()
foreach ($line in $content) {
    if ($line -match '/\* --- Premium Background Updates --- \*/') {
        break
    }
    $newContent += $line
}
Set-Content -Path $path -Value $newContent
Write-Host "Reverted successfully"
