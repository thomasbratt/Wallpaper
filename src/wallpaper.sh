#!/bin/bash

# Wallpaper changer script for Ubuntu 14.04.
#
# To install as a Cron job that runs every hour:
# crontab -e
# * */1 * * * <path to this script file>

FILES=/home/thomas/Pictures/wallpaper
LOG=/tmp/wallpaper.log

# Change the wallpaper to a random .jpg file in the specified folder.
# Exclude the previously selected file.
previous=$(                                                 \
    gsettings get org.gnome.desktop.background picture-uri  \
    | sed 's|file:///||g'                                     \
    | sed 's|\x27||g' )
next=$(
    find $FILES -iname '*.jpg' -type f                      \
    | grep -v "$previous"                                   \
    | shuf -n1 )
result=$(                                                   \
    DISPLAY=:0                                              \
    GSETTINGS_BACKEND=dconf                                 \
    gsettings set org.gnome.desktop.background picture-uri  \
    "file:///$next" )

# Logging.
printf '%s %s %s %s %s\n'                                   \
    "$(date -u +'%F %T')Z"                                  \
    "$(whoami)"                                             \
    "$previous"                                             \
    "$next"                                                 \
    "$result"                                               \
    >> "$LOG"

