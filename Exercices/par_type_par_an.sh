TYPE=$1
DATADIR=$2

A=$( ./compte_par_type.sh $DATADIR 2016 $TYPE)
B=$( ./compte_par_type.sh $DATADIR 2017 $TYPE)
C=$( ./compte_par_type.sh $DATADIR 2018 $TYPE)

echo " en 2016 : $A; en 2017 : $B; en 2018 : $C." 