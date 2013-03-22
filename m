From: Marc Ferland <ferlandm@sonatest.com>
Date: Fri, 22 Mar 2013 17:51:30 +0000
Subject: [lm-sensors] [PATCH] fancontrol: Fix handling of absolute paths in config
Message-Id: <87obebb9wd.fsf@sonatest.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--=-=-=
Content-Type: text/plain

The following patch fixes the fancontrol script so it can handle
absolute filenames again.

Marc


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline

Index: prog/pwm/fancontrol
===================================================================
--- prog/pwm/fancontrol	(revision 6127)
+++ prog/pwm/fancontrol	(working copy)
@@ -289,16 +289,19 @@
 cd $DIR
 
 # Check for configuration change
-if [ -z "$DEVPATH" -o -z "$DEVNAME" ]
+if [ "$DIR" != "/" ]
 then
-	echo "Configuration is too old, please run pwmconfig again" >&2
-	exit 1
+	if [ -z "$DEVPATH" -o -z "$DEVNAME" ]
+	then
+		echo "Configuration is too old, please run pwmconfig again" >&2
+		exit 1
+	fi
+	if ! ValidateDevices "$DEVPATH" "$DEVNAME"
+	then
+		echo "Configuration appears to be outdated, please run pwmconfig again" >&2
+		exit 1
+	fi
 fi
-if ! ValidateDevices "$DEVPATH" "$DEVNAME"
-then
-	echo "Configuration appears to be outdated, please run pwmconfig again" >&2
-	exit 1
-fi
 CheckFiles || exit 1
 
 if [ -f "$PIDFILE" ]

--=-=-=
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-=-=--
