From: stigge@antcom.de
Date: Sat, 29 Jan 2011 16:04:01 +0000
Subject: [lm-sensors] [PATCH] max6639.c: Set reasonable default PWM frequency
Message-Id: <1296317041-28718-1-git-send-email-stigge@antcom.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

max6639.c: Set reasonable default PWM frequency

This patch initializes register CONFIG3 to a reasonable default PWM frequency
of 25kHz, to prevent audible sound in fan.

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
index 40fd878..f20d997 100644
--- a/drivers/hwmon/max6639.c
+++ b/drivers/hwmon/max6639.c
@@ -64,9 +64,12 @@ static unsigned short normal_i2c[] = { 0x2c, 0x2e, 0x2f, I2C_CLIENT_END };
 #define MAX6639_GCONFIG_POR			0x40
 #define MAX6639_GCONFIG_DISABLE_TIMEOUT		0x20
 #define MAX6639_GCONFIG_CH2_LOCAL		0x10
+#define MAX6639_GCONFIG_PWM_FREQ_HI		0x08
 
 #define MAX6639_FAN_CONFIG1_PWM			0x80
 
+#define MAX6639_FAN_CONFIG3_THERM_FULL_SPEED	0x40
+
 static const int rpm_ranges[] = { 2000, 4000, 8000, 16000 };
 
 #define FAN_FROM_REG(val, div, rpm_range)	((val) = 0 ? -1 : \
@@ -430,7 +433,7 @@ static int max6639_init_client(struct i2c_client *client)
 	int rpm_range = 1; /* default: 4000 RPM */
 	int err = 0;
 
-	/* Reset chip to default values */
+	/* Reset chip to default values, see below for GCONFIG setup */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
 				  MAX6639_GCONFIG_POR);
 	if (err)
@@ -472,6 +475,16 @@ static int max6639_init_client(struct i2c_client *client)
 		if (err)
 			goto exit;
 
+		/*
+		 * /THERM full speed enable,
+		 * PWM frequency 25kHz, see also GCONFIG below
+		 */
+		err = i2c_smbus_write_byte_data(client,
+			MAX6639_REG_FAN_CONFIG3(i),
+			MAX6639_FAN_CONFIG3_THERM_FULL_SPEED | 0x03);
+		if (err)
+			goto exit;
+
 		/* Max. temp. 80C/90C/100C */
 		data->temp_therm[i] = 80;
 		data->temp_alert[i] = 90;
@@ -500,7 +513,8 @@ static int max6639_init_client(struct i2c_client *client)
 	}
 	/* Start monitoring */
 	err = i2c_smbus_write_byte_data(client, MAX6639_REG_GCONFIG,
-		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL);
+		MAX6639_GCONFIG_DISABLE_TIMEOUT | MAX6639_GCONFIG_CH2_LOCAL |
+		MAX6639_GCONFIG_PWM_FREQ_HI);
 exit:
 	return err;
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
