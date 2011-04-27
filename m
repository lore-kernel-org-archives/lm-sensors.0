From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 27 Apr 2011 13:05:10 +0000
Subject: [lm-sensors] PATCH: systemd integration version 2
Message-Id: <4DB81486.2010700@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020802030801090404060405"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020802030801090404060405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The attached patch:
1) uses systemd's systemctl to start / stop / enable the lm_sensors service on
systemd systems (such as Fedora 15)
2) recognizes the new /run dir for run time info (as used by systemd systems)
as a possible place where the udev db can live
3) adds a lm_sensor.service file to install under /lib/systemd/system

Version 2:
1) adds detection that the lm_sensor.service still needs to be installed
    under /lib/systemd/system to sensors-detect
2) has a better description for the .service file

Please review, I'll push it to svn myself once acked.

Regards,

Hans

--------------020802030801090404060405
Content-Type: text/plain;
 name="lm_sensors-systemd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lm_sensors-systemd.patch"

Index: prog/init/lm_sensors.service
===================================================================
--- prog/init/lm_sensors.service	(revision 0)
+++ prog/init/lm_sensors.service	(revision 0)
@@ -0,0 +1,14 @@
+[Unit]
+Description=Initialize hardware monitoring sensors
+After=syslog.target
+
+[Service]
+EnvironmentFile=/etc/sysconfig/lm_sensors
+Type=oneshot
+RemainAfterExit=yes
+ExecStart=-/sbin/modprobe -qab $BUS_MODULES $HWMON_MODULES
+ExecStart=/usr/bin/sensors -s
+ExecStop=-/sbin/modprobe -qabr $BUS_MODULES $HWMON_MODULES
+
+[Install]
+WantedBy=multi-user.target
Index: prog/detect/sensors-detect
===================================================================
--- prog/detect/sensors-detect	(revision 5939)
+++ prog/detect/sensors-detect	(working copy)
@@ -2339,7 +2339,7 @@
 	if (!$use_udev) {
 		# Try some known default udev db locations, just in case
 		if (-e '/dev/.udev.tdb' || -e '/dev/.udev'
-		 || -e '/dev/.udevdb') {
+		 || -e '/dev/.udevdb' || -e '/run/udev') {
 			$use_udev = 1;
 			$dev_i2c = '/dev/i2c-';
 		}
@@ -6378,6 +6378,22 @@
 		}
 		close(SYSCONFIG);
 
+		if (-x "/bin/systemctl" && -d "/lib/systemd/system" &&
+		    ! -f "/lib/systemd/system/lm_sensors.service") {
+			print "Copy prog/init/lm_sensors.service to /lib/systemd/system\n".
+			      "And run systemctl enable lm_sensors.service\n".
+			      "for initialization at boot time.\n";
+			return;
+		}
+
+		if (-x "/bin/systemctl" &&
+		    -f "/lib/systemd/system/lm_sensors.service") {
+			system("/bin/systemctl", "enable", "lm_sensors.service");
+			system("/bin/systemctl", "start", "lm_sensors.service");
+			# All done, don't check for /etc/init.d/lm_sensors
+			return;
+		}
+
 		print "Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors\n".
 		      "for initialization at boot time.\n"
 			unless -f "/etc/init.d/lm_sensors";
@@ -6433,8 +6449,10 @@
 		exit -1;
 	}
 
-	if (-x "/sbin/service" && -f "/etc/init.d/lm_sensors" &&
-	    -f "/var/lock/subsys/lm_sensors") {
+	if (-x "/bin/systemctl" && -f "/lib/systemd/system/lm_sensors.service") {
+		system("/bin/systemctl", "stop", "lm_sensors.service");
+	} elsif (-x "/sbin/service" && -f "/etc/init.d/lm_sensors" &&
+		 -f "/var/lock/subsys/lm_sensors") {
 		system("/sbin/service", "lm_sensors", "stop");
 	}
 

--------------020802030801090404060405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020802030801090404060405--
