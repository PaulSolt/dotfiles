# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/paulsolt/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# Use to change Ruby global install with ruby environment 
eval "$(rbenv init -)"

# Aliases

alias ll="ls -l"

# Aliases for safety (use the interactive mode)
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"


# Pass it the name and it'll create the folder and generate a starter Swift Package
# $ newXcode MyAwesomeApp
function newXcode {
	projectName=$1
	mkdir "$projectName"
	cd "$projectName"
	curl https://www.toptal.com/developers/gitignore/api/swift,xcode,macos > .gitignore
	swift package init
	swift package generate-xcodeproj
	xcode .
}

# Easier typing to move up one or two directories
# alias ..="cd .."
# alias ...="cd ../.."

alias reveal='open -R'

# Git aliases
alias gs="git status -sb"
alias pull="git pull"
alias push="git push"
alias refresh="source ~/.zshrc; echo Reloaded .zshrc settings"

# Open a file or directory in Xcode "xcode test.swift"
alias xcode='open -a Xcode'
alias beta='open -a Xcode-Beta'

# Open Book Folders for Auto Layout Book 1
alias cd1="cd /Users/paulsolt/book/Auto-Layout-Book-1"
alias cd2="cd /Users/paulsolt/dev/Auto-Layout-Book"

# Markdown Book/Writing Helpers
# Search a file for all markdown headings and bold headers
alias titles="grep -E '^[#]|(\*\*)'"

# Search a file for all TODO brackets of format [[TODO: edit the title]] 
# or [[IMAGE: iPhone XS home screen]]
alias todo="grep -E '^(\[\[)'"


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


# Hide warnings from Ruby 2.7.0 and Cocoapods (current issue: https://github.com/CocoaPods/CocoaPods/issues/9491)
export RUBYOPT=-W0
#export RUBYOPT=-W:no-deprecated
