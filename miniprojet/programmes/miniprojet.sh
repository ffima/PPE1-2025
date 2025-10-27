file=$1
num=1
output="/Users/serafimaklimova/PPE1-2025/miniprojet/tableaux/tableau-fr.tsv"
echo "Numéro\tURL\tCode_HTTP\tEncodage\tNb_mots" > "$output"
while read -r line; do
    if [ -n "$line" ]; then
        code=$(curl -s -o /dev/null -w "%{http_code}" "$line")

        content=$(curl -s "$line")
        encoding=$(echo "$content" | grep -iPo '(?<=charset=)[a-zA-Z0-9_-]+' | head -n 1)

        nb_mots=$(echo "$content" | wc -w)

        if [ -z "$encoding" ]; then
            encoding="non présent"
        fi

        echo "${num}\t${line}\t${code}\t${encoding}\t${nb_mots}" >> "$output"
        ((num++))
    fi
done < "$file"
