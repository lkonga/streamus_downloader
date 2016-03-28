#!/bin/bash

dir="nodupes"
if [ ! -d $dir ];then
    mkdir $dir
fi

dir2="done"
if [ ! -d $dir2 ];then
    mkdir $dir2
fi

for entry in "`pwd`"/*.json
do
    if [ -f "$entry" ];then
        grep -o 'https://[^"]*' "$entry" | sort | uniq > "$dir/${entry##*/}"
    fi
done


for entry in "`pwd`"/$dir/*.json
do
    if [ -f "$entry" ];then
        FILENAME=${entry##*/}
        BASENAME="${FILENAME%.*}"
        youtube-dl -a "$entry" -i -o "downloads/$BASENAME/%(title)s-%(id)s.%(ext)s"
        mv "$entry" "$dir2"
    fi
done



