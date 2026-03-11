param([string]$path)

try {
    $content = Get-Content -Path $path -Encoding Default -Raw
} catch {
    Write-Host "Failed to read file: $_"
    exit 1
}

# 1. Variables in :root
$content = $content.Replace("--bg-color: #0a0a0a;", "--bg-color: #0a130e;")
$content = $content.Replace("--card-bg: #151515;", "--card-bg: #121c16;")
$content = $content.Replace("--border-color: #262626;", "--border-color: #1e2c22;")
$content = $content.Replace("--accent: #d4af37;", "--accent: #C2A878;")
$content = $content.Replace("--text-muted: #888888;", "--text-muted: #8a9c8f;")
$content = $content.Replace("--border-gold: rgba(212, 175, 55, 0.3);", "--border-gold: rgba(194, 168, 120, 0.3);")

# 2. Hardcoded hex color values
$content = $content.Replace("#d4af37", "#C2A878")
$content = $content.Replace("#D4AF37", "#C2A878")
$content = $content.Replace("#0a0a0a", "#0a130e")
$content = $content.Replace("#0A0A0A", "#0a130e")
$content = $content.Replace("#151515", "#121c16")

# 3. Hardcoded rgba
$content = $content.Replace("rgba(212, 175, 55", "rgba(194, 168, 120")
$content = $content.Replace("rgba(212,175,55", "rgba(194,168,120")
$content = $content.Replace("rgba(10, 10, 10", "rgba(10, 19, 14")
$content = $content.Replace("rgba(10,10,10", "rgba(10,19,14")

# 4. Other dark backgrounds
$content = $content.Replace("background: #111;", "background: #0f1c14;")
$content = $content.Replace("background-color: #111;", "background-color: #0f1c14;")
$content = $content.Replace("background: #000;", "background: #050a07;")
$content = $content.Replace("background-color: #000;", "background-color: #050a07;")

# 5. Some specific button backgrounds or borders
$content = $content.Replace("border: 1px solid #333;", "border: 1px solid #233629;")
$content = $content.Replace("border-bottom: 1px solid #333;", "border-bottom: 1px solid #233629;")
$content = $content.Replace("border-top: 1px solid #333;", "border-top: 1px solid #233629;")

# 6. Specific gold colors elsewhere
$content = $content.Replace("color: #d4af37;", "color: #C2A878;")

# Let's also check for radial gradients that might use #151515 or #0a0a0a
# They are covered by the string replacement.

try {
    # Save back as UTF8 
    Set-Content -Path $path -Value $content -Encoding UTF8
    Write-Host "CSS updated successfully."
} catch {
    Write-Host "Failed to save file: $_"
    exit 1
}
