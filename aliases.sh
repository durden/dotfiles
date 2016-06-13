alias ls='ls -G'
alias ll='ls -alF'
alias la='ls -A'

# Switch between linux/mac
alias gvim='/usr/local/mvim'
alias ev="gvim -p $@"

alias oack='ack -l $@ | xargs gvim -p'

alias gen_tags='ctags -R -o mytags .'
alias rm='rm -i'

alias ipy='ipython'
alias pyclean='find . -name "*.pyc" -delete; find . -name "__pycache__" -delete'

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
    /Applications/TheHDFGroup/HDFView2.9/HDFView.app/Contents/MacOS/HDFView &
    #/Applications/HDFView.app/Contents/MacOS/HDFView &
}

# Spell check given files in directory recursively
spellcheck() {
    find . -iname "$1" -exec aspell -c {} \;
}

# List largest files/directories recursively in cwd
largest_stuff() {
    du -k | sort -nr | awk '
        function human(x) {
            s="kMGTEPYZ";
            while (x>=1000 && length(s)>1)
                {x/=1024; s=substr(s,2)}
            return int(x+0.5) substr(s,1,1)
        }
        {gsub(/^[0-9]+/, human($1)); print}' | head
}

# List files with most lines (including blank lines)
max_lines_with_blanks() {
    # http://stackoverflow.com/questions/8488301/bash-find-file-with-max-lines-count
    find . -name "*.py" -type f | xargs wc -l|sort -rn|grep -v ' total$'
}

max_lines_without_blanks() {
    # http://stackoverflow.com/questions/8488301/bash-find-file-with-max-lines-count
    find . -type f -name "*.py" -exec grep -H -c '[^[:space:]]' {} \; | sort -nr -t":" -k2
}

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

slog() {
    # Simulate git log -p with git svn log, show commit msg alongside the
    # # diff
    git log -p `git svn find-rev r"$1"`
}

recent_notes() {
    echo "Work notes"
    echo "==============================="
    ls -t -d1 $* ~/Dropbox/work/notes/* | head -n15
    echo ""
    echo ""

    echo "Personal notes"
    echo "==============================="
    ls -t -d1 $* ~/Dropbox/notes/* | head -n15
    echo ""
    echo ""
}

# Specific git funcs/aliases
source `dirname "${BASH_SOURCE[0]}"`/git_aliases.sh
