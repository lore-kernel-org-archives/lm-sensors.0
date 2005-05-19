From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH 2.6] Make master_xfer debug messages more useful
Message-Id: <20050308202853.2d82af32.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

While working on the recent saa7110 mess, I found that the debug message
displayed when calling master_xfer wasn't as useful as it could be. Here
is a patch improving this.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11/drivers/i2c/i2c-core.c.orig	2004-12-24 22:34:01.000000000 +0100
+++ linux-2.6.11/drivers/i2c/i2c-core.c	2005-03-08 19:06:36.000000000 +0100
@@ -588,7 +588,13 @@
 	int ret;
 
 	if (adap->algo->master_xfer) {
- 	 	dev_dbg(&adap->dev, "master_xfer: with %d msgs.\n", num);
+#ifdef DEBUG
+		for (ret = 0; ret < num; ret++) {
+			dev_dbg(&adap->dev, "master_xfer[%d] %c, addr=0x%02x, "
+				"len=%d\n", ret, msgs[ret].flags & I2C_M_RD ?
+				'R' : 'W', msgs[ret].addr, msgs[ret].len);
+		}
+#endif
 
 		down(&adap->bus_lock);
 		ret = adap->algo->master_xfer(adap,msgs,num);


-- 
Jean Delvare
