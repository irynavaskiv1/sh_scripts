#!/bin/bash

# $0 mean  caller
# $1.. var
# $$ proces id

printMe(){

    echo "process id $$"
    echo "hello irynka $1"
    echo "age $2"
    echo "job is $3"
}

#echo hello>job$$
printMe irynka 24 qa
printMe taras 29 programmer
printMe maria 55 banker
