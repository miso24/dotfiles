# Created by newuser for 5.7.1

# key bind
# curren vi like
bindkey -v

# Setting Language
export LANG=ja_JP.UTF-8

# Use color
autoload -U colors
colors

# Use complete
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

# set oprions
setopt correct
setopt extended_glob
setopt auto_pushd
setopt pushd_ignore_dups

# alias
alias ls='ls -G'
alias zsource="source $ZDOTDIR/.zshrc"
alias cdt='cd $HOME/desktop'
alias cdl='cd $HOME/downloads'
alias ts='bash $HOME/.bin/tmux.sh'
alias q='exit'
alias memo='$HOME/.bin/memo.sh'
alias py='python'
alias ipy='ipython'
alias rcat='$HOME/.bin/rcat'
alias poetry='python3 $HOME/.poetry/bin/poetry'

alias vi='nvim'
alias vim='nvim'
alias emacs='nvim'
alias nano='nvim'

set nobeep

export HISTFILE=${ZDOTDIR}/history/.zsh_history
setopt hist_ignore_all_dups

# z
. $ZDOTDIR/thirdparty/z/z.sh

# setting prompt
faces=("(*╹_╹)" "(;-_-)")

FACE_NORMAL=1
FACE_GUNUNU=2
face_state=FACE_NORMAL

setopt prompt_subst
PROMPT='%F{yellow}%(4~|.../%3~|%~)%f
${faces[${face_state}]}%F{green}<%f '

function update_face() {
  if [[ $? -eq 0 ]]; then
    face_state=FACE_NORMAL
  else
    face_state=FACE_GUNUNU
  fi
}

autoload add-zsh-hook
add-zsh-hook precmd update_face

# mkdir and cd
function mkcd() {
	if [[ -d $1 ]]; then
		echo "$1 already exists!"
		cd $1
	else
		mkdir -p $1 && cd $1
	fi
}

function rmfd() {
	if [[ $# != 1 ]]; then
		echo 'Usage: rmdir [dirname or filename]'
	else
		echo -n 'ok? (yes: y, no: other): '
		read check
		case "$check" in
			[yY] )
				rm -rf $1; echo 'Delete "$1" complete!' ;;
			* )
				echo 'Cannot delete!' ;;
		esac
	fi
}

function cargon() {
	if [[ $# != 1 ]]; then
		echo 'Usage: cargon <proj name>'
	else
    cargo new $1 --bin
    cd $1
  fi
}

function change_cursor() {
  if [[ ${KEYMAP} == vicmd ]]; then
    echo 'A'
  else
    echo -ne '\e[5'
  fi 
}

zle -N change_cursor

source "$HOME/.bin/git.zsh"
#--------------------
# git
#--------------------
use_vcs_info=true
#
autoload -Uz vcs_info

zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%s)[%b]' '%c%u %m'
zstyle ':vcs_info:git:*' actionformats '(%s)[%r|%b]' '%c%u %m' '<!%a>'
# zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"
zstyle ':vcs_info:git:*' unstagedstr "-"

zstyle ':vcs_info:git+set-message:*' hooks \
	git-hook-begin \
	git-status

function +vi-git-hook-begin() {
	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' || "$use_vcs_info" != "true" ]]; then
		return 1
	fi
	return 0
}

function +vi-git-status() {
	if [[ "$1" != 1 ]]; then
		return 0
	fi

	local stat 
	stat=$(git status --porcelain 2> /dev/null | cut -b 1-2)
	
	# staged
	if [[ -n $(echo "$stat" | grep -E "^[MADRCU] ") ]]; then
		hook_com[staged]+='+'
	fi

	# unstaged
	if [[ -n $(echo "$stat" | grep -E "^ [MADRCU]") ]]; then
		hook_com[unstaged]+='-'
	fi
	
	# unstaged
	if [[ -n $(echo ${stat} | grep -F '??' 2> /dev/null) ]]; then
		hook_com[unstaged]+='?'
	fi
}

function +vi-git-push-status() {
	if [[ "$1" != 1 ]]; then
		return 0
	fi

	if [[ "${hook_com[branch]}" != "master" ]]; then
		return 0
	fi

	local ahead
	ahead=$(git rev-list origin/master..master 2>/dev/null | wc -l | tr -d ' ')
	if [[ "$ahead" -gt 0 ]]; then
		hook_com[misc]+="(p${ahead})"
	fi
}

function _update_vcs_info_msg() {
	local -a messages
	local prompt

	LANG=en_US.UTF-8 vcs_info
	if [[ -z "${vcs_info_msg_0_}" ]]; then
		prompt=""
	else
		[[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
		[[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
		[[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_1}%f" )

		prompt="${(j: :)messages}"
	fi
	RPROMPT="$prompt"
}

add-zsh-hook precmd _update_vcs_info_msg
