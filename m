From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 14:01:08 +0000
Subject: [lm-sensors] [patch 25/36] hwmon: (w83795) Fix parity checks
Message-Id: <20100915160108.268f1f38@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

x % 1 is obviously wrong, as it always evaluates to 0. You want
x % 2, or x & 1, for parity checking.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:14:01.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:14:03.000000000 +0200
@@ -183,7 +183,7 @@ static const u8 IN_LSB_SHIFT_IDX[][2]  #define W83795_REG_FAN_MIN_HL(index)	(0xB6 + (index))
 #define W83795_REG_FAN_MIN_LSB(index)	(0xC4 + (index) / 2)
 #define W83795_REG_FAN_MIN_LSB_SHIFT(index) \
-	(((index) % 1) ? 4 : 0)
+	(((index) & 1) ? 4 : 0)
 
 #define W83795_REG_VID_CTRL		0x6A
 
@@ -670,7 +670,7 @@ store_fan_min(struct device *dev, struct
 	data->fan_min[index] = val;
 	w83795_write(client, W83795_REG_FAN_MIN_HL(index), (val >> 4) & 0xff);
 	val &= 0x0f;
-	if (index % 1) {
+	if (index & 1) {
 		val <<= 4;
 		val |= w83795_read(client, W83795_REG_FAN_MIN_LSB(index))
 		       & 0x0f;
@@ -823,7 +823,7 @@ show_temp_src(struct device *dev, struct
 	u8 val = index / 2;
 	u8 tmp = data->temp_src[val];
 
-	if (index % 1)
+	if (index & 1)
 		val = 4;
 	else
 		val = 0;
@@ -850,7 +850,7 @@ store_temp_src(struct device *dev, struc
 	tmp = SENSORS_LIMIT(tmp, 0, 15);
 
 	mutex_lock(&data->update_lock);
-	if (index % 1) {
+	if (index & 1) {
 		tmp <<= 4;
 		data->temp_src[val] &= 0x0f;
 	} else {


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
