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
        noduped="$dir/${entry##*/}"
        if [ -f "$noduped" ];then
            FILENAME=${noduped##*/}
            BASENAME="${FILENAME%.*}"
            youtube-dl -a "$noduped" -i -o "downloads/$BASENAME/%(title)s-%(id)s.%(ext)s"
            mv "$entry" "$dir2"
            mv "$noduped" "$dir2/nodupes_$entry"
        fi
    fi
done

