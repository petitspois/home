# vim:set et ft=zsh fdm=marker sw=4 ts=4 nopaste softtabstop=4 :

# [ Refer ]# {{{
#--------------------------------------------

# Zsh 技巧三则
# From : http://linuxtoy.org/archives/zsh_per_dir_hist.html

# zsh里代表当前目录下最后修改的文件的alias
# From : http://roylez.heroku.com/2010/03/06/zsh-recent-file-alias.html

# roylez    # From : https://github.com/roylez/dotfiles/raw/master/.zshrc
# gogonkt   # From : https://github.com/gogonkt/dotG/blob/master/.zshrc

# [ man ]# {{{
#--------------------------------------------
# setopt <选项>     -->     man zshoptions
# autoload  <选项>  -->     man zshmisc

# 补全              -->     man zshcompctl / zshcompwid
# 交互 / 编辑       -->     man zshzle
# 函数

# zsh                Zsh overview (this section)
# zshroadmap         Informal introduction to the manual
# zshmisc            Anything not fitting into the other sections
# zshexpn            Zsh command and parameter expansion
# zshparam           Zsh parameters
# zshoptions         Zsh options
# zshbuiltins        Zsh built-in functions
# zshzle             Zsh command line editing
# zshcompwid         Zsh completion widgets
# zshcompsys         Zsh completion system
# zshcompctl         Zsh completion control
# zshmodules         Zsh loadable modules
# zshcalsys          Zsh built-in calendar functions
# zshtcpsys          Zsh built-in TCP functions
# zshzftpsys         Zsh built-in FTP client
# zshcontrib         Additional zsh functions and utilities
# XXX zshall             Meta-man page containing all of the above

# }}}

#   [ 提示符颜色 ASCII 编码 ]# {{{
#--------------------------------------------
#   Black   0;30
#   Red     0;31
#   Green   0;32
#   Brown   0;33
#   Blue    0;34
#   Purple  0;35
#   Cyan    0;36

# }}}

# }}}

# [ todo ]# {{{
#--------------------------------------------

# 历史记录，中文乱码，自定义，时间戳格式




# }}}

# [ ENV 环境变量 ] # {{{
#--------------------------------------------
# 前置原因:有可能需要提前设置PATH等环境变量

# 使 screen 支持 256 色
export TERM=xterm-256color

export PATH="${PATH}:${HOME}/code/shell:${HOME}/.todo"
export CDPATH='.:..:../..:~:~/text:~/public_html/:/home/download/'

# pinax 下载的 django 插件添加到 PYTHONPATH 中，其他程序也可以调用
export PYTHONPATH="$PYTHONPATH:${HOME}/code/pinax/lib/python2.7/site-packages"

export MYSQL_PS1="[\\u@\\h \\d]"

export SHELL=`which zsh`

# Emacs 中 fcitx 输入法激活
#export LC_CTYPE=zh_CN.UTF-8

# NetBeans java 程序 字体开启抗锯齿
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'


#RPROMPT=$(echo '%{\033[31m%}%D %T%{\033[m%}')
#PROMPT=$(echo '%{\033[34m%}%M%{\033[32m%}%/
#%{\033[36m%}%n %{\033[01;31m%}>%{\033[33m%}>%{\033[34m%}>%{\033[m%} ')


# }}}

# [ PS1 git prompt  ] # {{{
#--------------------------------------------
# From : gogonkt
# [master¹//~]%                 (ink@king:~/)
# http://kriener.org/articles/2009/06/04/zsh-prompt-magic

autoload -U promptinit
promptinit

setopt prompt_subst
autoload colors
colors

autoload -Uz vcs_info

# 颜色变量
# black   red     green   yellow  blue    magenta     cyan    white
for COLOR in RED GREEN YELLOW WHITE BLACK CYAN BLUE MAGENTA; do
    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BRIGHT_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

# 重置颜色
PR_RESET="%{${reset_color}%}";

# %b - branchname               分支名
# %u - unstagedstr              未跟踪
# %c - stangedstr               新添加 跟踪
# %a - action                   [e.g. rebase-i]
# %R - repository path          版本路径
# %S - path in the repository   在版本库中到路径

# XXX 版本库左右添加 空格
FMT_BRANCH="${PR_BRIGHT_RED}%b${PR_CYAN}%u${PR_WHITE}%c${PR_RESET}"    # e.g. master¹²
#FMT_ACTION="(${PR_CYAN}%a${PR_RESET}%)"              # e.g. (rebase-i)
FMT_ACTION="[${PR_CYAN}%a${PR_RESET}]"              # e.g. (rebase-i)
# 右边的 ：(ink@king:~/)
FMT_PATH="%R${PR_YELLOW}/%S"                         # e.g. ~/repo/subdir

