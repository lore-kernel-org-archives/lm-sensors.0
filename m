From: Frans Klaver <frans.klaver@xsens.com>
Date: Thu, 26 Jun 2014 09:21:11 +0000
Subject: [lm-sensors] [PATCH] hwmon: add support for tmp112
Message-Id: <1403774471-31497-1-git-send-email-frans.klaver@xsens.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
This is basically a resubmission of the patch created by Lothar Felten[1].

[1] lists.lm-sensors.org/pipermail/lm-sensors/2013-August/039546.html

 Documentation/hwmon/lm75 | 5 +++--
 drivers/hwmon/Kconfig    | 4 ++--
 drivers/hwmon/lm75.c     | 8 ++++++++
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
index 2560a9c..c6a5ff1 100644
--- a/Documentation/hwmon/lm75
+++ b/Documentation/hwmon/lm75
@@ -42,13 +42,14 @@ Supported chips:
     Addresses scanned: none
     Datasheet: Publicly available at the ST website
                http://www.st.com/internet/analog/product/121769.jsp
-  * Texas Instruments TMP100, TMP101, TMP105, TMP75, TMP175, TMP275
-    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp175', 'tmp75', 'tmp275'
+  * Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75, TMP175, TMP275
+    Prefixes: 'tmp100', 'tmp101', 'tmp105', 'tmp112', 'tmp175', 'tmp75', 'tmp275'
     Addresses scanned: none
     Datasheet: Publicly available at the Texas Instruments website
                http://www.ti.com/product/tmp100
                http://www.ti.com/product/tmp101
                http://www.ti.com/product/tmp105
+               http://www.ti.com/product/tmp112
                http://www.ti.com/product/tmp75
                http://www.ti.com/product/tmp175
                http://www.ti.com/product/tmp275
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 08531a1..ac7a2a2 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -882,8 +882,8 @@ config SENSORS_LM75
 		- NXP's LM75A
 		- ST Microelectronics STDS75
 		- TelCom (now Microchip) TCN75
-		- Texas Instruments TMP100, TMP101, TMP105, TMP75, TMP175,
-		  TMP275
+		- Texas Instruments TMP100, TMP101, TMP105, TMP112, TMP75,
+		  TMP175, TMP275
 
 	  This driver supports driver model based binding through board
 	  specific I2C device tables.
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 479ffbe..d16dbb3 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -52,6 +52,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	tmp100,
 	tmp101,
 	tmp105,
+	tmp112,
 	tmp175,
 	tmp275,
 	tmp75,
@@ -255,6 +256,12 @@ lm75_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		data->sample_time = HZ;
 		clr_mask |= 1 << 7;		/* not one-shot mode */
 		break;
+	case tmp112:
+		set_mask |= 3 << 5;		/* 12-bit mode */
+		clr_mask |= 1 << 7;		/* not one-shot mode */
+		data->resolution = 12;
+		data->sample_time = HZ / 4;
+		break;
 	case tmp105:
 	case tmp175:
 	case tmp275:
@@ -323,6 +330,7 @@ static const struct i2c_device_id lm75_ids[] = {
 	{ "tmp100", tmp100, },
 	{ "tmp101", tmp101, },
 	{ "tmp105", tmp105, },
+	{ "tmp112", tmp112, },
 	{ "tmp175", tmp175, },
 	{ "tmp275", tmp275, },
 	{ "tmp75", tmp75, },
-- 
1.9.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
