# vim:set et ft=zsh fdm=marker sw=4 ts=4 nopaste softtabstop=4 :

#       环境变量# {{{
############################################

# 前置的主要原因是有可能需要提前设置PATH等环境变量

# 使 screen 支持 256 色
export TERM=xterm-256color

export PATH="${PATH}:${HOME}/me/code/shell"
export CDPATH='.:..:../..:~:~/me:~/me/text:~/public_html/:/home/download/'
export MYSQL_PS1="[\\u@\\h \\d]"

export SHELL=`which zsh`

# Emacs 中 fcitx 输入法激活
#export LC_CTYPE=zh_CN.UTF-8

# [ Keychain ssh-agent ]
#--------------------------------------------
# From : http://linux.chinaunix.net/bbs/archiver/tid-1132824.html
# 在 新启动的 zsh 中，继承 / 共用 keychain 产生的 ssh-agent 进程
if [ -n `ps aux | grep ssh-agent | grep -v grep | awk '{print $2}'` ]
then
    if [ -z ${SSH_AGENT_PID} ];then
        source ~/.keychain/`hostname`-sh
    fi
fi

function keys(){
    source ~/.keychain/`hostname`-sh;
}



# NetBeans java 程序 字体开启抗锯齿
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

#RPROMPT=$(echo '%{\033[31m%}%D %T%{\033[m%}')
#PROMPT=$(echo '%{\033[34m%}%M%{\033[32m%}%/
#%{\033[36m%}%n %{\033[01;31m%}>%{\033[33m%}>%{\033[34m%}>%{\033[m%} ')
# }}}

# 终端 标题栏 动态改变 #  {{{
case $TERM in
    #xterm*|rxvt*)
    rxvt*)
        function title() { print -nP "\e]0;$1\a" } 
        ;;
    xterm-256color|screen*)
        #only set screen title if it is in a local shell
        if [ -n $STY ] && (screen -ls |grep $STY &>/dev/null); then

            # 标题栏 定制函数
            function title() 
            {
                # 动态 标题栏
                print -nP "\ek$1\e\\"
                #modify window title bar
                #print -nPR $'\033]0;'$2$'\a'
            }

        elif [ -n $TMUX ]; then       # actually in tmux !
            function title() {  print -nP "\e]2;$1\a" }
        else
            function title() {}
        fi
        ;;
    *) 
        function title() {} 
        ;;
esac     

# Screen 动态改变 标题栏 扩展函数
# set screen title if not connected remotely
#if [ "$STY" != "" ]; then
screen_precmd() {

    # 底部 标题 使用 短路径
    title "%10< ..<%c%<<"

    #a bell, urgent notification trigger
    #echo -ne '\a'
    #title "`print -Pn "%~" | sed "s:\([~/][^/]*\)/.*/:\1...:"`" "$TERM $PWD"
    #title "`print -Pn "%~" |sed "s:\([~/][^/]*\)/.*/:\1...:;s:\([^-]*-[^-]*\)-.*:\1:"`" "$TERM $PWD"
    #echo -ne '\033[?17;0;127c'
}

screen_preexec() {

    title "%10>..>$1%<<"
    #local -a cmd; cmd=(${(z)1})
    #if [[ $cmd[1]:t == "ssh" ]]; then
    #    title "@""`echo $cmd[2]|sed 's:.*@::'`" "$TERM $cmd"
    #elif [[ $cmd[1]:t == "sudo" ]]; then
    #    title "#"$cmd[2]:t "$TERM $cmd[3,-1]"
    #elif [[ $cmd[1]:t == "for" ]]; then
    #    title "()"$cmd[7] "$TERM $cmd"
    #elif [[ $cmd[1]:t == "svn" ]]; then
    #    title "$cmd[1,2]" "$TERM $cmd"
    #elif [[ $cmd[1]:t == "ls" ]] || [[ $cmd[1]:t == "ll" ]] ; then
    #else
    #    title $cmd[1]:t "$TERM $cmd[2,-1]"
    #fi 
}

