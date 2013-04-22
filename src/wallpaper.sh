#!/bin/bash

# -----------------------------------------------------------------------------
# Bash script to change desktop Wallpaper.
#
# To install as a Cron job that runs every hour:
#   crontab -e
#   * */1 * * * /<path>/wallpaper.sh
#
# Changes are logged to the /tmp folder.
# -----------------------------------------------------------------------------

# Options
FILES='/<path>/Pictures/wallpaper'
LOG='/tmp/wallpaper.log'

# Change the wallpaper to a random file in the specified folder.o
# Exclude the previously selected file.
p=$( gsettings get org.gnome.desktop.background picture-uri ) 
p1=$( echo $p | sed s^file:///^^g | sed s^\'^^g)
n=$( find $FILES -iname '*.jpg' -type f | grep -v $p1 | shuf -n1 )
r=$( DISPLAY=:0 GSETTINGS_BACKEND=dconf gsettings set org.gnome.desktop.background picture-uri "file:///$n" )

# Logging.
echo -n "$(date -u +'%F %T')Z" >> $LOG
echo -n " $(whoami)">> $LOG
echo -n " $?" >> $LOG
echo -n " $p1" >> $LOG
echo -n " $n" >> $LOG
echo -n " $r" >> $LOG
echo "" >> $LOG