# 关闭对 不常用的 版本控制系统的支持
# 使用 vcs_info_printsys 可以查看 支持/不支持 的版本控制系统
zstyle ':vcs_info:*' disable bzr cdv darcs fossil mtn p4 svk tla
zstyle ':vcs_info:*' enable cvs git hg svn

# :vcs_info:<vcs-string>:<user-context>:<repo-root-name>
# vcs-string 版本控制系统名称
# user-context 作为 vcs_info 可选的，自由的配置选项
# repo-root-name 是 zstyle 要匹配的 repository

# 时事检查更新，才能使 stagedstr / unstagedstr 生效，对于比较大到版本库，可能会影响速度
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr '°'  # display ° if there are unstaged changes
zstyle ':vcs_info:*:prompt:*' stagedstr   '"'  # display " if there are staged changes

# 当前版本库，触发特定操作 (交互式 rebase 变基 / 合并冲突)
# XXX 本地目录之间 空格 间隔
zstyle ':vcs_info:*:prompt:*' actionformats "${FMT_BRANCH}${FMT_ACTION}"  "${FMT_PATH}"
# 一般状态样式
zstyle ':vcs_info:*:prompt:*' formats       "${FMT_BRANCH}"               "${FMT_PATH}"

# 没有版本控制 或 禁用版本控制的目录 格式字符串
# 用于结束 prompt 提示中的 vcs_info 信息
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                             "%~"

# [?] zsh 函数定义格式
function precmd {
    vcs_info 'prompt'
}

function lprompt {
    local git='$vcs_info_msg_0_'
    # 相对目录，空格添加在此处
    #local cwd="${color3} %B%1~%b "
    local cwd=" %B%d%b "

    #PROMPT="${PR_RESET}${bracket_open}${git}${cwd}${bracket_close}○%# ${PR_RESET}"

    # XXX promt 中的换行符使用 $prompt_newline
    #PROMPT="${PR_RESET}${PR_BLUE}${cwd}$prompt_newline ${git}${PR_RED} · ${PR_RESET}"

    # 需要使用 $'\n' 来分隔/断开 prompt 的双引号
    PROMPT="${PR_RESET}${PR_BLUE}${cwd} "$'\n'" ${git}${PR_RED} · ${PR_RESET}"

}

# 调用 lprompt 函数，初始化 PS1
lprompt
#lprompt '[]' $BR_BRIGHT_BLACK $PR_GREEN
#lprompt '' $BR_BRIGHT_BLACK $PR_GREEN




# }}}

# [ screen / tmux 小标题 ] #  {{{
#--------------------------------------------

# [ case 判断 screen / xterm / tmux  ]# {{{
#--------------------------------------------
case $TERM in
    #xterm*|rxvt*)
    rxvt*)
        function title() { print -nP "\e]0;$1\a" } 
        ;;
    xterm-256color|screen*)
        # 如果是本地 shell 仅设置 screen 标题栏
        # only set screen title if it is in a local shell
        if [ -n $STY ] && (screen -ls |grep $STY &>/dev/null); then

            # 标题栏 定制函数
            function title() {
                # 动态 标题栏
                print -nP "\ek$1\e\\"
                # 修改窗口 标题栏
                # modify window title ba
                #print -nPR $'\033]0;'$2$'\a'
            }

        # 定制 tmux 标题栏 # actually in tmux !
        elif [ -n $TMUX ]; then
            function title() {  print -nP "\e]2;$1\a" }
        else
            function title() {}
        fi
        ;;
    *)
        function title() {}
        ;;
esac
# }}}

# [ Screen 动态改变 标题栏 扩展函数 ]# {{{
#--------------------------------------------

# 若，没有连接到远程服务器，动态改变 screen 标题
#if [ "$STY" != "" ]; then

screen_precmd()
# {{{
{

    # 底部 标题 使用 短路径
    #title "%10< ..<%c%<<"

    # 输出 bell 报警信号 , urgent notification trigger
    #echo -ne '\a'
    #title "`print -Pn "%~" |sed "s:\([~/][^/]*\)/.*/:\1...:"`" "$TERM $PWD"
    title "`print -Pn "%~" |sed "s:\([~/][^/]*\)/.*/:\1...:;s:\([^-]*-[^-]*\)-.*:\1:"`" "$TERM $PWD"
    echo -ne '\033[?17;0;127c'
}
# }}}