#{{{ 将 自定义的 screen 扩展函数 添加到 zsh 默认的 precmd preexec 函数队列

# 适用于 zsh 4.3.* 版本
typeset -ga preexec_functions precmd_functions chpwd_functions
precmd_functions+=screen_precmd
preexec_functions+=screen_preexec
preexec_functions+=pwd_color_prexec
chpwd_functions+=pwd_color_chpwd

#}}}

#}}}

# PS1 参考示例# {{{
## color 颜色 定义

#autoload colors
#[[ $terminfo[colors] -ge 8 ]] && colors
#pR="%{$reset_color%}%u%b" pB="%B" pU="%U"
#for i in red green blue yellow magenta cyan white black; {eval pfg_$i="%{$fg[$i]%}" pbg_$i="%{$bg[$i]%}"}
#

#setopt prompt_subst             # prompt more dynamic, allow function in prompt
#
#if [ "$SSH_TTY" = "" ]; then
#    local host="$pB$pfg_magenta%m$pR"
#else
#    local host="$pB$pfg_red%m$pR"
#fi
#
#local user="$pB%(!:$pfg_red:$pfg_green)%n$pR"       #different color for privileged sessions
#local symbol="$pB%(!:$pfg_red# :$pfg_yellow> )$pR"
#local job="%1(j,$pfg_red:$pfg_blue%j,)$pR"
#
##PROMPT='$user$pfg_yellow@$pR$host$(get_prompt_git)$job$symbol'
#PROMPT='$user$pfg_yellow@$pR$host$job$symbol'
#PROMPT2="$PROMPT$pfg_cyan%_$pR $pB$pfg_black>$pR$pfg_green>$pB$pfg_green>$pR "
# }}}

# PS1 提示符# {{{
setprompt () {
    # load some modules
    autoload -U colors zsh/terminfo # Used in the colour alias below
    colors
    setopt prompt_subst

    # make some aliases for the colours: (coud use normal escap.seq's too)
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
        eval PR_$color='%{$fg[${(L)color}]%}'
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"


    # Check the UID
    if [[ $UID -ge 1000 ]]; then # normal user
        eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
        #eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
        # 自定义 用户标志符
        eval PR_USER_OP='${PR_CYAN}·${PR_NO_COLOR}'
    elif [[ $UID -eq 0 ]]; then # root
        eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
        eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
    fi  

    # Check if we are on SSH or not  --{FIXME}--  always goes to |no SSH|
    if [[ -z "$SSH_CLIENT"  ||  -z "$SSH2_CLIENT" ]]; then 
        eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
    else 
        eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
    fi

    # 自定义 用户标志符的空格是添加在 PS1，若添加在 上面的 $PR_USER 会出错！
    PS1=$'${PR_RED} %B%1~%b ${PR_USER_OP} ${PR_NO_COLOR}'
    #RPROMPT='$PR_GREEN%B%n$PR_NO_COLOR'

    # set the prompt
    #PS1=$'${PR_CYAN}[${PR_USER}${PR_CYAN}@${PR_HOST}${PR_CYAN}][${PR_BLUE}%1~${PR_CYAN}]${PR_USER_OP}'
    #PS2=$'%_>'
}
setprompt
# }}}

############################################
# 效果超炫的提示符
# http://i.linuxtoy.org/docs/guide/ch30s04.html
############################################

#       Base 基本# {{{
############################################

# 默认配置文件 格式 ：
#setopt appendhistory autocd extendedglob nomatch notify

# 关闭 报错 响铃
setopt NO_BEEP

#do not expand aliases _before_ completion has finished
setopt complete_aliases

#automatically send SIGCON to disowned jobs
setopt auto_continue

# 扩展通配符 ^() *~() ()#
setopt extended_glob

# pushds 和 popds 操作 静默模式
setopt pushd_silent

# expand alphabetic brace expressions
setopt brace_ccl

# 拼写检查
setopt correct

# 命令执行完毕前，搜索所有路径
setopt hash_list_all

