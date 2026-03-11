import codecs

filepath = r'c:\Users\grew1\Desktop\세월복원 홈페이지\style.css'
with codecs.open(filepath, 'r', encoding='utf-8') as f:
    lines = f.readlines()

new_lines = []
for line in lines:
    if '/* --- Premium Background Updates --- */' in line:
        break
    new_lines.append(line)

with codecs.open(filepath, 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print("Reverted successfully")
