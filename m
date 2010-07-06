From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 06 Jul 2010 22:24:37 +0000
Subject: [lm-sensors] [PATCH] sensors-detect: Add support for NCT6775F and
Message-Id: <20100706222437.GA31051@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following patch adds support for SE97 to sensors-detect.
It also displays the new chip names for W83677HG-I (NCT677xF).

---
Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5850)
+++ prog/detect/sensors-detect	(working copy)
@@ -1190,6 +1190,11 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x18..0x1f],
 		i2c_detect => sub { jedec_JC42_4_detect(@_, 0); },
 	}, {
+		name => "NXP SE97/SE97B",
+		driver => "to-be-written",
+		i2c_addrs => [0x18..0x1f],
+		i2c_detect => sub { jedec_JC42_4_detect(@_, 1); },
+	}, {
 		name => "Smart Battery",
 		driver => "sbs", # ACPI driver, not sure if it always works
 		i2c_addrs => [0x0b],
@@ -1730,7 +1735,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
 		logdev => 0x0b,
 		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
 	}, {
-		name => "Nuvoton W83677HG-I Super IO Sensors",
+		name => "Nuvoton W83677HG-I (NCT6771F/NCT6772F/NCT6775F) Super IO Sensors",
 		driver => "to-be-written",	# Probably w83627ehf
 		devid => 0xB470,
 		devid_mask => 0xFFF0,
@@ -5309,7 +5314,7 @@ sub max6655_detect
 	return 6;
 }
 
-# Chip to detect: 0 = STTS424
+# Chip to detect: 0 = STTS424, 1 = SE97/SE97B
 # Registers used:
 #   0x00: Capabilities
 #   0x01: Configuration
@@ -5332,9 +5337,13 @@ sub jedec_JC42_4_detect
 	# Check for manufacturer and device ID
 	$manid = i2c_smbus_read_byte_data($file, 0x06);
 	$devid = i2c_smbus_read_byte_data($file, 0x07);
+
 	if ($chip = 0) {
 		return unless $manid = 0x10;		# STMicrolectronics
 		return unless $devid = 0x00;		# STTS424
+	} elsif ($chip = 1) {
+		return unless $manid = 0x11;		# NXP
+		return unless $devid = 0xa2;		# SE97
 	}
 
 	# Now, do it all again with words. Note that we get
@@ -5342,7 +5351,7 @@ sub jedec_JC42_4_detect
 
 	# Check for unused bits
 	$reg = i2c_smbus_read_word_data($file, 0x00);
-	return if $reg < 0 || $reg & 0xc0ff;
+	return if $reg < 0 || $reg & 0x00ff;
 
 	$manid = i2c_smbus_read_word_data($file, 0x06);
 	$devid = i2c_smbus_read_word_data($file, 0x07);
@@ -5350,6 +5359,9 @@ sub jedec_JC42_4_detect
 	if ($chip = 0) {
 		return unless $manid = 0x4a10;		# STMicrolectronics
 		return unless ($devid & 0xfeff) = 0x0000; # STTS424
+	} elsif ($chip = 1) {
+		return unless $manid = 0x3111;		# NXP
+		return unless ($devid & 0xfcff) = 0x00a2; # SE97
 	}
 
 	return 5;
Index: CHANGES
=================================--- CHANGES	(revision 5850)
+++ CHANGES	(working copy)
@@ -18,6 +18,8 @@ SVN HEAD
                   Fix Maxim MAX6690 support
                   Fix handling of duplicate detections
                   Add support for STMicroelectronics STTS424
+                  Add support for NXP SE97 / SE97B
+                  Add reference to NCT6771F/NCT6772F/NCT6775F
 
 3.1.2 (2010-02-02)
   libsensors: Support upcoming sysfs path to i2c adapters

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
