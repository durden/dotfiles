alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'

# Switch between linux/mac
alias gvim='mvim'
alias ev="gvim -p $@"

alias hdfview='/Applications/HDFView.app/Contents/MacOS/HDFView'

# Better version of this is provided via viack as mentioned below
sack() {
    search_text="$@"
    ack -l --print0 "$search_text" | xargs -0 mvim -p +/"$search_text"
}

alias gen_tags='ctags -R -o mytags .'
alias rm='rm -i'

alias ipy='ipython'
alias pyclean='find . -name "*.pyc" -exec rm -r {} \;'

# Specific git funcs/aliases
source ~/dotfiles/git_aliases.sh
