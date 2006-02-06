From: deant@hawaii.rr.com (Dean Takemori)
Date: Mon, 06 Feb 2006 07:59:51 +0000
Subject: [lm-sensors] [PATCH 11/11] fancontrol.init
Message-Id: <7E87AA2D-989B-4787-8ACE-4C46A63DAB27@hawaii.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Submitted for the upcoming 2.10.0 release:  To upgrade the =20
fancontrol.init script
to the version I've been using for a while now on an FC1 system.


--- lm_sensors-2.9.2/prog/init/fancontrol.init	2004-06-23 =20
09:36:49.000000000 -1000
+++ Working/etc/init.d/fancontrol	2006-02-05 19:58:03.000000000 -1000
@@ -1,101 +1,103 @@
#!/bin/sh
#
-# $Id: fancontrol.init,v 1.1 2004/06/23 19:36:49 khali Exp $
+# $Id: fancontrol,v 1.17 2006/02/06 05:58:03 dean Exp $
+#
+# System V style startup script for RedHat-like systems.
+#
#
# fancontrol
#
-# chkconfig: 2345 90 01
-# description: start/stop fancontrol
+# chkconfig: 2345 60 01
+# description: Optional part of LM_Sensors.  On certain motherboards
+#              with supported chipsets, fancontrol can control the
+#              speed of System/CPU fans in response to temperature
+#              sensor output.
# pidfile: /var/run/fancontrol.pid
#
-
-PATH=3D/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
-export PATH
+# Usage /etc/init.d/fancontrol {start|stop|restart|status|condrestart}
# Source function library.
. /etc/rc.d/init.d/functions
-FANCONTROL=3D"/usr/local/sbin/fancontrol"
-PIDFILE=3D"/var/run/fancontrol.pid"
+PATH=3D/bin:/sbin
+export PATH
+
+prog=FAncontrol
+exe=3D/usr/local/sbin/$prog
+PIDFILE=3D/var/run/$prog.pid
+LOCKFILE=3D/var/lock/subsys/$prog
-RETVAL=3D0
start()
{
-   echo -n "Starting fancontrol daemon"
-   daemon $FANCONTROL -d
-   RETVAL=3D$?
-   [ $RETVAL -eq 0 ] && touch /var/lock/subsys/fancontrol
-   echo
+	echo -n "Starting $prog daemon: "
+	if [ -f $LOCKFILE ] ; then
+		echo -n "Lock file exists"
+		echo_failure
+		echo
+		exit -1;
+	fi
+	daemon $exe -d
+	RETVAL=3D$?
+	[ $RETVAL -eq 0 ] && touch $LOCKFILE && echo_success
+	echo
+	return $RETVAL
}
stop()
{
-   echo -n "Stopping fancontrol daemon"
-   killproc $FANCONTROL
-   RETVAL=3D$?
-   rm -f $PIDFILE
-   rm -f /var/lock/subsys/fancontrol
-   echo
-}
-
-status()
-{
-   if [ -f $PIDFILE ] ; then
-     pid=3D`cat $PIDFILE`
-   else
-     echo -n "$FANCONTROL does not appear to be running"
-     echo
-     exit
-   fi
-
-   if [ -n "$pid" ] ; then
-     ps -p $pid > /dev/null
-     if [ $? ] ; then
-       echo -n "$FANCONTROL appears to be running"
-     else
-       echo -n "$FANCONTROL does not appear to be running"
-     fi
-     echo
-   fi
+	echo -n "Stopping $prog daemon: "
+	killproc $exe
+	RETVAL=3D$?
+	echo
+	[ $RETVAL =3D 0 ] && rm -f $LOCKFILE $PIDFILE
+	return $RETVAL
}
condrestart()
{
-   [ -e /var/lock/subsys/fancontrol ] && restart || :
+	[ -e $LOCKFILE ] && restart || :
}
-if [ ! -x $FANCONTROL ] ; then
-   echo "Cannot run $FANCONTROL"
-   exit 0
+
+
+if [ ! -x $exe ] ; then
+	echo -n "No such service $prog: "
+	if [ ! -f $exe ] ; then
+		echo -n "No such executable $exe"
+	else
+		echo -n "Insufficient permissions for $exe"
+	fi
+	echo_failure
+	exit -1
fi
case "$1" in
-   start)
-     start
-     ;;
-
-   stop)
-     stop
-     ;;
-
-   status)
-     status
-     ;;
-
-   restart)
-     stop
-     start
-     ;;
-
-   condrestart)
-     condrestart
-     ;;
-
-   *)
-     echo "Usage: /etc/init.d/fancontrol
-{start|stop|status|restart|condrestart}"
-     RETVAL=3D1
+start)
+	start
+	;;
+
+stop)
+	stop
+	;;
+
+restart)
+	stop
+	start
+	;;
+
+status)
+	status $exe
+	RETVAL=3D$?
+	;;
+
+condrestart)
+	condrestart
+	;;
+
+*)
+	echo "Usage: /etc/init.d/$prog {start|stop|status|restart|=20
condrestart}"
+	exit -1
esac
exit $RETVAL


