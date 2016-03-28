#!/bin/bash

dir="done"
if [ ! -d $dir ];then
    mkdir $dir
fi

for entry in "`pwd`"/*.json
do
    if [ -f "$entry" ];then
        noduped="noduped_${entry##*/}"
        grep -o 'https://[^"]*' "$entry" | sort | uniq > "$noduped"
        if [ -f "$noduped" ];then
            FILENAME=${entry##*/}
            BASENAME="${FILENAME%.*}"
            youtube-dl -a "$noduped" -i -o "downloads/$BASENAME/%(title)s-%(id)s.%(ext)s"
            mv "$entry" "$dir"
            mv "$noduped" "$dir"
        fi
    fi
done

