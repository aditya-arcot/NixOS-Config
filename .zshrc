fastfetch


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### OMZ ###
zstyle ':omz:update' mode auto
HYPHEN_INSENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="%Y-%m-%d %H:%M:%S"

export UPDATE_ZSH_DAYS=1
export ZSH_CUSTOM_AUTOUPDATE_QUIET=true
export ZSH_CUSTOM_AUTOUPDATE_NUM_WORKERS=8
### OMZ ###


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


eval "$(zoxide init zsh)"

export PAGER='less -S'

export EZA_CONFIG_DIR=~/.config/eza
unset LS_COLORS

export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

export HISTSIZE=100000
export SAVEHIST=100000
setopt incappendhistory
unsetopt sharehistory


### ALIASES ###
alias ls='eza -aal --icons=always --git-repos --time-style=relative'
alias _ls='\ls'
alias _l='\ls -lah'
alias _la='\ls -lah'
alias _ll='\ls -lh'
alias _lsa='\ls -lah'

alias vi=nvim
alias vim=nvim

alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

cd() {
	echo "use 'z' & 'zi' commands instead"
	builtin cd "$@"
}

alias path='for i in $(echo "$PATH" | sed "s/:/ /g"); do echo $i; done;'

alias epoch='date +%s'

alias password='openssl rand -hex 32'

alias strip_ansi='sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,3})*)?[mGK]//g"'
### ALIASES ###