screen_preexec()
# {{{
{
    #title "%10>..>$1%<<"

    local -a cmd; cmd=(${(z)1})
    case $cmd[1]:t in
        'ssh')          title "@""`echo $cmd[2]|sed 's:.*@::'`" "$TERM $cmd";;
        'sudo')         title "#"$cmd[2]:t "$TERM $cmd[3,-1]";;
        'for')          title "()"$cmd[7] "$TERM $cmd";;
        'svn'|'git')    title "$cmd[1,2]" "$TERM $cmd";;
        'ls'|'ll')      ;;
        *)              title $cmd[1]:t "$TERM $cmd[2,-1]";;
    esac

}
# }}}

#{{{  自定义 screen 扩展函数 添加到 zsh 默认的 precmd preexec 函数队列

# 版本 zsh 4.3.11 (2011.4.4) 中没有 add-zsh-hook 函数
# roylez's zshrc 配置文件，中有相关函数定义
typeset -ga preexec_functions precmd_functions
precmd_functions+=screen_precmd
preexec_functions+=screen_preexec

#}}}

# }}}



# }}}

# [ Base 基本 ] # {{{
#--------------------------------------------

# 默认配置文件 格式 ：
#setopt appendhistory autocd extendedglob nomatch notify

# 关闭 报错 响铃
setopt NO_BEEP

# 关闭 C-q/C-k 锁定 终端快捷键 [screen] [?] 无效
unsetopt flowcontrol

# pushds 和 popds 操作后，不打印输出 dir stack
setopt pushd_silent
setopt pushd_ignore_dups        # do not push dups on stack

# 允许在交互模式中使用注释 如： cmd #这是注释
setopt INTERACTIVE_COMMENTS

# 在 提示符函数中有调用
#setopt prompt_subst             # prompt more dynamic, allow function in prompt

# [ 进程 ? ]
#--------------------------------------------
# 自动向 暂停工作 disowned jobs 发送 CONT 继续重新工作信号
setopt auto_continue

# 使用默认的 long 格式，显示 后台 运行的 作业 jobs
setopt long_list_jobs

# 创建文件时，将 ^ * # 字符视作 文件命名的合法字符 [?] 无效
setopt extended_glob

# [ XXX ] #--------------------------------------------

# 展开 达括号中到表达式 [?]
setopt brace_ccl


# shell 不会按照远程地址上的文件去扩展参数，# scp ip:/home/tommy/*
# 本地当前目录中，不存在 ip:/home/tommy/*，匹配失败
# 默认情况下，bash 在匹配失败时就使用原来的内容，zsh 则报告一个错误
# zsh 中执行 setopt nonomatch 则告诉它不要报告 no matches 的错误，而是当匹配失败时直接使用原来的内容
# XXX 实际上，不管是 bash 还是 zsh，不管设置了什么选项，只要把 "ip:/home/tommy/*" 加上引号，可解决问题
setopt nonomatch

# 在改变路径是，若包含 链接目录，要如何处理 [?]
# ~/ln -> /; cd ln; pwd -> /
#setopt chase_links

# 扩展路径
#/v/c/p/p => /var/cache/pacman/pkg
#setopt complete_in_word



# }}}

# [ completion 补全 ]# {{{
#--------------------------------------------

# [ 补全 选项 ]# {{{
#--------------------------------------------

# man zshoptions 查看选项到详细说明
setopt AUTO_LIST AUTO_MENU
#开启此选项，补全时会直接选中菜单项
#setopt MENU_COMPLETE

#启用 cd 命令的历史纪录，cd -[TAB]进入历史路径
setopt AUTO_PUSHD

# 补全命令，包括 .ssh/known_hosts 里面到主机
autoload -U compinit
#autoload -Uz compinit # [?]
compinit

# 启用自动 cd，输入目录名回车进入目录
# 稍微有点混乱，不如 cd 补全实用
#setopt AUTO_CD

# 在命令补全过程中，不展开 alias 别名
setopt complete_aliases

# 拼写检查 仅对命令纠错
setopt CORRECT
# 对命令中的所有参数纠错
#setopt CORRECT_ALL

# 在开始补全时，会将可能路径提前 hash，可能会使 补全变慢
#setopt hash_list_all

# 补全文件类型提示 ，类似 ls -F 的文件类型标志符
setopt list_types

# 补全 数字开头到文件时，按照数字排序，而非字典排序
setopt numeric_glob_sort





# }}}

# [ 补全 类型  ] #{{{
#--------------------------------------------
# 格式定义 man zshcompsys 中的 completer 字段
# zstyle ':completion:*' completer _complete _complete:-foo
# zsytle ':completion:*:completer:context or command:argument:tag'

