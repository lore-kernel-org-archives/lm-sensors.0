From: vbooh <vbooh@somenet.pw>
Date: Thu, 26 Feb 2015 23:31:52 +0000
Subject: [lm-sensors] Patch and Upstart file for healthd.sh
Message-Id: <20150226233151.GA17731@alpha.somenet.pw>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

I want to propose a patch for healthd.sh and also an Upstart init file for it. A patch is for a decreasing of the resource consumption by healthd.sh; it replaces the external commands with the built-in Bash commands. It did not make a huge difference, but it was still useful in my case.

Thank you.

--EeQfGwPcQSOJBaQU
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="healthd.sh.patch"

--- a/healthd.sh	1999-02-15 08:42:01.000000000 +0300
+++ b/healthd.sh	2015-02-25 23:43:48.460431783 +0300
@@ -25,7 +25,8 @@
 
 ADMIN_EMAIL="root@localhost"
 
-if [ -n "`sensors | grep ALARM`" ]
+sensors_state=$(sensors)
+if [[ "$sensors_state" =~ 'ALARM' ]]
 then
         echo "Pending Alarms on start up!  Exiting!"
         exit
@@ -33,10 +34,11 @@
 
 while true
 do
- sleep 15
- if [ -n "`sensors | grep ALARM`" ]
+ read -t 15 -N 0
+ sensors_state=$(sensors)
+ if [[ "$sensors_state" =~ 'ALARM' ]]
  then
-        sensors | mail -s "**** Hardware Health Warning ****"  $ADMIN_EMAIL
-        sleep 600
+        echo "$sensors_state" | mail -s '**** Hardware Health Warning ****' $ADMIN_EMAIL
+        read -t 600 -N 0 
  fi
 done

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="healthd.conf"

# Upstart init file. Installation:
# cp --interactive --verbose /usr/share/doc/lm-sensors/examples/daemon/healthd.sh /usr/local/sbin/healthd
# cp --interactive --verbose /usr/share/doc/lm-sensors/examples/daemon/healthd.conf /etc/init/
# sed --in-place '1,7d' /etc/init/healthd.conf
# initctl reload-configuration
# service healthd start

# healthd - shell script daemon, that sends via email alerts of "sensors" utility
#
# This is a simple daemon, which can be used to alert you in the
# event of a hardware health monitoring alarm by sending an
# email to the root.
 
description	"sends via email alerts of sensors utility"

start on runlevel [2345]
stop on runlevel [!2345]

respawn

exec healthd

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--EeQfGwPcQSOJBaQU--
