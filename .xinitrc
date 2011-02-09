#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# urxvt Tabpage 标签页高亮提示完成任务
#export PROMPT_COMMAND="echo -ne '\a'"

# NetBeans java 程序 字体开启抗锯齿
#export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'

# [ fcitx iput  ]
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

# [ Scim input ]
#-------------------------------------------

#export XMODIFIERS=@im=SCIM
#export GTK_IM_MODULE="scim"
#export QT_IM_MODULE="scim"

#scim -d


############################################


# awesome 启用透明功能，依赖
xcompmgr &
#urxvt &
#tilda &
#xterm &

# 关闭X下响铃
xset b off

# pcmanfm2 使用 gvfs 挂载设备
#if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
#	eval "$(dbus-launch --sh-syntax --exit-with-session)"
#fi

############################################

#DEFAULTSESSION=openbox-session
#DEFAULTSESSION=compiz
DEFAULTSESSION=awesome

case $1 in
fvwm*)
#	exec fvwm2
	#exec ck-launch-session fvwm2
    # 使 pcmanfm2 使用 udisks 自动挂载
	exec dbus-launch ck-launch-session fvwm2
	;;
musca)
	exec dbus-launch ck-launch-session musca
#	exec musca
	;;	  
i3)
#	exec i3
	;;	  
compiz)
	sh /usr/local/bin/start-fusion.sh
	;;	  
openbox)
	exec openbox-session
	;;	  
awesome)
	exec awesome
	;;	  
*)
	exec $DEFAULTSESSION
	;;	  
esac




############################################


# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice


