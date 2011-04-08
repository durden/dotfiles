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

    echo "Linking $file to $link_name"
    ln -s `pwd`/$file ~/.$file
done
