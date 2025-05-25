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
alias zshrc="zed ~/dotfiles/.zshrc; source ~/.zshrc; cd"
alias cd="z"
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
alias please="sudo !!"

mkcd() {
  mkdir $1 && cd $_
}

c() {
  g++ $1.cpp --std=c++17 -O2 -DLOCAL -Wunreachable-code -o $1 && ./$1
}

function py() {
  python3 "$1.py"
}

ignitestart() {
  brew services start typesense-server
  brew services start mongodb-community
}

ignitestop() {
  brew services stop typesense-server
  brew services stop mongodb-community
}

eval $(thefuck --alias)

eval "$(atuin init zsh)"
