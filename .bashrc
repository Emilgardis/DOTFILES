#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set x to swedish keymap
setxkbmap se &
# Enable bash-completion

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f /usr/share/bash_completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi

export EDITOR=vim
export CC=gcc

alias ls='exa -G'
alias la='exa -Ga'
alias lx='exa'
alias lg='exa --git --long'
# lsa
# lsa () { ls --color=always -ltQhFgGa --group-directories-first; } ;
alias dir='ls --color=always --format=vertical'
alias vdir='ls --color=always --format=long'

# some more ls aliases
alias ll='ls --color=auto -lhX'
#alias la='ls --color=auto -A'
alias ldir='ls --color=auto -lhA |grep --color=never ^d'
alias lfiles='ls --color=auto -lhA |grep ^-'
#alias l='ls -CF'

# To see something coming into ls output: lss
alias lss='ls -lrta | grep $1'

# To check a process is running in a box with a heavy load: pss
alias pss='ps -ef | grep $1'

# usefull alias to browse your filesystem for heavy usage quickly
alias ducks='ls -A --color=auto | grep -v -e '\''^\.\.$'\'' |xargs -i du -ks {} |sort -rn |head -16 | awk '\''{print $2}'\'' | xargs -i
 du -hs {}'

alias open='xdg-open'

alias '?'='echo $?'
# ' Fixes formatting bug
eval "$(thefuck --alias)" 
# Setup x
# ensure X forwarding is setup correctly, even for screen
XAUTH=~/.Xauthority
if [[ ! -e "${XAUTH}" ]]; then
         # create new ~/.Xauthority file
          xauth
  fi
  if [[ -z "${XAUTHORITY}" ]]; then
           # export env var if not already available.
            export XAUTHORITY="${XAUTH}" 
    fi

# -- Improved X11 forwarding through GNU Screen (or tmux).
# If not in screen or tmux, update the DISPLAY cache.
# If we are, update the value of DISPLAY to be that in the cache.
function update-x11-forwarding
{
    if [ -z "$STY" -a -z "$TMUX" ]; then
        echo $DISPLAY > ~/.display.txt
    else
        export DISPLAY='localhost:10.0'
        export XAUTHORITY=/Network/Servers/waldorf.forsmarksskola.se/Volumes/Extern1/home/fs14emga/.Xauthority
    fi
}


PATH=$PATH:/home/localsys/.local/bin:/home/localsys/.cargo/bin:/home/localsys/.gem/ruby/2.3.0/bin:/home/localsys/.cargo:/home/localsys/.cargo/bin
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:
# Use correct winsize
shopt -s checkwinsize

# One line history
shopt -s cmdhist

# Set cd alias correct
shopt -s cdspell
shopt -s autocd

# Correct tab complete off-by-one mistakes
shopt -s dirspell

shopt -s globstar

# Rust things.
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export RUST_NEW_ERROR_FORMAT=true
export CARGO_HOME=/home/localsys/.cargo/
## rust-lldb doesn't work atm. Make a temporary override of rust-lldb
# alias rust-lldb="/home/localsys/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/etc/rust-lldb"
# Evic things
export EVICSDK=/home/localsys/projects/evic-sdk
export EVICSDKTC=/home/localsys/projects/evic-sdk-tc
alias upload="evic-usb upload"
alias xxd="xxd -u -c10 -g1"

# Make pacman have color
alias pacman="pacman --color=auto"
# Set up "eat", AUR and pacman manager
eat () {
    if [[ $1 == '--noconfirm' ]]; then
        noconfirm=1
        shift
    fi
    abs_dir=${abs_dir:-$HOME/abs}
    mkdir -p "$abs_dir"
    for package in $@; do
        echo  "$HOSTNAME: Searching repos for '$package'..."
        echo -n "Looking for '$package' in the package repos... "
        result=$(pacman -Sqs | grep -m1 "^${package}$")
        if [[ $result ]]; then
            echo  "$HOSTNAME: Found package '$package'..."
            echo "Found: $result"
            [[ -z $noconfirm ]] &&
                read -n1 -p 'Install [Y/Enter], search AUR [A], or cancel [N]? ' feedback
            echo
            feedback=${feedback,,}
            if [[ -z $feedback || $feedback == 'y' ]]; then
                echo "$HOSTNAME: Installing package '$package'..."
                sudo pacman -S $package
            fi
    else
            echo 'Not found.'
        fi
        if [[ -z $result || $feedback == 'a' ]]; then
            echo "$HOSTNAME: Searching AUR for '$package'..."
            echo "Looking for '$package' in the AUR..."
            if [[ -d "$abs_dir/$package" ]]; then
                echo "$HOSTNAME: Found existing build for '$package'"
                echo 'Build exists.'
                [[ -z $noconfirm ]] &&
                    read -n1 -p 'Overwrite [Y/Enter] or Cancel [N]? ' feedback
                echo
                [[ $feedback && ${feedback,,} != 'y' ]] &&
                    continue
            fi
            echo "$HOSTNAME: Downloading build for '$package'"
            cower -df -t "$abs_dir" "$package"
        fi
    done
}

# Random stuff
alias steam='env STEAM_RUNTIME=0 /usr/bin/steam %U'
alias rmx='\rm'
alias rm='echo nej du inte rm '
alias yes='echo jaaaa'
alias car='clear; cargo run'
alias gisl='git smart-log'
alias gipu='git pull'
alias gist='git status'
alias gich='git checkout'
alias _vim='\vim'
alias vim='nvim'
# --- Load Liquidprompt
[[ $- = *i* ]] && source liquidprompt

