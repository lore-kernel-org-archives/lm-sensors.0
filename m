From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: [PATCH 2.6] I2C: Cleanup lm78 init
Message-Id: <20040921211054.3dc36a26.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch cleans the init part of the lm78 driver.

* Do not reset the chip.

* Get rid of useless code, which was accidentally left in when we
removed the limit initialization from the driver.

* Do not enable monitoring if it is already enabled (it wouldn't hurt,
but since we can avoid it at no cost...)

Similar changes were applied to the Linux 2.4 driver, which I
successfully tested on my own LM78 chip.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.9-rc2/drivers/i2c/chips/lm78.c.orig	2004-09-15 20:41:49.000000000 +0200
+++ linux-2.6.9-rc2/drivers/i2c/chips/lm78.c	2004-09-20 19:52:06.000000000 +0200
@@ -692,26 +692,12 @@
 /* Called when we have found a new LM78. It should set limits, etc. */
 static void lm78_init_client(struct i2c_client *client)
 {
-	struct lm78_data *data = i2c_get_clientdata(client);
-	int vid;
-
-	/* Reset all except Watchdog values and last conversion values
-	   This sets fan-divs to 2, among others */
-	lm78_write_value(client, LM78_REG_CONFIG, 0x80);
-
-	vid = lm78_read_value(client, LM78_REG_VID_FANDIV) & 0x0f;
-	if (data->type = lm79)
-		vid |-		    (lm78_read_value(client, LM78_REG_CHIPID) & 0x01) << 4;
-	else
-		vid |= 0x10;
-	vid = VID_FROM_REG(vid);
+	u8 config = lm78_read_value(client, LM78_REG_CONFIG);
 
 	/* Start monitoring */
-	lm78_write_value(client, LM78_REG_CONFIG,
-			 (lm78_read_value(client, LM78_REG_CONFIG) & 0xf7)
-			 | 0x01);
-
+	if (!(config & 0x01))
+		lm78_write_value(client, LM78_REG_CONFIG,
+				 (config & 0xf7) | 0x01);
 }
 
 static struct lm78_data *lm78_update_device(struct device *dev)


-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
