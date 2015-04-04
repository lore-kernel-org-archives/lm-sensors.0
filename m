From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 21:54:54 +0000
Subject: [lm-sensors] [PATCH v2 03/22] hwmon: (it87) Add AVCC3 support for IT8620E
Message-Id: <1428184513-22380-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

AVCC3 is supported on IT8620E, similar to IT8603E. Add feature flag
to indicate AVCC3 support, and enable support for it on IT8620E.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Use feature macro on sio_data

 drivers/hwmon/it87.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 04b929cc21f3..d26b51f6683b 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -230,6 +230,8 @@ static const u8 IT87_REG_TEMP_OFFSET[] = { 0x56, 0x57, 0x59 };
 #define IT87_REG_VIN(nr)       (0x20 + (nr))
 #define IT87_REG_TEMP(nr)      (0x29 + (nr))
 
+#define IT87_REG_AVCC3		0x2f
+
 #define IT87_REG_VIN_MAX(nr)   (0x30 + (nr) * 2)
 #define IT87_REG_VIN_MIN(nr)   (0x31 + (nr) * 2)
 #define IT87_REG_TEMP_HIGH(nr) (0x40 + (nr) * 2)
@@ -265,6 +267,7 @@ struct it87_devices {
 #define FEAT_VID		(1 << 9)	/* Set if chip supports VID */
 #define FEAT_IN7_INTERNAL	(1 << 10)	/* Set if in7 is internal */
 #define FEAT_SIX_FANS		(1 << 11)	/* Supports six fans */
+#define FEAT_AVCC3		(1 << 12)	/* Chip supports in9/AVCC3 */
 
 static const struct it87_devices it87_devices[] = {
 	[it87] = {
@@ -376,7 +379,8 @@ static const struct it87_devices it87_devices[] = {
 		.name = "it8603",
 		.suffix = "E",
 		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
-		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_IN7_INTERNAL,
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_IN7_INTERNAL
+		  | FEAT_AVCC3,
 		.peci_mask = 0x07,
 	},
 	[it8620] = {
@@ -384,7 +388,7 @@ static const struct it87_devices it87_devices[] = {
 		.suffix = "E",
 		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
 		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_SIX_FANS
-		  | FEAT_IN7_INTERNAL,
+		  | FEAT_IN7_INTERNAL | FEAT_AVCC3,
 		.peci_mask = 0x07,
 	},
 };
@@ -405,6 +409,7 @@ static const struct it87_devices it87_devices[] = {
 #define has_vid(data)		((data)->features & FEAT_VID)
 #define has_in7_internal(data)	((data)->features & FEAT_IN7_INTERNAL)
 #define has_six_fans(data)	((data)->features & FEAT_SIX_FANS)
+#define has_avcc3(data)		((data)->features & FEAT_AVCC3)
 
 struct it87_sio_data {
 	enum chips type;
@@ -1522,7 +1527,7 @@ static ssize_t show_label(struct device *dev, struct device_attribute *attr,
 static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, show_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(in8_label, S_IRUGO, show_label, NULL, 2);
-/* special AVCC3 IT8603E in9 */
+/* AVCC3 */
 static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_label, NULL, 0);
 
 static ssize_t show_name(struct device *dev, struct device_attribute
@@ -1915,8 +1920,10 @@ static int __init it87_find(unsigned short *address,
 	/* in8 (Vbat) is always internal */
 	sio_data->internal |= (1 << 2);
 
-	/* Only the IT8603E has in9 */
-	if (sio_data->type != it8603)
+	/* in9 (AVCC3), always internal if supported */
+	if (has_avcc3(config))
+		sio_data->internal |= (1 << 3); /* in9 is AVCC */
+	else
 		sio_data->skip_in |= (1 << 9);
 
 	if (!has_vid(config))
@@ -2015,8 +2022,6 @@ static int __init it87_find(unsigned short *address,
 		sio_data->skip_in |= (1 << 5); /* No VIN5 */
 		sio_data->skip_in |= (1 << 6); /* No VIN6 */
 
-		sio_data->internal |= (1 << 3); /* in9 is AVCC */
-
 		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
 	} else if (sio_data->type = it8620) {
 		int reg;
@@ -2660,8 +2665,8 @@ static struct it87_data *it87_update_device(struct device *dev)
 		}
 		/* in8 (battery) has no limit registers */
 		data->in[8][0] = it87_read_value(data, IT87_REG_VIN(8));
-		if (data->type = it8603)
-			data->in[9][0] = it87_read_value(data, 0x2f);
+		if (has_avcc3(data))
+			data->in[9][0] = it87_read_value(data, IT87_REG_AVCC3);
 
 		for (i = 0; i < 6; i++) {
 			/* Skip disabled fans */
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
