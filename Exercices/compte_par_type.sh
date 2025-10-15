#!/bin/zsh

ANNEE=$1
TYPE=$2
DIR="/Users/serafimaklimova/Exercice1/ann"

cat $DIR/$ANNEE/*.ann | grep "$TYPE" | wc -l
