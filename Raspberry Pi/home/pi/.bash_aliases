# history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10

function mcd {
	mkdir -p $1
	cd $1
}

alias streamo='_(){ omxplayer `youtube-dl --get-url --format best[ext=mp4]/best $@`; };_'
alias streamv='_(){ vlc --fullscreen `youtube-dl --get-url --format best[ext=mp4]/best $@`; };_'
alias streama='_(){ audacious `youtube-dl --get-url --format bestaudio[ext=mp3]/bestaudio $@`; };_'

function replay {
	if test -z $1 ; then
		echo -e "No arguments specified. Usage:\n${FUNCNAME[0]} replay-web-page-url(s)"
		return 1
	fi
	# both omxplayer and vlc are hardware accelerated on Raspberry Pi
	vlc --fullscreen `youtube-dl --get-url --format best[ext=mp4]/best $@`
}
