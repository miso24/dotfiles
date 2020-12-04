#--------------------
# tmux
#--------------------

if [[ -z "$TMUX" ]]; then
	# get sessoins
	sessions=$(tmux list-sessions)
	echo "${sessions}"
	if [[ -z "${sessions}" ]]; then
		tmux new-session
	else
		# coloring sessoins
		sessions=$(echo "$sessions" | awk '{$1="\033[32m"$1"\033[0m";print}')
		# select session
		create_new_session='Create New Session'
		sessions="$sessions\n$create_new_session"
		selected=$(echo "$sessions" | fzf --ansi --reverse --header="TMUX session already existed!")
		# setting tmux
		if [[ "$selected" = "$create_new_session" ]]; then
			tmux new-session
		elif [[ -n "$selected" ]]; then
			tmux attach -t $(echo "$selected" | awk '{print $1}')
		else
			echo 'normal mode'
		fi
	fi
fi