# Archwiki 补全菜单可以使用方向键导航
zstyle ':completion:*' menu select
# 只有一个候选结果时，也显示补全候选菜单，默认：大于 2 个候选菜单才显示
zstyle ':completion:*:*:default' force-list always

# 使用 cache 加速 pacman 补全 # man zshcompsys
zstyle ':completion::complete:*' use-cache on
#zstyle ':completion::complete:*' cache-path .zcache
# cd 不选择 父 目录
zstyle ':completion:*' ignore-parents parent pwd directory

# 路径补全，扩展函数，包含 prefix / suffix
zstyle ':completion:*' expand 'yes'
# 若 路径中包含 多个 // 斜扛，当作一个处理：/foo//who ==> /foo/who
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

# 错误校正
#zstyle ':completion:*' completer _complete _match _approximate
#zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _match #_user_expand
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

zstyle ':completion:*:match:*' original only
# 容错字数 可以修改
zstyle ':completion:*:approximate:*' max-errors 1 numeric
# 递增 补全
zstyle ':completion:incremental:*' completer _complete _correct

# [ XXX ] #--------------------------------------------

# 前缀 补全选项 [?] man 中没找到 prefix-1 格式
zstyle ':completion::prefix-1:*' completer _complete
# 推测 / 预告 补全 [?] man 中没找到
zstyle ':completion:predict:*' completer _complete

# [ XXX ] #--------------------------------------------

#修正大小写
# 大写 <==> 小写
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
# 大小写 <==> 大小写
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# kill 命令补全
# From http://wandsea.com/doc/opensource_guide/ch14s09.html
compdef pkill=kill
compdef pkill=killall
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
# 没什么效果 [?]
#zstyle ':completion:*:*:killall:*' menu yes select
#zstyle ':completion:*:killall:*'   force-list always
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'


#}}}

# [ 补全菜单 样式 ]# {{{
#--------------------------------------------

# 给补全菜单添加颜色
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# 补全提示 标题描述 group matches and descriptions
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

# 补全 标题 样式
#zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
#zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
#zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'

#zstyle ':completion:*:descriptions' format $'\e[33m == \e[1;7;36m %d \e[m\e[33m ==\e[m' 
#zstyle ':completion:*:messages' format $'\e[33m == \e[1;7;36m %d \e[m\e[0;33m ==\e[m'
#zstyle ':completion:*:warnings' format $'\e[33m == \e[1;7;31m No Matches Found \e[m\e[0;33m ==\e[m' 
#zstyle ':completion:*:corrections' format $'\e[33m == \e[1;7;37m %d (errors: %e) \e[m\e[0;33m ==\e[m'

#   [ 提示符颜色 ASCII 编码 ]# {{{
#--------------------------------------------
#   Black   0;30
#   Red     0;31
#   Green   0;32
#   Brown   0;33
#   Blue    0;34
#   Purple  0;35
#   Cyan    0;36
# }}}

zstyle ':completion:*:descriptions' format $'\e[33m | \e[1;7;32m %d \e[m\e[33m |\e[m' 
zstyle ':completion:*:messages' format $'\e[33m | \e[1;7;32m %d \e[m\e[0;33m |\e[m'
zstyle ':completion:*:warnings' format $'\e[33m | \e[1;7;33m No Matches \e[m\e[0;33m |\e[m'
zstyle ':completion:*:corrections' format $'\e[33m | \e[1;7;35m %d [errors: %e] \e[m\e[0;33m |\e[m'

#zstyle ':completion:*:descriptions' format $'\e[33m == \e[1;46;33m %d \e[m\e[33m ==\e[m' 
#zstyle ':completion:*:messages' format $'\e[33m == \e[1;46;33m %d \e[m\e[0;33m ==\e[m'
#zstyle ':completion:*:warnings' format $'\e[33m == \e[1;47;31m No Matches Found \e[m\e[0;33m ==\e[m' 
#zstyle ':completion:*:corrections' format $'\e[33m == \e[1;47;31m %d (errors: %e) \e[m\e[0;33m ==\e[m'



# }}}

# [ 自定义补全 ] #{{{
#--------------------------------------------

# ping
zstyle ':completion:*:ping:*' hosts www.zstu.edu.cn www.google.com \
192.168.128.1{38,} 192.168.{1,0}.1{{7..9},} 10.10.62.{1,{5{2..8},}}

