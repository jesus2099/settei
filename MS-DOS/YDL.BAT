@ECHO OFF
SETLOCAL
REM Requires both https://github.com/rg3/youtube-dl and https://ffmpeg.org in the PATH.
REM Download best stream combination (called DASH in YouTube), best MP4 otherwise, best anything otherwise
SET ydl=bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best
SET url=%1
REM arte.tv: VO-STF (HTTP_MP4_SQ_3) then VF/VF-STF/VF-STF/VOF/VOF-STF (HTTP_MP4_SQ_1) then (should never happen) best (mp4 if possible)
IF NOT %url:*//www.arte.tv=%==%url% SET ydl=HTTP_MP4_SQ_3/HTTP_MP4_SQ_1/best[ext=mp4]/best
REM tf1.fr: Force pre-multiplexed MP4 download
IF NOT %url:*//www.tf1.fr=%==%url% SET ydl=best[ext=mp4]/best
SET ydl=YOUTUBE-DL -f %ydl% %*
ECHO.&ECHO %ydl%
%ydl%