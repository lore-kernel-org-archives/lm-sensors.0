From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:00:57 +0000
Subject: [lm-sensors] [patch 24/36] hwmon: (w83795) Get rid of VRLSB_SHIFT
Message-Id: <20100915160057.06ee8132@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

VRLSB_SHIFT is a non-sense, the actual shift depends on the sensor
type (fans need 4, other sensors need 6). Get rid of it to prevent
any confusion. Also get rid of the useless masking, the meaningful
bits are always the MSb so there's nothing to mask out after
shifting.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:13:59.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:14:01.000000000 +0200
@@ -127,7 +127,6 @@ static const u16 W83795_REG_IN[][3] = {
 	{0x24, 0xa2, 0xa3},	/* VSEN17 */
 };
 #define W83795_REG_VRLSB		0x3C
-#define VRLSB_SHIFT			6
 
 static const u8 W83795_REG_IN_HL_LSB[] = {
 	0x8e,	/* VSEN1-4 */
@@ -485,8 +484,7 @@ static struct w83795_data *w83795_update
 		if (!(data->has_in & (1 << i)))
 			continue;
 		tmp = w83795_read(client, W83795_REG_IN[i][IN_READ]) << 2;
-		tmp |= (w83795_read(client, W83795_REG_VRLSB)
-			>> VRLSB_SHIFT) & 0x03;
+		tmp |= w83795_read(client, W83795_REG_VRLSB) >> 6;
 		data->in[i][IN_READ] = tmp;
 	}
 
@@ -1140,8 +1138,7 @@ show_temp(struct device *dev, struct dev
 	long temp = temp_from_reg(data->temp[index][nr]);
 
 	if (TEMP_READ = nr)
-		temp += ((data->temp_read_vrlsb[index] >> VRLSB_SHIFT) & 0x03)
-			* 250;
+		temp += (data->temp_read_vrlsb[index] >> 6) * 250;
 	return sprintf(buf, "%ld\n", temp);
 }
 
@@ -1202,7 +1199,7 @@ show_dts(struct device *dev, struct devi
 	struct w83795_data *data = w83795_update_device(dev);
 	long temp = temp_from_reg(data->dts[index]);
 
-	temp += ((data->dts_read_vrlsb[index] >> VRLSB_SHIFT) & 0x03) * 250;
+	temp += (data->dts_read_vrlsb[index] >> 6) * 250;
 	return sprintf(buf, "%ld\n", temp);
 }
 
@@ -1981,8 +1978,7 @@ static int w83795_probe(struct i2c_clien
 		data->in[i][IN_LOW]  			w83795_read(client, W83795_REG_IN[i][IN_LOW]);
 		tmp = w83795_read(client, W83795_REG_IN[i][IN_READ]) << 2;
-		tmp |= (w83795_read(client, W83795_REG_VRLSB)
-			>> VRLSB_SHIFT) & 0x03;
+		tmp |= w83795_read(client, W83795_REG_VRLSB) >> 6;
 		data->in[i][IN_READ] = tmp;
 	}
 	for (i = 0; i < IN_LSB_REG_NUM; i++) {
@@ -2010,8 +2006,7 @@ static int w83795_probe(struct i2c_clien
 		data->fan_min[i] | 			(tmp >> W83795_REG_FAN_MIN_LSB_SHIFT(i)) & 0x0F;
 		data->fan[i] = w83795_read(client, W83795_REG_FAN(i)) << 4;
-		data->fan[i] |-		  (w83795_read(client, W83795_REG_VRLSB) >> 4) & 0x0F;
+		data->fan[i] |= w83795_read(client, W83795_REG_VRLSB) >> 4;
 	}
 
 	/* temperature and limits */


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
