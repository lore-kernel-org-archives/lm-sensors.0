From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 13 Sep 2009 12:53:18 +0000
Subject: [lm-sensors] [PATCH] Make fancontrol more robust to kernel changes
Message-Id: <20090913145318.7f260dfd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi all,

As newer kernels have improved support for ACPI-based hardware
monitoring (be it using the generic thermal_sys driver, or
asus_atk0110), it can happen that a kernel upgrade causes hardware
monitoring class devices (/sys/class/hwmon/*) to change without any
user interaction. While libsensors doesn't care too much, fancontrol
does, because it uses the hwmon class device numbers for
identification. This can result in a totally broken fan control
behavior, as was reported here:

https://bugzilla.novell.com/show_bug.cgi?idR9483

At this point, best would probably be to admit that fancontrol was just
a quick hack and was never meant for production, and rewrite it in a
language that can make use of libsensors. This is however more work
than I can afford spending on this myself.

So, as a temporary workaround, I propose to extend the /etc/fancontrol
configuration file syntax to record the physical device path and name
of each used hwmon class device. pwmconfig will be in charge of writing
the information at configuration time, and fancontrol will have to
check it at run time. If the values do not match, fancontrol will exit
immediately: better no fan control at all than fan control based on
broken assumptions.

I decided to record both the path and the name because:
* Not all hwmon devices have a physical device path. Purely virtual
  devices (for example thermal_sys) don't. So checking only the path
  wouldn't be sufficient.
* The device name is not unique. It is perfectly possible for two
  devices to have the same name (for example "coretemp").
So neither the path nor the name is sufficient. I hope that having both
will be good enough, even though I am well aware it isn't bullet-proof.

One drawback is that _everyone_ will have to run pwmconfig again when
using this new version of fancontrol. But without a time machine, I
just can't think of a way to avoid it.

Here's the patch, comments welcome:

Index: prog/pwm/fancontrol
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/pwm/fancontrol	(r=E9vision 5766)
+++ prog/pwm/fancontrol	(copie de travail)
@@ -3,12 +3,12 @@
 # Simple script implementing a temperature dependent fan speed control
 # Supported Linux kernel versions: 2.6.5 and later
 #
-# Version 0.69
+# Version 0.70
 #
 # Usage: fancontrol [CONFIGFILE]
 #
 # Dependencies:
-#   bash, egrep, sed, cut, sleep, lm_sensors :)
+#   bash, egrep, sed, cut, sleep, readlink, lm_sensors :)
 #
 # Please send any questions, comments or success stories to
 # marius.reiner@hdev.de
@@ -55,6 +55,8 @@
=20
 	# grep configuration from file
 	INTERVAL=3D`egrep '^INTERVAL=3D.*$' $1 | sed -e 's/INTERVAL=3D//g'`
+	DEVPATH=3D`egrep '^DEVPATH=3D.*$' $1 | sed -e 's/DEVPATH=3D *//g'`
+	DEVNAME=3D`egrep '^DEVNAME=3D.*$' $1 | sed -e 's/DEVNAME=3D *//g'`
 	FCTEMPS=3D`egrep '^FCTEMPS=3D.*$' $1 | sed -e 's/FCTEMPS=3D//g'`
 	MINTEMP=3D`egrep '^MINTEMP=3D.*$' $1 | sed -e 's/MINTEMP=3D//g'`
 	MAXTEMP=3D`egrep '^MAXTEMP=3D.*$' $1 | sed -e 's/MAXTEMP=3D//g'`
@@ -152,6 +154,57 @@
 	echo
 }
