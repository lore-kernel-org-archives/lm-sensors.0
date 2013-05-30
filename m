From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 30 May 2013 13:21:01 +0000
Subject: [lm-sensors] [PATCH 2/2] sensors-detect: Handle built-in modules properly
Message-Id: <20130530152101.15d1cc1f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We now have everything we need to handle built-in modules properly, so
do it. It should work fine since kernel 2.6.33.
---
 prog/detect/sensors-detect |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- lm-sensors.orig/prog/detect/sensors-detect	2013-05-30 14:29:07.580744646 +0200
+++ lm-sensors/prog/detect/sensors-detect	2013-05-30 15:05:00.730120433 +0200
@@ -2789,7 +2789,7 @@ sub hwmon_is_autoloaded
 # MODULES #
 ###########
 
-use vars qw(%modules_list %modules_supported @modules_we_loaded);
+use vars qw(%modules_builtin %modules_list %modules_supported @modules_we_loaded);
 
 sub initialize_modules_list
 {
@@ -2799,7 +2799,7 @@ sub initialize_modules_list
 	if (open(*INPUTFILE, "/lib/modules/$kernel_version/modules.builtin")) {
 		while (<INPUTFILE>) {
 			tr/-/_/;
-			$modules_list{$1} = 1 if m/\/([^\/]+)\.ko$/;
+			$modules_builtin{$1} = 1 if m/\/([^\/]+)\.ko$/;
 		}
 		close(INPUTFILE);
 	}
@@ -2815,7 +2815,14 @@ sub is_module_loaded
 {
 	my $module = shift;
 	$module =~ tr/-/_/;
-	return exists $modules_list{$module}
+	return exists $modules_list{$module} || exists $modules_builtin{$module};
+}
+
+sub is_module_builtin
+{
+	my $module = shift;
+	$module =~ tr/-/_/;
+	return exists $modules_builtin{$module};
 }
 
 sub load_module
@@ -6638,7 +6645,7 @@ sub generate_modprobes
 		if ($driver eq "to-be-written") {
 			print "Note: there is no driver for ${$chips_detected{$driver}}[0]{chipname} yet.\n".
 			      "Check http://www.lm-sensors.org/wiki/Devices for updates.\n\n";
-		} else {
+		} elsif (!is_module_builtin($driver)) {
 			open(local *INPUTFILE, "modprobe -l $driver 2>/dev/null |");
 			local $_;
 			my $modulefound = 0;
@@ -6653,8 +6660,7 @@ sub generate_modprobes
 			# isn't supported
 			if ((($? >> 8) = 0) && ! $modulefound) {
 				print "Warning: the required module $driver is not currently installed\n".
-				      "on your system. If it is built into the kernel then it's OK.\n".
-				      "Otherwise, check http://www.lm-sensors.org/wiki/Devices for\n".
+				      "on your system. Check http://www.lm-sensors.org/wiki/Devices for\n".
 				      "driver availability.\n\n";
 			} else {
 				$hwmon_modules{$driver}++
@@ -6770,13 +6776,10 @@ EOT
 		       "/usr/local/bin/sensors -s\n").
 		      "#----cut here----\n\n");
 
-		print "If you have some drivers built into your kernel, the list above will\n".
-		      "contain too many modules. Skip the appropriate ones! You really\n".
-		      "should try these commands right now to make sure everything is\n".
-		      "working properly. Monitoring programs won't work until the needed\n".
+		print "You really should try these commands right now to make sure everything\n".
+		      "is working properly. Monitoring programs won't work until the needed\n".
 		      "modules are loaded.\n\n";
 	}
-
 }
 
 sub main
@@ -6940,6 +6943,7 @@ sub main
 		find_aliases($chips_detected{$driver});
 		print "\nDriver `$driver'";
 		print " (autoloaded)" if hwmon_is_autoloaded($driver);
+		print " (built-in)" if is_module_builtin($driver);
 		print ":\n";
 		print_chips_report($chips_detected{$driver});
 	}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
