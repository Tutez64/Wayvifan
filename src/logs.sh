NC="\033[0m"
log() {
	type="$1"
	color="$2"
	message="$3"
	current_time=$(date "+%Y/%m/%d %H:%M:%S")
	if [ $colored = true ]
	then
		echo "${color}[$current_time]" "[$type]" "$message""${NC}"
	else
		echo "[$current_time]" "[$type]" "$message"
	fi
}

debug() {
	if [ $log_lvl -ge 5 ]
	then
  		log DEBUG '\033[0;96m' "$1"
  	fi
}

info() {
	if [ $log_lvl -ge 4 ]
	then
  		log INFO '\033[0;32m' "$1"
  	fi
}

warn() {
	if [ $log_lvl -ge 3 ]
	then
  		log WARN '\033[0;33m' "$1"
  	fi
}

error() {
	if [ $log_lvl -ge 2 ]
	then
  		log ERROR '\033[0;91m' "$1"
  	fi
}

fatal() {
	if [ $log_lvl -ge 1 ]
	then
  		log FATAL '\033[41;30m' "$1"
  	fi
}
