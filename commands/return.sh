#!/bin/bash

function myfunc {
read -p "Enter a value: " value
echo "adding value"
return $(( $value + 10 ))
}
myfunc
echo "The new value is $?"
