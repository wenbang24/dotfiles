# Add Homebrew's executable directory to the front of the PATH
export PATH=/opt/homebrew/bin:$PATH

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source ~/.f-sy-h/F-Sy-H.plugin.zsh

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"
fi
eval "$(zoxide init zsh)"

export PATH="$PATH:/Users/ben_wang/.local/bin"

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
alias g="git "
alias k="kubectl "
alias gpo="git push origin "
alias gc="git commit -a -m "
alias ga="git add --all"
alias j="just "

mkcd() {
  mkdir $1 && cd $_
}

function py() {
  python3 "$1.py"
}

release() {
    git tag "$1" && git push origin "$1"
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

export EDITOR=nvim

eval "$(atuin init zsh)"

. "$HOME/.local/bin/env"
