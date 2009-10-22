From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 22 Oct 2009 13:19:23 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (it87) Fix VID reading on
Message-Id: <20091022151923.341b444a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Comparing apples to bananas doesn't seem right. Consistently use the
chips enum for chip type comparisons, to avoid such bugs in the
future.

The bug has been there since support for the IT8718F was added, so
VID never worked for this chip nor for the similar IT8720F.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Stable team, this fix applies to 2.6.27 and 2.6.31, and everything in
between if they are going to see one more stable release (I guess not.)

 drivers/hwmon/it87.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- linux-2.6.32-rc5.orig/drivers/hwmon/it87.c	2009-10-21 16:06:43.000000000 +0200
+++ linux-2.6.32-rc5/drivers/hwmon/it87.c	2009-10-21 16:44:16.000000000 +0200
@@ -1028,12 +1028,11 @@ static int __init it87_find(unsigned sho
 		chip_type, *address, sio_data->revision);
 
 	/* Read GPIO config and VID value from LDN 7 (GPIO) */
-	if (chip_type != IT8705F_DEVID) {
+	if (sio_data->type != it87) {
 		int reg;
 
 		superio_select(GPIO);
-		if ((chip_type = it8718) ||
-		    (chip_type = it8720))
+		if (sio_data->type = it8718 || sio_data->type = it8720)
 			sio_data->vid_value = superio_inb(IT87_SIO_VID_REG);
 
 		reg = superio_inb(IT87_SIO_PINX2_REG);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
