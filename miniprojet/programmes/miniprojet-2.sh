if [ $# -ne 2 ]; then
    echo "Le script attend exactement deux arguments: le chemin vers le fichier d'URL et le chemin vers le dossier de sortie"
    exit 1
fi

FICHIER_URL=$1
DOSSIER_SORTIE=$2
FICHIER_RESULTAT="$DOSSIER_SORTIE/tableau-fr.html"

echo "<!DOCTYPE html>" > "$FICHIER_RESULTAT"
echo "<html lang=\"fr\">" >> "$FICHIER_RESULTAT"
echo "<head>" >> "$FICHIER_RESULTAT"
echo "<meta charset=\"UTF-8\">" >> "$FICHIER_RESULTAT"
echo "<title>Tableau des URLs</title>" >> "$FICHIER_RESULTAT"
echo "<style>" >> "$FICHIER_RESULTAT"
echo "table { border-collapse: collapse; width: 100%; }" >> "$FICHIER_RESULTAT"
echo "th, td { border: 1px solid #000; padding: 8px; text-align: left; }" >> "$FICHIER_RESULTAT"
echo "th { background-color: #f2f2f2; }" >> "$FICHIER_RESULTAT"
echo "</style>" >> "$FICHIER_RESULTAT"
echo "</head>" >> "$FICHIER_RESULTAT"
echo "<body>" >> "$FICHIER_RESULTAT"
echo "<table>" >> "$FICHIER_RESULTAT"
echo "<tr><th>Numéro</th><th>URL</th><th>Code HTTP</th><th>Encodage</th><th>Nb mots</th></tr>" >> "$FICHIER_RESULTAT"

lineno=1
while read -r line; do
    if [ -n "$line" ]; then
        code=$(curl -s -o /dev/null -w "%{http_code}" "$line")
        content=$(curl -s "$line")
        encoding=$(echo "$content" | grep -iPo '(?<=charset=)[a-zA-Z0-9_-]+' | head -n 1)
        if [ -z "$encoding" ]; then
            encoding="non présent"
        fi
        nb_mots=$(echo "$content" | lynx -dump -stdin -nolist | wc -w)
        echo "<tr>" >> "$FICHIER_RESULTAT"
        echo "<td>${lineno}</td>" >> "$FICHIER_RESULTAT"
        echo "<td><a href=\"${line}\" target=\"_blank\">${line}</a></td>" >> "$FICHIER_RESULTAT"
        echo "<td>${code}</td>" >> "$FICHIER_RESULTAT"
        echo "<td>${encoding}</td>" >> "$FICHIER_RESULTAT"
        echo "<td>${nb_mots}</td>" >> "$FICHIER_RESULTAT"
        echo "</tr>" >> "$FICHIER_RESULTAT"

        lineno=$((lineno + 1))
    fi
done < "$FICHIER_URL"

echo "</table>" >> "$FICHIER_RESULTAT"
echo "</body>" >> "$FICHIER_RESULTAT"
echo "</html>" >> "$FICHIER_RESULTAT"
