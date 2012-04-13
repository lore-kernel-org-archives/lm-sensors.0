From: Charles <c@catcons.co.uk>
Date: Fri, 13 Apr 2012 15:46:29 +0000
Subject: [lm-sensors] fancontrol script modifications
Message-Id: <4F884785.4030603@catcons.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello :-)

Two new features are shown in the diff, based on the 3.3.2 version.

One provides for handling a stale PID file.

The other allows the PIDFILE value to be optionally configured.  This is
useful if the user wants to start fancontrol before the file system
containing /var/run is mounted (I have it configured as
/root/var/run/fancontrol.pid)

=== diff begins ==--- fancontrol.org	2012-04-11 21:15:58.611000054 +0530
+++ fancontrol	2012-04-13 15:55:06.790123451 +0530
@@ -38,8 +38,6 @@
 #
 #

-PIDFILE="/var/run/fancontrol.pid"
-
 #DEBUG=1
 MAX%5

@@ -66,6 +64,11 @@
 	FCFANS=`egrep '^FCFANS=.*$' $1 | sed -e 's/FCFANS=//g'`
 	MINPWM=`egrep '^MINPWM=.*$' $1 | sed -e 's/MINPWM=//g'`
 	MAXPWM=`egrep '^MAXPWM=.*$' $1 | sed -e 's/MAXPWM=//g'`
+	PIDFILE=`egrep '^PIDFILE=.*$' $1 | sed -e 's/PIDFILE=//g'`
+    if [[ -z $PIDFILE ]]
+    then
+        PIDFILE='/var/run/fancontrol.pid'
+    fi

 	# Check whether all mandatory settings are set
 	if [[ -z ${INTERVAL} || -z ${FCTEMPS} || -z ${MINTEMP} || -z
${MAXTEMP} || -z ${MINSTART} || -z ${MINSTOP} ]]
@@ -205,6 +208,25 @@
 	return $outdated
 }

+# Check and write PID file
+function PIDfile {
+    local cmd my_name PID
+    if [[ -f "$PIDFILE" ]]
+    then
+        my_name="${0##*/}"
+        PID=`cat "$PIDFILE"`
+        cmd=`ps --pid "$PID" --format cmd --no-headers`
+        if [ "${cmd##*/}" = "$my_name" ]
+        then
+            echo "$my_name is already running with PID $PID" >&2
+            exit 1
+        else
+            echo "Refreshing stale PID file, $PIDFILE" >&2
+        fi
+    fi
+    echo $$ > "$PIDFILE"
+}
+
 # Check that all referenced sysfs files exist
 function CheckFiles {
 	local outdated=0
@@ -301,12 +323,7 @@
 fi
 CheckFiles || exit 1

-if [ -f "$PIDFILE" ]
-then
-	echo "File $PIDFILE exists, is fancontrol already running?" >&2
-	exit 1
-fi
-echo $$ > "$PIDFILE"
+PIDfile

 # $1 = pwm file name
 function pwmdisable()
=== diff ends ==
Best

Charles

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
