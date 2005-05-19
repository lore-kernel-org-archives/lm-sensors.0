From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: [PATCH 2.6] More verbose debug in w83781d detection
Message-Id: <20040912115802.3c6dc0c7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Quoting myself:

> As for me, I will propose my extra-debug patch (slightly cleaned up)
> for inclusion into the 2.6 kernel. It helped us once, so it could
> prove to be valuable in the future as well.

Here is the patch. It makes the w83781d (mis)detection more verbose so
as to help debugging problems. The extra messages of course only show
when I2C chip debugging is enabled. It additionally features some code
refactoring, some CodingStyle cleanups and adds a missing white space in
one debug message.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

--- linux-2.6.9-rc1/drivers/i2c/chips/w83781d.c.orig	2004-08-25 21:53:37.000000000 +0200
+++ linux-2.6.9-rc1/drivers/i2c/chips/w83781d.c	2004-09-12 11:10:38.000000000 +0200
@@ -1062,6 +1062,9 @@
 	
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
+			dev_dbg(&adapter->dev, "Request of region "
+				"0x%x-0x%x for w83781d failed\n", address,
+				address + W83781D_EXTENT - 1);
 			err = -EBUSY;
 			goto ERROR0;
 		}
@@ -1075,15 +1078,11 @@
 			/* We need the timeouts for at least some LM78-like
 			   chips. But only if we read 'undefined' registers. */
 			i = inb_p(address + 1);
-			if (inb_p(address + 2) != i) {
-				err = -ENODEV;
-				goto ERROR1;
-			}
-			if (inb_p(address + 3) != i) {
-				err = -ENODEV;
-				goto ERROR1;
-			}
-			if (inb_p(address + 7) != i) {
+			if (inb_p(address + 2) != i
+			 || inb_p(address + 3) != i
+			 || inb_p(address + 7) != i) {
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 1\n");
 				err = -ENODEV;
 				goto ERROR1;
 			}
@@ -1092,8 +1091,13 @@
 			/* Let's just hope nothing breaks here */
 			i = inb_p(address + 5) & 0x7f;
 			outb_p(~i & 0x7f, address + 5);
-			if ((inb_p(address + 5) & 0x7f) != (~i & 0x7f)) {
+			val2 = inb_p(address + 5) & 0x7f;
+			if (val2 != (~i & 0x7f)) {
 				outb_p(i, address + 5);
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 2 (0x%x != "
+					"0x%x at 0x%x)\n", val2, ~i & 0x7f,
+					address + 5);
 				err = -ENODEV;
 				goto ERROR1;
 			}
@@ -1125,7 +1129,9 @@
 	   force_*=... parameter, and the Winbond will be reset to the right
 	   bank. */
 	if (kind < 0) {
-		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80){
+		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80) {
+			dev_dbg(&new_client->dev, "Detection failed at step "
+				"3\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1135,6 +1141,8 @@
 		if ((!(val1 & 0x07)) &&
 		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
+			dev_dbg(&new_client->dev, "Detection failed at step "
+				"4\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1144,6 +1152,8 @@
 				  ((val1 & 0x80) && (val2 = 0x5c)))) {
 			if (w83781d_read_value
 			    (new_client, W83781D_REG_I2C_ADDR) != address) {
+				dev_dbg(&new_client->dev, "Detection failed "
+					"at step 5\n");
 				err = -ENODEV;
 				goto ERROR2;
 			}
@@ -1166,6 +1176,8 @@
 		else if (val2 = 0x12)
 			vendid = asus;
 		else {
+			dev_dbg(&new_client->dev, "Chip was made by neither "
+				"Winbond nor Asus?\n");
 			err = -ENODEV;
 			goto ERROR2;
 		}
@@ -1186,10 +1198,10 @@
 			kind = w83697hf;
 		else {
 			if (kind = 0)
-				dev_warn(&new_client->dev,
-				       "Ignoring 'force' parameter for unknown chip at"
-				       "adapter %d, address 0x%02x\n",
-				       i2c_adapter_id(adapter), address);
+				dev_warn(&new_client->dev, "Ignoring 'force' "
+					 "parameter for unknown chip at "
+					 "adapter %d, address 0x%02x\n",
+					 i2c_adapter_id(adapter), address);
 			err = -EINVAL;
 			goto ERROR2;
 		}


-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
