q=$(echo "https://hdaudiobooks.net//?s=$@" | tr ' ' '+')
html=$(curl -s "$q")
name=$(echo "$html" | grep "<h2>" | cut -d'"' -f4 | sed -e 's/&#8211/\-/g;' | fzf | sed -e 's/\-/\&#8211/g')
links=$(curl -s "$(echo "$html" | grep "$name" | cut -d'"' -f2 | head -n 1)" | grep "mp3" | cut -d'"' -f14)
mpv $(echo "$links" | grep "=$(echo "$links" | cut -d "=" -f 2 | fzf)")
