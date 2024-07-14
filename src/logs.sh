# Handle all five types of logs.
log() (
	_type="$1"
	_color="$2"
	_message="$3"
	_current_time=$(date "+%Y/%m/%d %H:%M:%S")
	if [ $C_COLORED_TXT = true ]
	then
		printf "${_color}[%s] [%s] %s\033[0m\n" "$_current_time" "$_type" "$_message"
	else
		printf "[%s] [%s] %s" "$_current_time" "$_message" "$_current_time"
	fi
)

# Level 5 blue-colored logs.
debug() {
	if [ $C_LOG_LVL -ge 5 ]
	then
  		log DEBUG '\033[0;96m' "$*"
  	fi
}

# Level 4 green-colored logs.
info() {
	if [ $C_LOG_LVL -ge 4 ]
	then
  		log INFO '\033[0;32m' "$*"
  	fi
}

# Level 3 orange-colored logs.
warn() {
	if [ $C_LOG_LVL -ge 3 ]
	then
  		log WARN '\033[0;33m' "$*"
  	fi
}

# Level 2 red-colored logs.
error() {
	if [ $C_LOG_LVL -ge 2 ]
	then
  		log ERROR '\033[0;91m' "$*"
  	fi
}

# Level 1 black-colored on red background logs.
fatal() {
	if [ $C_LOG_LVL -ge 1 ]
	then
  		log FATAL '\033[41;30m' "$*"
  	fi
}
