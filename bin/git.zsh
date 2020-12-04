#!/bin/zsh
function _in_git_repo() {
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) != "true" ]]; then
		return 1
	fi
	return 0
}

function gadd() {
	_in_git_repo
	if [[ $? != 0 ]]; then
		echo 'is not git repo'
		return 1
	fi
		
	local addfiles
	addfiles=$(git status -s | fzf --reverse --border --color=light --preview="git diff --color-words -- {2} 2> /dev/null" --multi | awk '{print $2}')
	if [[ -n "$addfiles" ]]; then
		git add $(echo "$addfiles" | awk '{print $1}') && echo "added: $addfiles"
	else
		echo "nothing added."
	fi
}
