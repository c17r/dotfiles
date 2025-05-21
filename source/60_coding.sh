
function uuid() {
	local version="long"
	local count=1
	OPTIND=1

	while getopts ":sn:" opt; do
		case "$opt" in
		  s) version="short" ;;
		  n) count=$OPTARG ;;
		  ?) echo "Usage: uuid [-s] [-n number]" >&2; return 1 ;;
		esac
	done
	shift $((OPTIND - 1))

	for i in $(seq 1 "$count"); do
		local val=$(uuidgen)
		if [ $version = "short" ]; then
			val=$(echo $val | sed 's/-//g')
		fi
		echo $val
	done
}
