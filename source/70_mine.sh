
function hr() {
	marker="="
	[[ -n $1 ]] && marker=$1
	marker_size=${#marker};

	for (( char_index=0; char_index<${marker_size}; char_index++ ))
	do
		current=${marker:char_index:1}
		line=''
		columns=$(tput cols)

		for (( i=1; i<columns; i++ ))
		do
			line+="${current}"
		done

		echo $line
	done
}


function calc() {
	echo "scale=2;$*" | bc
}


function pyn() {
	pid=$(ps auxwww | awk '/jupyter/ && !/awk/ { print $2 }')

	case "$1" in
		stop)
			if [ -n "$pid" ]
			then
				kill $pid
			fi
			;;
		*)

			case "$2" in
				lab)
					style=lab
					;;
				*)
					style=notebook
					;;
			esac

			if [ -z "$pid" ]
			then
				mkdir -p ~/odrive/Box/Sync/ipython-notebook/
				pushd ~/odrive/Box/Sync/ipython-notebook/
				jupyter $style &
				popd
			else
				open http://localhost:8888
			fi
			;;
	esac
}

if is_osx; then

	function __announce() {
		now=$(date -j "+%D %T")
		say $*
		echo "$now - $*"
	}


	function say_ping() {
		address=$1
		prev=255

		if [ -z "$2" ]; then
			name=$1
		else
			shift
			name=$*
		fi

		while true; do
			ping -c 1 $address > /dev/null 2>&1
			code=$?

			if [ $code != $prev ]; then
				if [ $code -eq 0 ]; then
					__announce $name is up
				else
					__announce $name is down
				fi
				prev=$code
			fi

			sleep 1
		done
	}


#	function twitch() {
#		if [ ! "$1" ]; then
#			echo "Usage: <twitch username>"
#			exit 0
#		fi
#
#		[ -d ~/Applications/VLC.app ] && vlc=~/Applications/VLC.app/Contents/MacOS/VLC
#		[ -d /Applications/VLC.app ] && vlc=/Applications/VLC.app/Contents/MacOS/VLC
#
#		if [ -z "$vlc" ]; then
#			echo "Couldn't find VLC, exiting..."
#			exit 1
#		fi
#
#		level=best
#		[ "$2" ] && level=$2
#
#		streamlink twitch.tv/$1 $level -p "$vlc --auhal-volume 128 --network-caching 500 --file-caching 500" --player-http -v --hls-segment-threads 4 &
#	}

	function finder-show-files() {
		defaults write com.apple.finder AppleShowAllFiles YES
		killall Finder /System/Library/CoreServices/Finder.app
	}


	function finder-hide-files() {
		defaults write com.apple.finder AppleShowAllFiles NO
		killall Finder /System/Library/CoreServices/Finder.app
	}


	function osx-clear-dns() {
		sudo dscacheutil -flushcache
		sudo killall -HUP mDNSResponder
	}


	function osx-restart-dnsmasq() {
		sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
		sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist
	}


	function osx-wakeall() {
		# workbookpro
		echo workbookpro is 10.0.14.14
		wakeonlan 14:10:9f:dd:e4:29

		# tvmini
		echo tvmini is 10.0.14.81
		wakeonlan 00:26:b0:de:28:72

		# playbookpro
		echo playbookpro is 10.0.14.15
		wakeonlan b8:f6:b1:19:76:cb
	}


	function osx-lock() {
		sleep 0.5

		if [[ "$(ioreg -c AppleSmartBattery | grep '"ExternalConnected" = Yes')" ]]; then
		  # Plugged in: start screensaver.
		  open /System/Library/CoreServices/ScreenSaverEngine.app
		else
		  # Battery power: go to lock menu.
		  /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
		fi
	}


	function restart-flux() {
		pid=$(ps auxwww | grep -E "[F]lux" | awk '{ print $2 }')
		if [ -n "$pid" ]; then
			echo "Killing flux ($pid)"
			kill -9 $pid

			sleep 1

			open "/Applications/Flux.app"
		fi
	}


	function osx-alias() {
		[[ -f "$1" ]] && type="file"
		[[ -d "$1" ]] && type="folder"

		if [ -z "$type" ]; then
			echo "Invalid path or unsupported type"
			exit 1
		fi

		osascript <<EOF
		tell application "Finder"
		   make new alias to $type (posix file "$1") at desktop
		end tell
EOF
	}

fi
