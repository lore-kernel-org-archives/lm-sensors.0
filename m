From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 15:34:28 +0000
Subject: [lm-sensors] [PATCH 02/11] hwmon: w83792d simplify in low bits
Message-Id: <20051218163428.6142ebe2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-w83792d-simplify-in-low-bits.patch

Simplify the way the w83792d driver handles the extra resolution
bits of voltage input channels.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Yuan Mu <Ymu at winbond.com.tw>
---
 drivers/hwmon/w83792d.c |   48 ++++++++++-------------------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

--- linux-2.6.15-rc5.orig/drivers/hwmon/w83792d.c	2005-12-07 22:18:25.000000000 +0100
+++ linux-2.6.15-rc5/drivers/hwmon/w83792d.c	2005-12-07 22:18:28.000000000 +0100
@@ -281,7 +281,7 @@
 	u8 in[9];		/* Register value */
 	u8 in_max[9];		/* Register value */
 	u8 in_min[9];		/* Register value */
-	u8 low_bits[2];		/* Additional resolution to voltage in0-6 */
+	u16 low_bits;		/* Additional resolution to voltage in6-0 */
 	u8 fan[7];		/* Register value */
 	u8 fan_min[7];		/* Register value */
 	u8 temp1[3];		/* current, over, thyst */
@@ -323,38 +323,10 @@
 	.detach_client = w83792d_detach_client,
 };
 
-static long in_count_from_reg(int nr, struct w83792d_data *data)
+static inline long in_count_from_reg(int nr, struct w83792d_data *data)
 {
-	u16 vol_count = data->in[nr];
-	u16 low_bits = 0;
-	vol_count = (vol_count << 2);
-	switch (nr)
-	{
-	case 0:  /* vin0 */
-		low_bits = (data->low_bits[0]) & 0x03;
-		break;
-	case 1:  /* vin1 */
-		low_bits = ((data->low_bits[0]) & 0x0c) >> 2;
-		break;
-	case 2:  /* vin2 */
-		low_bits = ((data->low_bits[0]) & 0x30) >> 4;
-		break;
-	case 3:  /* vin3 */
-		low_bits = ((data->low_bits[0]) & 0xc0) >> 6;
-		break;
-	case 4:  /* vin4 */
-		low_bits = (data->low_bits[1]) & 0x03;
-		break;
-	case 5:  /* vin5 */
-		low_bits = ((data->low_bits[1]) & 0x0c) >> 2;
-		break;
-	case 6:  /* vin6 */
-		low_bits = ((data->low_bits[1]) & 0x30) >> 4;
-	default:
-		break;
-	}
-	vol_count = vol_count | low_bits;
-	return vol_count;
+	/* in7 and in8 do not have low bits, but the formula still works */
+	return ((data->in[nr] << 2) | ((data->low_bits >> (2 * nr)) & 0x03));
 }
 
 /* following are the sysfs callback functions */
@@ -1483,10 +1455,10 @@
 			data->in_min[i] = w83792d_read_value(client,
 						W83792D_REG_IN_MIN[i]);
 		}
-		data->low_bits[0] = w83792d_read_value(client,
-						W83792D_REG_LOW_BITS1);
-		data->low_bits[1] = w83792d_read_value(client,
-						W83792D_REG_LOW_BITS2);
+		data->low_bits = w83792d_read_value(client,
+						W83792D_REG_LOW_BITS1) +
+				 (w83792d_read_value(client,
+						W83792D_REG_LOW_BITS2) << 8);
 		for (i = 0; i < 7; i++) {
 			/* Update the Fan measured value and limits */
 			data->fan[i] = w83792d_read_value(client,
@@ -1598,8 +1570,8 @@
 		dev_dbg(dev, "vin[%d] max is: 0x%x\n", i, data->in_max[i]);
 		dev_dbg(dev, "vin[%d] min is: 0x%x\n", i, data->in_min[i]);
 	}
-	dev_dbg(dev, "Low Bit1 is: 0x%x\n", data->low_bits[0]);
-	dev_dbg(dev, "Low Bit2 is: 0x%x\n", data->low_bits[1]);
+	dev_dbg(dev, "Low Bit1 is: 0x%x\n", data->low_bits & 0xff);
+	dev_dbg(dev, "Low Bit2 is: 0x%x\n", data->low_bits >> 8);
 	dev_dbg(dev, "7 set of Fan Counts and Duty Cycles: ===>\n");
 	for (i=0; i<7; i++) {
 		dev_dbg(dev, "fan[%d] is: 0x%x\n", i, data->fan[i]);

-- 
Jean Delvare

