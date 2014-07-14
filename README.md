Bash script to change desktop wallpaper
=======================================

Installation
------------

To install as a Cron job that runs every hour:

    crontab -e
    * */1 * * * /<path>/wallpaper.sh

Troubleshooting
---------------

* Changes are logged to the /tmp folder.
* Requires Gnome based Window Manager to run. Runs fine with Ubuntu 12.10, Ubuntu 14.04.
 
