From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <20040910231520.371a6b99.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> => /var/log/(debug|syslog) <=
> Sep 10 10:55:40 defiant kernel: i2c-core: driver w83781d registered.
> Sep 10 10:55:40 defiant kernel: i2c_adapter i2c-0: found normal isa
> entry for adapter 9191, addr 0290
> 
> I see no complaints?

Looks good, I have to admit.

I took a look at the driver, trying to figure out where it thinks your
chip should not be used. Please apply the attached patch and recompile
the driver, then repeat the tests. Hopefully this will yield more
information.

I would also appreciate the output of "isadump 0x295 0x296".

> Another odd note that I forgot.  sensors-detect seems to insist on
> checking for i2c-ali1535 module, though this is definitely the ALi
> 1543 chip.  Out of curiousity I configured, compiled and loaded the
> ali1535 module, and sensors-detect found nothing for that.  Is this
> one of those situations where boards used either chipset?  I know
> specifically for the ASUS P5A board, that it did not use the ALi 1535
> chip.  Is there a way to detect which chip is present, and not bug
> about the other?

The bug is with ALi giving the same PCI ID to both chips. This makes
them virtually undistinguishable, thus the trouble in sensors-detect. I
am not a specialist of ALi chips but I don't think anything can be done,
at least not easily. The only chance of the average user is to try both
and see what works.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
-------------- next part --------------
--- linux-2.6.8/drivers/i2c/chips/w83781d.c.orig	2004-08-24 18:42:40.000000000 +0200
+++ linux-2.6.8/drivers/i2c/chips/w83781d.c	2004-09-10 23:05:42.000000000 +0200
@@ -1064,6 +1064,9 @@
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT, "w83781d")) {
 			err = -EBUSY;
+			dev_dbg(&adapter->dev, "Request of region "
+				"0x%x-0x%x for w83781d failed\n", address,
+				address + W83781D_EXTENT - 1);
 			goto ERROR0;
 		}
 
@@ -1076,16 +1079,12 @@
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
 				err = -ENODEV;
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 1\n");
 				goto ERROR1;
 			}
 #undef REALLY_SLOW_IO
@@ -1096,6 +1095,8 @@
 			if ((inb_p(address + 5) & 0x7f) != (~i & 0x7f)) {
 				outb_p(i, address + 5);
 				err = -ENODEV;
+				dev_dbg(&adapter->dev, "Detection of w83781d "
+					"chip failed at step 2\n");
 				goto ERROR1;
 			}
 		}
@@ -1126,8 +1127,10 @@
 	   force_*=... parameter, and the Winbond will be reset to the right
 	   bank. */
 	if (kind < 0) {
-		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80){
+		if (w83781d_read_value(new_client, W83781D_REG_CONFIG) & 0x80) {
 			err = -ENODEV;
+			dev_dbg(&new_client->dev, "Detection failed at step "
+				"3\n");
 			goto ERROR2;
 		}
 		val1 = w83781d_read_value(new_client, W83781D_REG_BANK);
@@ -1137,6 +1140,8 @@
 		    (((!(val1 & 0x80)) && (val2 != 0xa3) && (val2 != 0xc3))
 		     || ((val1 & 0x80) && (val2 != 0x5c) && (val2 != 0x12)))) {
 			err = -ENODEV;
+			dev_dbg(&new_client->dev, "Detection failed at step "
+				"4\n");
 			goto ERROR2;
 		}
 		/* If Winbond SMBus, check address at 0x48.
@@ -1146,6 +1151,8 @@
 			if (w83781d_read_value
 			    (new_client, W83781D_REG_I2C_ADDR) != address) {
 				err = -ENODEV;
+				dev_dbg(&new_client->dev, "Detection failed "
+					"at step 5\n");
 				goto ERROR2;
 			}
 		}
@@ -1168,6 +1175,8 @@
 			vendid = asus;
 		else {
 			err = -ENODEV;
+			dev_dbg(&new_client->dev, "Chip was made by neither "
+				"Winbond nor Asus?\n");
 			goto ERROR2;
 		}
 
