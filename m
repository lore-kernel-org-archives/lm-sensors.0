From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:03:22 +0000
Subject: [lm-sensors] [patch 36/36] hwmon: (w83795) Fix LSB reading of
Message-Id: <20100915160322.75cbb4d6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Wrong index caused the wrong register value to be read, resulting in
random LSB for voltage limits.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:16:00.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:16:03.000000000 +0200
@@ -1405,7 +1405,7 @@ show_in(struct device *dev, struct devic
 		lsb_idx = IN_LSB_SHIFT_IDX[index][IN_LSB_IDX];
 		val <<= 2;
 		val |= (data->in_lsb[lsb_idx][nr] >>
-			IN_LSB_SHIFT_IDX[lsb_idx][IN_LSB_SHIFT]) & 0x03;
+			IN_LSB_SHIFT_IDX[index][IN_LSB_SHIFT]) & 0x03;
 		if ((index >= 17) &&
 		    !((data->has_gain >> (index - 17)) & 1))
 			val *= 8;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
