From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 29 Jun 2008 10:31:11 +0000
Subject: [lm-sensors] [PATCH] hwmon: (atxp1) Fix device detection logic
Message-Id: <20080629123111.26ffc368@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The atxp1 device detection code has a major logic flaw, fix it. Not
sure how we managed to miss this when the driver was merged...

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Sebastian Witt <se.witt@gmx.net>
---
Sebastian, can you please review and test this patch? I've tested with
i2c-stub but an additional test with a real device can't hurt.

 drivers/hwmon/atxp1.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.26-rc8.orig/drivers/hwmon/atxp1.c	2008-06-29 11:52:24.000000000 +0200
+++ linux-2.6.26-rc8/drivers/hwmon/atxp1.c	2008-06-29 12:25:49.000000000 +0200
@@ -31,7 +31,7 @@
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("System voltages control via Attansic ATXP1");
-MODULE_VERSION("0.6.2");
+MODULE_VERSION("0.6.3");
 MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
 
 #define ATXP1_VID	0x00
@@ -298,7 +298,8 @@ static int atxp1_detect(struct i2c_adapt
 	     (i2c_smbus_read_byte_data(new_client, 0x3f) = 0) &&
 	     (i2c_smbus_read_byte_data(new_client, 0xfe) = 0) &&
 	     (i2c_smbus_read_byte_data(new_client, 0xff) = 0) )) {
-
+		goto exit_free;
+	} else {
 		/* No vendor ID, now checking if registers 0x10,0x11 (non-existent)
 		 * showing the same as register 0x00 */
 		temp = i2c_smbus_read_byte_data(new_client, 0x00);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
