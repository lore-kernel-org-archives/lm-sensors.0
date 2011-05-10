From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Tue, 10 May 2011 14:21:28 +0000
Subject: [lm-sensors] [PATCH] Document existing support for SMSC EMC2300 fan
Message-Id: <1305037288-16695-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The recently added support for EMC6D103S also supports EMC2300.
These two devices report exactly the same revision/stepping
register, so it's not possible to tell them apart.

EMC2300 doesn't have all the voltage inputs that EMC6D103S has,
so reports in0, in3 and in4 all as zero.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 Documentation/hwmon/lm85 |   10 +++++++++-
 drivers/hwmon/lm85.c     |    2 ++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/Documentation/hwmon/lm85 b/Documentation/hwmon/lm85
index 7c49fea..04cc342 100644
--- a/Documentation/hwmon/lm85
+++ b/Documentation/hwmon/lm85
@@ -34,6 +34,10 @@ Supported chips:
     Prefix: 'emc6d103s'
     Addresses scanned: I2C 0x2c, 0x2d, 0x2e
     Datasheet: http://www.smsc.com/main/catalog/emc6d103s.html
+  * SMSC EMC2300
+    Prefix: 'emc6d103s'
+    Addresses scanned: I2C 0x2c, 0x2d, 0x2e
+    Datasheet: http://www.smsc.com/media/Downloads_Public/Data_Sheets/2300.pdf
 
 Authors:
         Philip Pokorny <ppokorny@penguincomputing.com>,
@@ -47,7 +51,7 @@ Description
 
 This driver implements support for the National Semiconductor LM85 and
 compatible chips including the Analog Devices ADM1027, ADT7463, ADT7468 and
-SMSC EMC6D10x chips family.
+SMSC EMC6D10x and EMC2300 chips family.
 
 The LM85 uses the 2-wire interface compatible with the SMBUS 2.0
 specification. Using an analog to digital converter it measures three (3)
@@ -136,6 +140,10 @@ of voltage and temperature channels.
 SMSC EMC6D103S is similar to EMC6D103, but does not support pwm#_auto_pwm_minctl
 and temp#_auto_temp_off.
 
+SMSC EMC2300 is similar to EMC6D103S, with fewer voltage inputs.
+Unfortunately it is not possible to distinguish between these two on a register
+level so EMC2300's voltage inputs in0, in3 and in4 will read zero.
+
 Hardware Configurations
 -----------------------
 
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index da72dc1..4b89b70 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1260,6 +1260,8 @@ static int lm85_detect(struct i2c_client *client, struct i2c_board_info *info)
 			type_name = "emc6d103";
 			break;
 		case LM85_VERSTEP_EMC6D103S:
+			/* Note: this also matches EMC2300, we can't tell
+			 * the difference between the two */
 			type_name = "emc6d103s";
 			break;
 		}
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
