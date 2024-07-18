#!/usr/bin/env sh
. ./conf.sh && . ./logs.sh && . ./detections.sh

# If not already given, ask for root permission.
check_perm() {
	[ "$(id -u)" -eq 0 ] || exec sudo "$0" "$@"
}

# Update the fans' speed to the passed value
set_speed() {
	(
		_new_speed=$1

		if [ "$_new_speed" -gt "$current_speed" ]; then
			_update='increase'
		else
			_update='decrease'
		fi

		# shellcheck disable=SC2046,SC2086
		debug $(nvidia-settings -a GPUTargetFanSpeed=$_new_speed)
		info "Fan speed $_update from $current_speed to $_new_speed"
		return "$_new_speed"
	)
	current_speed=$?
}

# Main loop
loop() (
	info 'Starting main loop.'
	# Iterations since the last speed increase.
	_iterations=0
	# Remember if the last speed change was an increase.
	_just_got_up=false

	while :; do
		current_temp=$(nvidia-settings -tq GPUCoreTemp)
		# For each tuple in $C_CONFIG
		for _elem in $(echo "$C_CONFIG" | tac -s ' '); do
			_temp=$(echo "$_elem" | cut -d ',' -f 1)
			_speed=$(echo "$_elem" | cut -d ',' -f 2)
			if [ "$current_temp" -ge "$_temp" ]; then
				if [ "$current_speed" = "$_speed" ]; then
					_iterations=0
					break
				elif [ "$current_speed" -gt "$_speed" ]; then
					if [ "$_just_got_up" = true ]; then
						if [ "$_iterations" -le "$C_RQD_ITERATIONS" ]; then
							_iterations=$((_iterations + 1))
							break
						else
							_just_got_up=false
						fi
					fi
				else
					_just_got_up=true
					_iterations=0
				fi
				set_speed "$_speed"
				break
			fi
		done
		sleep $C_WAIT
	done
)

main() {
	check_perm "$@"
	detections || exit $?
	current_speed=$(nvidia-settings -tq GPUTargetFanSpeed | head -n 1)
	loop
}

main "$@"
