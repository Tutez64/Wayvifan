#!/bin/sh

. src/conf.sh
. src/logs.sh

# If not already given, ask for root permission
[ "$(id -u)" -eq 0 ] || exec sudo "$0" "$@"

iterations=0 # The number of iterations since the last increase
current_speed=$(nvidia-settings -tq GPUTargetFanSpeed | head -n 1)
just_got_up=false # Remembers if the last change was an increase
while :
do
    temp=$(nvidia-settings -tq GPUCoreTemp) # Current temp
    for elem in $(echo "$config" | tac -s ' ')
    do
        t=$(echo "$elem" | cut -d ',' -f 1) # Left number (temp)
        s=$(echo "$elem" | cut -d ',' -f 2) # Right number (speed)
        # If the GPU temp is higher or equal to the current tuple left number
        if [ "$temp" -ge "$t" ]
        then
            # If the current speed is already the one
            if [ "$current_speed" = "$s" ]
            then
                iterations=0
                break
            # If the current speed is higher then the appropriate one
            elif [ "$current_speed" -gt "$s" ]
            then
                # If the last speed change was an increase
                if [ "$just_got_up" = true ]
                then
                    # If the speed has been too high since less than $delay iterations
                    # Meaning the GPU could potentially go above again shortly
                    if [ "$iterations" -le "$delay" ]
                    then
                        iterations=$((iterations + 1))
                        break
                    # If it's been at least $delay iterations since the speed has been too high
                    # Meaning the GPU likely won't go to the upper level just now
                    else
                        info "Fan speed decrease from $current_speed to $s"
                        just_got_up=false
                    fi
                # If the last change was a decrease and it's still too high
                else
                	info "Fan speed decrease from $current_speed to $s"
                fi
            # If current speed is too low, increase it immediately
            else
                info "Fan speed increase from $current_speed to $s"
                just_got_up=true
                iterations=0
            fi
            # Sets the speed to the current tuple right number
            nvidia-settings -a GPUTargetFanSpeed="$s" > /dev/null
            current_speed=$s
            break # Breaks the for loop when the correct speed is set
        fi
    done
    sleep $wait # Waits the said number of seconds before checking again
done