# 自动补全提示 ，使用 类似 ls -F 的文件类型标志符
setopt list_types

# 显示 后台 运行的 作业 号
setopt long_list_jobs

# when globbing numbered files, use real counting
setopt numeric_glob_sort

# 关闭 C-q/C-k 锁定 终端快捷键 [screen]
#unsetopt flowcontrol
# ~/ln -> /; cd ln; pwd -> /
#setopt chase_links
# }}}

# 历史纪录的配置 {{{
############################################

#历史纪录条目数量
export HISTSIZE=1000
#注销后保存的历史纪录条目数量
export SAVEHIST=1000
#历史纪录文件
export HISTFILE=~/.zhistory
# 多 session 共享历史
setopt SHARE_HISTORY
# 附加，递增立即写入方式 历史纪录，而 APPEND_HISTORY 则是在 shell 退出之后写入
setopt INC_APPEND_HISTORY
#如果连续输入的命令相同，历史纪录中只保留一个
setopt HIST_IGNORE_DUPS      
#为历史纪录中的命令添加时间戳      
setopt EXTENDED_HISTORY      
# 删除历史文件 里面的空白
setopt hist_reduce_blanks
# 使用 历史命令时 重载 完整的 命令
setopt hist_verify
# 删除 超出 最大上限 数量的 记录
setopt hist_expire_dups_first
# don not beep on history expansion errors
setopt no_hist_beep

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD
#相同的历史路径只保留一个
setopt PUSHD_IGNORE_DUPS
#setopt hist_ignore_all_dups

#在命令前添加空格，不将此命令添加到纪录文件中
#setopt HIST_IGNORE_SPACE      
#}}}

#杂项 {{{
#允许在交互模式中使用注释  例如：
#cmd #这是注释
setopt INTERACTIVE_COMMENTS      
      
#启用自动 cd，输入目录名回车进入目录
#稍微有点混乱，不如 cd 补全实用
#setopt AUTO_CD
      
#扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
setopt complete_in_word
      
#禁用 core dumps
limit coredumpsize 0

#Emacs风格 键绑定
bindkey -e
#设置 [DEL]键 为向后删除
bindkey "\e[3~" delete-char

#report to me when people login/logout
watch=(notme)
#replace the default beep with a message
#ZBEEP="\e[?5h\e[?5l"        # visual beep

#以下字符视为单词的一部分
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'
#}}}

#自动补全功能 {{{
setopt AUTO_LIST
setopt AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE

autoload -U compinit
compinit

#自动补全缓存
#zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
# cd 不选择 父 目录
#zstyle ':completion:*:cd:*' ignore-parents parent pwd

# 纠错，作用于所有参数
# setopt correctall
# 纠错，作用于所有参数
# setopt correctall

#自动补全选项
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

#路径补全
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*' menu select
zstyle ':completion:*:*:default' force-list always

#彩色补全菜单 
eval $(dircolors -b) 
export ZLSCOLORS="${LS_COLORS}"
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#修正大小写
#zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
# 大写 <==> 小写
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# 大小写 <==> 大小写
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

#错误校正      
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
# 容错字数 可以修改
zstyle ':completion:*:approximate:*' max-errors 1 numeric

#kill 命令补全      
#compdef pkill=kill
#compdef pkill=killall
#zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:*:*:*:processes' force-list always
#zstyle ':completion:*:*:killall:*' menu yes select
#zstyle ':completion:*:killall:*'   force-list always
#zstyle ':completion:*:processes' command 'ps -au$USER'


# kill 命令补全
# From http://wandsea.com/doc/opensource_guide/ch14s09.html
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'

# 使用 cache 加速 pacman 补全
zstyle ':completion::complete:*' use-cache on

#补全类型提示分组 
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

