From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2007 15:47:58 +0000
Subject: [lm-sensors] [PATCH 5/5] hwmon: (gl518sm) Report error on invalid
Message-Id: <20071022174758.40075af8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If the user attempts to write a fan clock divider not supported by
the chip, an error should be returned.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/gl518sm.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- linux-2.6.24-rc0.orig/drivers/hwmon/gl518sm.c	2007-10-22 15:21:24.000000000 +0200
+++ linux-2.6.24-rc0/drivers/hwmon/gl518sm.c	2007-10-22 15:26:02.000000000 +0200
@@ -107,7 +107,6 @@ static inline u8 FAN_TO_REG(long rpm, in
 #define VDD_TO_REG(val)		(SENSORS_LIMIT((((val)*4+47)/95),0,255))
 #define VDD_FROM_REG(val)	(((val)*95+2)/4)
 
-#define DIV_TO_REG(val)		((val)=4?2:(val)=2?1:(val)=1?0:3)
 #define DIV_FROM_REG(val)	(1 << (val))
 
 #define BEEP_MASK_TO_REG(val)	((val) & 0x7f & data->alarm_mask)
@@ -302,9 +301,20 @@ static ssize_t set_fan_div(struct device
 	int regvalue;
 	unsigned long val = simple_strtoul(buf, NULL, 10);
 
+	switch (val) {
+	case 1: val = 0; break;
+	case 2: val = 1; break;
+	case 4: val = 2; break;
+	case 8: val = 3; break;
+	default:
+		dev_err(dev, "Invalid fan clock divider %lu, choose one "
+			"of 1, 2, 4 or 8\n", val);
+		return -EINVAL;
+	}
+
 	mutex_lock(&data->update_lock);
 	regvalue = gl518_read_value(client, GL518_REG_MISC);
-	data->fan_div[nr] = DIV_TO_REG(val);
+	data->fan_div[nr] = val;
 	regvalue = (regvalue & ~(0xc0 >> (2 * nr)))
 		 | (data->fan_div[nr] << (6 - 2 * nr));
 	gl518_write_value(client, GL518_REG_MISC, regvalue);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
