if [ $# -ne 2 ]
then
    echo "Le scripte attend exactement deux arguments: le chemin vers le fichier d'URL et le chemin vers le dossier de sortie"
    exit
fi

FICHIER_URL=$1
DOSSIER_SORTIE=$2
FICHIER_RESULTAT="$DOSSIER_SORTIE/tableau-fr.html"
echo "<html><body><table border=\"1\"><thead><tr><th>Numéro</th><th>URL</th><th>Code_HTTP</th><th>Encodage</th><th>NB_mots</th></tr></thead><tbody>" > "$FICHIER_RESULTAT"

num=1
while read -r line; do
    if [ -n "$line" ]; then
        code=$(curl -s -o /dev/null -w "%{http_code}" "$line")
        content=$(curl -s "$line")
        encoding=$(echo $content | grep -ioP 'charset=["'\''"]?\K[^"'\'' >]+' | head -n 1)
        if [ -z "$encoding" ]; then
            encoding="non présent"
        fi
        nb_mots=$(lynx -dump -nolist $line | wc -w)
        echo "<tr><td>${num}</td><td>${line}</td><td>${code}</td><td>${encoding}</td><td>${nb_mots}</td></tr>" >> "$FICHIER_RESULTAT"
        ((num++))
    fi
done < "$FICHIER_URL"
echo "</table></body></html>" >> "$FICHIER_RESULTAT"