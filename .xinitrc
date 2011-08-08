#!/bin/sh

# [ App Evnvirenmet 程序依赖环境变量 ]# {{{
#--------------------------------------------

# urxvt Tabpage 标签页高亮提示完成任务
#export PROMPT_COMMAND="echo -ne '\a'"

# NetBeans java 程序 字体开启抗锯齿
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# [ dbus-launch ]#{{{
#--------------------------------------------

## https://wiki.archlinux.org/index.php/D-Bus
## 如果存在，载入 dbus-launch 初始化脚本
#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#    for f in /etc/X11/xinit/xinitrc.d/*; do
#        [ -x "$f" ] && . "$f"
#    done
#    unset f
#fi

# pcmanfm 使用 gvfs 挂载移动设备时需要用到
# 依赖：dbus-launch --> 软件包 dbus
dbuslaunch="`which dbus-launch 2>/dev/null`"
if [ -n "$dbuslaunch" ] && [ -x "$dbuslaunch" ] && [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval `$dbuslaunch --sh-syntax --exit-with-session`
fi

#}}}

# [ fcitx iput  ]# {{{
#-------------------------------------------
# From : /usr/share/fcitx/doc/fcitx3.pdf
#export XIM=fcitx
#export XIM_PROGRAM=/usr/bin/fcitx
#export XIM_ARGS=""
#export DEPENDS="fcitx"

export GTK_IM_MODULE=xim
export QT_IM_MODULE=xim
# locale en_US.UTF8 在英文环境
export XMODIFIERS="@im=fcitx"

killall fcitx
fcitx &

# }}}

# [ Scim input ]# {{{
#-------------------------------------------
#export XMODIFIERS=@im=SCIM
#export GTK_IM_MODULE="scim"
#export QT_IM_MODULE="scim"

#scim -d

# }}}



# }}}

# [ AutoRun  自动启动 ]# {{{
#--------------------------------------------
#urxvt &
#tilda &

# sleep 延时解决 fcitx 无法在自启动 xterm 激活问题 [?]
(sleep 2 && xterm) &

# awesome 启用透明功能，依赖
#xcompmgr &

# 阴影效果对比明显，无窗口/菜单渐隐
# XXX 会导致 musca 虚拟桌面不能及时刷新 [?]
#xcompmgr -l -5 -t -5 -r 5 -o 0.60 -c &

#(sleep 40 && conky -c ~/conky/big_conky) &

# wallpaper 壁纸
#feh --bg-scale ~/pic/wall/glass.jpg
xsetroot -solid "#a8a8a8"

# 关闭X下响铃
xset b off

# 加载 dmenu 使用 X11 核心字体路径
xset +fp /usr/share/fonts/myfont/pix.square

# 键盘 键位 置换
xmodmap ~/.xmodmap

#/usr/bin/urxvtd -q -o -f &

#mpd ~/.mpdconf

#wicd-client &
#lxsession &

# }}}

#DEFAULTSESSION=openbox-session
#DEFAULTSESSION=compiz
#DEFAULTSESSION=fvwm2
#DEFAULTSESSION=subtle
DEFAULTSESSION=musca

# [ Window Manager 窗口管理器 ]# {{{
#--------------------------------------------
#openbox-session

case $1 in
fvwm*)
	exec ck-launch-session dbus-launch fvwm2
	#exec fvwm2
	;;
openbox)
	exec ck-launch-session dbus-launch openbox-session
	#exec openbox-session
	;;
musca)
	#exec ck-launch-session dbus-launch musca
    # 在 slim 中加载 ck-launch-session 和 dbus-launch
    # 如果不使用 slim ,使用 .xinitrc 中无法加载 ck-launch-session
	exec musca
	;;
awesome)
	exec ck-launch-session dbus-launch awesome
	#exec awesome
	;;
i3)
	exec ck-launch-session dbus-launch i3
	#exec i3
	;;
subtle)
	exec ck-launch-session dbus-launch subtle
	#exec subtle
    #exec /usr/bin/subtle &> $HOME/.config/subtle/logs/subtle-$(date +"%F-%k-%M").log
	;;
compiz)
	#exec ck-launch-session dbus-launch $HOME/.compiz.sh
	exec $HOME/.compiz.sh
	#ck-launch-session dbus-launch  $HOME/.compiz.sh
	#sh /usr/local/bin/start-fusion.sh
    #compiz ccp &
    #thunar &
    #xterm
	;;
*)
	exec $DEFAULTSESSION
	;;
esac

# }}}


