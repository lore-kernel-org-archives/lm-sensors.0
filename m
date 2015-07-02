From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 02 Jul 2015 08:43:52 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Fix systemd paths
Message-Id: <20150702104352.5ce3394a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Most distributions have moved systemd from / to /usr, so sensors-detect
should check for the latter too (and first.)
---
 prog/detect/sensors-detect |   53 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2015-06-09 15:12:16.556941510 +0200
+++ lm-sensors/prog/detect/sensors-detect	2015-07-02 10:28:32.138475805 +0200
@@ -2728,7 +2728,7 @@ sub isa_read_i5d6
 # AUTODETECTION #
 #################
 
-use vars qw($dev_i2c $sysfs_root);
+use vars qw($dev_i2c $sysfs_root $systemd_systemctl $systemd_system_dir);
 
 sub initialize_conf
 {
@@ -2789,6 +2789,19 @@ sub initialize_conf
 			exit -1;
 		}
 	}
+
+	# Detect systemd presence and paths
+	if (-x "/usr/bin/systemctl") {
+		$systemd_systemctl = "/usr/bin/systemctl";
+	} elsif (-x "/bin/systemctl") {
+		$systemd_systemctl = "/bin/systemctl";
+	}
+
+	if (-d "/usr/lib/systemd/system") {
+		$systemd_system_dir = "/usr/lib/systemd/system";
+	} elsif (-d "/lib/systemd/system") {
+		$systemd_system_dir = "/lib/systemd/system";
+	}
 }
 
 # [0] -> VERSION
@@ -7090,19 +7103,16 @@ EOT
 		print SYSCONFIG "HWMON_MODULES=\"", join(" ", @{$hwmon_modules}), "\"\n";
 		close(SYSCONFIG);
 
-		if (-x "/bin/systemctl" && -d "/lib/systemd/system" &&
-		    ! -f "/lib/systemd/system/lm_sensors.service") {
-			print "Copy prog/init/lm_sensors.service to /lib/systemd/system\n".
-			      "and run 'systemctl enable lm_sensors.service'\n".
-			      "for initialization at boot time.\n";
-			return;
-		}
-
-		if (-x "/bin/systemctl" &&
-		    -f "/lib/systemd/system/lm_sensors.service") {
-			system("/bin/systemctl", "enable", "lm_sensors.service");
-			system("/bin/systemctl", "start", "lm_sensors.service");
-			# All done, don't check for /etc/init.d/lm_sensors
+		if ($systemd_systemctl && $systemd_system_dir) {
+			if (-f "$systemd_system_dir/lm_sensors.service") {
+				system($systemd_systemctl, "enable", "lm_sensors.service");
+				system($systemd_systemctl, "start", "lm_sensors.service");
+				# All done, don't check for /etc/init.d/lm_sensors
+			} else {
+				print "Copy prog/init/lm_sensors.service to $systemd_system_dir\n".
+				      "and run 'systemctl enable lm_sensors.service'\n".
+				      "for initialization at boot time.\n";
+			}
 			return;
 		}
 
@@ -7170,13 +7180,6 @@ sub main
 		exit -1;
 	}
 
-	if (-x "/bin/systemctl" && -f "/lib/systemd/system/lm_sensors.service") {
-		system("/bin/systemctl", "stop", "lm_sensors.service");
-	} elsif (-x "/sbin/service" && -f "/etc/init.d/lm_sensors" &&
-		 -f "/var/lock/subsys/lm_sensors") {
-		system("/sbin/service", "lm_sensors", "stop");
-	}
-
 	initialize_kernel_version();
 	initialize_conf();
 	initialize_pci();
@@ -7187,6 +7190,14 @@ sub main
 	initialize_modules_supported();
 	initialize_cpu_list();
 
+	if ($systemd_systemctl && $systemd_system_dir &&
+	    -f "$systemd_system_dir/lm_sensors.service") {
+		system("$systemd_systemctl", "stop", "lm_sensors.service");
+	} elsif (-x "/sbin/service" && -f "/etc/init.d/lm_sensors" &&
+		 -f "/var/lock/subsys/lm_sensors") {
+		system("/sbin/service", "lm_sensors", "stop");
+	}
+
 	print "# sensors-detect revision $revision\n";
 	initialize_dmi_data();
 	print_dmi_summary();


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
