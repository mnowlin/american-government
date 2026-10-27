#!/bin/zsh
# Render lecture .qmd files to self-contained reveal.js HTML and re-render the site.
# Usage: ./update-slides.sh                     # all lectures that have slides posted
#        ./update-slides.sh 12-public-opinion   # one lecture (new or updated)
cd "${0:A:h}"
LECT="${0:A:h}/../lectures"
OUT="${0:A:h}/slides"
if [[ -n "$1" ]]; then names=("$1"); else names=("$OUT"/*.html(:t:r)); fi
cd "$LECT"
for b in $names; do
  quarto render "$b.qmd" --to revealjs -M embed-resources:true -o "web-$b.html" >/dev/null 2>&1 \
    && mv "web-$b.html" "$OUT/$b.html" && echo "✓ $b.html" || echo "✗ $b failed"
done
cd "${0:A:h}"
quarto render
