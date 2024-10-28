# Add Homebrew's executable directory to the front of the PATH
export PATH=/opt/homebrew/bin:$PATH

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/path/to/f-sy-h/F-Sy-H.plugin.zsh

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi
eval "$(zoxide init zsh)"

export PATH="$PATH:/Users/ben_wang/.spicetify"

alias ..="cd .."
alias ....="cd ../.."
alias ......="cd ../../.."
alias ........="cd ../../../.."
alias python="python3 "
alias pip="pip3 "
alias ls="eza "
alias sudo="sudo "
alias zshrc="nvim ~/dotfiles/.zshrc; source ~/.zshrc; cd"
alias cd="z"
alias vim="nvim "

mkcd() {
  mkdir $1 && cd $_
}

c() {
  g++ $1.cpp --std=c++17 -DLOCAL -o $1 && ./$1
}

j() {
  javac $1.java && java $1
}

function py() {
  python3 "$1.py"
}

eval $(thefuck --alias)

