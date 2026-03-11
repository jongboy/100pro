$brainDir = "C:\Users\grew1\.gemini\antigravity\brain\698907e0-f546-4188-8fe4-520dc70da60e"
$targetDir = "c:\Users\grew1\Desktop\세월복원 홈페이지\premium_assets"

# 1. Copy the background image
$heroBgSrc = Get-ChildItem -Path $brainDir -Filter "hero_bg_dark_green_*.png" | Select-Object -First 1
if ($heroBgSrc) {
    Copy-Item -Path $heroBgSrc.FullName -Destination (Join-Path $targetDir "hero_bg.png") -Force
}

# 2. Append the CSS to style.css
$cssPath = "c:\Users\grew1\Desktop\세월복원 홈페이지\style.css"

$appendCss = "
/* --- Premium Background Updates --- */
.dash-hero .hero-terminal {
    background-image: linear-gradient(to right, rgba(10, 19, 14, 0.95) 0%, rgba(10, 19, 14, 0.6) 100%), url('premium_assets/hero_bg.png') !important;
    background-size: cover !important;
    background-position: center !important;
    border: 1px solid var(--border-gold) !important;
}

/* Add a subtle background texture to the main site wrapper for a more luxurious feel instead of flat color */
body {
    background: radial-gradient(circle at top, #121c16 0%, #0a130e 100%) !important;
    background-attachment: fixed !important;
}
"

Add-Content -Path $cssPath -Value $appendCss -Encoding UTF8
Write-Host "Background copied and CSS appended successfully."
