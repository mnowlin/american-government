#!/bin/zsh
# Convert lecture .pptx files to PDF (via Microsoft PowerPoint) and re-render the site.
# Usage: ./update-slides.sh            # all lectures
#        ./update-slides.sh 12-public-opinion   # one lecture
cd "${0:A:h}"
LECT="${0:A:h}/../lectures"
OUT="${0:A:h}/slides"
if [[ -n "$1" ]]; then files=("$LECT/$1.pptx"); else files=("$LECT"/[01]*.pptx); fi
for f in $files; do
  b=${f:t:r}
  [[ $b == 00-syllabus ]] && continue
  osascript -e "tell application \"Microsoft PowerPoint\"
    open POSIX file \"$f\"
    set p to active presentation
    save p in POSIX file \"$OUT/$b.pdf\" as save as PDF
    close p saving no
  end tell" && echo "✓ $b.pdf"
done
quarto render
