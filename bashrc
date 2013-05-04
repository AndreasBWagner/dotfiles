#
#  Default initial .bashrc for the ac.  
#
#  Much of your environment should be setup in your .profile or
#  .bash_profile file.  The environment configured there will be
#  inherited by subshells, scripts, batch job etc.  This file 
#  (.bashrc) should only be used to define aliases, functions and, 
#  where necessary, terminal settings.  By default this file will 
#  be sourced for every bash shell and script so avoid unnecessary 
#  actions.  
#
#  See your .profile file for examples of how to add paths to 
#  software in your environment.
#  See http://nf.nci.org.au/facilities/software/modules.php
#  for instructions on how to set your environment to use specific
#  software packages.
#
#  $Id: default.bashrc,v 1.3 2008/12/18 00:08:09 dbs900 Exp $
#

#  Avoid going through here more than once in a shell


[[ $- != *i* ]] && return


#  Source global definitions to get the module command defined.
#  If you remove this from your file and/or you reset the BASH_ENV (or
#  ENV) variables,  you risk getting "module command not found"
#  errors from batch jobs.

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -n "$PS1" ]; then
##
##  Setup aliases etc for interactive session here
##
##  Any noisy output should go in here.  Output in non-interactive
##  sessions can cause failure. 
##
##  Put any tty settings in here

# echo I am an interactive session, so it is ok to be a bit noisy.
  true
fi

#nf_bashrc_sourced=YES

# COLOURS
#######################################################

#call locale to set colour fallback
source ~/.scripts/localeCheck
localeCheck

source ~/.scripts/apoklinonManage

#Some supercomputing clusters tend to use a dog old version of dir_colors - primarily to piss me off.
if [ $(echo "$(dircolors --version | head -n1 | awk '{ print $4 }') < 7.5" | bc) -eq 1 ]; then
    [ $apoklinonRGB -eq 1 ] && eval `dircolors -b <(sed -e '/RESET/d' -e '/MULTIHARDLINK/d' -e '/CAPABILITY/d' $HOME/.dir_colors.RGB)` || eval `dircolors -b <(sed -e '/RESET/d' -e '/MULTIHARDLINK/d' -e '/CAPABILITY/d' $HOME/.dir_colors.8bit)`
else
    [ $apoklinonRGB -eq 1 ] && eval `dircolors -b $HOME/.dir_colors.RGB` || eval `dircolors -b $HOME/.dir_colors.8bit`
fi

blueg=${blue#\\e[}
export GREP_OPTIONS='--color=auto' GREP_COLOR=${blueg%m}

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls)
#-------------------------------------------------------------
#alias ll="ls -l --group-directories-first"
alias ls='ls -hF --color'  # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lm='ls -al |more'    # pipe through 'more'
alias lr='ls -lR'          # recursive ls
alias tree='tree -Csu'     # nice alternative to 'recursive ls'

# If your version of 'ls' doesn't support --group-directories-first try this:
function ll(){ ls -l "$@"| egrep "^d" ; ls -lXB "$@" 2>&-| \
                egrep -v "^d|total "; }

alias dud='du -sh' #requires directory
alias vi='vim'

# NOTES
#######################################################

# To temporarily bypass an alias, we preceed the command with a \  
# EG:  the ls command is aliased, but to use the normal ls command you would 
# type \ls 


function ii() {
    echo -e "\nYou are logged on ${jazzberry}$HOST"
    echo -e "\nAdditionnal information:$reset " ; uname -a
    echo -e "\n${jazzberry}Users logged on:$reset " ; w -h
    echo -e "\n${jazzberry}Current date :$reset " ; date
    echo -e "\n${jazzberry}Machine stats :$reset " ; uptime
    echo -e "\n${jazzberry}Memory stats :$reset " ; free
    echo
}


# Underline
UBlack="\[\033[4;30m\]"       # Black
URed="\[\033[4;31m\]"         # Red
UGreen="\[\033[4;32m\]"       # Green
UYellow="\[\033[4;33m\]"      # Yellow
UBlue="\[\033[4;34m\]"        # Blue
UPurple="\[\033[4;35m\]"      # Purple
UCyan="\[\033[4;36m\]"        # Cyan
UWhite="\[\033[4;37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensty
IBlack="\[\033[0;90m\]"       # Black
IRed="\[\033[0;91m\]"         # Red
IGreen="\[\033[0;92m\]"       # Green
IYellow="\[\033[0;93m\]"      # Yellow
IBlue="\[\033[0;94m\]"        # Blue
IPurple="\[\033[0;95m\]"      # Purple
ICyan="\[\033[0;96m\]"        # Cyan
IWhite="\[\033[0;97m\]"       # White

# Bold High Intensty
BIBlack="\[\033[1;90m\]"      # Black
BIRed="\[\033[1;91m\]"        # Red
BIGreen="\[\033[1;92m\]"      # Green
BIYellow="\[\033[1;93m\]"     # Yellow
BIBlue="\[\033[1;94m\]"       # Blue
BIPurple="\[\033[1;95m\]"     # Purple
BICyan="\[\033[1;96m\]"       # Cyan
BIWhite="\[\033[1;97m\]"      # White

# High Intensty backgrounds
On_IBlack="\[\033[0;100m\]"   # Black
On_IRed="\[\033[0;101m\]"     # Red
On_IGreen="\[\033[0;102m\]"   # Green
On_IYellow="\[\033[0;103m\]"  # Yellow
On_IBlue="\[\033[0;104m\]"    # Blue
On_IPurple="\[\033[10;95m\]"  # Purple
On_ICyan="\[\033[0;106m\]"    # Cyan
On_IWhite="\[\033[0;107m\]"   # White

# Various variables
host=${HOSTNAME%%[.0-9]*}
Host=${host[@]^}
Time12h="\T"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"

export PS1=$davgrayp$Host$resetp'$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
    echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
    if [ "$?" -eq "0" ]; then \
        # @4 - Clean repository - nothing to commit
        echo "'$bluep'"$(__git_ps1 " (%s)"); \
    else \
       # @5 - Changes to working tree
       echo "'$brickp'"$(__git_ps1 " {%s}"); \
    fi) '$sandyp$PathShort$resetp'\$ "; \
else \
   # @2 - Prompt when not in GIT repo
   echo " '$aquap$PathShort$resetp'\$ "; \
fi)'


# Host specific proflie additions
[ -f ~/.dotfiles/includes/"$host"/bashrc ] && source ~/.dotfiles/includes/"$host"/bashrc

