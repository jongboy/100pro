import re

file_path = r'c:\Users\grew1\Desktop\세월복원 홈페이지\style.css'

try:
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()
except UnicodeDecodeError:
    with open(file_path, 'r', encoding='euc-kr') as f:
        content = f.read()

# Replace variables
content = content.replace('--bg-color: #0a0a0a;', '--bg-color: #08110a;')
content = content.replace('--card-bg: #151515;', '--card-bg: #111a13;')
content = content.replace('--border-color: #262626;', '--border-color: #1e2820;')

# Re-brand the accent color to a luxury gold that pairs with dark green
# #CDA051 or #C2A878
content = content.replace('--accent: #d4af37;', '--accent: #C2A878;')
content = content.replace('--text-muted: #888888;', '--text-muted: #8e9a91;')
content = content.replace('--border-gold: rgba(212, 175, 55, 0.3);', '--border-gold: rgba(194, 168, 120, 0.3);')

# Replace hex codes anywhere
content = content.replace('#d4af37', '#C2A878')
content = content.replace('#D4AF37', '#C2A878')
content = content.replace('#0a0a0a', '#08110a')
content = content.replace('#0A0A0A', '#08110a')
content = content.replace('#151515', '#111a13')
content = content.replace('rgba(212, 175, 55', 'rgba(194, 168, 120')
content = content.replace('rgba(212,175,55', 'rgba(194,168,120')

# Specific string replacements
content = content.replace('background: #111;', 'background: #0f1812;')
content = content.replace('background-color: #111;', 'background-color: #0f1812;')
content = content.replace('background: #000;', 'background: #050a07;')
content = content.replace('background-color: #000;', 'background-color: #050a07;')

# Adjust some gradients if they exist
content = content.replace('linear-gradient(to top, rgba(10, 10, 10, 1)', 'linear-gradient(to top, rgba(8, 17, 10, 1)')
content = content.replace('linear-gradient(to bottom, rgba(10, 10, 10, 1)', 'linear-gradient(to bottom, rgba(8, 17, 10, 1)')
content = content.replace('rgba(10, 10, 10,', 'rgba(8, 17, 10,')

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)
print('CSS Updated successfully.')
