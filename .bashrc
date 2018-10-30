
# ENVIRONMENT VARIABLES

# add my ~/bin dir to path
PATH=${PATH}:~/bin
export PATH

# simple prompt
# default macOS prompt is: \h:\W \u\$
export PS1="\W \$ "

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

# Open a file in xcode "xcode test.swift"
alias xcode='open -a Xcode'

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