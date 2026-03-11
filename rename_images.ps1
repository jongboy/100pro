$dir = "c:\Users\grew1\Desktop\세월복원 홈페이지\premium_assets"
Rename-Item -Path "$dir\diff_color_match_*.png" -NewName "diff_color_match.png" -ErrorAction SilentlyContinue
Rename-Item -Path "$dir\diff_eco_friendly_*.png" -NewName "diff_eco_friendly.png" -ErrorAction SilentlyContinue
Rename-Item -Path "$dir\diff_perfect_finish_*.png" -NewName "diff_perfect_finish.png" -ErrorAction SilentlyContinue
Rename-Item -Path "$dir\matrix_door_*.png" -NewName "matrix_door.png" -ErrorAction SilentlyContinue
Rename-Item -Path "$dir\matrix_floor_*.png" -NewName "matrix_floor.png" -ErrorAction SilentlyContinue
Rename-Item -Path "$dir\matrix_marble_*.png" -NewName "matrix_marble.png" -ErrorAction SilentlyContinue
Rename-Item -Path "$dir\matrix_wall_*.png" -NewName "matrix_wall.png" -ErrorAction SilentlyContinue
Write-Host "Renamed successfully"
