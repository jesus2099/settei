@REM Requires both https://github.com/rg3/youtube-dl and https://ffmpeg.org in the PATH.
@REM Will download best DASH combination from YouTube, best MP4 otherwise, best anything otherwise.
@REM Can’t be used for multilingual videos, like Arte. Use YOUTUBE-DL directly then. -F to check formats, then -f selectedformat.
YOUTUBE-DL -f bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best %*