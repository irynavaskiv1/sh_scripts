#!/bin/bash

echo "hello ira" > vaskiv.txt

echo "read file use cat"
cat vaskiv.txt 

while read line
  do
    echo $line
done < vaskiv.txt
