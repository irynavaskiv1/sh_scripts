#!/bin/bash

# example - 1
for i in {8..10}
do
	echo "hello $i"
done

# example - 2
for i in 10 20 30
do
	echo "ira has $i money"
done


# read all files in directory
for fileName in *
do
	echo "file name: $fileName"
done

# example - 3
for i in {1..100}
do
 if [['$i' -gt '10' && '$i' -le '50']]; then
	echo 'i: ${i}'
 fi
done

# example loop with continue statement
for i in {1..10}; do
        if[[ "$i" -eq '8']]; then
           break
        fi
        echo 'i: $i'
done

# example loop with break statement
for i in {1..10}; do
	if[[ "$i" -eq '8']]; then
	   break
	fi
	echo 'i: $i'
done
