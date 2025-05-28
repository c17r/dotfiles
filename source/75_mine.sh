[ -d ~/bin ] || mkdir ~/bin
export PATH=~/bin:$(path_remove ~/bin)

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
