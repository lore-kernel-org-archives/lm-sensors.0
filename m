From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: [PATCH 2.6] I2C: Enable w83781d and w83627hf temperature channels
Message-Id: <20050127211136.7345e443.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

The chips supported by the w83781d and w83627hf drivers might come up
with their temperature channels disabled. Currently, the w83781d driver
does so for temp3 but omits temp2, while the w83627hf driver omits both.
The following patch fixes that, and prints warning messages when the
driver has to enable the channels (normally the BIOS should do it for
us). We also skip this initialization step for the AS99127F chips, for
which we have no documentation.

This should hopefully solve the problem reported here:
http://archives.andrew.net.au/lm-sensors/msg29150.html

Thanks,

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.11-rc2/drivers/i2c/chips/w83781d.c.orig	2005-01-26 22:38:49.000000000 +0100
+++ linux-2.6.11-rc2/drivers/i2c/chips/w83781d.c	2005-01-27 19:57:04.000000000 +0100
@@ -1562,11 +1562,28 @@
 	}
 #endif				/* W83781D_RT */
 
-	if (init) {
+	if (init && type != as99127f) {
+		/* Enable temp2 */
+		tmp = w83781d_read_value(client, W83781D_REG_TEMP2_CONFIG);
+		if (tmp & 0x01) {
+			dev_warn(&client->dev, "Enabling temp2, readings "
+				 "might not make sense\n");
+			w83781d_write_value(client, W83781D_REG_TEMP2_CONFIG,
+				tmp & 0xfe);
+		}
+
+		/* Enable temp3 */
 		if (type != w83783s && type != w83697hf) {
-			w83781d_write_value(client, W83781D_REG_TEMP3_CONFIG,
-					    0x00);
+			tmp = w83781d_read_value(client,
+				W83781D_REG_TEMP3_CONFIG);
+			if (tmp & 0x01) {
+				dev_warn(&client->dev, "Enabling temp3, "
+					 "readings might not make sense\n");
+				w83781d_write_value(client,
+					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
+			}
 		}
+
 		if (type != w83781d) {
 			/* enable comparator mode for temp2 and temp3 so
 			   alarm indication will work correctly */

--- linux-2.6.11-rc2/drivers/i2c/chips/w83627hf.c.orig	2005-01-22 15:08:51.000000000 +0100
+++ linux-2.6.11-rc2/drivers/i2c/chips/w83627hf.c	2005-01-27 20:06:01.000000000 +0100
@@ -1321,6 +1321,27 @@
 	data->pwmenable[2] = 1;
 
 	if(init) {
+		/* Enable temp2 */
+		tmp = w83627hf_read_value(client, W83781D_REG_TEMP2_CONFIG);
+		if (tmp & 0x01) {
+			dev_warn(&client->dev, "Enabling temp2, readings "
+				 "might not make sense\n");
+			w83627hf_write_value(client, W83781D_REG_TEMP2_CONFIG,
+				tmp & 0xfe);
+		}
+
+		/* Enable temp3 */
+		if (type != w83697hf) {
+			tmp = w83627hf_read_value(client,
+				W83781D_REG_TEMP3_CONFIG);
+			if (tmp & 0x01) {
+				dev_warn(&client->dev, "Enabling temp3, "
+					 "readings might not make sense\n");
+				w83627hf_write_value(client,
+					W83781D_REG_TEMP3_CONFIG, tmp & 0xfe);
+			}
+		}
+
 		if (type = w83627hf) {
 			/* enable PWM2 control (can't hurt since PWM reg
 		           should have been reset to 0xff) */

-- 
Jean Delvare
http://khali.linux-fr.org/
