# Fun git shortcuts/stats snatched from various places online
gitimpact()
{
    res=`/usr/bin/git log --numstat --pretty="%H" --author=llee "$@" | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}'`
    added=`echo $res | cut -d, -f1 | cut -d+ -f2`
    removed=`echo $res | cut -d, -f2 | cut -d- -f2`
    net=`expr $added - $removed`
    echo "Net: $net (Added: $added Removed: $removed)"
}

# Short cut to get pretty view of what commits in current branch are NOT yet
# in remote svn repo, aka what will be pushed with a git svn dcommit cmd
gitsvnpushed()
{
    # Stash anything that we currently have outstanding
    stashed=0
    if [ ! -z "`git diff --shortstat`" ]; then
        echo 'STASHED'
        stashed=1
        git stash -q
    fi

    commits=`git svn dcommit --dry-run | wc -l`

    # Output has one line of header information
    pushed_commits=`expr $commits - 1`

    echo "$pushed_commits commits to be pushed"

    git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n$pushed_commits "$@"
    gitsvndiffstats

    # Get local changes back
    if [ $stashed -eq 1 ]; then
        echo 'UNSTASHED'
        git stash pop -q
    fi
}

# Short cut to get pretty view of what commits in current branch are NOT yet
# in remote svn repo, aka what will be pushed with a git svn dcommit cmd
gitsvnpushed()
{
    # Stash anything that we currently have outstanding
    stashed=0
    if [ ! -z "`git diff --shortstat`" ]; then
        echo 'STASHED'
        stashed=1
        git stash -q
    fi

    commits=`git svn dcommit --dry-run | wc -l`

    # Output has one line of header information
    pushed_commits=`expr $commits - 1`

    echo "$pushed_commits commits to be pushed"

    git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit -n$pushed_commits "$@"
    gitsvndiffstats

    # Get local changes back
    if [ $stashed -eq 1 ]; then
        echo 'UNSTASHED'
        git stash pop -q
    fi
}

# Shortcut to get summary of what will be pushed to svn on next dcommit
gitsvndiffstats()
{
    commits=`git svn dcommit --dry-run | wc -l`

    # Output has one line of header information
    pushed_commits=`expr $commits - 1`

    res=`/usr/bin/git log -n$pushed_commits --numstat --pretty="%H" "$@" | awk 'NF==3 {plus+=$1; minus+=$2} END {printf("+%d, -%d\n", plus, minus)}'`
    added=`echo $res | cut -d, -f1 | cut -d+ -f2`
    removed=`echo $res | cut -d, -f2 | cut -d- -f2`
    net=`expr $added - $removed`

    echo "Net: $net (Added: $added Removed: $removed) -- $pushed_commits commits"
}

# Completely remove a file from all history in a git repo
whack_file() {
    file = $1

    git filter-branch --index-filter 'git rm --cached --ignore-unmatch $file' --prune-empty -- --all
    git push origin master --force
    rm -rf .git/refs/original/
    git reflog expire --expire=now --all
    git gc --prune=now
    git gc --aggressive --prune=now
}

changelog() {
    git log HEAD...`git log CHANGELOG | grep commit | cut -d' ' -f2 | head -n1`
}

alias gi=gitimpact
alias gsd=gitsvnpushed
alias gss=gitsvndiffstats
alias gwhackfile=whack_file

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gtoday='git log --reverse --oneline --since=yesterday'