# ssh scp sftp 等
my_accounts=(
57wsqh@216.194.70.6
lvii@fedora.unix-center.net
{r00t,root}@{192.168.1.1,192.168.0.1}
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts



#}}}






# }}}

# [ history 历史记录 ] # {{{
#--------------------------------------------
# 历史记录 修饰符 man zshexpn

#历史纪录条目数量
export HISTSIZE=2000
#注销后保存的历史纪录条目数量
export SAVEHIST=2000
#历史纪录文件
export HISTFILE=~/.zhistory

# 为历史纪录中的命令添加 时间戳 格式 [?]：
# : 1301840847:0;history 20 # EXTENDED_HISTORY

# 去除重复（相邻两次输入） [?]，若历史中已有，不再写入
#setopt HIST_IGNORE_DUPS

# file text/soft/zsh.txt # vim !$ 时，不立即执行，而是输出
# vim text/soft/zsh.txt 用户确认后在执行
setopt hist_verify              # 使用 历史命令时 重载 完整的 命令
setopt no_hist_beep             # 获取 / 写入 [?] 历史记录错误，不发出 beep 报警
setopt hist_ignore_all_dups     # 去除重复，新纪录覆盖旧的历史记录
setopt hist_reduce_blanks       # 删除历史文件 里面的空白
setopt hist_ignore_space        # 不纪录以空格开始的命令
setopt share_history            # 多 session 共享历史
setopt hist_verify              # reload full command when runing from history
setopt hist_expire_dups_first   # 删除 超出 最大上限 数量的 记录
setopt hist_find_no_dups        # 使用 history 命令显示时，不显示重复历史记录
setopt inc_append_history       # 立即附加，递增立即写入方式 历史纪录，而 APPEND_HISTORY 则是在 shell 退出之后写入

#}}}

# [ zle bindkey ]# {{{
#--------------------------------------------

# man zle = zsh command editor Emacs 风格
bindkey -e

# 设置 [DEL]键 为向后删除
#  1 前面的顿号，<1> xev 查看 ` 的 keycode，<2>在 xmodmap -pke 中查找对应的名称
bindkey "\e[3~" delete-char

#bindkey "\M-v" "\`xclip -o\`\M-\C-e\""

# c-z 后，再按一次，将进程调到前台 [?]
bindkey -s "" "fg\n"


# Archwiki 只在当前会话中进行，历史记录查找
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Ctrl 左/右 ==> Alt - B / F 单词移动
bindkey '[1;5D' backward-word # C-left
bindkey '[1;5C' forward-word  # C-right

# Archwiki [?]
[[ -n "${key[Home]}" ]]     && bindkey "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}" ]]      && bindkey "${key[End]}"    end-of-line

[[ -n "${key[Insert]}" ]]   && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]]   && bindkey "${key[Delete]}" delete-char

[[ -n "${key[Up]}" ]]       && bindkey "${key[Up]}"     up-line-or-history
[[ -n "${key[Down]}" ]]     && bindkey "${key[Down]}"   down-line-or-history

[[ -n "${key[Left]}" ]]     && bindkey "${key[Left]}"   backward-char
[[ -n "${key[Right]}" ]]    && bindkey "${key[Right]}"  forward-char

# Ctrl N/P 历史记录 翻页，默认支持 [?]
#bindkey "" history-beginning-search-backward
#bindkey "" history-beginning-search-forward




# [ PS1 之后，命令行输入样式 ] # {{{
#--------------------------------------------
# man zshzle

# Ctrl+@ 设置标记，标记和光标点之间为 region
zle_highlight=(region:bg=magenta  #选中区域
               special:bold       #特殊字符
               isearch:underline) #搜索时使用的关键字

zle_highlight+=( default:fg=green,bold )

#}}}

# }}}

# [ alias 别名 ]# {{{
#--------------------------------------------

# [ 读取 .alias 中的命令别名  ]
#--------------------------------------------
if [ -f $HOME/.alias ]; then
    source $HOME/.alias
fi

# [ global 命令别名 ] # {{{
#--------------------------------------------
# -g 全局命令别名，放在命令的哪个位置都行
# cat test.txt L ==> cat test.txt|less

alias -g A="|awk"
# remove color, make things boring
alias -g B='|sed -r "s:\x1B\[[0-9;]*[mK]::g"'
alias -g C="|wc"
alias -g E="|sed"
alias -g G="|egrep"
alias -g H="|head -n $(($LINES-2))"
# less -R 可以解析 ls / grep 等颜色转义字符
alias -g L="|less -R"
alias -g P="|column -t"
alias -g R="|tac"
alias -g S="|sort"
alias -g T="|tail -n $(($LINES-2))"
alias -g X="|xargs"
#alias -g N="> /dev/null"
alias -g N='&> /dev/null &'
# last modified(inode time) file or directory
#alias -g NF="./*(oc[1])"

