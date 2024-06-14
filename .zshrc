# Add Homebrew's executable directory to the front of the PATH
export PATH=/usr/local/bin:$PATH

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/path/to/f-sy-h/F-Sy-H.plugin.zsh

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi
eval "$(zoxide init zsh)"

export CPATH=/opt/homebrew/Cellar/python@3.12/3.12.0/Frameworks/Python.framework/Versions/3.12/include/python3.12
export PATH="$(brew --prefix)/opt/python@3.12/libexec/bin:$PATH"

alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."
alias ........="cd ../../../.."
alias home="cd"
alias back="cd .."
alias python="python3 "
alias pip="pip3 "
alias l="ls --color -l -h"
alias lsall="ls -lah"
alias sudo="sudo "
alias zshrc="cd ~/dotfiles; nvim .zshrc; source .zshrc; cd"
alias cd="z "
alias vim="nvim "
alias comfyuistart="python3 main.py --force-fp16"
alias treeall="tree -I '.git' -a ."
alias gittree="git log --all --decorate --oneline --graph"
alias gp="git push origin "

mkcd() {
  mkdir $1 && cd $_
}

c() {
  g++ $1.cpp -o $1 && ./$1
}

function py() {
  python3 "$1.py"
}
