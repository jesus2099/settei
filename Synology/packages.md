Manual install
==============

These are not available as packages.

youtube-dl
----------

    sudo wget --no-check-certificate https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
    sudo nano /etc.defaults/.bashrc_profile (alias youtube-dl="youtube-dl --ffmpeg-location /usr/local/ffmpeg/bin/")

yt-dlp
------

Replaces youtube-dl.
Requires Python3 Synology package.

Install:

    sudo curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp
    sudo chmod a+rx /usr/local/bin/yt-dlp
    sudo nano /etc.defaults/.bashrc_profile (alias yt-dlp="yt-dlp --ffmpeg-location /usr/local/ffmpeg/bin/")

Update:

    sudo yt-dlp --update


Packages
========

Synology
--------

- Antivirus Essential
- AudioStation: Allows playing music to USB connected _mini-chaîne_)
- Download Station
- Files Station
- Media Server: Simple DLNA server for Blu-ray disc drive, PS3, etc.
- Storage Analyzer: Locate duplicate files or big files easily
- Universal Search


SynoCommunity
-------------

Location: http://packages.synocommunity.com

- ffmpeg (installed in /usr/local/ffmpeg/bin/ffmpeg)
- htop
- ncdu
- SynoCLI File Tools (includes nano and: jdupes --delete --no-prompt --recurse --param-order /folderKeep /folderDupe1 /folderDupe2)


PCLoadLetter.co.uk
------------------

Location: http://packages.pcloadletter.co.uk

- SANE Backends (useful for Windows XP+ and old scanners)

