#!/bin/bash

exec 6<&0
exec 0< vaskiv2.txt

count=1
while read line
do
echo "Line #$count: $line"
count=$(( $count + 1 ))
done

exec 0<&6
read -p "Are you done now (y/n) ?" answer

case $answer in
y) echo "Goodbye";;
n) echo "Sorry, this is the end.";;
esac
