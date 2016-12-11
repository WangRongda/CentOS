# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias ctagsc='ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . /usr/include /usr/local/include'
alias exe='chmod a+x'
alias vimnote='vim + ~/CentOS_note.mytxt'
alias vimrc='vim + ~/.vimrc'
alias bashrc='vim + ~/.bashrc'
# NS2,tclsh complete
alias tclsh='rlwrap -cf ~/NS2/NS2complete tclsh'
alias ns2='rlwrap -cf ~/NS2/NS2complete ns'
alias baidu='w3m www.baidu.com'
alias baike='python ~/python/baike.py'
alias wgetall='wget -e robots=off -w 1 -x -np -p -k -r'
#alias toEn='python ~/python/toEn.py'

export COLUMNS
export LANG='zh_CN.UTF-8'
export PS4='$LINENO + '
#export NS_HOME=/home/d/soft/ns-allinone-2.35
#export PATH=.:$NS_HOME/nam.11:$NS_HOME/tcl8.5.10/unix:$NS_HOME/tk8.5.10/unix:$NS_HOME/bin:~/bin:$PATH
#export LD_LIBRARY_PATH=$NS_HOME/tcl8.5.10/unix:$NS_HOME/tk8.5.10/unix:$NS_HOME/otcl-1.9:$NS_HOME/lib:$LD_LIBRARY_PATH
#export TCL_LIBRARY=$NS_HOME/tcl8.5.10/library

export PATH=$PATH:.:~/bin

if [ -e /usr/share/terminfo/x/xterm-256color ]; then
export TERM='xterm-256color'
else
export TERM='xterm-color'
fi

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}[`basename ${PWD}`]\007"'
