#!/bin/sh

# [ App Evnvirenmet 程序依赖环境变量 ]# {{{
#--------------------------------------------

# urxvt Tabpage 标签页高亮提示完成任务
#export PROMPT_COMMAND="echo -ne '\a'"

# NetBeans java 程序 字体开启抗锯齿
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# pcmanfm2 使用 gvfs 挂载设备
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
	eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

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
#xterm &

# awesome 启用透明功能，依赖
#xcompmgr &

# 阴影效果对比明显，无窗口/菜单渐隐
# XXX 会导致 musca 虚拟桌面不能及时刷新 [?]
#xcompmgr -l -5 -t -5 -r 5 -o 0.60 -c &

# wallpaper 壁纸
feh --bg-scale ~/pic/wall/glass.jpg

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
#	exec fvwm2
	#exec ck-launch-session fvwm2
    # 使 pcmanfm2 使用 udisks 自动挂载
	exec ck-launch-session dbus-launch fvwm2
	;;
musca)
	exec ck-launch-session dbus-launch musca
#	exec musca
	;;	  
i3)
	exec i3
	;;	  
subtle)
	exec subtle
#    exec /usr/bin/subtle &> $HOME/.config/subtle/logs/subtle-$(date +"%F-%k-%M").log
	;;	  
compiz)
	sh /usr/local/bin/start-fusion.sh
	;;	  
openbox)
	exec openbox-session
	;;	  
awesome)
	exec ck-launch-session dbus-launch awesome
#	exec awesome
	;;	  
*)
	exec $DEFAULTSESSION
	;;	  
esac

# }}}


