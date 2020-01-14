
# ENVIRONMENT VARIABLES

# add my ~/bin dir to path
PATH=${PATH}:~/bin
export PATH

# simple prompt
# default macOS prompt is: \h:\W \u\$

export PS1="\W \$ "

# Color git branchname and dirty flag
source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-completion.bash
source /Applications/Xcode.app/Contents/Developer/usr/share/git-core/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS="yes"
export PS1='\W\[\033[32m\]$(__git_ps1)\[\033[00m\]$ '


# enable Terminal color
export CLICOLOR=1

# Google Mock/Testing
export GMOCK_HOME=~/dev/github/googletest-release-1.8.0
export CPPUTEST_HOME=/usr/local/Cellar/cpputest/3.8
export JSONCPP_HOME=/usr/local/Cellar/jsoncpp/1.8.0
export RLOG_HOME=/usr/local/Cellar/rlog/1.4
export BOOST_ROOT=/usr/local/Cellar/boost/1.63.0
export BOOST_VERSION=1.63.0
export CURL_HOME=~/dev/github/curl-7.53.1

# Use to change Ruby global install with ruby environment 
eval "$(rbenv init -)"

# Aliases

alias ll="ls -l"

# Aliases for safety (use the interactive mode)
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# Easier typing to move up one or two directories
alias ..="cd .."
alias ...="cd ../.."

alias reveal='open -R'

# Git aliases
alias gs="git status -sb"
alias pull="git pull"
alias push="git push"
alias refresh="source ~/.bash_profile; echo Reloaded Bash Profile"

# Open a file in xcode "xcode test.swift"
alias xcode='open -a Xcode'


# Open Book Folders for Auto Layout Book 1
alias cd1="cd /Users/paulsolt/book/Auto-Layout-Book-1"
alias cd2="cd /Users/paulsolt/dev/Auto-Layout-Book"

# Markdown Book/Writing Helpers
# Search a file for all markdown headings and bold headers
alias titles="grep -E '^[#]|(\*\*)'"

# Search a file for all TODO brackets of format [[TODO: edit the title]] 
# or [[IMAGE: iPhone XS home screen]]
alias todo="grep -E '^(\[\[)'"


# Playing with Scheme programming (MIT SICP)
# https://groups.csail.mit.edu/mac/users/gjs/6.945/dont-panic/

alias edwin="scheme --edit --heap 100000"

alias emacs1="/usr/bin/emacs"


# PDF version of man pages
function preman() {
	man -t $@ | open -f -a "Preview"
}

# prints the path of the front Finder window. Desktop if no window open
function pwdf () {
    osascript <<EOS
        tell application "Finder"
            if (count of Finder windows) is 0 then
                set dir to (desktop as alias)
            else
                set dir to ((target of Finder window 1) as alias)
            end if
            return POSIX path of dir
        end tell
EOS
}

# changes directory to frontmost 
alias cdf='pwdf; cd "$(pwdf)"'


# Word count and diff for Chaptered files "Chapter 1 <your title>.md"
function words {
	echo "    Words added: "$(git_words_added)
	echo "    Words removed: " $(git_words_removed)
	echo "    Word diff: " $(git_words_diff)
	echo
	wc -w C*.md
}

# Word Aliases for Weekly stats (relative to current day)

alias wordsWeek1="git_words_added master@{7.days.ago}"
alias wordsWeek2="git_words_added master@{2.weeks.ago}..master@{1.weeks.ago}"
alias wordsWeek3="git_words_added master@{3.weeks.ago}..master@{2.weeks.ago}"
alias wordsWeek4="git_words_added master@{4.weeks.ago}..master@{3.weeks.ago}"
alias wordsWeek5="git_words_added master@{5.weeks.ago}..master@{4.weeks.ago}"

function wordsMonth {
	echo "    Last 7 days:" `wordsWeek1`
	echo "    1 week ago: " `wordsWeek2`
	echo "    2 weeks ago:" `wordsWeek3`
	echo "    3 weeks ago:" `wordsWeek4`
	echo "    4 weeks ago:" `wordsWeek5`
}

# Calculate writing word diff between revisions. Cribbed / modified from:
# https://stackoverflow.com/questions/2874318/quantifying-the-amount-of-change-in-a-git-diff
function git_words_added {
  revision=${1:-origin/master}

  git diff --word-diff=porcelain $revision | \
    grep -e "^+[^+]" | \
    wc -w | \
    xargs
}

function git_words_removed {
  revision=${1:-origin/master}

  git diff --word-diff=porcelain $revision | \
    grep -e "^-[^-]" | \
    wc -w | \
    xargs
}

function git_words_diff {
  revision=${1:-origin/master}

  echo $(($(git_words_added $1) - $(git_words_removed $1)))
}
