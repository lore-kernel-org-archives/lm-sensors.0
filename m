From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 17 Oct 2006 18:27:57 +0000
Subject: [lm-sensors] patch hwmon-fix-debug-messages-in-w83781d.patch added
Message-Id: <20061017182857.318F1959515@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: hwmon: Fix debug messages in w83781d

to my gregkh-2.6 tree.  Its filename is

     hwmon-fix-debug-messages-in-w83781d.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Fri Oct 13 08:03:43 2006
Date: Fri, 13 Oct 2006 17:03:42 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: hwmon: Fix debug messages in w83781d
Message-Id: <20061013170342.3742f94b.khali at linux-fr.org>

Fix debug messages in w83781d at detection time. We can't use dev_dbg()
on an i2c client's device before calling i2c_attach_client() on that
client.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 drivers/hwmon/w83781d.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- gregkh-2.6.orig/drivers/hwmon/w83781d.c
+++ gregkh-2.6/drivers/hwmon/w83781d.c
@@ -1099,7 +1099,8 @@ w83781d_detect(struct i2c_adapter *adapt
 	   bank. */
 	if (kind < 0) {
 		if (w83781d_read_value(client, W83781D_REG_CONFIG) & 0x80) {
-			dev_dbg(dev, "Detection failed at step 3\n");
+			dev_dbg(&adapter->dev, "Detection of w83781d chip "
+				"failed at step 3\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1109,7 +1110,8 @@ w83781d_detect(struct i2c_adapter *adapt
 		if ((!(val1 & 0x07)) &&
 		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
-			dev_dbg(dev, "Detection failed at step 4\n");
+			dev_dbg(&adapter->dev, "Detection of w83781d chip "
+				"failed at step 4\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1119,7 +1121,8 @@ w83781d_detect(struct i2c_adapter *adapt
 				  ((val1 & 0x80) && (val2 = 0x5c)))) {
 			if (w83781d_read_value
 			    (client, W83781D_REG_I2C_ADDR) != address) {
-				dev_dbg(dev, "Detection failed at step 5\n");
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 5\n");
 				err = -ENODEV;
 				goto ERROR2;
 			}
@@ -1141,8 +1144,8 @@ w83781d_detect(struct i2c_adapter *adapt
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
@@ -1161,10 +1164,9 @@ w83781d_detect(struct i2c_adapter *adapt
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


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-documentation-typos.patch
i2c/hwmon-k8temp-documentation-update.patch
i2c/hwmon-smsc47m112-documentation.patch
i2c/hwmon-unchecked-return-status-fixes-w83791d.patch
i2c/hwmon-update-Grant-Coady-email-address.patch
i2c/hwmon-w83627ehf-fix-fan5-detection.patch
i2c/i2c-scx200_acb-handle-pci-errors.patch
i2c/hwmon-fix-debug-messages-in-w83781d.patch
i2c/hwmon-let-w83781d-and-lm78-load-again.patch
driver-class/i2c-dev-device.patch
driver-class/i2c-dev-device.old.patch

