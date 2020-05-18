################################################################################
# Tweak my prompt
# Author: ansn
# Purpose: Parse the status of current repo quickly, along with branch name and 
#          report along with other usefule info like history, pwd, `date`, shell
################################################################################

# Declare colours and TimeZone
    red="\[\033[1;31m\]"
  green="\[\033[0;32m\]"
 yellow="\[\033[1;33m\]"
   blue="\[\033[1;34m\]"
magenta="\[\033[1;35m\]"
   cyan="\[\033[1;36m\]"
  white="\[\033[0;37m\]"
    end="\[\033[0m\]" # This is needed at the end... :(
export TZ=Asia/Calcutta

# First cut
#function parse_git_dirty {
#  [[ -z "$(command git status --porcelain)" ]] || echo "*";
#}
#function parse_git_branch {
#  rvar=$(command git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/");
#  if [[ -n "$(parse_git_dirty)" ]]; then
#    echo "${red}$rvar";
#  else 
#    echo "${yellow}$rvar";
#  fi
#}
#
#export PS1="${yellow}!\!: ${red}[ ${blue}\w ${red}] ${red}[${end}\D{%u,%D},\A|\s|\u@\h${red}]${yellow}\n$(parse_git_branch)$ ${end}"

git_branch() {
    # -- Finds and outputs the current branch name by parsing the list of
    #    all branches
    # -- Current branch is identified by an asterisk at the beginning
    # -- If not in a Git repository, error message goes to /dev/null and
    #    no output is produced
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

git_status() {
    # Outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    [[ -n $output ]] && output="|$output"  # separate from branch name
    echo $output
}

git_color() {
    # Receives output of git_status as argument; produces appropriate color
    # code based on status of working directory:
    # - White if everything is clean
    # - Green if all changes are staged
    # - Red if there are uncommitted changes with nothing staged
    # - Yellow if there are both staged and unstaged changes
    # - Blue if there are unpushed commits
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    local needs_push=$([[ $1 =~ P ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[1;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[1;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[1;31m'  # bold red
    elif [[ -n $needs_push ]]; then
        echo -e '\033[1;34m' # bold blue
    else
        echo -e '\033[1;37m'  # bold white
    fi
}

git_prompt() {
    # First, get the branch name...
    local branch=$(git_branch)
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        #echo -e "\x01$color\x02[$branch$state]\x01\033[00m\x02"  # last bit resets color
        echo -e "$color[$branch$state]"  # last bit resets color
    fi
}

#PS1="$yellow!\!:$red [$blue\w$red] $red[$end\D{%u,%D},\A|\s|\u@\h$red]$yellow\n$ $end"
PS1="$yellow!\!:$red [$blue\w$red] $red[$end\A|\u@\h$red]$yellow\n\$(git_prompt)$ $end"
