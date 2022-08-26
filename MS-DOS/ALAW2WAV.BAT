@echo off
rem jesus2099 version 2022-08-26
for %%f in (%1) do ffmpeg -f alaw -ar 8000 -i "%%f" "%%f.wav"
