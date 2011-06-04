if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# [ PS1 color style ]# {{{
#--------------------------------------------

# 右上角 用户名
#PS1="\[\e[1;31m\][\W]\$\[\e[s\]\[\e[1;\$((COLUMNS-4))f\]\[\e[1;32m\]\$(whoami)\[\e[u\]\[\e[0m\]"
#PS1="\[\e[1;31m\]\W \$\[\e[s\]\[\e[1;\$((COLUMNS-5))f\]\[\e[1;32m\]\$(whoami)\[\e[u\]\[\e[0m\]"

#PS1='\[\033[34m\]\t\[\033[1;31m\][\u@\h]\[\033[1;32m\]\w\[\033[m\]\$'
#PS1='\[\033[1;31m\][ \u·\W ] > \[\033[m\]'

#PS1='\[\033[1;32m\]\u @ \[\033[1;34m\]\w \[\033[1;33m\][ \d \t ] \n[ h:\! l:\# ]\[\033[1;31m\] $ \[\033[0;39m\]'
PS1='\[\033[1;32m\]\u @ \[\033[1;34m\]\w \[\033[1;33m\] \n\[\033[1;31m\] $ \[\033[0;39m\]'

#PS1='\[\033[34m\]\t\[\033[1;31m\][\u@\h]\[\033[1;32m\]\w\[\033[m\]\$'
#PS1='\[\033[34m\]\t\[\033[m\]\[\033[36m\][\u@\[\033[m\]\[\033[36m\]\h]\[\033[m\]\[\033[31;1m\]\w\[\033[m\]\$'

#Black  0;30
#Red    0;31
#Green  0;32
#Brown  0;33
#Blue   0;34
#Purple 0;35
#Cyan   0;36

# }}}

# [ export 环境变量 ]# {{{
#--------------------------------------------

export PATH=$PATH:~/code/shell
#export CDPATH='.:..:../..:~/links:~:~/projects:/var/www/virtual_hosts'
export CDPATH='.:..:../..:~:~/text:~/code/'
export MYSQL_PS1="[\\u@\\h \\d]"

# go-office gtk2 set
#export OOO_FORCE_DESKTOP=gnome
#export OOO_FORCE_DESKTOP=gnome







# }}}

# [ alias 别名 ]#{{{
#--------------------------------------------

# ls color set
export LS_OPTIONS='--color=auto'
eval "`dircolors`"

# 颜色，文件类型标志符，横向排列
alias ls='ls $LS_OPTIONS -Fx'

# 下面的别名都会将 ls 使用上面的代替，无须在重复相应参数
#alias ll='ls $LS_OPTIONS -lFh'
#alias la='ls $LS_OPTIONS -A'
#alias lla="ls -alFh --color=auto"
#alias ll='ls -lh --time-style=long-iso'
alias l='ls -1X'
# + 按照 date 格式自定义时间格式，去掉 24 小时时间
alias ll='ls -lh --time-style=+%Y-%m-%d'
alias la='ls -A'
alias lla="ls -Alh"

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'
alias tee='tee -a'
alias grep='grep -i --color'

alias c="clear"
# todo.sh 使用该 别名了
#alias t="tmux"
alias Vim="sudo vim"
alias exit="clear; exit"
alias halt="sudo halt"
alias reboot="sudo reboot"

# 多级目录回溯
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

# U 盘挂载
alias Uin="sudo mount -t vfat -o iocharset=utf8,uid=1000,gid=100 /dev/sdb4 /mnt/usb/"
alias Uout="sudo umount /mnt/usb/"
alias mym="sudo mount -o iocharset=utf8,uid=1000,gid=100 "
alias myu="sudo umount "

alias myhttpd='sudo /etc/rc.d/httpd'
alias mymysqld='sudo /etc/rc.d/mysqld'
alias mysshd='sudo /etc/rc.d/sshd'








#}}}

# [ bash set 变量设置 ]# {{{
#--------------------------------------------

# bash 使用 vi 风格的行编辑
#set -o vi

## Bash下Vi输入模式重设 Ctrl-N, Ctrl-P, Ctrl-L等快捷
## 默认是保存到 .inputrc 文件
#set editing-mode vi
#set show-all-if-ambiguous on
#set completion-ignore-case on
#set meta-flag on
#set convert-meta off
#set output-meta on
#set bell-style visible

# 使用 bind -p 列出相应操作所对应的按键
#"\C-l": clear-screen
#"\C-n": next-history
#"\C-p": previous-history
#"\C-a": beginning-of-line
#"\C-e": end-of-line
#"\C-f": forward-char
#"\C-b": backward-char

