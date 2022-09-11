#!/bin/bash


ech
while [ $# -gt 0 ]
do
        case "$1" in
          -f|--file )
                FILE=$1
                if ! [ -f "$FILE" ];    then
        echo "file doesn't exist"
        exit 2
                fi
        LINES=cat "$FILE" | wc -l
        WORDS=cat "$FILE" | wc -w
        AVERAGE=cat "$FILE" | bc
	
        echo "======FILE : $FILE ====="
        echo "=====Words : $WORDS ===="
        echo "=====Average : $AVERAGE   ====="
       
        ;;


esac
done


