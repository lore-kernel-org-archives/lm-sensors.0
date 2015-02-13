From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Feb 2015 20:13:51 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (it87) Add feature flags for fans count and 16-bit fan configuration
Message-Id: <1423858433-1416-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fans 4-5 are not supported on all chips and revisions. Also, 16-bit fan
counters only need to be enabled on older chips. Provide feature flags
to simplify adding support for new chips.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 70 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index ed25e4b..0e1758f 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -252,79 +252,87 @@ struct it87_devices {
 #define FEAT_TEMP_OFFSET	(1 << 4)
 #define FEAT_TEMP_PECI		(1 << 5)
 #define FEAT_TEMP_OLD_PECI	(1 << 6)
+#define FEAT_FAN16_CONFIG	(1 << 7)	/* Need to enable 16-bit fans */
+#define FEAT_FIVE_FANS		(1 << 8)	/* Supports five fans */
 
 static const struct it87_devices it87_devices[] = {
 	[it87] = {
 		.name = "it87",
-		.features = FEAT_OLD_AUTOPWM,	/* may need to overwrite */
+		.features = FEAT_OLD_AUTOPWM | FEAT_FAN16_CONFIG,
+						/* may need to overwrite */
 	},
 	[it8712] = {
 		.name = "it8712",
-		.features = FEAT_OLD_AUTOPWM,	/* may need to overwrite */
+		.features = FEAT_OLD_AUTOPWM | FEAT_FAN16_CONFIG,
+						/* may need to overwrite */
 	},
 	[it8716] = {
 		.name = "it8716",
-		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET,
+		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
+		  | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
 	},
 	[it8718] = {
 		.name = "it8718",
 		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
-		  | FEAT_TEMP_OLD_PECI,
+		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
 		.old_peci_mask = 0x4,
 	},
 	[it8720] = {
 		.name = "it8720",
 		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
-		  | FEAT_TEMP_OLD_PECI,
+		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
 		.old_peci_mask = 0x4,
 	},
 	[it8721] = {
 		.name = "it8721",
 		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
-		  | FEAT_TEMP_OFFSET | FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI,
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI
+		  | FEAT_FAN16_CONFIG | FEAT_FIVE_FANS,
 		.peci_mask = 0x05,
 		.old_peci_mask = 0x02,	/* Actually reports PCH */
 	},
 	[it8728] = {
 		.name = "it8728",
 		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
-		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI | FEAT_FIVE_FANS,
 		.peci_mask = 0x07,
 	},
 	[it8771] = {
 		.name = "it8771",
 		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
 		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
-					/* PECI: guesswork */
-					/* 12mV ADC (OHM) */
-					/* 16 bit fans (OHM) */
+				/* PECI: guesswork */
+				/* 12mV ADC (OHM) */
+				/* 16 bit fans (OHM) */
+				/* three fans, always 16 bit (guesswork) */
 		.peci_mask = 0x07,
 	},
 	[it8772] = {
 		.name = "it8772",
 		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
 		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
-					/* PECI (coreboot) */
-					/* 12mV ADC (HWSensors4, OHM) */
-					/* 16 bit fans (HWSensors4, OHM) */
+				/* PECI (coreboot) */
+				/* 12mV ADC (HWSensors4, OHM) */
+				/* 16 bit fans (HWSensors4, OHM) */
+				/* three fans, always 16 bit (datasheet) */
 		.peci_mask = 0x07,
 	},
 	[it8781] = {
 		.name = "it8781",
 		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
-		  | FEAT_TEMP_OLD_PECI,
+		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
 		.old_peci_mask = 0x4,
 	},
 	[it8782] = {
 		.name = "it8782",
 		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
-		  | FEAT_TEMP_OLD_PECI,
+		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
 		.old_peci_mask = 0x4,
 	},
 	[it8783] = {
 		.name = "it8783",
 		.features = FEAT_16BIT_FANS | FEAT_TEMP_OFFSET
-		  | FEAT_TEMP_OLD_PECI,
+		  | FEAT_TEMP_OLD_PECI | FEAT_FAN16_CONFIG,
 		.old_peci_mask = 0x4,
 	},
 	[it8603] = {
@@ -345,6 +353,9 @@ static const struct it87_devices it87_devices[] = {
 #define has_temp_old_peci(data, nr) \
 				(((data)->features & FEAT_TEMP_OLD_PECI) && \
 				 ((data)->old_peci_mask & (1 << nr)))
+#define has_fan16_config(data)	(has_16bit_fans(data) && \
+				 ((data)->features & FEAT_FAN16_CONFIG))
+#define has_five_fans(data)	((data)->features & FEAT_FIVE_FANS)
 
 struct it87_sio_data {
 	enum chips type;
@@ -2130,7 +2141,7 @@ static int it87_probe(struct platform_device *pdev)
 	case it8712:
 		if (sio_data->revision >= 0x08) {
 			data->features &= ~FEAT_OLD_AUTOPWM;
-			data->features |= FEAT_16BIT_FANS;
+			data->features |= FEAT_16BIT_FANS | FEAT_FIVE_FANS;
 		}
 		break;
 	default:
@@ -2463,9 +2474,8 @@ static void it87_init_device(struct platform_device *pdev)
 	}
 	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
 
-	/* Set tachometers to 16-bit mode if needed, IT8603E (and IT8728F?)
-	 * has it by default */
-	if (has_16bit_fans(data) && data->type != it8603) {
+	/* Set tachometers to 16-bit mode if needed. */
+	if (has_fan16_config(data)) {
 		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
 		if (~tmp & 0x07 & data->has_fan) {
 			dev_dbg(&pdev->dev,
@@ -2473,17 +2483,15 @@ static void it87_init_device(struct platform_device *pdev)
 			it87_write_value(data, IT87_REG_FAN_16BIT,
 					 tmp | 0x07);
 		}
-		/*
-		 * IT8705F, IT8781F, IT8782F, and IT8783E/F only support
-		 * three fans.
-		 */
-		if (data->type != it87 && data->type != it8781 &&
-		    data->type != it8782 && data->type != it8783) {
-			if (tmp & (1 << 4))
-				data->has_fan |= (1 << 3); /* fan4 enabled */
-			if (tmp & (1 << 5))
-				data->has_fan |= (1 << 4); /* fan5 enabled */
-		}
+	}
+
+	/* Check for additional fans */
+	if (has_five_fans(data)) {
+		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
+		if (tmp & (1 << 4))
+			data->has_fan |= (1 << 3); /* fan4 enabled */
+		if (tmp & (1 << 5))
+			data->has_fan |= (1 << 4); /* fan5 enabled */
 	}
 
 	/* Fan input pins may be used for alternative functions */
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