# }}}

# [ man 手册 颜色 ]#{{{
#--------------------------------------------
# same to .zshrc
export LESS_TERMCAP_mb=$'\E[01;31m'   # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'       # end mode
export LESS_TERMCAP_se=$'\E[0m'       # end standout-mode
export LESS_TERMCAP_so=$'\E[1;33;40m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'       # end underline
export LESS_TERMCAP_us=$'\E[1;32m'    # begin underline
#}}}

# [ tmux 256 color 提示符 ]# {{{
#--------------------------------------------

# tmux 256 support
#[[ $TERM == "screen" ]] && export -p TERM="screen-256color"
#export -p TERM="screen-256color"

# /etc/bash.bashrc 里面的 终端标题设置,注释之后即可使Fvwm里面的xterm 标题使用 xterm
# 而非以下定义的( ascii 007 \a 代表报警响铃 )
# if test "$TERM" = "xterm" -o \
#         "$TERM" = "xterm-color" -o \
#         "$TERM" = "xterm-256color" -o \
# 
#         "$TERM" = "rxvt" -o \
#         "$TERM" = "rxvt-unicode" -o \
#         "$TERM" = "xterm-xfree86"; then
#     PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
#     export PROMPT_COMMAND
# fi

#alias tmux='tmux -2 '  # 256 colors
# xterm urxvt 256 color [tmux]
export TERM=xterm-256color

# xterm title 标题栏,PROMPT_COMMAND 会在 PS1 随执行，报警声，bell
case $TERM in
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;xterm -> ${PWD}\007"'
        export PROMPT_COMMAND
        ;;
    #screen*)
    #   # 以下为 自定义 变量
    #   PATHTITLE='\[\ek\W\e\\\]'
    #   PROGRAMTITLE='\[\ek\e\\\]'
    #   PS1="${PROGRAMTITLE}${PATHTITLE}${PS1}"
    #   ;;
    rxvt)
        PROMPT_COMMAND='echo -ne "\033]0;urxvt : ${PWD}\007"'
        export PROMPT_COMMAND
        ;;
    *)
        ;;
esac








# }}}

# [ arch pacman alias ]# {{{
#--------------------------------------------

alias P="pacman"
alias Y="yaourt"

# 在 后面添加 空格，可以实现自动补全
alias pac="sudo pacman -S "
alias pacs="pacman -Ss "
alias pq='pacman -Q '
alias pm='sudo pacman -Rsun '
alias pu="sudo pacman -Su"
alias py="sudo pacman -Sy"

alias yao="sudo yaourt -S "
alias ys="yaourt -Ss "
alias yq="yaourt -Q "
alias yu="sudo yaourt -Su"
alias yy="sudo yaourt -Sy"

#lets you search through all available packages simply using 'pacsearch packagename'
#alias pacsearch="pacman -Sl | cut -d' ' -f2 | grep "

# colorized pacman output with pacs alias:
#alias pacs="pacsearch"
#pacsearch()
#{
#   echo -e "$(pacman -Ss $@ | sed \
#   -e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
#   -e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
#   -e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
#   -e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
#}

# }}}

# [ history 历史记录 ]# {{{
#--------------------------------------------

#datestamp_history(){
#export infodate=`date “+: %c”`
#export infohis=`history 1`
#echo $infodate’ => ‘$infohis >> $HOME/.history-timestamp
#}
#export PROMPT_COMMAND=datestamp_history

#--------------------------------------------

# HISTSIZE 控制历史命令记录的总行数,默认 500
export HISTSIZE=1000
export HISTFILESIZE=1000

# 禁用 history，,将 HISTSIZE 设置为 0
#export HISTSIZE=0

# HISTIGNORE 忽略历史中的特定命令, 将忽略 pwd、ls、ls -ltr 等命令：
export HISTIGNORE="ls:ls -ltr:ll:la:cd:"

# 重复的命令，多个 shell 可能会干扰各自的历史记录，在 shell 中执行 shopt -s histappend

# 移除 shell 历史记录中连续的重复命令，清除整个命令历史中的重复条目 erasedups 参数
export HISTCONTROL=erasedups

# 使用 HISTTIMEFORMAT 显示时间戳
#export HISTTIMEFORMAT='%F %T '

# HISTFILE 更改历史文件名称
#HISTFILE=/root/.commandline_warrior







# }}}







