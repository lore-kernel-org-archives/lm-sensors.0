From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Nov 2010 15:45:53 +0000
Subject: [lm-sensors] [PATCH 4/7] hwmon: (w83795) Print the actual
Message-Id: <20101107164553.225d0647@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't expose raw register values to user-space. Decode and encode
temperature channels selected as temperature sources as needed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 w83795.c |   30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

--- a/drivers/hwmon/w83795.c	2010-11-05 22:01:58.000000000 +0100
+++ b/drivers/hwmon/w83795.c	2010-11-05 22:06:23.000000000 +0100
@@ -966,17 +966,18 @@ show_temp_src(struct device *dev, struct
 	    to_sensor_dev_attr_2(attr);
 	struct w83795_data *data = w83795_update_pwm_config(dev);
 	int index = sensor_attr->index;
-	u8 val = index / 2;
-	u8 tmp = data->temp_src[val];
+	u8 tmp = data->temp_src[index / 2];
 
 	if (index & 1)
-		val = 4;
+		tmp >>= 4;	/* Pick high nibble */
 	else
-		val = 0;
-	tmp >>= val;
-	tmp &= 0x0f;
+		tmp &= 0x0f;	/* Pick low nibble */
 
-	return sprintf(buf, "%u\n", tmp);
+	/* Look-up the actual temperature channel number */
+	if (tmp >= 4 || tss_map[tmp][index] = TSS_MAP_RESERVED)
+		return -EINVAL;		/* Shouldn't happen */
+
+	return sprintf(buf, "%u\n", (unsigned int)tss_map[tmp][index] + 1);
 }
 
 static ssize_t
@@ -988,12 +989,21 @@ store_temp_src(struct device *dev, struc
 	struct sensor_device_attribute_2 *sensor_attr  	    to_sensor_dev_attr_2(attr);
 	int index = sensor_attr->index;
-	unsigned long tmp;
+	int tmp;
+	unsigned long channel;
 	u8 val = index / 2;
 
-	if (strict_strtoul(buf, 10, &tmp) < 0)
+	if (strict_strtoul(buf, 10, &channel) < 0 ||
+	    channel < 1 || channel > 14)
+		return -EINVAL;
+
+	/* Check if request can be fulfilled */
+	for (tmp = 0; tmp < 4; tmp++) {
+		if (tss_map[tmp][index] = channel - 1)
+			break;
+	}
+	if (tmp = 4)	/* No match */
 		return -EINVAL;
-	tmp = SENSORS_LIMIT(tmp, 0, 15);
 
 	mutex_lock(&data->update_lock);
 	if (index & 1) {

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
