From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Sep 2008 10:12:31 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: (lm78) Prevent misdetection of
Message-Id: <20080911121231.660d93bb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM78 detection is relatively weak, and sometimes recent Winbond
chips can be misdetected as an LM78. We have had repeated reports of
this happening. We have an explicit check against this for the ISA
access, do the same for I2C access now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm78.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-2.6.27-rc5.orig/drivers/hwmon/lm78.c	2008-09-09 18:30:51.000000000 +0200
+++ linux-2.6.27-rc5/drivers/hwmon/lm78.c	2008-09-09 18:33:57.000000000 +0200
@@ -613,6 +613,12 @@ static int lm78_detect(struct i2c_adapte
 			err = -ENODEV;
 			goto ERROR2;
 		}
+		/* Explicitly prevent the misdetection of Winbond chips */
+		i = lm78_read_value(data, 0x4f);
+		if (i = 0xa3 || i = 0x5c) {
+			err = -ENODEV;
+			goto ERROR2;
+		}
 	}
 
 	/* Determine the chip type. */

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