## 补全提示 格式 样式
#zstyle ':completion:*:descriptions' format $'\e[33m == \e[1;46;33m %d \e[m\e[33m ==\e[m' 
#zstyle ':completion:*:messages' format $'\e[33m == \e[1;46;33m %d \e[m\e[0;33m ==\e[m'
#zstyle ':completion:*:warnings' format $'\e[33m == \e[1;47;31m No Matches Found \e[m\e[0;33m ==\e[m' 
#zstyle ':completion:*:corrections' format $'\e[33m == \e[1;47;31m %d (errors: %e) \e[m\e[0;33m ==\e[m'


#}}}

##行编辑高亮模式 {{{
# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta #选中区域 
               special:bold      #特殊字符
               isearch:underline)#搜索时使用的关键字
#}}}

# 空行按[tab] 出 "cd [tab]" 再按[tab] 开始遍历菜单 -[tab] 出 directory stack --[tab] 变为 +[tab] （负负得正）逆序 directory stack# {{{
user-complete(){
    case $BUFFER in
        "cd --" )                  # "cd --" 替换为 "cd +"
        BUFFER="cd +"
        zle end-of-line
        zle expand-or-complete
        ;;
        "cd +-" )                  # "cd +-" 替换为 "cd -"
        BUFFER="cd -"
        zle end-of-line
        zle expand-or-complete
        ;;
        "" )                       # 空行填入 "cd "
        BUFFER="cd "
        zle end-of-line
        zle expand-or-complete
        ;;
        * )
        zle expand-or-complete
        ;;
    esac
}
# }}}

#命令别名 {{{
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

alias ls='ls -F --color=auto'
# x 按行排列，X 按文件类型排序
#alias ls='ls -xXF --color=auto'
alias l='ls -1X'
alias ll='ls -lh --time-style=+%Y-%m-%d'
alias la='ls -A'
alias lx='ls -xX'

# 同时显示隐藏目录
#alias ld='ls -d *(-/DN)'
# From：linuxgem.is-programmer.com/2007/10/4/list-only-directories-and-count-them.5107.html
# 不显示隐藏目录
alias ld='ls -d */'
# 显示隐藏目录
alias lhd='ls -d .*/'
alias lla='ls -Alh'

alias df='df -Th'
alias du='du -h'
#show directories size
alias dud='du -s *(/)'

# 多级目录回溯
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."

alias tee='tee -a'
alias grep='grep --color=auto -i'
alias ee='emacsclient -t'

alias c='clear'
alias m='mutt'
alias t='tmux'
alias s='screen'

alias myhttpd='sudo /etc/rc.d/httpd'
alias mymysqld='sudo /etc/rc.d/mysqld'
alias mysshd='sudo /etc/rc.d/sshd'
alias myftpd='sudo /etc/rc.d/vsftpd'

# [ Sudo ]
#--------------------------------------------

alias Cp="sudo cp"
alias Mv="sudo mv"
alias Rm="sudo rm"
alias Vim="sudo vim"
alias exit="clear; exit"
alias halt="sudo halt"
alias reboot="sudo reboot"

# U 盘挂载
alias Uin="sudo mount -t vfat -o iocharset=utf8,uid=1000,gid=100 /dev/sdb1 /mnt/myusb/"
alias Uout="sudo umount /mnt/myusb/"
alias mym="sudo mount -o iocharset=utf8,uid=1000,gid=100 "
alias myu="sudo umount "



# Pacman
alias P="pacman"
alias Y="yaourt"

# 在 后面添加 空格，可以实现自动补全
alias spm='sudo pacman'
alias pac="sudo pacman -S "
alias pq='pacman -Q '
alias pi='pacman -Qi '
alias pl='pacman -Ql '
alias pm='sudo pacman -Rsun '
alias pu="sudo pacman -Su"
alias py="sudo pacman -Sy"

alias yao="sudo yaourt -S "
alias ys="yaourt -Ss "
# 若要实现 yaourt 查询软件包，可以取消注释 /etc/yaourtrc 
# AURUPGRADE=0
# AURSEARCH=0
# 使用额外的 --aur 指定查询 AUR 里面的软件包，其他类似 pacman
alias yq="yaourt -Q "
alias yu="sudo yaourt -Su"
alias yy="sudo yaourt -Sy"


