DATADIR=$1
ANNEE=$2
MOIS=$3
TOPN=$4

if [ ! -d $DATADIR ]
then
        echo "$DATADIR n'est pas un dossier"
        exit &
fi 

if [ ! -d $DATADIR/2016 ] || [ ! -d $DATADIR/2017 ] || [ ! -d $DATADIR/2018 ]
then
        echo "$DATADIR n'est probabment pas le bon dossier"
fi

cd $DATADIR

cat ./${ANNEE}/${ANNEE}_${MOIS}_*.ann | grep Location | cut -f3 | sort | uniq -c | sort -n -r | head -n $TOPN 