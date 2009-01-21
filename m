From: "Charles" <CharlesA@auroville.org.in>
Date: Wed, 21 Jan 2009 06:30:31 +0000
Subject: [lm-sensors] fancontrol init script for ubuntu +
Message-Id: <000101c97b90$15a03de0$3001a8c0@cw8xp>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_0002_01C97BBE.2F5879E0"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0002_01C97BBE.2F5879E0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello lmsensors mailing list  :-)
 
Here's a standards-compliant init script for fancontrol, developed and
tested using fancontrol 0.66 on ubuntu 8.04.1. It may work on other ubuntus,
debian and other debian-based systems using lsb-base (>= 3.0-6).

Part of the standards-compliance is that the script issues no messages at
boot or shutdown if /etc/default/rcS has VERBOSE=no (the default value).

Best
 
Charles

------=_NextPart_000_0002_01C97BBE.2F5879E0
Content-Type: application/octet-stream;
	name="fancontrol"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fancontrol"

#! /bin/sh=0A=
=0A=
# fancontrol startup script=0A=
=0A=
# fancontrol is part of the lm-sensors package=0A=
=0A=
# Developed and tested using fancontrol 0.66 on ubuntu 8.04.1; may work=0A=
# on other ubuntus, debian and other debian-based systems using =0A=
# lsb-base (>=3D 3.0-6)=0A=
=0A=
# INIT INFO for insserv and YaST=0A=
### BEGIN INIT INFO=0A=
# Provides:          fancontrol=0A=
# Required-Start:    $local_fs=0A=
# Required-Stop:=0A=
# Default-Start:     2 3 4 5=0A=
# Default-Stop:      S 0 1 6=0A=
# Short-Description: fancontrol=0A=
# Description:       fan control=0A=
### END INIT INFO=0A=
=0A=
# Change History=0A=
#   20jan09 Charles=0A=
#       * Creation on ubuntu 8.04.1 with lm-sensors 1:3.0.0-4ubuntu2, =0A=
#         using skeleton 1.8 as a pro-forma with minimal functional =
change=0A=
=0A=
# PATH is not set because no reason to change what init provides=0A=
DESC=3D"fan controller"=0A=
NAME=3Dfancontrol=0A=
DAEMON=3D/usr/sbin/$NAME=0A=
DAEMON_ARGS=3D=0A=
PIDFILE=3D/var/run/$NAME.pid=0A=
SCRIPTNAME=3D/etc/init.d/$NAME=0A=
=0A=
# Exit if the package is not installed=0A=
[ -x "$DAEMON" ] || exit 0=0A=
=0A=
# Read configuration variable file if it is present=0A=
[ -r /etc/default/$NAME ] && . /etc/default/$NAME=0A=
=0A=
# Load the VERBOSE setting and other rcS variables=0A=
[ -f /etc/default/rcS ] && . /etc/default/rcS=0A=
=0A=
# Define LSB log_* functions.=0A=
# Depend on lsb-base (>=3D 3.0-6) to ensure that this file is present.=0A=
. /lib/lsb/init-functions=0A=
=0A=
#=0A=
# Function that starts the daemon/service=0A=
#=0A=
# fancontrol does not background itself so start-stop-daemon's -b option =
used=0A=
do_start()=0A=
{=0A=
	# Return=0A=
	#   0 if daemon has been started=0A=
	#   1 if daemon was already running=0A=
	#   2 if daemon could not be started=0A=
	start-stop-daemon -b --start --quiet --pidfile $PIDFILE --exec $DAEMON =
--test > /dev/null \=0A=
		|| return 1=0A=
	start-stop-daemon -b --start --quiet --pidfile $PIDFILE --exec $DAEMON =
-- \=0A=
		$DAEMON_ARGS \=0A=
		|| return 2=0A=
}=0A=
=0A=
#=0A=
# Function that stops the daemon/service=0A=
#=0A=
do_stop()=0A=
{=0A=
	# Return=0A=
	#   0 if daemon has been stopped=0A=
	#   1 if daemon was already stopped=0A=
	#   2 if daemon could not be stopped=0A=
	#   other if a failure occurred=0A=
	start-stop-daemon --stop --quiet --retry=3DTERM/30/KILL/5 --pidfile =
$PIDFILE --name $NAME=0A=
	RETVAL=3D"$?"=0A=
	[ "$RETVAL" =3D 2 ] && return 2=0A=
	# Many daemons don't delete their pidfiles when they exit.=0A=
	rm -f $PIDFILE=0A=
	return "$RETVAL"=0A=
}=0A=
=0A=
case "$1" in=0A=
  start)=0A=
	[ "$VERBOSE" !=3D no ] && log_daemon_msg "Starting $DESC" "$NAME"=0A=
	do_start=0A=
	case "$?" in=0A=
		0|1) [ "$VERBOSE" !=3D no ] && log_end_msg 0 ;;=0A=
		2) [ "$VERBOSE" !=3D no ] && log_end_msg 1 ;;=0A=
	esac=0A=
	;;=0A=
  stop)=0A=
	[ "$VERBOSE" !=3D no ] && log_daemon_msg "Stopping $DESC" "$NAME"=0A=
	do_stop=0A=
	case "$?" in=0A=
		0|1) [ "$VERBOSE" !=3D no ] && log_end_msg 0 ;;=0A=
		2) [ "$VERBOSE" !=3D no ] && log_end_msg 1 ;;=0A=
	esac=0A=
	;;=0A=
  restart|force-reload)=0A=
	log_daemon_msg "Restarting $DESC" "$NAME"=0A=
	do_stop=0A=
	case "$?" in=0A=
	  0|1)=0A=
		do_start=0A=
		case "$?" in=0A=
			0) log_end_msg 0 ;;=0A=
			1) log_end_msg 1 ;; # Old process is still running=0A=
			*) log_end_msg 1 ;; # Failed to start=0A=
		esac=0A=
		;;=0A=
	  *)=0A=
	  	# Failed to stop=0A=
		log_end_msg 1=0A=
		;;=0A=
	esac=0A=
	;;=0A=
  *)=0A=
	echo "Usage: $SCRIPTNAME {start|stop|restart|force-reload}" >&2=0A=
	exit 3=0A=
	;;=0A=
esac=0A=

------=_NextPart_000_0002_01C97BBE.2F5879E0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_0002_01C97BBE.2F5879E0--

