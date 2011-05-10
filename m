From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Tue, 10 May 2011 14:29:26 +0000
Subject: [lm-sensors] [PATCH] Add detection of EMC2300 to sensors-detect
Message-Id: <1305037766-17323-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

EMC2300 is already detected, but is reported as EMC6D103S.  These
two are register compatible and it's not actually possible to
distinguish between them by registers so this patch changes the
sensors-detect script to report it's found "EMC6D103S or EMC2300".

Both are supported by the same lm85 driver, so this patch makes
it more obvious to anyone grepping the source that EMC2300 is
supported.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 prog/detect/sensors-detect |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
index 96f7e04..c525e69 100755
--- a/prog/detect/sensors-detect
+++ b/prog/detect/sensors-detect
@@ -557,7 +557,7 @@ use vars qw(@i2c_adapter_names);
 		i2c_addrs => [0x2c..0x2e],
 		i2c_detect => sub { lm85_detect(@_, 6); },
 	}, {
-		name => "SMSC EMC6D103S",
+		name => "SMSC EMC6D103S or EMC2300",
 		driver => "lm85",
 		i2c_addrs => [0x2c..0x2e],
 		i2c_detect => sub { lm85_detect(@_, 8); },
@@ -4857,7 +4857,7 @@ sub andigilog_aSC7511_detect
 
 # Chip to detect: 0 = LM85, 1 = LM96000, 2 = ADM1027, 3 = ADT7463,
 #		  4 = EMC6D100/101, 5 = EMC6D102, 6 = EMC6D103,
-#		  7 = WPCD377I (no sensors), 8 = EMC6D103S
+#		  7 = WPCD377I (no sensors), 8 = EMC6D103S/EMC2300
 # Registers used:
 #   0x3e: Vendor register
 #   0x3d: Device ID register (Analog Devices only)
@@ -4896,7 +4896,7 @@ sub lm85_detect
 		       && $verstep != 0x69;	# EMC6D103 A1
 	} elsif ($chip = 8) {
 		return if $vendor != 0x5c;	# SMSC
-		return if $verstep != 0x6a;	# EMC6D103S
+		return if $verstep != 0x6a;	# EMC6D103S/EMC2300
 	}
 
 	if ($vendor = 0x41) {			# Analog Devices
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
