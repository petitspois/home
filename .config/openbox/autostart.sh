# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

# Set a background color
BG=""
if which hsetroot >/dev/null; then
    BG=hsetroot
else
    if which esetroot >/dev/null; then
	BG=esetroot
    else
	if which xsetroot >/dev/null; then
	    BG=xsetroot
	fi
    fi
fi
test -z $BG || $BG -solid "#303030"

# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

# Make GTK apps look and behave how they were set up in the gnome config tools
if test -x /usr/libexec/gnome-settings-daemon >/dev/null; then
  /usr/libexec/gnome-settings-daemon &
elif which gnome-settings-daemon >/dev/null; then
  gnome-settings-daemon &
# Make GTK apps look and behave how they were set up in the XFCE config tools
elif which xfce-mcs-manager >/dev/null; then
  xfce-mcs-manager n &
fi

# Preload stuff for KDE apps
if which start_kdeinit >/dev/null; then
  LD_BIND_NOW=true start_kdeinit --new-startup +kcminit_startup &
fi

# Run XDG autostart things.  By default don't run anything desktop-specific
# See xdg-autostart --help more info
DESKTOP_ENV="OPENBOX"
if which /usr/lib/openbox/xdg-autostart >/dev/null; then
  /usr/lib/openbox/xdg-autostart $DESKTOP_ENV
fi

# 阴影效果对比明显，无窗口/菜单渐隐
#xcompmgr -l -5 -t -5 -r 5 -o 0.60 -c
#feh --bg-scale ~/pic/wall/glass.jpg
stalonetray &
#xmodmap ~/.xmodmaprc

# 含有窗口渐隐
#xcompmgr -c -t-5 -l-5 -r4.2 -o.52 -C -f -F &
#(sleep 40 && conky -c ~/conky/big_conky) &
#tint2 -c /root/.tint2/tint2rc &
#(sleep 8 && wbar -bpress -above-desk -vbar -isize 40.0 -idist 5.0 -zoomf 1.5 -pos top-left) &
#transset 0.8