# NN 指向 inode 最新的那个文件，下载完7z x NN 解压缩，解压缩 cd NN 进入解压缩后的目录，方便!
alias -g NN="*(oc[1])"
# zsh 通配符 * 后可加括号修饰，o 表示排序，c 排序方式 inode time，方括号限定一个显示
# 用inode time 而非 file modified time NN 仍能指向 解压缩出来 修改时间较旧的文件


# }}}

# [ 文件关联 ] # {{{
#--------------------------------------------
# 查看 *.png 文件，只要输入该文件名（Tab 补完）回车，Zsh 会自动调用关联打开
# From : http://linuxtoy.org/archives/zsh-tip.html

# 依赖选项，默认就开启
#autoload -U zsh-mime-setup
#zsh-mime-setup
# alias 形式来实现文件关联 , 其中 png 为文件扩展名，= 右边的 feh 为关联的程序。-s 必不可少

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

# [ 路径别名  ] #{{{
#--------------------------------------------
# 使用 cd ~XXX 快速进入自定义目录

hash -d a="${HOME}/.config/awesome/"
hash -d b="${HOME}/book/"
hash -d x="${HOME}/text/"
hash -d c="${HOME}/code/"
hash -d d="${HOME}/code/django/"
hash -d m="/home/download/m"
hash -d o="/var/log/"
hash -d p="${HOME}/pic/"
hash -d u="/mnt/usb/"
hash -d pkg="/var/cache/pacman/pkg"

# [?] 进入到相应目录，提示符会显示 ~e
#hash -d e="/etc"
#hash -d c="/etc/conf.d"
#hash -d r="/etc/rc.d"
#hash -d X="/etc/X11"

#}}}





# }}}

# [ 自定义 函数 ] #{{{
#--------------------------------------------

# 本机 IP 地址
function lip { ifconfig|sed -n '2p' }
# 查询公网 IP，需要安装 curl 工具
function pubip() 
{ curl -s 'http://checkip.dyndns.org' | sed 's/.*Current IP Address: \([0-9\.]*\).*/\1/g'; }

# 查询执行 pacman -S 安装命令
function pkg()
{ sed -n '/pacman -S /p' /var/log/pacman.log|awk -F "'" '{print $2}'|uniq }

# 用 rox 打开当前目录
function fm()
{ $mydir=`pwd`; `rox $mydir &`; }

# 使用 atd 播放提示音，要用到 alsa 声音驱动
alarm()
{ echo "msg ${argv[2,-1]} && aplay -q ~/.sounds/MACSound/System\ Notifi.wav" | at now + $1 min }

nms() { find . -name $* }

# [ 打印 256 颜色 ]# {{{
#--------------------------------------------
function 256tab() {
    for k in `seq 0 1`;do 
        for j in `seq $((16+k*18)) 36 $((196+k*18))`;do 
            for i in `seq $j $((j+17))`; do 
                printf "\e[01;$1;38;5;%sm%4s" $i $i;
            done;echo;
        done;
    done
}

# }}}

# [ 目录 堆栈 ]# {{{
#--------------------------------------------
# 空行按[tab] 自动输出 cd 提示
# cd    [tab] 再按 [tab] 开始遍历当前目录
# cd -  [tab] 打开 directory stack 菜单
# cd -- [tab] 变为 +[tab] （负负得正）逆序 directory stack
user-complete(){
    case $BUFFER in
        # "cd --" 替换为 "cd +"
        "cd --" )
        BUFFER="cd +"
        zle end-of-line
        zle expand-or-complete
        ;;
        # "cd +-" 替换为 "cd -"
        "cd +-" )
        BUFFER="cd -"
        zle end-of-line
        zle expand-or-complete
        ;;
        # 空行自动输入 "cd "
        "" )
        BUFFER="cd "
        zle end-of-line
        zle expand-or-complete
        ;;
        * )
        zle expand-or-complete
        ;;
    esac
}
# 调用 user-complete 函数
zle -N user-complete
# 绑定到 快捷键 tab
bindkey "\t" user-complete

# }}}

# [ 在命令前插入 sudo  ] #{{{
#--------------------------------------------
# 输完命令，命令若要 root 权限，一般采用：[Ctrl+a] sudo (空格）[Ctrl+e]
# 按两下 ESC 键，在命令开头补全 sudo

sudo-command-line()
{
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    #光标移动到行末
    zle end-of-line
}
zle -N sudo-command-line
#定义快捷键为： [Esc] [Esc]
bindkey "\e\e" sudo-command-line

