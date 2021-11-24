Packages
========

Raspbian (apt)
--------

- abcde
- adb (to remotely debug Android Firefox 68)
- audacious
- audacity
- baobab (though I prefer ncdu actually)
- dosfstools
- firefox-esr (although it is really more stable to use Raspbian modded Chromium)
- geany
- git-cola (I am looking for a better alternative to Tortoise Git than git-cola)
- htop
- httpie
- nano
- ncdu
- nfs-common
- ntfs-3g
- pavucontrol (to fix when pulseaudio sends sound to analog instead of hdmi)
- pgcli (to query musicbrainz-docker PG database)
- pinout (I think it is included)
- rpi-imager
- schism
- sonaar
- thunderbird
- vlc

Python (pip)
------

- youtube-dl (pip install --upgrade youtube-dl)


Manual installs
===============

yt-dlp
------

Replaces youtube-dl.

Install:

    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp

Update:

    sudo yt-dlp --update
