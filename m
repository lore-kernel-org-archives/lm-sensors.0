From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Jan 2012 13:12:00 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (lm63) LM64 has a dedicated pin for tachometer
Message-Id: <20120113141200.481b3fa2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On the LM64, the tachometer function has a dedicated pin and fan speed
monitoring is always enabled.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Changes in v2:
* Fake the tachometer enable config bit on LM64.
* Improve documentation.

 Documentation/hwmon/lm63 |    5 ++++-
 drivers/hwmon/lm63.c     |   10 +++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

--- linux-3.3-rc0.orig/Documentation/hwmon/lm63	2012-01-13 14:07:41.000000000 +0100
+++ linux-3.3-rc0/Documentation/hwmon/lm63	2012-01-13 14:07:43.000000000 +0100
@@ -54,7 +54,10 @@ value for measuring the speed of the fan
 Note that the pin used for fan monitoring is shared with an alert out
 function. Depending on how the board designer wanted to use the chip, fan
 speed monitoring will or will not be possible. The proper chip configuration
-is left to the BIOS, and the driver will blindly trust it.
+is left to the BIOS, and the driver will blindly trust it. Only the original
+LM63 suffers from this limitation, the LM64 and LM96163 have separate pins
+for fan monitoring and alert out. On the LM64, monitoring is always enabled;
+on the LM96163 it can be disabled.
 
 A PWM output can be used to control the speed of the fan. The LM63 has two
 PWM modes: manual and automatic. Automatic mode is not fully implemented yet
--- linux-3.3-rc0.orig/drivers/hwmon/lm63.c	2012-01-13 14:07:41.000000000 +0100
+++ linux-3.3-rc0/drivers/hwmon/lm63.c	2012-01-13 14:07:43.000000000 +0100
@@ -796,6 +796,9 @@ static void lm63_init_client(struct i2c_
 		i2c_smbus_write_byte_data(client, LM63_REG_CONFIG1,
 					  data->config);
 	}
+	/* Tachometer is always enabled on LM64 */
+	if (data->kind = lm64)
+		data->config |= 0x04;
 
 	/* We may need pwm1_freq before ever updating the client data */
 	data->pwm1_freq = i2c_smbus_read_byte_data(client, LM63_REG_PWM_FREQ);
@@ -836,9 +839,10 @@ static void lm63_init_client(struct i2c_
 	}
 
 	/* Show some debug info about the LM63 configuration */
-	dev_dbg(&client->dev, "Alert/tach pin configured for %s\n",
-		(data->config & 0x04) ? "tachometer input" :
-		"alert output");
+	if (data->kind = lm63)
+		dev_dbg(&client->dev, "Alert/tach pin configured for %s\n",
+			(data->config & 0x04) ? "tachometer input" :
+			"alert output");
 	dev_dbg(&client->dev, "PWM clock %s kHz, output frequency %u Hz\n",
 		(data->config_fan & 0x08) ? "1.4" : "360",
 		((data->config_fan & 0x08) ? 700 : 180000) / data->pwm1_freq);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