=20
+function DevicePath()
+{
+	if [ -d "$1/device" ]
+	then
+		readlink -f "$1/device" | sed -e 's/^\/sys\///'
+	fi
+}
+
+function DeviceName()
+{
+	if [ -r "$1/name" ]
+	then
+		cat "$1/name" | sed -e 's/[[:space:]=3D]/_/g'
+	elif [ -r "$1/device/name" ]
+	then
+		cat "$1/device/name" | sed -e 's/[[:space:]=3D]/_/g'
+	fi
+}
+
+function ValidateDevices()
+{
+	local OLD_DEVPATH=3D"$1" OLD_DEVNAME=3D"$2" outdated=3D0
+	local entry device name path
+
+	for entry in $OLD_DEVPATH
+	do
+		device=3D`echo "$entry" | sed -e 's/=3D[^=3D]*$//'`
+		path=3D`echo "$entry" | sed -e 's/^[^=3D]*=3D//'`
+
+		if [ "`DevicePath "$device"`" !=3D "$path" ]
+		then
+			echo "Device path of $device has changed"
+			outdated=3D1
+		fi
+	done
+
+	for entry in $OLD_DEVNAME
+	do
+		device=3D`echo "$entry" | sed -e 's/=3D[^=3D]*$//'`
+		name=3D`echo "$entry" | sed -e 's/^[^=3D]*=3D//'`
+
+		if [ "`DeviceName "$device"`" !=3D "$name" ]
+		then
+			echo "Device name of $device has changed"
+			outdated=3D1
+		fi
+	done
+
+	return $outdated
+}
+
 # Check that all referenced sysfs files exist
 function CheckFiles {
 	local outdated=3D0
@@ -232,6 +285,17 @@
 fi
 cd $DIR
=20
+# Check for configuration change
+if [ -z "$DEVPATH" -o -z "$DEVNAME" ]
+then
+	echo "Configuration is too old, please run pwmconfig again"
+	exit 1
+fi
+if ! ValidateDevices "$DEVPATH" "$DEVNAME"
+then
+	echo "Configuration appears to be outdated, please run pwmconfig again"
+	exit 1
+fi
 CheckFiles || exit 1
=20
 if [ -f "$PIDFILE" ]
Index: prog/pwm/pwmconfig
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/pwm/pwmconfig	(r=E9vision 5767)
+++ prog/pwm/pwmconfig	(copie de travail)
@@ -539,6 +539,57 @@
 	exit 1
 fi
=20
+function DevicePath()
+{
+	if [ -d "$1/device" ]
+	then
+		readlink -f "$1/device" | sed -e 's/^\/sys\///'
+	fi
+}
+
+function DeviceName()
+{
+	if [ -r "$1/name" ]
+	then
+		cat "$1/name" | sed -e 's/[[:space:]=3D]/_/g'
+	elif [ -r "$1/device/name" ]
+	then
+		cat "$1/device/name" | sed -e 's/[[:space:]=3D]/_/g'
+	fi
+}
+
+function ValidateDevices()
+{
+	local OLD_DEVPATH=3D"$1" OLD_DEVNAME=3D"$2" outdated=3D0
+	local entry device name path
+
+	for entry in $OLD_DEVPATH
+	do
+		device=3D`echo "$entry" | sed -e 's/=3D[^=3D]*$//'`
+		path=3D`echo "$entry" | sed -e 's/^[^=3D]*=3D//'`
+
+		if [ "`DevicePath "$device"`" !=3D "$path" ]
+		then
+			echo "Device path of $device has changed"
+			outdated=3D1
+		fi
+	done
+
+	for entry in $OLD_DEVNAME
+	do
+		device=3D`echo "$entry" | sed -e 's/=3D[^=3D]*$//'`
+		name=3D`echo "$entry" | sed -e 's/^[^=3D]*=3D//'`
+
+		if [ "`DeviceName "$device"`" !=3D "$name" ]
+		then
+			echo "Device name of $device has changed"
+			outdated=3D1
+		fi
+	done
+
+	return $outdated
+}
+
 function AskPath()
 {
 	echo -n 'What should be the path to your fancontrol config file (/etc/fan=
control)? '
@@ -566,6 +617,8 @@
=20
 function LoadConfig()
 {
+	local OLD_DEVPATH OLD_DEVNAME
+
 	# Nothing to do
 	if [ ! -f "$1" ]
 	then
@@ -575,6 +628,8 @@
=20
 	echo "Loading configuration from $1 ..."
 	INTERVAL=3D`egrep '^INTERVAL=3D.*$' $1 | sed -e 's/INTERVAL=3D *//g'`
+	OLD_DEVPATH=3D`egrep '^DEVPATH=3D.*$' $1 | sed -e 's/DEVPATH=3D *//g'`
+	OLD_DEVNAME=3D`egrep '^DEVNAME=3D.*$' $1 | sed -e 's/DEVNAME=3D *//g'`
 	FCTEMPS=3D`egrep '^FCTEMPS=3D.*$' $1 | sed -e 's/FCTEMPS=3D *//g'`
 	FCFANS=3D`egrep '^FCFANS=3D.*$' $1 | sed -e 's/FCFANS=3D *//g'`
 	MINTEMP=3D`egrep '^MINTEMP=3D.*$' $1 | sed -e 's/MINTEMP=3D *//g'`
@@ -585,16 +640,12 @@
 	MAXPWM=3D`egrep '^MAXPWM=3D.*$' $1 | sed -e 's/MAXPWM=3D *//g'`
=20
 	# Check for configuration change
-	local item
-	for item in $FCFANS
-	do
-		if [ ! -f "`echo $item | sed -e 's/=3D.*$//'`" ]
-		then
-			echo "Configuration appears to be outdated, discarded"
-			ClearConfig
-			return 0
-		fi
-	done
+	if ! ValidateDevices "$OLD_DEVPATH" "$OLD_DEVNAME"
+	then
+		echo "Configuration appears to be outdated, discarded"
+		ClearConfig
+		return 0
+	fi
 }
=20
 LoadConfig $FCCONFIG
@@ -675,14 +726,68 @@
 	echo "OK, using $fanval"
 }
