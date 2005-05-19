From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [PATCH 2.6] I2C: Improve VID code for the W83627THF
Message-Id: <20041226153638.122ba238.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch cleans up and improves the VID pins value retrieval for the
W83627THF chip in the w83627hf driver. Tested successfully by Mark
Hoffman. The previous code was using an unrelated lock and reading
register values it didn't need. The new code supports 6-bit VID values
(as defined by Intel VRM 10), and also ensures that the GPIO pins are
possibly used as VID inputs.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c.orig	2004-12-19 12:55:31.000000000 +0100
+++ linux-2.6.10-rc3/drivers/i2c/chips/w83627hf.c	2004-12-19 13:57:59.000000000 +0100
@@ -90,9 +90,9 @@
 
 #define	DEVID	0x20	/* Register: Device ID */
 
+#define W83627THF_GPIO5_EN	0x30 /* w83627thf only */
 #define W83627THF_GPIO5_IOSR	0xf3 /* w83627thf only */
 #define W83627THF_GPIO5_DR	0xf4 /* w83627thf only */
-#define W83627THF_GPIO5_INVR	0xf5 /* w83627thf only */
 
 static inline void
 superio_outb(int reg, int val)
@@ -1190,16 +1190,31 @@
 
 static int w83627thf_read_gpio5(struct i2c_client *client)
 {
-	struct w83627hf_data *data = i2c_get_clientdata(client);
-	int res, inv;
+	int res = 0xff, sel;
 
-	down(&data->lock);
 	superio_enter();
 	superio_select(W83627HF_LD_GPIO5);
-	res = superio_inb(W83627THF_GPIO5_DR);
-	inv = superio_inb(W83627THF_GPIO5_INVR);
+
+	/* Make sure these GPIO pins are enabled */
+	if (!(superio_inb(W83627THF_GPIO5_EN) & (1<<3))) {
+		dev_dbg(&client->dev, "GPIO5 disabled, no VID function\n");
+		goto exit;
+	}
+
+	/* Make sure the pins are configured for input
+	   There must be at least five (VRM 9), and possibly 6 (VRM 10) */
+	sel = superio_inb(W83627THF_GPIO5_IOSR);
+	if ((sel & 0x1f) != 0x1f) {
+		dev_dbg(&client->dev, "GPIO5 not configured for VID "
+			"function\n");
+		goto exit;
+	}
+
+	dev_info(&client->dev, "Reading VID from GPIO5\n");
+	res = superio_inb(W83627THF_GPIO5_DR) & sel;
+
+exit:
 	superio_exit();
-	up(&data->lock);
 	return res;
 }
 
@@ -1272,7 +1287,7 @@
 		int hi = w83627hf_read_value(client, W83781D_REG_CHIPID);
 		data->vid = (lo & 0x0f) | ((hi & 0x01) << 4);
 	} else if (w83627thf = data->type) {
-		data->vid = w83627thf_read_gpio5(client) & 0x1f;
+		data->vid = w83627thf_read_gpio5(client) & 0x3f;
 	}
 
 	/* Read VRM & OVT Config only once */


-- 
Jean Delvare
http://khali.linux-fr.org/
