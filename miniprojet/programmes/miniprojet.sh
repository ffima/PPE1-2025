if [ $# -ne 2 ]
then
    echo "Le scripte attend exactement deux arguments: le chemin vers le fichier d'URL et le chemin vers le dossier de sortie"
    exit
fi

FICHIER_URL=$1
DOSSIER_SORTIE=$2
FICHIER_RESULTAT="$DOSSIER_SORTIE/tableau-fr.html"

echo '<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Résultats d'"'"'analyse des URLs</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.4/css/bulma.min.css">
</head>

<body>
    <section class="section">
        <div class="container">
            <div class="hero is-success mb-5">
                <div class="hero-body">
                    <h1 class="title is-size-2">Résultats d'"'"'analyse des URLs</h1>
                </div>
            </div>

            <a href="../../index.html" class="button is-light mb-5">
                ← Retour à l'"'"'accueil
            </a>
            <div class="is-flex is-justify-content-center">
                <table class="table is-striped is-hoverable box">
                    <thead>
                        <tr>
                            <th>Numéro</th>
                            <th>URL</th>
                            <th>Code HTTP</th>
                            <th>Encodage</th>
                            <th>NB mots</th>
                        </tr>
                    </thead>
                    <tbody>' > "$FICHIER_RESULTAT"

num=1
while read -r line; do
    if [ -n "$line" ]; then
        code=$(curl -s -o /dev/null -w "%{http_code}" "$line")
        content=$(curl -s "$line")
        encoding=$(echo $content | grep -ioP 'charset=["'\''"]?\K[^"'\'' >]+' | head -n 1)
        if [ -z "$encoding" ]; then
            encoding="non présent"
        fi
        nb_mots=$(lynx -dump -nolist "$line" | wc -w)
        echo "                        <tr>" >> "$FICHIER_RESULTAT"
        echo "                            <td>$num</td>" >> "$FICHIER_RESULTAT"
        echo "                            <td>$line</td>" >> "$FICHIER_RESULTAT"
        echo "                            <td>$code</td>" >> "$FICHIER_RESULTAT"
        echo "                            <td>$encoding</td>" >> "$FICHIER_RESULTAT"
        echo "                            <td>$nb_mots</td>" >> "$FICHIER_RESULTAT"
        echo "                        </tr>" >> "$FICHIER_RESULTAT"
        ((num++))
    fi
done < "$FICHIER_URL"

echo '                    </tbody>
                </table>
            </div>
        </div>
    </section>
</body>
</html>' >> "$FICHIER_RESULTAT"

echo "Page HTML générée: $FICHIER_RESULTAT"