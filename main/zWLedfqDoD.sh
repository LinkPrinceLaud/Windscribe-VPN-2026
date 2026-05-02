#!/bin/bash
if [ $# -eq 0 ]; then
  echo "No files provided."
  exit 1
fi
for file in "$@"; do
  if [ -f "$file" ]; then
    lines=$(wc -l < "$file")
    words=$(wc -w < "$file")
    chars=$(wc -c < "$file")
    echo "File: $file"
    echo "Lines: $lines"
    echo "Words: $words"
    echo "Characters: $chars"
  else
    echo "Error: $file is not a valid file."
  fi
done
mkdir -p processed
for file in "$@"; do
  if [ -f "$file" ]; then
    cp "$file" processed/
    echo "Copied $file to processed/"
  fi
done
find processed -type f -name '*.txt' -exec grep -l 'TODO' {} \; | while read todo_file; do
  echo "TODO found in: $todo_file"
  echo "Contents:" 
  head -n 5 "$todo_file"
done
find processed -type f -exec wc -l {} \; | sort -n | awk '{print $2, $1}'
done
