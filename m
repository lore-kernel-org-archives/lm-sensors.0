From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:18 +0000
Subject: [PATCH] fix it8712 detection
Message-Id: <Pine.LNX.4.58.0410121927500.9204@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello,

Following patch fixes the bug introduced by me in VID VRM patch.
Spotted (and later reviewed) by Jean Delvare. This bug is non-fatal,
it8712 will be just treated as it was before my VID VRM patch.

Tested on it8705 and it8712  hardware.

Signed-off-by: Rudolf Marek <r.marek@sh.cvut.cz>

Thank you.

Regards

Rudolf

diff -Naur a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	2004-09-30 05:05:21.000000000 +0200
+++ b/drivers/i2c/chips/it87.c	2004-10-11 21:38:18.000000000 +0200
@@ -105,6 +105,10 @@
 /* Reset the registers on init if true */
 static int reset;

+/* Chip Type */
+
+static u16 chip_type;
+
 /* Many IT87 constants specified below */

 /* Length of ISA address segment */
@@ -592,9 +596,9 @@
 	u16 val;

 	superio_enter();
-	val = (superio_inb(DEVID) << 8) |
+	chip_type = (superio_inb(DEVID) << 8) |
 	       superio_inb(DEVID + 1);
-	if (val != IT8712F_DEVID) {
+	if (chip_type != IT8712F_DEVID) {
 		superio_exit();
 		return -ENODEV;
 	}
@@ -691,11 +695,9 @@
 	if (kind <= 0) {
 		i = it87_read_value(new_client, IT87_REG_CHIPID);
 		if (i = 0x90) {
-			u16 val;
 			kind = it87;
-			val = (superio_inb(DEVID) << 8) |
-			superio_inb(DEVID + 1);
-			if (val = IT8712F_DEVID) kind = it8712;
+			if ((is_isa) && (chip_type = IT8712F_DEVID))
+				kind = it8712;
 		}
 		else {
 			if (kind = 0)
