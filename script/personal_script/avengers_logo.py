import time
import os

# ASCII art for the Avengers logo
logo = [
    '            __ ',
    '          /"  "\',',
    '          \/   ,/',
    '          /   /',
    '        /" "/',
    '      /"  "/',
]

# Colors to use for the animation
colors = [
    '\033[1;31m',  # red
    '\033[1;32m',  # green
    '\033[1;33m',  # yellow
    '\033[1;34m',  # blue
    '\033[1;35m',  # purple
    '\033[1;36m',  # cyan
]

# Clear the terminal
os.system('clear')

# Print the logo
for line in logo:
    print(line)

# Animate the logo by cycling through different colors
while True:
    for color in colors:
        # Clear the terminal
        os.system('clear')

        # Print the logo in the new color
        for line in logo:
            print(color + line + '\033[0m')  # reset the color after printing each line

        # Sleep for half a second
        time.sleep(0.5)

