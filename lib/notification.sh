#! /usr/bin/env bash

# TODO redirect hash output to devnull?
if ! $(hash notify-send); then
    echo "Cannot execute, notify-send is not installed" >&2
    exit 1
fi

declare -r ICONS_DIR=/usr/share/icons/gnome/48x48/status
declare -r INFO_ICON=$ICONS_DIR/dialog-information.png
declare -r WARN_ICON=$ICONS_DIR/dialog-warning.png
declare -r ERROR_ICON=$ICONS_DIR/dialog-error.png

declare -r TIMEOUT=15000

while getopts "iwe" opt; do
    case $opt in
        i ) 
			declare -r ICON=$INFO_ICON;;   
		w ) 
			declare -r ICON=$WARN_ICON;;   
        e )
            declare -r ICON=$ERROR_ICON;;   
	esac
done
shift $(expr $OPTIND - 1 )

if ! [[ -v ICON ]]; then
    declare -r ICON=$INFO_ICON   
fi

declare -r TITLE=$1
if [[ -z $TITLE ]]; then
    echo "No title" >&2
    exit 1
fi

declare -r TEXT=$2
if [[ -z $TEXT ]]; then
    echo "No text" >&2
    exit 1
fi

notify-send  -t "$TIMEOUT" -i "$ICON" "$TITLE" "$TEXT"