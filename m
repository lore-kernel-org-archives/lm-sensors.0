From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Sun, 06 Jun 2010 17:32:12 +0000
Subject: [lm-sensors] [PATCH] Add detection of SMSC EMC2103 to sensors-detect
Message-Id: <1275845532-19395-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch allows the sensors-detect script to detect the SMSC
EMC2103 family of temperature sensors and fan controllers.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 prog/detect/sensors-detect |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index e7f5ab2..9ffaf98 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -1130,6 +1130,11 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x2c..0x2e],
 		i2c_detect => sub { dme1737_detect(@_, 2); },
 	}, {
+		name => "SMSC EMC2103",
+		driver => "emc2103",
+		i2c_addrs => [0x2e],
+		i2c_detect => sub { emc1403_detect(@_, 2); },
+	}, {
 		name => "Fintek F75121R/F75122R/RG (VID+GPIO)",
 		driver => "to-be-written",
 		i2c_addrs => [0x4e], # 0x37 not probed
@@ -5143,7 +5148,7 @@ sub fintek_detect
 	return 7;
 }
 
-# Chip to detect: 0 = EMC1403, 1 = EMC1404
+# Chip to detect: 0 = EMC1403, 1 = EMC1404, 2 = EMC2103
 # Registers used:
 #   0xfd: Device ID register
 #   0xfe: Vendor ID register
@@ -5163,6 +5168,9 @@ sub emc1403_detect
 	} elsif ($chip = 1) {
 		return unless $dev_id = 0x25;
 		return unless $rev = 0x01;
+	} elsif ($chip = 2) {
+		return unless ($dev_id = 0x24) || ($dev_id = 0x26);
+		return unless $rev = 0x01;
 	}
 
 	return 6;
-- 
1.7.0.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
