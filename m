From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: [PATCH 2.6] I2C: Fix bogus bitmask in lm63 debug message
Message-Id: <20050112203123.38105157.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

There is a bitmask error in one debug message of my lm63 chip driver.
Nothing critical but still worth fixing, hence comes a patch.

Credits go to Mohan Mistry for finding the error.

Please apply,
thanks.

Signed-off-by: Jean Delvare

--- linux-2.6.11-rc1/drivers/i2c/chips/lm63.c.orig	2004-12-24 22:35:49.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/lm63.c	2005-01-12 20:23:54.000000000 +0100
@@ -464,8 +464,8 @@
 		(data->config & 0x04) ? "tachometer input" :
 		"alert output");
 	dev_dbg(&client->dev, "PWM clock %s kHz, output frequency %u Hz\n",
-		(data->config_fan & 0x04) ? "1.4" : "360",
-		((data->config_fan & 0x04) ? 700 : 180000) / data->pwm1_freq);
+		(data->config_fan & 0x08) ? "1.4" : "360",
+		((data->config_fan & 0x08) ? 700 : 180000) / data->pwm1_freq);
 	dev_dbg(&client->dev, "PWM output active %s, %s mode\n",
 		(data->config_fan & 0x10) ? "low" : "high",
 		(data->config_fan & 0x20) ? "manual" : "auto");


-- 
Jean Delvare
http://khali.linux-fr.org/
