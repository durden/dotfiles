alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'

# Switch between linux/mac
alias gvim='mvim'
alias ev="gvim -p $@"

alias oack='ack -l $@ | xargs gvim -p'

alias gen_tags='ctags -R -o mytags .'
alias rm='rm -i'

alias ipy='ipython'
alias pyclean='find . -name "*.pyc" -exec rm -r {} \;'

# Specific git funcs/aliases
source `dirname "${BASH_SOURCE[0]}"`/git_aliases.sh
