Manual install
==============

These are not available as packages.

youtube-dl
----------

```
sudo wget --no-check-certificate https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
sudo nano /etc.defaults/.bashrc_profile (alias youtube-dl="youtube-dl --ffmpeg-location /usr/local/ffmpeg/bin/")
```


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
- SynoCLI File Tools (includes nano)


PCLoadLetter.co.uk
------------------

Location: http://packages.pcloadletter.co.uk

- SANE Backends (useful for Windows XP+ and old scanners)

