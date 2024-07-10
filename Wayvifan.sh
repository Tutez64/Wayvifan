#!/bin/sh

# Configure the following to your liking

# For each tuple, the left number is the temp the GPU has to reach
# for the right number to become its fan speed
# I personally use config='0,30 65,40 75,50 85,60 95,70'
# It means my fans are at 30% at idle/low usage (< 65°C) and mostly at
# 40% (65°C <= t < 75°C) or eventually 50% (75°C <= t < 85°C) speed when gaming
config='0,30 65,40 75,50 85,60 95,70'


# The rest can be kept as such

# Time to wait between each iteration, in seconds
wait=1

# Number of iterations before decreasing the fan speed if it was lastly increased
delay=30

# A wait of 1 with a delay of 30 means your GPU fan speed will only
# go down if its temp has lowered enough for 30 (1*30) seconds straight


# Unless you know what you're doing, don't touch anything below

iterations=0 # The number of iterations since the last increase
current_speed=$(nvidia-settings -tq GPUTargetFanSpeed | head -n 1)
just_got_up=false # Remembers if the last change was an increase


# If not already given, ask for root permission
[ "$(id -u)" -eq 0 ] || exec sudo "$0" "$@"

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
                        echo "Fan speed decrease"
                        just_got_up=false
                    fi
                fi
            # If current speed is too low, increase it immediately
            else
                echo "Fan speed increase"
                just_got_up=true
                iterations=0
            fi
            # Sets the speed to the current tuple right number
            nvidia-settings -a GPUTargetFanSpeed="$s"
            current_speed=$s
            break # Breaks the for loop when the correct speed is set
        fi
    done
    sleep $wait # Waits the said number of seconds before checking again
done
