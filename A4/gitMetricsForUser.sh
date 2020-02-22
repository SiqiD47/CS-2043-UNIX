#!/bin/bash
if [ $# -ne 2 ]; then
  echo "usage: gitMetricsForUser username repository"
elif ! [ -d $2 ]; then
  echo "gitMetricsForUser: $2: Not a directory"
else
  cd $2
  num_commits=$(git log | grep $1 | wc -l)
  echo ""
  echo "User $1 has made $num_commits commits"
  echo "Longest message:"
  total_num_lines=$(wc -l < <(git log))
  i=1
  longest_msg=""
  while [[ $i -le $total_num_lines ]]; do
    line=$((head -$i | tail -1) < <(git log))
    if [[ $line == *$1* ]]; then
      i=$((i+3))
      content=$((head -$i | tail -1) < <(git log))
      if [[ ${#content} -ge ${#longest_msg} ]]; then
        longest_msg=$content
      fi
    fi
    i=$((i+1))
  done
  echo ""
  echo $longest_msg
fi
