#!/bin/sh

if [ -n "$SHOW_BANNER" ]; then
	# get terminal width
	term_width=$(tput cols)

	# set color
	printf "\x1b[36m"

	function draw_line() {
		printf "%*s\n" "${term_width}" | sed -e 's/ /-/g'
	}

	# draw line
	draw_line

	# draw logo
	if [ ${term_width} -ge 53 ]; then
	 # print 'welcome'
		echo '                    __                               '
		echo '   __  __  ______  / /    ____________________  ____ '
		echo '  / / / / / / __ \/ /    / ____/ __  / __  __ \/ __ \'
		echo ' / /_/ /_/ / /___/ /____/ /___/ /_/ / / / / / / /___/'
		echo ' \________/_____/______/\____/\____/_/ /_/ /_/_____/ '
		echo
	else
		echo '\nWelcome!\n'
	fi

	# draw line
	draw_line
fi
