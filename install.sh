#!/bin/sh

for file in `ls`; do
    link_name=~/.$file

    # Ignore install file and README
    if [ "$file" = "`basename $0`" -o "$file" = "README" ]; then
        echo "-- Skipping $file"
        continue
    fi

    if [ -f $link_name ]; then
       echo "-- $link_name exists, skipping"
       continue
    fi

    if [ -d $file ]; then
        src="`pwd`/$file/"
    else
        src="`pwd`/$file"
    fi

    echo "Linking $src to $link_name"
    ln -s $src ~/.$file
done
