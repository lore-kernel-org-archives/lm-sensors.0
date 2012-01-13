From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 09:13:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm63) LM64 has a dedicated pin for tachometer
Message-Id: <20120113101321.366a6f35@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On the LM64, the tachometer function has a dedicated pin and fan speed
monitoring is always enabled.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm63 |    4 +++-
 drivers/hwmon/lm63.c     |    3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

--- linux-3.3-rc0.orig/Documentation/hwmon/lm63	2012-01-13 09:09:25.000000000 +0100
+++ linux-3.3-rc0/Documentation/hwmon/lm63	2012-01-13 09:54:38.000000000 +0100
@@ -54,7 +54,9 @@ value for measuring the speed of the fan
 Note that the pin used for fan monitoring is shared with an alert out
 function. Depending on how the board designer wanted to use the chip, fan
 speed monitoring will or will not be possible. The proper chip configuration
-is left to the BIOS, and the driver will blindly trust it.
+is left to the BIOS, and the driver will blindly trust it. Only the original
+LM63 suffers from this limitation, the LM64 and LM96163 have separate pins
+for fan monitoring and alert out.
 
 A PWM output can be used to control the speed of the fan. The LM63 has two
 PWM modes: manual and automatic. Automatic mode is not fully implemented yet
--- linux-3.3-rc0.orig/drivers/hwmon/lm63.c	2012-01-13 09:33:23.000000000 +0100
+++ linux-3.3-rc0/drivers/hwmon/lm63.c	2012-01-13 09:53:19.000000000 +0100
@@ -745,7 +745,8 @@ static int lm63_probe(struct i2c_client
 	err = sysfs_create_group(&new_client->dev.kobj, &lm63_group);
 	if (err)
 		goto exit_free;
-	if (data->config & 0x04) { /* tachometer enabled */
+	if (data->kind = lm64 ||	/* tachometer has dedicated pin */
+	    (data->config & 0x04)) {	/* tachometer enabled */
 		err = sysfs_create_group(&new_client->dev.kobj,
 					 &lm63_group_fan1);
 		if (err)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
