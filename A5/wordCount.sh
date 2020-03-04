#!/bin/bash

declare -A array

function countWords {
  while read line; do
    for word in $line; do
      word=$(echo $word | tr [[:upper:]] [[:lower:]])
      ((array[$word]++))
    done
  done < $1
}

function printResult {
  echo 'RESULTS'
  echo '=================================================='
  for index in "${!array[@]}"; do
    count=${array[$index]}
    case $count in
      1) echo "'$index' occurs 1 time."
      ;;
      [2-4]) echo "'$index' occurs $count times."
      ;;
      *)  echo "'$index' occurs $count times. WARNING!"
    esac
  done
}

if [ $# -ne 1 ]; then
  echo "usage: wordCount.sh <filename>"
elif ! [ -f $1 ]; then
  echo "wordCount.sh: $1: Not a file"
else
  countWords $1
  printResult
fi


