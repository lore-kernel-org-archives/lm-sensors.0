From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:57:00 +0000
Subject: [lm-sensors] [patch 14/36] hwmon: (w83795) Fix in17-in20 gain factor
Message-Id: <20100915155700.6da99791@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Gain bit set means 1x gain and cleared means 8x gain, not the other
way around.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:12:48.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:12:51.000000000 +0200
@@ -1335,7 +1335,7 @@ show_in(struct device *dev, struct devic
 	case IN_READ:
 		/* calculate this value again by sensors as sensors3.conf */
 		if ((index >= 17) &&
-		    ((data->has_gain >> (index - 17)) & 1))
+		    !((data->has_gain >> (index - 17)) & 1))
 			val *= 8;
 		break;
 	case IN_MAX:
@@ -1345,7 +1345,7 @@ show_in(struct device *dev, struct devic
 		val |= (data->in_lsb[lsb_idx][nr] >>
 			IN_LSB_SHIFT_IDX[lsb_idx][IN_LSB_SHIFT]) & 0x03;
 		if ((index >= 17) &&
-		    ((data->has_gain >> (index - 17)) & 1))
+		    !((data->has_gain >> (index - 17)) & 1))
 			val *= 8;
 		break;
 	}
@@ -1373,7 +1373,7 @@ store_in(struct device *dev, struct devi
 	val = in_to_reg(index, val);
 
 	if ((index >= 17) &&
-	    ((data->has_gain >> (index - 17)) & 1))
+	    !((data->has_gain >> (index - 17)) & 1))
 		val /= 8;
 	val = SENSORS_LIMIT(val, 0, 0x3FF);
 	mutex_lock(&data->update_lock);


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
