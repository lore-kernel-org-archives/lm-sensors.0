From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 11 Feb 2008 13:18:20 +0000
Subject: [lm-sensors] Patch: don't start initscript by default on chkconfig
Message-Id: <47B04B1C.9070405@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010001010008040106010704"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010001010008040106010704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

The attached patch modifies the initscript included with lm_sensors so that it 
doesn't start by default on chkconfig using systems.

The patch also modifies sensors-detect to activate the initscript once 
lm_sensors has been successfully configured.

If I don't get any objections I will be committing this to svn in a couple of days.

Regards,

Hans

--------------010001010008040106010704
Content-Type: text/x-patch; name="lm_sensors-2.10.4-service-default-off.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="lm_sensors-2.10.4-service-default-off.patch"

diff -up lm_sensors-3.0.1/prog/detect/sensors-detect.foo lm_sensors-3.0.1/prog/detect/sensors-detect
--- lm_sensors-3.0.1/prog/detect/sensors-detect.foo	2008-01-22 13:22:47.000000000 +0100
+++ lm_sensors-3.0.1/prog/detect/sensors-detect	2008-02-11 13:42:04.000000000 +0100
@@ -5943,6 +5943,15 @@ EOT
 
     if (-x "/sbin/insserv" && -f "/etc/init.d/lm_sensors") {
       system("/sbin/insserv", "/etc/init.d/lm_sensors");
+    } elsif (-x "/sbin/chkconfig" && -f "/etc/init.d/lm_sensors") {
+      system("/sbin/chkconfig", "lm_sensors", "on");
+      if (-x "/sbin/service") {
+        if (-f "/var/lock/subsys/lm_sensors") {
+          system("/sbin/service", "lm_sensors", "restart");
+        } else {
+          system("/sbin/service", "lm_sensors", "start");
+        }
+      }
     } else {
       print "You should now start the lm_sensors service to load the required\n".
             "kernel modules.\n\n";
diff -up lm_sensors-3.0.1/prog/init/lm_sensors.init.foo lm_sensors-3.0.1/prog/init/lm_sensors.init
--- lm_sensors-3.0.1/prog/init/lm_sensors.init.foo	2007-04-27 14:34:17.000000000 +0200
+++ lm_sensors-3.0.1/prog/init/lm_sensors.init	2008-02-11 13:08:58.000000000 +0100
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# chkconfig: 2345 26 74
+# chkconfig: - 26 74
 # description: sensors is used for monitoring motherboard sensor values.
 # config: /etc/sysconfig/lm_sensors
 #

--------------010001010008040106010704
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010001010008040106010704--

