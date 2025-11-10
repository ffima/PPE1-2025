if [ $# -ne 2 ]
then
    echo "Le scripte attend exactement deux arguments: le chemin vers le fichier d'URL et le chemin vers le dossier de sortie"
    exit
fi

FICHIER_URL=$1
DOSSIER_SORTIE=$2
FICHIER_RESULTAT="$DOSSIER_SORTIE/tableau-fr.tsv"

echo "Numéro\tURL\tCode_HTTP\tEncodage\tNb_mots" > "$FICHIER_RESULTAT"

num=1
while read -r line; do
    if [ -n "$line" ]; then

        code=$(curl -s -o /dev/null -w "%{http_code}" "$line")

        content=$(curl -s "$line")

        encoding=$(echo "$content" | grep -iPo '(?<=charset=)[a-zA-Z0-9_-]+' | head -n 1)
        if [ -z "$encoding" ]; then
            encoding="non présent"
        fi

        nb_mots=$(echo "$content" | lynx -dump -stdin -nolist | wc -w)

        echo "${num}\t${line}\t${code}\t${encoding}\t${nb_mots}" >> "$FICHIER_RESULTAT"

        ((num++))
    fi
done < "$FICHIER_URL"