=20
+# Remember the path and name of each device with at least one
+# reference (pwm, temp or fan) in the configuration file.
+# This function sets globals DEVPATH and DEVNAME as a side effect.
+function RememberDevices()
+{
+	local used entry device name path tempfandev pwmdev
+	DEVPATH=3D""
+	DEVNAME=3D""
+
+	for device in $DEVICES
+	do
+		device=3D`echo "$device" | sed -e 's/\/.*$//'`
+
+		used=3D0
+		for entry in $1 $2
+		do
+			pwmdev=3D`echo "$entry" | sed -e 's/\/.*$//'`
+			tempfandev=3D`echo "$entry" | sed -e 's/^[^=3D]*=3D//' -e 's/\/.*$//'`
+
+			if [ "$device" =3D "$pwmdev" -o "$device" =3D "$tempfandev" ]
+			then
+				used=3D1
+			fi
+		done
+		if [ "$used" -eq 0 ]
+		then
+			continue
+		fi
+
+		# Record the device path and name. This lets the fancontrol
+		# script check that they didn't change. If they did, then the
+		# configuration file can no longer be trusted.
+		path=3D`DevicePath "$device"`
+		if [ -z "$DEVPATH" ]
+		then
+			DEVPATH=3D"$device=3D$path"
+		else
+			DEVPATH=3D"$DEVPATH $device=3D$path"
+		fi
+
+		name=3D`DeviceName "$device"`
+		if [ -z "$DEVNAME" ]
+		then
+			DEVNAME=3D"$device=3D$name"
+		else
+			DEVNAME=3D"$DEVNAME $device=3D$name"
+		fi
+	done
+}
+
 function SaveConfig()
 {
+	RememberDevices "$FCTEMPS" "$FCFANS"
+
 	echo
 	echo "Saving configuration to $FCCONFIG..."
 	tmpfile=3D`mktemp -t pwmcfg.XXXXXXXXXX` || { echo "$0: Cannot create temp=
orary file" >&2; exit 1;  }
 	trap " [ -f \"$tmpfile\" ] && /bin/rm -f -- \"$tmpfile\"" 0 1 2 3 13 15
 	echo "# Configuration file generated by pwmconfig, changes will be lost" =
>$tmpfile
 	echo "INTERVAL=3D$INTERVAL" >>$tmpfile
+	echo "DEVPATH=3D$DEVPATH" >>$tmpfile
+	echo "DEVNAME=3D$DEVNAME" >>$tmpfile
 	echo "FCTEMPS=3D$FCTEMPS" >>$tmpfile
 	echo "FCFANS=3D$FCFANS" >>$tmpfile
 	echo "MINTEMP=3D$MINTEMP" >>$tmpfile
Index: prog/pwm/fancontrol.8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- prog/pwm/fancontrol.8	(r=E9vision 5765)
+++ prog/pwm/fancontrol.8	(copie de travail)
@@ -92,9 +92,11 @@
 setup I recommend using the \fBpwmconfig\fP script. Small changes can be m=
ade by
 editing the config file directly following the rules above.
=20
-Upon starting, fancontrol will make sure that all referenced sysfs files
-do exist. If not, it will quit immediately, upon the assumption that the
-configuration file may be out-of-sync with the loaded kernel drivers.
+Upon starting, fancontrol will make sure that all referenced devices
+do exist and match what they were at configuration time, and that all
+referenced sysfs files do exist. If not, it will quit immediately, upon
+the assumption that the configuration file may be out-of-sync with the
+loaded kernel drivers.
=20
 .SH THE ALGORITHM
=20


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
