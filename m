From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 Jan 2009 13:02:36 +0000
Subject: [lm-sensors] Updated initialization script, testers wanted
Message-Id: <20090112140236.6b74302e@hyperion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/h5AbupxSchbEotZR5fUsv9k"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--MP_/h5AbupxSchbEotZR5fUsv9k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Hans,

I have implemented and committed the sensors-detect side of ticket
#2246. Now the lm_sensors initialization script needs to be updated as
well, to make use of the new configuration file syntax. The
initialization script in our repository is meant for Red Hat
distributions but I don't have any, so I can't test my changes. The
patch I intend to apply is attached, could you (or anyone with a Red
Hat distribution) give it a try and confirm that it works OK?
Beforehand, you'll need to download and run the latest version of
sensors-detect:

http://www.lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect

and let it regenerate /etc/sysconfig/lm_sensors.

Thanks,
-- 
Jean Delvare

--MP_/h5AbupxSchbEotZR5fUsv9k
Content-Type: text/x-patch; name=init-new-format.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=init-new-format.patch

Update the initialization script to make use of the new syntax
of /etc/sysconfig/lm_sensors.

---
 prog/init/lm_sensors.init |   20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

--- lm-sensors-3.orig/prog/init/lm_sensors.init	2009-01-12 13:20:39.000000000 +0100
+++ lm-sensors-3/prog/init/lm_sensors.init	2009-01-12 13:47:07.000000000 +0100
@@ -25,9 +25,9 @@
 # It uses a config file /etc/sysconfig/lm_sensors that contains the modules
 # to be loaded/unloaded. That file is sourced into this one.
 
-# The format of that file a shell script that simply defines the modules 
-# in order as normal shell variables with the special names:
-#    MODULE_1, MODULE_2, MODULE_3, etc.
+# The format of this file is a shell script that simply defines variables:
+# HWMON_MODULES for hardware monitoring driver modules, and optionally
+# BUS_MODULES for any required bus driver module (for example for I2C or SPI).
 
 PSENSORS=/usr/local/bin/sensors
 
@@ -68,7 +68,7 @@ check_sensors() {
 	fi
 
 	CONFIG=/etc/sysconfig/lm_sensors
-	if ! [ -r "$CONFIG" ] || ! grep '^MODULE_' $CONFIG >/dev/null 2>&1; then
+	if ! [ -r "$CONFIG" ] || ! grep '^HWMON_MODULES' $CONFIG >/dev/null 2>&1; then
 		echo -n "$1 $prog: not configured, run sensors-detect"
 		echo_warning
 		echo
@@ -84,13 +84,9 @@ start() {
 
 	echo -n "Starting $prog: loading module "
 
-	modules=`grep \^MODULE_ $CONFIG | wc -l | tr -d ' '`
-	i=0
-	while [ $i -lt $modules ] ; do
-		module=`eval echo '$'MODULE_$i`
+	for $module in $BUS_MODULES $HWMON_MODULES ; do
 		echo -n "${module} "
 		/sbin/modprobe $module >/dev/null 2>&1
-		i=`expr $i + 1`
 	done
 	$PSENSORS -s
 
@@ -109,12 +105,8 @@ stop() {
 
 	echo -n "Stopping $prog: "
 
-	modules=`grep \^MODULE_ $CONFIG | wc -l | tr -d ' '`
-	i=`expr $modules`
-	while [ $i -ge 0 ] ; do
-		module=`eval echo '$'MODULE_$i`
+	for $module in $HWMON_MODULES $BUS_MODULES ; do
 		/sbin/modprobe -r $module >/dev/null 2>&1
-		i=`expr $i - 1`
 	done
 
 	if [ $WITHSYS == "0" ]; then

--MP_/h5AbupxSchbEotZR5fUsv9k
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/h5AbupxSchbEotZR5fUsv9k--
