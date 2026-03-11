param([string]$path)

try {
    $content = Get-Content -Path $path -Encoding UTF8 -Raw
} catch {
    Write-Host "Failed to read file: $_"
    exit 1
}

# The user felt the champagne gold was still not a good fit for dark green.
# Usually, dark green (like Racing Green or Emerald) pairs exceptionally well with 
# a sophisticated soft cream, pearl, or muted beige (no strong yellow undertones).
# Let's use a premium warm pearl/sand color: #e1d8c9

$content = $content.Replace("--accent: #d8c381;", "--accent: #e1d8c9;")
$content = $content.Replace("#d8c381", "#e1d8c9")
$content = $content.Replace("--border-gold: rgba(216, 195, 129, 0.3);", "--border-gold: rgba(225, 216, 201, 0.3);")
$content = $content.Replace("rgba(216, 195, 129", "rgba(225, 216, 201")
$content = $content.Replace("rgba(216,195,129", "rgba(225,216,201")

try {
    Set-Content -Path $path -Value $content -Encoding UTF8
    Write-Host "CSS accent color updated to Warm Pearl."
} catch {
    Write-Host "Failed to save file: $_"
    exit 1
}
