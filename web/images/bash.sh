#!/bin/sh

SOURCE="icons/*"
STRING="\""
BUF="\", \""

for file in $SOURCE
do
	STRING=$STRING$BUF$file
done
echo "$STRING\""
