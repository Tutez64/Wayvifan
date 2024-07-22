#!/usr/bin/env sh
. ./conf.sh && . ./logs.sh && . ./detections.sh

# If not already given, ask for root permission.
check_perm() {
	[ "$(id -u)" -eq 0 ] || exec sudo "$0" "$@"
}

# Update the fans' speed to the passed value.
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

# Main loop.
loop() (
	info 'Starting main loop.'
	# Iterations since the last speed increase.
	_iterations=0
	# Remember if the last speed change was an increase.
	_just_got_up=false
	# Temp from previous tuple.
	_previous_temp=

	while :; do
		current_temp=$(nvidia-settings -tq GPUCoreTemp)
		debug "current_temp: $current_temp"
		# For each tuple in $C_CONFIG.
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
							if [ $C_ITERATIONS_IF_DELTA = false ] || [ "$current_temp" -lt $((_previous_temp - C_RQD_DELDA)) ]; then
								_iterations=$((_iterations + 1))
							else
								_iterations=0
							fi
							break
						else
							if [ $C_RQD_DELDA -gt 0 ]; then
								if [ "$current_temp" -ge $((_previous_temp - C_RQD_DELDA)) ]; then
									break
								fi
							fi
							_just_got_up=false
						fi
					fi
				else
					_just_got_up=true
					_iterations=0
				fi
				set_speed "$_speed"
				break
			else
				_previous_temp=$_temp
				#debug "previous_temp: $_previous_temp"
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
