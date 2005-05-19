From: stefan@desire.ch (Stefan Ott)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: [patch] fix for fscpos voltage values
Message-Id: <20050120190831.GO26072@desire.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050120181851.GN26072@desire.ch>
In-Reply-To: <20050120181851.GN26072@desire.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Multiplied the voltage multipliers by 10 in order to comply with the sysfs
guidelines.

Signed-off-by: Stefan Ott <stefan@desire.ch>

diff -Nru linux-2.6.11-rc1-yesterday/drivers/i2c/chips/fscpos.c linux-2.6.11-rc1/drivers/i2c/chips/fscpos.c
--- linux-2.6.11-rc1-yesterday/drivers/i2c/chips/fscpos.c	2005-01-20 19:57:26.000000000 +0100
+++ linux-2.6.11-rc1/drivers/i2c/chips/fscpos.c	2005-01-20 19:28:37.000000000 +0100
@@ -244,19 +244,19 @@
 static ssize_t show_volt_12(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 1420));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 14200));
 }
 
 static ssize_t show_volt_5(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 660));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 6600));
 }
 
 static ssize_t show_volt_batt(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 330));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 3300));
 }
 
 /* Watchdog */
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050120/feeb8b06/attachment.bin
