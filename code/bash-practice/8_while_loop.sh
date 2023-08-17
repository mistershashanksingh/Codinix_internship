#!/bin/bash

echo -e " Program to print number 1...10 using while loop\n"

i=1
while [ $i -le 10 ];
do
  echo "Loop iterate:" $i
  ((i++))
done
