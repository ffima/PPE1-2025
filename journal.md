# Journal de bord du projet encadré
## 4/10: 
création du dépôt PPE1-2025; récupération du dépôt; création du journal de bord; transmission des changements avec 'git pull'; 'git log' pour vérifier le commit 
## Devoir 2 (15/10)
Pendant le cours, nous avons fait l’exercice 1 des scripts bash et j’ai mis ma version sur Git.  
J’ai réussi à créer un script pour compter le nombre de personnes, organisations et lieux dans les fichiers de 2016, mais je n’ai pas encore adapté ça pour d’autres années.

```bash
#!/bin/zsh
echo "Argument : $1"
CHEMIN=$1
cat "$CHEMIN/2016/"* | grep Location | wc -l
cat "$CHEMIN/2016/"* | grep Person | wc -l
cat "$CHEMIN/2016/"* | grep Organisation | wc -l

## Devoir 3 
Le 14/10, en cours, nous avons travaillé sur les exercices 2 et 3 des scripts bash.

On a appris à utiliser plusieurs arguments dans une commande et à appeler un script depuis un autre. Puis on a adapté notre premier script comptes.sh pour qu’il fonctionne avec une boucle for … in.

## Devoir 4
Réponses aux questions sur les diapos :
Les arguments utilisés avec cat ne changent pas le résultat final du script.
Il faut ajouter un argument file=$1 et indiquer le chemin vers le fichier contenant les URLs lors de l’exécution.
Il faut créer une variable num=1 et l’afficher avant la première tabulation.

Après l’exercice 1, mon script était :
file=$1
num=1

while read -r line; do
    echo "${num}\t${line}"
    num=$((num+1))
done < "${file}";

J'ai remarqué que l’option -e d’echo n’es pas nécessaire sur macOS ; si je l’utilise, -e s’affiche dans le tableau 
