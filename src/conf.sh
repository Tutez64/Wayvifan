#!/usr/bin/env sh

# For each tuple, the left number is the temp the GPU has to reach
# for the right number to become its fan speed
# I personally use config='0,30 65,40 75,50 85,60 95,70'
# It means my fans are at 30% at idle/low usage (< 65°C) and mostly at
# 40% (65°C <= t < 75°C) or eventually 50% (75°C <= t < 85°C) speed when gaming
config='0,30 65,40 75,50 85,60 95,70'

# The lines below can be kept as such

# Time to wait between each iteration, in seconds
wait=1

# Number of iterations before decreasing the fan speed if it was lastly increased
delay=30

# A wait of 1 with a delay of 30 means your GPU fan speed will only
# go down if its temp has lowered enough for 30 (1*30) seconds straight

# 0 means no log, 5 means all logs (FATAL, ERROR, WARN, INFO and DEBUG).
# If, for example, you only want FATAL and ERROR types of logs, put 2
log_lvl=4

# Makes the logs colored according to their importance
colored=true
