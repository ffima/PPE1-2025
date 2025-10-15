#!/bin/zsh

echo "argument donné : $1"

CHEMIN=$1

for ANNEE in 2016 2017 2018
do
    echo "Nombre de lieux en $ANNEE:" 
    cat "$CHEMIN/$ANNEE/"* | grep Location | wc -l 
done