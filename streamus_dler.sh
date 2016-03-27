for entry in "`pwd`"/*.json
do
    if [ -f "$entry" ];then
        grep -o 'https://[^"]*' "$entry" | sort | uniq > "nodupes/"${entry##*/}
    fi
done


for entry in "`pwd`"/nodupes/*.json
do
    if [ -f "$entry" ];then
        echo $entry
        FILENAME=${entry##*/}
        BASENAME="${FILENAME%.*}"
        youtube-dl -a "$entry" -i -o "downloads/$BASENAME/%(title)s-%(id)s.%(ext)s"
    fi
done



