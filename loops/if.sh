#! /bin/bash

if   [ "$1"=='Ira' ]; then
	echo "Hi, $1"
elif [ '$1'=='Anya' ]; then
	echo 'Hi, $2'
else echo 'Hi, $1'
fi
x=$2

echo 'Starting case selection...'
case $x in
	20) echo "20 years old";;
	22) echo "You are so sweet"
esac

# --------------------------------------------------------------------

if pwd
then
echo "It works"
fi

# --------------------------------------------------------------------

user=iryna
if grep $user /etc/passwd
then
echo "The user $user Exists"
else
echo "The user $user does not exist"
fi
