#! /bin/bash

COUNT=0

while [ $COUNT -lt 10 ]; do
	echo " Current counter is $COUNT "
	COUNT=$(($COUNT+1))
done

for x in {1..10}; do
	echo " X = $x"
done
