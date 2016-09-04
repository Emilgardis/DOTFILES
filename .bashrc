#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export EDITOR=vim
export CC=gcc
alias ls='ls --color=auto'
alias lsa='ls --color=auto -a'
alias '?'='echo $?'
eval "$(thefuck --alias)" 
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

# Rust things.
export RUST_SRC_PATH=/home/localsys/src/rust/src
export RUST_NEW_ERROR_FORMAT=true
export CARGO_HOME=/home/localsys/.cargo/
# Evic things
export EVICSDK=/home/localsys/projects/evic-sdk
export EVICSDKTC=/home/localsys/projects/evic-sdk-tc
alias upload="evic-usb upload"


alias xxd="xxd -u -c10 -g1"
# Set up "eat", AUR and pacman manager
eat () {
    if [[ $1 == '--noconfirm' ]]; then
        noconfirm=1
        shift
    fi
    abs_dir=${abs_dir:-$HOME/abs}
    mkdir -p "$abs_dir"
    for package in $@; do
        title "$HOSTNAME: Searching repos for '$package'..."
        echo -n "Looking for '$package' in the package repos... "
        result=$(pacman -Sqs | grep -m1 "^${package}$")
        if [[ $result ]]; then
            title "$HOSTNAME: Found package '$package'..."
            echo "Found: $result"
            [[ -z $noconfirm ]] &&
                read -n1 -p 'Install [Y/Enter], search AUR [A], or cancel [N]? ' feedback
            echo
            feedback=${feedback,,}
            if [[ -z $feedback || $feedback == 'y' ]]; then
                title "$HOSTNAME: Installing package '$package'..."
                sudo pacman -S $package
            fi
        else
            echo 'Not found.'
        fi
        if [[ -z $result || $feedback == 'a' ]]; then
            title "$HOSTNAME: Searching AUR for '$package'..."
            echo "Looking for '$package' in the AUR..."
            if [[ -d "$abs_dir/$package" ]]; then
                title "$HOSTNAME: Found existing build for '$package'"
                echo 'Build exists.'
                [[ -z $noconfirm ]] &&
                    read -n1 -p 'Overwrite [Y/Enter] or Cancel [N]? ' feedback
                echo
                [[ $feedback && ${feedback,,} != 'y' ]] &&
                    continue
            fi
            title "$HOSTNAME: Downloading build for '$package'"
            cower -df -t "$abs_dir" "$package"
        fi
    done
}
# --- Load Liquidprompt
[[ $- = *i* ]] && source liquidprompt