#}}}

# [ 高端应用 ]# {{{
#--------------------------------------------

# whence 类似 which 但当没有查询到结果时，不提示错误
bin-exist() {[[ -x `whence -cp $1 2>/dev/null` ]]}

#recalculate track db gain with mp3gain
(bin-exist mp3gain) && id3gain() { find $* -type f -iregex ".*\(mp3\|ogg\|wma\)" -exec mp3gain -r -s i {} \; }

#ccze for log viewing
# tac 是 cat 反义词，倒序输出文件
(bin-exist ccze) && lless() { tac $* |ccze -A |less }

#man page to pdf
(bin-exist ps2pdf) && man2pdf() {  man -t ${1:?Specify man as arg} | ps2pdf -dCompatibility=1.3 - - > ${1}.pdf; }

# }}}

# [ 借鉴 ]# {{{
#--------------------------------------------

# https://github.com/Barrucadu/home/blob/master/config/zsh/functions

# System
function start()
{
    for arg in "${*[@]}"; do
        sudo /etc/rc.d/$arg start
    done
}

function stop()
{
    for arg in "${*[@]}"; do
        sudo /etc/rc.d/$arg stop
    done
}

function restart()
{
    for arg in "${*[@]}"; do
sudo /etc/rc.d/$arg restart
    done
}

function reprobe()
{
    for arg in "${*[@]}"; do
sudo modprobe -r $arg
        sudo modprobe $arg
    done
}

function maintain()
{
    # Update
    sudo pacman -Syu
    sudo abs

    # Clean
    sudo pacman -Rsc $(pacman -Qtdq)
    sudo localepurge
    sudo pacman -Scc

    # Generale maintenence
    sudo pacman-optimize
    sudo mandb
    sudo ldconfig -v
    sudo updatedb
    sudo sync
}

function shutdownhost()
{
    if ping -c1 $1 &>/dev/null; then
        ssh $1 "sudo shutdown -hP now"
    fi
}

# Running programs
function r()
{
    $* &>/dev/null &
    disown %%
}

function re()
{
    $* &>/dev/null &
    disown %%
    exit
}


# Misc
function extract ()
{
    case $1 in
        *.tar.xz)
            tar xvJf $1;;
        *.tar.bz2)
            tar xvjf $1;;
        *.tar.gz)
            tar xvzf $1;;
        *.xz)
            unxz $1;;
        *.bz2)
            bunzip2 $1;;
        *.gz)
            gunzip $1;;
        *.tar)
            tar xvf $1;;
        *.tbz2)
            tar xvjf $1;;
        *.tgz)
            tar xvzf $1;;
        *.Z)
            uncompress $1;;
        *.zip)
            unzip $1;;
        *)
            echo "don't know how to extract '$1'...";;
    esac
}

function sign ()
{
    KEY=$1;
    KEYSERVER='keyserver.ubuntu.com';
    
    [[ "$2" != "" ]] && KEYSERVER=$2
    
    gpg --keyserver $KEYSERVER --recv-keys $KEY
    gpg --yes --ask-cert-level --sign-key $KEY
    gpg --keyserver $KEYSERVER --send-keys $KEY
}

# }}}



# }}}

# [ man keychain ]# {{{
#--------------------------------------------

[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
[ -f $HOME/.keychain/$HOSTNAME-sh ] &&
       . $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] &&
       . $HOME/.keychain/$HOSTNAME-sh-gpg

function keys()
{ source ~/.keychain/`hostname`-sh; }

# }}}

# [ man color ] # {{{ 
#--------------------------------------------


export LESS_TERMCAP_mb=$'\E[01;31m'   # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m'   # begin bold
export LESS_TERMCAP_me=$'\E[0m'       # end mode
export LESS_TERMCAP_se=$'\E[0m'       # end standout-mode
export LESS_TERMCAP_so=$'\E[1;33;40m' # begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'       # end underline
export LESS_TERMCAP_us=$'\E[1;32m'    # begin underline

# color theme 和当前 xdefaults 的 color 主题有些冲突
#export LESS_TERMCAP_mb=$'\E[01;31m'
#export LESS_TERMCAP_md=$'\E[01;31m'
#export LESS_TERMCAP_me=$'\E[0m'
#export LESS_TERMCAP_se=$'\E[0m'
#export LESS_TERMCAP_so=$'\E[01;40;34m'
#export LESS_TERMCAP_so=$'\E[01;44;34m'
#export LESS_TERMCAP_ue=$'\E[0m'
#export LESS_TERMCAP_us=$'\E[01;32m'

