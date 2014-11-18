From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 18 Nov 2014 17:59:59 +0000
Subject: [lm-sensors] [PATCH 2/2] sensors-detect: EMC14xx chip updates
Message-Id: <1416333599-12717-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 CHANGES                    |  3 +++
 prog/detect/sensors-detect | 26 +++++++++++++++++---------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/CHANGES b/CHANGES
index 62cfd24..505257f 100644
--- a/CHANGES
+++ b/CHANGES
@@ -21,6 +21,9 @@ SVN HEAD
                   Show that NCT6102D/6104D/6106D are supported by nct6775 driver
                   Show that NCT5573D is compatible to NCT6776F and has the same
                   chip ID.
+                  Document support for EMC1402, EMC1404, and EMC1424.
+                  Detect new revisions of EMC14xx.
+                  Add detection of EMC1422.
 
 3.3.5 "Happy Birthday Beddy" (2014-01-22)
   libsensors: Improve documentation of two functions
diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 610338b..cfeccd0 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -1366,7 +1366,7 @@ use vars qw(@i2c_adapter_names);
 		i2c_detect => sub { emc1403_detect(@_, 10); },
 	}, {
 		name => "SMSC EMC1402",
-		driver => "to-be-written",
+		driver => "emc1403",
 		i2c_addrs => [0x18, 0x29, 0x4c, 0x4d],
 		i2c_detect => sub { emc1403_detect(@_, 11); },
 	}, {
@@ -1376,17 +1376,22 @@ use vars qw(@i2c_adapter_names);
 		i2c_detect => sub { emc1403_detect(@_, 0); },
 	}, {
 		name => "SMSC EMC1404",
-		driver => "to-be-written", # emc1403
+		driver => "emc1403",
 		i2c_addrs => [0x18, 0x29, 0x4c, 0x4d],
 		i2c_detect => sub { emc1403_detect(@_, 1); },
 	}, {
+		name => "SMSC EMC1422",
+		driver => "emc1403",
+		i2c_addrs => [0x4c],
+		i2c_detect => sub { emc1403_detect(@_, 14); },
+	}, {
 		name => "SMSC EMC1423",
 		driver => "emc1403",
 		i2c_addrs => [0x4c],
 		i2c_detect => sub { emc1403_detect(@_, 3); },
 	}, {
 		name => "SMSC EMC1424",
-		driver => "to-be-written",
+		driver => "emc1403",
 		i2c_addrs => [0x4c],
 		i2c_detect => sub { emc1403_detect(@_, 12); },
 	}, {
@@ -6117,7 +6122,7 @@ sub emc1023_detect
 # Chip to detect: 0 = EMC1403, 1 = EMC1404, 2 = EMC2103, 3 = EMC1423,
 #	4 = EMC1002, 5 = EMC1033, 6 = EMC1046, 7 = EMC1047, 8 = EMC1072,
 #	9 = EMC1073, 10 = EMC1074, 11 = EMC1402, 12 = EMC1424,
-#	13 = EMC2104
+#	13 = EMC2104, 14 = EMC1422
 # Registers used:
 #   0xfd: Device ID register
 #   0xfe: Vendor ID register
@@ -6133,16 +6138,16 @@ sub emc1403_detect
 
 	if ($chip = 0) {		# EMC1403
 		return unless $dev_id = 0x21;
-		return unless $rev = 0x01;
+		return unless $rev = 0x01 || $rev = 0x04;
 	} elsif ($chip = 1) {		# EMC1404
 		return unless $dev_id = 0x25;
-		return unless $rev = 0x01;
+		return unless $rev = 0x01 || $rev = 0x04;
 	} elsif ($chip = 2) {		# EMC2103
 		return unless ($dev_id = 0x24) || ($dev_id = 0x26);
 		return unless $rev = 0x01;
 	} elsif ($chip = 3) {		# EMC1423
 		return unless $dev_id = 0x23;
-		return unless $rev = 0x01;
+		return unless $rev = 0x01 || $rev = 0x04;
 	} elsif ($chip = 4) {		# EMC1002
 		return unless ($dev_id = 0x02) || ($dev_id = 0x03);
 		return unless $rev = 0x01;
@@ -6166,13 +6171,16 @@ sub emc1403_detect
 		return unless $rev = 0x03;
 	} elsif ($chip = 11) {		# EMC1402
 		return unless $dev_id = 0x20;
-		return unless $rev = 0x01;
+		return unless $rev = 0x01 || $rev = 0x04;
 	} elsif ($chip = 12) {		# EMC1424
 		return unless $dev_id = 0x27;
-		return unless $rev = 0x01;
+		return unless $rev = 0x01 || $rev = 0x04;
 	} elsif ($chip = 13) {		# EMC2104
 		return unless $dev_id = 0x1d;
 		return unless $rev = 0x02;
+	} elsif ($chip = 14) {		# EMC1422
+		return unless $dev_id = 0x22;
+		return unless $rev = 0x01 || $rev = 0x04;
 	}
 
 	return 6;
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
