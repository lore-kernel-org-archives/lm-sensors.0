From: greg@kroah.com (Greg KH)
Date: Wed, 18 Oct 2006 20:09:39 +0000
Subject: [lm-sensors] [PATCH 8/8] hwmon: Fix debug messages in w83781d
Message-Id: <11612022031458-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Fix debug messages in w83781d at detection time. We can't use dev_dbg()
on an i2c client's device before calling i2c_attach_client() on that
client.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/w83781d.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
index fea9206..1232171 100644
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1099,7 +1099,8 @@ #undef REALLY_SLOW_IO
 	   bank. */
 	if (kind < 0) {
 		if (w83781d_read_value(client, W83781D_REG_CONFIG) & 0x80) {
-			dev_dbg(dev, "Detection failed at step 3\n");
+			dev_dbg(&adapter->dev, "Detection of w83781d chip "
+				"failed at step 3\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1109,7 +1110,8 @@ #undef REALLY_SLOW_IO
 		if ((!(val1 & 0x07)) &&
 		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
-			dev_dbg(dev, "Detection failed at step 4\n");
+			dev_dbg(&adapter->dev, "Detection of w83781d chip "
+				"failed at step 4\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1119,7 +1121,8 @@ #undef REALLY_SLOW_IO
 				  ((val1 & 0x80) && (val2 = 0x5c)))) {
 			if (w83781d_read_value
 			    (client, W83781D_REG_I2C_ADDR) != address) {
-				dev_dbg(dev, "Detection failed at step 5\n");
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 5\n");
 				err = -ENODEV;
 				goto ERROR2;
 			}
@@ -1141,8 +1144,8 @@ #undef REALLY_SLOW_IO
 		else if (val2 = 0x12)
 			vendid = asus;
 		else {
-			dev_dbg(dev, "Chip was made by neither "
-				"Winbond nor Asus?\n");
+			dev_dbg(&adapter->dev, "w83781d chip vendor is "
+				"neither Winbond nor Asus\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1161,10 +1164,9 @@ #undef REALLY_SLOW_IO
 			kind = as99127f;
 		else {
 			if (kind = 0)
-				dev_warn(dev, "Ignoring 'force' "
+				dev_warn(&adapter->dev, "Ignoring 'force' "
 					 "parameter for unknown chip at "
-					 "adapter %d, address 0x%02x\n",
-					 i2c_adapter_id(adapter), address);
+					 "address 0x%02x\n", address);
 			err = -EINVAL;
 			goto ERROR2;
 		}
-- 
1.4.2.4