# 使用 'pacsearch packagename' 查找pkg，只列出软件包的名称，版本号，没有描述信息
#alias pacsearch="pacman -Sl | cut -d' ' -f2 | grep "

# pacman 查找 输出彩色
#alias pacs="pacman -Ss "
alias pacs="pacsearch"
pacsearch() 
{
	echo -e "$(pacman -Ss $@ | sed \
	-e 's#core/.*#\\033[1;31m&\\033[0;37m#g' \
	-e 's#extra/.*#\\033[0;32m&\\033[0;37m#g' \
	-e 's#community/.*#\\033[1;35m&\\033[0;37m#g' \
	-e 's#^.*/.* [0-9].*#\\033[0;36m&\\033[0;37m#g' )"
}

# inode 最新的文件
alias -g nn="*(oc[1])"
# * 通配符，zsh里面在后面可以加括号修饰它，o 表示排序，c 排序方式为inode time，方括号限定了只显示一个
# 用inode change time而非file modification time 让解压缩出来的修改时间较旧的文件依然被NN所指向

#历史命令 top10
alias top10='print -l  ${(o)history%% *} | uniq -c | sort -nr | head -n 10'

alias info='info --vi-keys'
alias port='netstat -ntlp'      #opening ports
#alias tree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"

#[Esc][h] man 当前命令时，显示简短说明 
alias run-help >&/dev/null && unalias run-help
autoload run-help

#}}}

# 全局 命令别名# {{{
# -g 全局命令别名，放在命令的哪个地方都可以
alias -g A="|awk"
alias -g B='|sed -r "s:\x1B\[[0-9;]*[mK]::g"' # remove color, make things boring
alias -g C="|wc"
alias -g E="|sed"
alias -g G="|egrep"
alias -g H="|head -n $(($LINES-2))"
alias -g L="|less"
alias -g P="|column -t"
alias -g R="|tac"
alias -g S="|sort"
alias -g T="|tail -n $(($LINES-2))"
alias -g X="|xargs"
alias -g N="> /dev/null"
alias -g NF="./*(oc[1])" # last modified(inode time) file or directory
# }}}

# 文件关联# {{{

for i in jpg png gif; alias -s $i=feh
for i in avi rmvb wmv; alias -s $i=mplayer

#alias -s txt=$EDITOR
#alias -s gz=tar -xzvf
#alias -s bz2=tar -xjvf
#alias -s html=$BROWSER
#alias -s php=$BROWSER
#
#alias -s org=$BROWSER
#alias -s com=$BROWSER
#alias -s net=$BROWSER
#
#alias -s sxw=soffice
#alias -s doc=soffice
#alias -s java=$EDITOR
#alias -s PKGBUILD=$EDITOR

# }}}

#路径别名 {{{
#进入相应的路径时只要 cd ~xxx
#hash -d tx="/home/king/me/text/"
#hash -d usb="/mnt/myusb/"
hash -d pkg="/var/cache/pacman/pkg"
hash -d x="/home/king/me/text/"
hash -d u="/mnt/myusb/"
hash -d m="/home/download/m"

hash -d e="/etc"
hash -d c="/etc/conf.d"
hash -d r="/etc/rc.d"
hash -d X="/etc/X11"

#}}}

zle -N user-complete
bindkey "\t" user-complete

##在命令前插入 sudo {{{
# 输完命令，这个命令需要管理员权限， Ctrl+a s u d o (空格）[Ctrl+e] 按两下 ESC 键完成上面的过程 定义功能 
sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line                 #光标移动到行末
}
zle -N sudo-command-line
#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line
#}}}

#{{{自定义补全
#补全 ping
zstyle ':completion:*:ping:*' hosts 192.168.128.1{38,} www.g.cn \
       192.168.{1,0}.1{{7..9},}

