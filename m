From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 09 Feb 2011 16:20:41 +0000
Subject: [lm-sensors] [PATCH v3] sensors-detect: Add capability to detect
Message-Id: <20110209162041.GA19070@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds detection of SMSC EMC1002, EMC1033, EMC1046, EMC1047,
EMC1072, EMC1073, EMC1074, EMC1402, and EMC1424 to sensors-detect.

--
v3:
- Don't detect chips on addresses 0x10, 0x3c, 0x3d, 0x6c, and 0x7c
  to avoid probing of so far unprobed addresses.
- Remove duplicate lines from emc1403_detect function comment

v2:
- Updated CHANGES
- More detailed description

Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5913)
+++ prog/detect/sensors-detect	(working copy)
@@ -1195,16 +1195,36 @@
 		i2c_addrs => [0x2f],
 		i2c_detect => sub { fintek_detect(@_, 7); },
 	}, {
+		name => "SMSC EMC1002",
+		driver => "to-be-written",
+		i2c_addrs => [0x4c, 0x4d],
+		i2c_detect => sub { emc1403_detect(@_, 4); },
+	}, {
 		name => "SMSC EMC1023",
 		driver => "to-be-written",	# emc1023
 		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
 		i2c_detect => sub { emc1023_detect(@_, 0); },
 	}, {
+		name => "SMSC EMC1033",
+		driver => "to-be-written",
+		i2c_addrs => [0x4c, 0x4d],
+		i2c_detect => sub { emc1403_detect(@_, 5); },
+	}, {
 		name => "SMSC EMC1043",
 		driver => "to-be-written",	# emc1023
 		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
 		i2c_detect => sub { emc1023_detect(@_, 1); },
 	}, {
+		name => "SMSC EMC1046",
+		driver => "to-be-written",
+		i2c_addrs => [0x4c, 0x4d],
+		i2c_detect => sub { emc1403_detect(@_, 6); },
+	}, {
+		name => "SMSC EMC1047",
+		driver => "to-be-written",
+		i2c_addrs => [0x18],
+		i2c_detect => sub { emc1403_detect(@_, 7); },
+	}, {
 		name => "SMSC EMC1053",
 		driver => "to-be-written",	# emc1023
 		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
@@ -1215,6 +1235,26 @@
 		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
 		i2c_detect => sub { emc1023_detect(@_, 3); },
 	}, {
+		name => "SMSC EMC1072",
+		driver => "to-be-written",
+		i2c_addrs => [0x1c, 0x4c, 0x5c],
+		i2c_detect => sub { emc1403_detect(@_, 8); },
+	}, {
+		name => "SMSC EMC1073",
+		driver => "to-be-written",
+		i2c_addrs => [0x1c, 0x4c, 0x5c],
+		i2c_detect => sub { emc1403_detect(@_, 9); },
+	}, {
+		name => "SMSC EMC1074",
+		driver => "to-be-written",
+		i2c_addrs => [0x1c, 0x4c, 0x5c],
+		i2c_detect => sub { emc1403_detect(@_, 10); },
+	}, {
+		name => "SMSC EMC1402",
+		driver => "to-be-written",
+		i2c_addrs => [0x18, 0x19, 0x4c, 0x4d],
+		i2c_detect => sub { emc1403_detect(@_, 11); },
+	}, {
 		name => "SMSC EMC1403",
 		driver => "emc1403",
 		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
@@ -1230,6 +1270,11 @@
 		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
 		i2c_detect => sub { emc1403_detect(@_, 3); },
 	}, {
+		name => "SMSC EMC1424",
+		driver => "to-be-written",
+		i2c_addrs => [0x4c],
+		i2c_detect => sub { emc1403_detect(@_, 12); },
+	}, {
 		name => "ST STTS424",
 		driver => "jc42",
 		i2c_addrs => [0x18..0x1f],
@@ -5446,7 +5491,9 @@
 	return 7;
 }
 
-# Chip to detect: 0 = EMC1403, 1 = EMC1404, 2 = EMC2103, 3 = EMC1423
+# Chip to detect: 0 = EMC1403, 1 = EMC1404, 2 = EMC2103, 3 = EMC1423,
+#	4 = EMC1002, 5 = EMC1033, 6 = EMC1046, 7 = EMC1047, 8 = EMC1072,
+#	9 = EMC1073, 10 = EMC1074, 11 = EMC1402, 12 = EMC1424
 # Registers used:
 #   0xfd: Device ID register
 #   0xfe: Vendor ID register
@@ -5460,18 +5507,45 @@
 
 	return unless $man_id = 0x5d;	# SMSC
 
-	if ($chip = 0) {
+	if ($chip = 0) {		# EMC1403
 		return unless $dev_id = 0x21;
 		return unless $rev = 0x01;
-	} elsif ($chip = 1) {
+	} elsif ($chip = 1) {		# EMC1404
 		return unless $dev_id = 0x25;
 		return unless $rev = 0x01;
-	} elsif ($chip = 2) {
+	} elsif ($chip = 2) {		# EMC2103
 		return unless ($dev_id = 0x24) || ($dev_id = 0x26);
 		return unless $rev = 0x01;
-	} elsif ($chip = 3) {
+	} elsif ($chip = 3) {		# EMC1423
 		return unless $dev_id = 0x23;
 		return unless $rev = 0x01;
+	} elsif ($chip = 4) {		# EMC1002
+		return unless ($dev_id = 0x02) || ($dev_id = 0x03);
+		return unless $rev = 0x01;
+	} elsif ($chip = 5) {		# EMC1033
+		return unless ($dev_id = 0x0a) || ($dev_id = 0x0b);
+		return unless $rev = 0x01;
+	} elsif ($chip = 6) {		# EMC1046
+		return unless $dev_id = 0x1a;
+		return unless $rev = 0x01;
+	} elsif ($chip = 7) {		# EMC1047
+		return unless $dev_id = 0x1c;
+		return unless $rev = 0x01;
+	} elsif ($chip = 8) {		# EMC1072
+		return unless $dev_id = 0x20;
+		return unless $rev = 0x03;
+	} elsif ($chip = 9) {		# EMC1073
+		return unless $dev_id = 0x21;
+		return unless $rev = 0x03;
+	} elsif ($chip = 10) {		# EMC1074
+		return unless $dev_id = 0x25;
+		return unless $rev = 0x03;
+	} elsif ($chip = 11) {		# EMC1402
+		return unless $dev_id = 0x20;
+		return unless $rev = 0x01;
+	} elsif ($chip = 12) {		# EMC1424
+		return unless $dev_id = 0x27;
+		return unless $rev = 0x01;
 	}
 
 	return 6;
Index: CHANGES
=================================--- CHANGES	(revision 5913)
+++ CHANGES	(working copy)
@@ -20,8 +20,10 @@
                   Add detection of the ITE IT8728F
                   Implement universal detection for coretemp (#2381)
                   Add detection of Maxim MAX6639
-                  Add detection of EMC1023, EMC1043, EMC1053, and EMC1063
+                  Add detection of SMSC EMC1023, EMC1043, EMC1053, and EMC1063
                   Add detection of Nuvoton NCT5571D, NCT5577D and NCT6776F
+                  Add detection of SMSC EMC1002, EMC1033, EMC1046, EMC1047,
+                        EMC1072, EMC1073, EMC1074, EMC1402, and EMC1424
 
 3.2.0 (2010-10-10)
   libsensors: Increase MAX_SENSORS_PER_TYPE to 24

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
