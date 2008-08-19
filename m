From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Aug 2008 14:17:27 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Don't spam the kernel log
Message-Id: <20080819161727.16c58eea@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Degrade the "Unsupported chip" message from info to debug level.
There's nothing wrong with this, so no need to bother the user.
Also make the message slightly more descriptive.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Ben, Martyn, could any of you please review, test and ack this patch?
It applies on top of the 8 other lm90 patches that are queued for
kernel 2.6.28:
  http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/
Thanks.

 drivers/hwmon/lm90.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.27-rc3.orig/drivers/hwmon/lm90.c	2008-08-19 15:40:14.000000000 +0200
+++ linux-2.6.27-rc3/drivers/hwmon/lm90.c	2008-08-19 15:50:20.000000000 +0200
@@ -742,9 +742,9 @@ static int lm90_detect(struct i2c_client
 		}
 
 		if (kind <= 0) { /* identification failed */
-			dev_info(&adapter->dev,
-			    "Unsupported chip (man_id=0x%02X, "
-			    "chip_id=0x%02X).\n", man_id, chip_id);
+			dev_dbg(&adapter->dev,
+				"Unsupported chip at 0x%02x (man_id=0x%02X, "
+				"chip_id=0x%02X)\n", address, man_id, chip_id);
 			return -ENODEV;
 		}
 	}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
