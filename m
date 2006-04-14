From: greg@kroah.com (Greg KH)
Date: Fri, 14 Apr 2006 20:10:47 +0000
Subject: [lm-sensors] [PATCH 3/5] w83792d: Be quiet on misdetection
Message-Id: <11450454472880-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Make the w83792d driver keep quiet when misdetecting a chip. This can
happen, and the user doesn't need to know.

Also renumber the messages, and add one, for consistency.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---

 drivers/hwmon/w83792d.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

ac987c1f65cedd98d953e14ba219db2f8cc009d4
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
index 6865c64..958602e 100644
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -1161,7 +1161,7 @@ w83792d_detect(struct i2c_adapter *adapt
 	   bank. */
 	if (kind < 0) {
 		if (w83792d_read_value(client, W83792D_REG_CONFIG) & 0x80) {
-			dev_warn(dev, "Detection failed at step 3\n");
+			dev_dbg(dev, "Detection failed at step 1\n");
 			goto ERROR1;
 		}
 		val1 = w83792d_read_value(client, W83792D_REG_BANK);
@@ -1170,6 +1170,7 @@ w83792d_detect(struct i2c_adapter *adapt
 		if (!(val1 & 0x07)) {  /* is Bank0 */
 			if (((!(val1 & 0x80)) && (val2 != 0xa3)) ||
 			     ((val1 & 0x80) && (val2 != 0x5c))) {
+				dev_dbg(dev, "Detection failed at step 2\n");
 				goto ERROR1;
 			}
 		}
@@ -1177,7 +1178,7 @@ w83792d_detect(struct i2c_adapter *adapt
 		   should match */
 		if (w83792d_read_value(client,
 					W83792D_REG_I2C_ADDR) != address) {
-			dev_warn(dev, "Detection failed at step 5\n");
+			dev_dbg(dev, "Detection failed at step 3\n");
 			goto ERROR1;
 		}
 	}
-- 
1.2.6



