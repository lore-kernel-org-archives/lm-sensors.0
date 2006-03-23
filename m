From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 15:38:21 +0000
Subject: [lm-sensors] [PATCH 05/10] w83792d: Be quiet on misdetection
Message-Id: <20060323163821.074148b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-w83792d-quiet-on-misdetection.patch

Make the w83792d driver keep quiet when misdetecting a chip. This can
happen, and the user doesn't need to know.

Also renumber the messages, and add one, for consistency.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/w83792d.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.16-rc6.orig/drivers/hwmon/w83792d.c	2006-03-13 21:41:04.000000000 +0100
+++ linux-2.6.16-rc6/drivers/hwmon/w83792d.c	2006-03-14 19:29:04.000000000 +0100
@@ -1161,7 +1161,7 @@
 	   bank. */
 	if (kind < 0) {
 		if (w83792d_read_value(client, W83792D_REG_CONFIG) & 0x80) {
-			dev_warn(dev, "Detection failed at step 3\n");
+			dev_dbg(dev, "Detection failed at step 1\n");
 			goto ERROR1;
 		}
 		val1 = w83792d_read_value(client, W83792D_REG_BANK);
@@ -1170,6 +1170,7 @@
 		if (!(val1 & 0x07)) {  /* is Bank0 */
 			if (((!(val1 & 0x80)) && (val2 != 0xa3)) ||
 			     ((val1 & 0x80) && (val2 != 0x5c))) {
+				dev_dbg(dev, "Detection failed at step 2\n");
 				goto ERROR1;
 			}
 		}
@@ -1177,7 +1178,7 @@
 		   should match */
 		if (w83792d_read_value(client,
 					W83792D_REG_I2C_ADDR) != address) {
-			dev_warn(dev, "Detection failed at step 5\n");
+			dev_dbg(dev, "Detection failed at step 3\n");
 			goto ERROR1;
 		}
 	}

-- 
Jean Delvare

