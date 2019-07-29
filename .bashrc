# ~/bashrc: executed by bash(1) for non-login shells.

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
source ~/.git-prompt.sh

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# set default title for tmux panes
printf '\033]2;bash\033\\' 

rename-pane() { 
    printf '\033]2;%s\033\\' $1
}

ssh() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=)" = "tmux" ]; then
        tmux rename-window "$(echo $* | cut -d . -f 1)"
        command ssh "$@"
        tmux set-window-option automatic-rename "on" 1>/dev/null
    else
        command ssh "$@"
    fi
}

export -f rename-pane

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=500000
HISTFILESIZE=1000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    # PS1='$([ \j -gt 0 ] && echo "\[\033[01;41m\]\j\[\033[01;48;5;18m\] ")\[\033[01;40m\]\033[48;5;18m\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[01;38;5;20m\]\w$(__git_ps1 "\[\033[01;33m\](%s)")\[\033[48;5;0;01;97m\]»\[\033[00m\] '
#     PS1='$([ \j -gt 0 ] && echo "\[\033[01;41m\]\j\[\033[01;48;5;18m\] ")\[\033[01;40m\]\033[48;5;19m\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[38;5;19;48;5;18m\]\[\033[01;38;5;20;48;5;18m\] \w$(__git_ps1 "\[\033[01;33m\](%s)")\[\033[48;5;0;38;5;18m\]\[\033[38;5;19m\]\[\033[00m\] '
#     PS1='$([ \j -gt 0 ] && echo "\[\033[01;41m\]\j\[\033[01;48;5;18m\] ")\[\033[01;40m\]\033[48;5;19m\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[38;5;19;48;5;18m\]\[\033[01;38;5;20;48;5;18m\] \w$(__git_ps1 "\[\033[01;33m\](%s)")\[\033[48;5;0;38;5;18m\]\[\033[00m\] '
# PS1='$([ \j -gt 0 ] && echo "\[\033[48;5;21;38;5;18m\]\j\[\033[38;5;21;48;5;18m\] ")\[\033[01;40m\]\033[48;5;18m\]${debian_chroot:+($debian_chroot)}\[\033[01;31;48;5;18m\]\u\[\033[38;5;21m\]\[\033[01;38;5;20;48;5;18m\]\w$(__git_ps1 "\[\033[38;5;21m\](\[\033[01;38;5;16m\]%s\[\033[38;5;21m\])")\[\033[48;5;0;01;97m\]»\[\033[00m\] '
PS1='$([ \j -gt 0 ] && echo "\[\033[48;5;21;38;5;18m\]\j\[\033[38;5;21;48;5;0m\] ")\[\033[01;40m\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u \[\033[38;5;21m\]\[\033[01;38;5;20m\]\w$(__git_ps1 "\[\033[38;5;21m\](\[\033[01;38;5;16m\]%s\[\033[38;5;21m\])")\[\033[01;38;5;21m\]»\[\033[00m\] '

else
    PS1='$([ \j -gt 0 ] && echo [\j])${debian_chroot:+($debian_chroot)}\u\w$(__git_ps1 "(%s)")» '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
# case "$TERM" in
# xterm*|rxvt*)
#     PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u: \w\a\]$PS1"
#     ;;
# *)
#     ;;
# esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#Prevent file overwrite on stdout redirection
#Use '>|' to force redirection to an existing file
set -o noclobber

#Automatically trim long paths in prompt
PROMPT_DIRTRIM=2

#Enable history expansion with space
#Type !!<space> to replace !! with last command
bind Space:magic-space

#Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

#Case insensitive globbing
shopt -s nocaseglob;

#Smarter tab completion (readline bindings)

#Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

#Treat hyphens and unserscores as equivalent
bind "set completion-map-case on"

#Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

#Immediately add trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

#SANE HISTORY DEFAULTS

#Append to history file, don't overwrite it
shopt -s histappend

#Save multi-line commands as one command
shopt -s cmdhist

#Record each line as it gets issued
PROMPT_COMMAND='history -a'

#Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

#Don't record some recommends
export HISTIGNORE="&:[]*:exit:ls:bg:fg:history:clear"

#Use standard ISO 8601 timestamp
HISTTIMEFORMAT='(%m/%d/%y %T) '

#Enable incremental history search up and down
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

#Better directory navigation

#Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null

#Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null

#Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null


#This is defines where cd looks for targets, add directories to have fast access to, separated by colon
CDPATH=".:~"

#This allows to bookmark favorite places across the filesystem
#Define a variable containing a path and you will be able to cd into it regardlesss of the directory you're in
#Example (export dotfiles="$HOME/dotfiles")
shopt -s cdable_vars


#BASE 16 colors
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

#FUZZY FINDER
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#Golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/golang


export PATH=$PATH:$GOPATH/bin:$GOROOT/bin:$HOME/.local/bin/sbin:$HOME/.local/bin:/sbin:/home/eddy/.cargo/bin

setxkbmap us -option "caps:swapescape"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Start TMUX
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#    exec tmux #new-session -A -s Main
#fi