#补全 ssh scp sftp 等
my_accounts=(
{r00t,root}@{192.168.1.1,192.168.0.1}
kardinal@linuxtoy.org
123@211.148.131.7
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
#}}}

# 自定义 函数 ##{{{
function calc { echo $(($@)) }
function timeconv { date -d @$1 +"%Y-%m-%d %T" }

#show 256 color tab
256tab() {
    for k in `seq 0 1`;do 
        for j in `seq $((16+k*18)) 36 $((196+k*18))`;do 
            for i in `seq $j $((j+17))`; do 
                printf "\e[01;$1;38;5;%sm%4s" $i $i;
            done;echo;
        done;
    done
}

fm()
{
    $mydir=`pwd`;
    `rox $mydir &`;
}


#alarm using atd
alarm() { 
    echo "msg ${argv[2,-1]} && aplay -q ~/.sounds/MACSound/System\ Notifi.wav" | at now + $1 min
}

#calculator
calc()  { awk "BEGIN{ print $* }" ; }

#check if a binary exists in path
bin-exist() {[[ -x `whence -cp $1 2>/dev/null` ]]}

#recalculate track db gain with mp3gain
(bin-exist mp3gain) && id3gain() { find $* -type f -iregex ".*\(mp3\|ogg\|wma\)" -exec mp3gain -r -s i {} \; }

#ccze for log viewing
(bin-exist ccze) && lless() { tac $* |ccze -A |less }

#man page to pdf
(bin-exist ps2pdf) && man2pdf() {  man -t ${1:?Specify man as arg} | ps2pdf -dCompatibility=1.3 - - > ${1}.pdf; }
# }}}

# 键盘定义及键绑定 {{{
#bindkey "\M-v" "\`xclip -o\`\M-\C-e\""
# 设置键盘 {{{
# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
autoload -U zkbd
bindkey -e #use emacs style keybindings :(
typeset -A key #define an array

#if zkbd definition exists, use defined keys instead
if [[ -f ~/.zkbd/${TERM}-${DISPLAY:-$VENDOR-$OSTYPE} ]]; then
    source ~/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
else
    key[Home]=${terminfo[khome]}
    key[End]=${terminfo[kend]}
    key[Insert]=${terminfo[kich1]}
    key[Delete]=${terminfo[kdch1]}
    key[Up]=${terminfo[kcuu1]}
    key[Down]=${terminfo[kcud1]}
    key[Left]=${terminfo[kcub1]}
    key[Right]=${terminfo[kcuf1]}
    key[PageUp]=${terminfo[kpp]}
    key[PageDown]=${terminfo[knp]}
    for k in ${(k)key} ; do
        # $terminfo[] entries are weird in ncurses application mode...
        [[ ${key[$k]} == $'\eO'* ]] && key[$k]=${key[$k]/O/[}
    done
fi

# setup key accordingly
[[ -n "${key[Home]}" ]] && bindkey "${key[Home]}" beginning-of-line
[[ -n "${key[End]}" ]] && bindkey "${key[End]}" end-of-line
[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Up]}" ]] && bindkey "${key[Up]}" up-line-or-history
[[ -n "${key[Down]}" ]] && bindkey "${key[Down]}" down-line-or-history
[[ -n "${key[Left]}" ]] && bindkey "${key[Left]}" backward-char
[[ -n "${key[Right]}" ]] && bindkey "${key[Right]}" forward-char

# }}}

# 键绑定 {{{
bindkey "" history-beginning-search-backward
bindkey "" history-beginning-search-forward
bindkey '[1;5D' backward-word # C-left
bindkey '[1;5C' forward-word # C-right

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ee' edit-command-line
# }}}

# }}}

# [ man color ]# {{{
#--------------------------------------------
export LESS_TERMCAP_mb=$'\E[01;31m'   # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'       # end mode
export LESS_TERMCAP_se=$'\E[0m'       # end standout-mode
export LESS_TERMCAP_so=$'\E[1;33;40m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'       # end underline
export LESS_TERMCAP_us=$'\E[1;32m'    # begin underline
# }}}