# }}}

# [ XXX ] #--------------------------------------------

# [ 杂项  ] #{{{
#--------------------------------------------

# 禁用 core dumps，man zshbuiltins
limit coredumpsize 0

# report to me when people login/logout
watch=(notme)
# replace the default beep with a message
#ZBEEP="\e[?5h\e[?5l"        # visual beep

## 除了字母和数字之外还有哪些符号是一个单词可以包含的
## 默认值: ?*_-.[]~=/&;!#$%^(){}<>
## 去掉 / 在使用 C-w 删除单词时，可以逐一删除路径，而不是一次整个删除路径
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'


#[Esc][h] man 当前命令时，显示简短说明
alias run-help >&/dev/null && unalias run-help
autoload run-help

# force rehash 当没找到命令时，强制 rehash
# http://zshwiki.org/home/examples/compsys/general
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1    # Because we did not really complete anything
}
#一启动 zsh 的时候顺带自动开启 screen 呢
#在~/.zshrc中加入 echo "$TERM"| grep -vq "screen" && \ exec screen zsh




#}}}

# [  ]# {{{
#--------------------------------------------





# }}}

# https://github.com/milomouse/dotfiles/blob/master/zsh/functions

# check ownership of given argument, as determined by pacman:
function owns {
  if [[ -n $(for each in ${PATH//:\\\n}; do
             find ${each}/$1 2>/dev/null ; done) ]]
  then pacman -Qo $(which -p $1)
  else pacman -Qo $1 ; fi
}

# jump to previous directory by integer or reg-exp, also list dirs,
# else jump to last visited directory if no argument supplied:
function back {
  if [[ $# == 1 ]]; then
    case $1 {
      <->) pushd -q +$1 2>/dev/null ;;
      --) dirs -lpv|sed '2s|$| \[last\]|' ;;
      *) [[ -n $(dirs -lpv|grep -i $1|grep -v ${PWD}) ]] && \
              pushd -q +${$(dirs -lpv|grep -i $1|grep -v ${PWD})[1]}
    }
  else pushd -q - 2>/dev/null ; fi
}

# go up Nth amount of directories:
function up {
  local arg=${1:-1};
  while [ ${arg} -gt 0 ]; do
    cd .. >&/dev/null;
    arg=$((${arg} - 1));
  done
}

# show ps information with simple output for scripts, quick views, etc:
function psi {
  if [[ ${#${@:/$0}} -ge 2 ]]; then
    case $1 {
      '-C'|'-c') ps -C $2 hopid,args ;; # by- command name
      '-G'|'-g') ps -G $2 hopid,args ;; # by- real group id (RGID)/name
      '-U'|'-u') ps -U $2 hopid,args ;; # by- effective user ID (EUID)/name
      '-P'|'-p') ps -p $2 hoargs ;; # by- pid
      '-S'|'-s') ps -s $2 hopid,args ;; # by- session id
      '-T'|'-t') ps -t $2 hopid,args ;; # by- tty
      *) print "invalid selection. read: man ps (section: process selection by list)"
    }
  else
        << EOP
(show process information by .. )
psi -c ARG | command name
psi -g ARG | group id
psi -u ARG | user id
psi -p ARG | pid
psi -s ARG | session id
psi -t ARG | tty
EOP
  fi
}

# one-liners/micro functions:
#function flashproc { for f (${$(file /proc/$(pidof luakit)/fd/*|gawk '/\/tmp\/Flash/ {print $1}')//:}){print - "$f"} }
function lss { ls -- ${1:-.}/*(D.om) }
#function rc { [[ -n $1 ]] && sudo /etc/rc.d/$1 ${@:/$1} }
#function alv { <${${$(command find ${H:-/howl}/othe/archive/installed_*)}[${1:--1}]}|w3m -o pagerline=1000 -o confirm_qq=0 }
function mkcd { command mkdir -p "$@" && cd "$@" }
#function pubip { curl -m 30 http://automation.whatismyip.com/n09230945.asp }
#function newmail { print - ${(Fw)#$(find /howl/mail/*/*/new -type f)} }
#function qdep { pacman-color -Q $@ $(pacman-color -Qi $@|grep Depends|cut -d: -f2-|sed -E 's|>\S+\>||g') }
#function timec { print "$(date +'%T %Y-%m-%d')" ; while sleep 1 ; do printf '\r%s ' "$(date +'%T %Y-%m-%d')" ; done }
#function dropcache { sync && command su -s /bin/zsh -c 'echo 1 > /proc/sys/vm/drop_caches && echo 2 > /proc/sys/vm/drop_caches' root }































