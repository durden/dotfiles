alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'

# Switch between linux/mac
alias gvim='mvim'
alias ev="gvim -p $@"

hdfview() {
    # Stupid Java app won't take arguments and right-clicking on a file doesn't
    # seem to want to open the file. So, display the full path so it's easy to
    # cut and paste in app after opening.
    path=`pwd`
    name="$1"
    filename="$path/$name"
    echo "$filename"

    # Copy name without newline
    echo "$filename" | tr -d '\n' | pbcopy
    /Applications/HDFView.app/Contents/MacOS/HDFView &
}

# Better version of this is provided via viack as mentioned below
sack() {
    search_text="$@"
    ack -l --print0 "$search_text" | xargs -0 mvim -p +/"$search_text"
}

alias gen_tags='ctags -R -o mytags .'
alias rm='rm -i'

alias ipy='ipython'
alias pyclean='find . -name "*.pyc" -o -name "__pycache__" -exec rm -r {} \;'

# Specific git funcs/aliases
source ~/dotfiles/git_aliases.sh

# Aliases for fuzzy file search installed in ~/.fzf/
source ~/dotfiles/fzf_functions.sh
