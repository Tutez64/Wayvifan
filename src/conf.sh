# For each tuple, the left number is the temp the GPU has to reach
# for the right number to become its fan speed.
# I personally use config='0,30 65,40 75,50 85,60 95,70',
# meaning my fans are at 30% at idle/low usage (t < 65°C) and mostly at
# 40% (65°C <= t < 75°C) or eventually 50% (75°C <= t < 85°C) speed when gaming.
C_CONFIG='0,30 65,40 75,50 85,60 95,70'

# The lines below can be kept as such

# Second(s) to wait between each iteration
C_WAIT=1

# Consecutive iterations for which the GPU must stay below a said temp before its speed decreases.
# This only applies for when the last speed change was an increase.
C_RQD_ITERATIONS=30

# How verbose the logs are, from 0 (no logs) to 5 (all logs).
# For, let's say, FATAL and ERROR logs but not WARN, INFO and DEBUG logs: put 2.
C_LOG_LVL=4

# Make logs colored according to their importance.
C_COLORED_TXT=true

readonly C_CONFIG C_WAIT C_RQD_ITERATIONS C_LOG_LVL C_COLORED_TXT
