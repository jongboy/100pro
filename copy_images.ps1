$brainDir = "C:\Users\grew1\.gemini\antigravity\brain\698907e0-f546-4188-8fe4-520dc70da60e"
$targetDir = "c:\Users\grew1\Desktop\세월복원 홈페이지\premium_assets"

if (!(Test-Path -Path $targetDir)) {
    New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
}

$files = @{
    "diff_color_match_1773232059882.png" = "diff_color_match.png"
    "diff_eco_friendly_1773232076371.png" = "diff_eco_friendly.png"
    "diff_perfect_finish_1773232094580.png" = "diff_perfect_finish.png"
    "matrix_floor_1773232121452.png" = "matrix_floor.png"
    "matrix_door_1773232140345.png" = "matrix_door.png"
    "matrix_marble_1773232160956.png" = "matrix_marble.png"
    "matrix_wall_1773232179425.png" = "matrix_wall.png"
}

foreach ($key in $files.Keys) {
    $source = Join-Path -Path $brainDir -ChildPath $key
    $dest = Join-Path -Path $targetDir -ChildPath $files[$key]
    Copy-Item -Path $source -Destination $dest -Force
}

Write-Host "Images copied successfully."
