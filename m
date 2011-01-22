From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 22 Jan 2011 17:14:37 +0000
Subject: [lm-sensors] [PATCH v2] sensors-detect: Add code to detect emc1023,
Message-Id: <20110122171437.GA21444@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds support for emc1023, emc1043, emc1053, and emc1063 to sensors-detect.
It is based on the emc1023 detection code written by Anish Patel, but supports additional chips
and is at the same time more restrictive.

v2: Use capitals for device names, simplify revision number validation
--
Index: prog/detect/sensors-detect
=================================--- prog/detect/sensors-detect	(revision 5907)
+++ prog/detect/sensors-detect	(working copy)
@@ -1195,6 +1195,26 @@
 		i2c_addrs => [0x2f],
 		i2c_detect => sub { fintek_detect(@_, 7); },
 	}, {
+		name => "SMSC EMC1023",
+		driver => "to-be-written",	# emc1023
+		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
+		i2c_detect => sub { emc1023_detect(@_, 0); },
+	}, {
+		name => "SMSC EMC1043",
+		driver => "to-be-written",	# emc1023
+		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
+		i2c_detect => sub { emc1023_detect(@_, 1); },
+	}, {
+		name => "SMSC EMC1053",
+		driver => "to-be-written",	# emc1023
+		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
+		i2c_detect => sub { emc1023_detect(@_, 2); },
+	}, {
+		name => "SMSC EMC1063",
+		driver => "to-be-written",	# emc1023
+		i2c_addrs => [0x48, 0x49, 0x4c, 0x4d],
+		i2c_detect => sub { emc1023_detect(@_, 3); },
+	}, {
 		name => "SMSC EMC1403",
 		driver => "emc1403",
 		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
@@ -5372,6 +5392,48 @@
 	return 7;
 }
 
+# Chips to detect: 0 = EMC1023, 1 = EMC1043, 2 = EMC1053, 3 = EMC1063
+# Registers used:
+#   0xed: Device ID register
+#   0xfe: Vendor ID register
+#   0xff: Revision register
+sub emc1023_detect
+{
+	my ($file, $addr, $chip) = @_;
+	my $dev_id = i2c_smbus_read_byte_data($file, 0xed);
+	my $man_id = i2c_smbus_read_byte_data($file, 0xfe);
+	my $rev = i2c_smbus_read_byte_data($file, 0xff);
+
+	return unless $man_id = 0x5d;  # SMSC
+	return unless $rev <= 1;
+
+	if ($chip = 0) {
+		return if ($addr = 0x4c) && ($dev_id != 0x04);	# EMC1023-1
+		return if ($addr = 0x4d) && ($dev_id != 0x05);	# EMC1023-2
+		return if ($addr = 0x48) && ($dev_id != 0x06);	# EMC1023-3
+		return if ($addr = 0x49) && ($dev_id != 0x07);	# EMC1023-4
+	} elsif ($chip = 1) {
+		if ($addr = 0x4c) {				# EMC1043-1, EMC1043-5
+			return unless ($dev_id = 0x0c) || ($dev_id = 0x2c);
+		}
+		return if ($addr = 0x4d) && ($dev_id != 0x0d);	# EMC1043-2
+		return if ($addr = 0x48) && ($dev_id != 0x0e);	# EMC1043-3
+		return if ($addr = 0x49) && ($dev_id != 0x0f);	# EMC1043-4
+	} elsif ($chip = 2) {
+		return if ($addr = 0x4c) && ($dev_id != 0x3c);	# EMC1053-1
+		return if ($addr = 0x4d) && ($dev_id != 0x3d);	# EMC1053-2
+		return if ($addr = 0x48) && ($dev_id != 0x3e);	# EMC1053-3
+		return if ($addr = 0x49) && ($dev_id != 0x3f);	# EMC1053-4
+	} elsif ($chip = 3) {
+		return if ($addr = 0x4c) && ($dev_id != 0x30);	# EMC1063-1
+		return if ($addr = 0x4d) && ($dev_id != 0x31);	# EMC1063-2
+		return if ($addr = 0x48) && ($dev_id != 0x32);	# EMC1063-3
+		return if ($addr = 0x49) && ($dev_id != 0x33);	# EMC1063-4
+	}
+
+	return 7;
+}
+
 # Chip to detect: 0 = EMC1403, 1 = EMC1404, 2 = EMC2103, 3 = EMC1423
 # Registers used:
 #   0xfd: Device ID register

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
