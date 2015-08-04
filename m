From: Justin Maggard <jmaggard10@gmail.com>
Date: Tue, 04 Aug 2015 21:48:31 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (it87) Add support for IT8732F
Message-Id: <1438724911-8441-1-git-send-email-jmaggard@netgear.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351960184-23005-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351960184-23005-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add support for the IT8732F.  This chip is pretty similar to IT8721F,
with the main difference being that the ADC LSB is 10.9 mV instead of
12 mV.

Signed-off-by: Justin Maggard <jmaggard@netgear.com>
---
 Documentation/hwmon/it87 | 35 ++++++++++++++++++++++-------------
 drivers/hwmon/it87.c     | 43 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
index e872948..733296d 100644
--- a/Documentation/hwmon/it87
+++ b/Documentation/hwmon/it87
@@ -38,6 +38,10 @@ Supported chips:
     Prefix: 'it8728'
     Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Not publicly available
+  * IT8732F
+    Prefix: 'it8732'
+    Addresses scanned: from Super I/O config space (8 I/O ports)
+    Datasheet: Not publicly available
   * IT8771E
     Prefix: 'it8771'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -111,9 +115,9 @@ Description
 -----------
 
 This driver implements support for the IT8603E, IT8620E, IT8623E, IT8705F,
-IT8712F, IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E,
-IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E, and SiS950
-chips.
+IT8712F, IT8716F, IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8732F,
+IT8758E, IT8771E, IT8772E, IT8781F, IT8782F, IT8783E/F, IT8786E, IT8790E, and
+SiS950 chips.
 
 These chips are 'Super I/O chips', supporting floppy disks, infrared ports,
 joysticks and other miscellaneous stuff. For hardware monitoring, they
@@ -137,10 +141,10 @@ The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E and later IT8712F revisions
 have support for 2 additional fans. The additional fans are supported by the
 driver.
 
-The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E, IT8781F, IT8782F, IT8783E/F,
-and late IT8712F and IT8705F also have optional 16-bit tachometer counters
-for fans 1 to 3. This is better (no more fan clock divider mess) but not
-compatible with the older chips and revisions. The 16-bit tachometer mode
+The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E, IT8732F, IT8781F, IT8782F,
+IT8783E/F, and late IT8712F and IT8705F also have optional 16-bit tachometer
+counters for fans 1 to 3. This is better (no more fan clock divider mess) but
+not compatible with the older chips and revisions. The 16-bit tachometer mode
 is enabled by the driver when one of the above chips is detected.
 
 The IT8726F is just bit enhanced IT8716F with additional hardware
@@ -159,6 +163,9 @@ IT8728F. It only supports 16-bit fan mode.
 
 The IT8790E supports up to 3 fans. 16-bit fan mode is always enabled.
 
+The IT8732F supports a closed-loop mode for fan control, but this is not
+currently implemented by the driver.
+
 Temperatures are measured in degrees Celsius. An alarm is triggered once
 when the Overtemperature Shutdown limit is crossed.
 
@@ -173,12 +180,14 @@ is done.
 Voltage sensors (also known as IN sensors) report their values in volts. An
 alarm is triggered if the voltage has crossed a programmable minimum or
 maximum limit. Note that minimum in this case always means 'closest to
-zero'; this is important for negative voltage measurements. All voltage
-inputs can measure voltages between 0 and 4.08 volts, with a resolution of
-0.016 volt (except IT8603E, IT8721F/IT8758E and IT8728F: 0.012 volt.) The
-battery voltage in8 does not have limit registers.
-
-On the IT8603E, IT8721F/IT8758E, IT8781F, IT8782F, and IT8783E/F, some
+zero'; this is important for negative voltage measurements. On most chips, all
+voltage inputs can measure voltages between 0 and 4.08 volts, with a resolution
+of 0.016 volt.  IT8603E, IT8721F/IT8758E and IT8728F can measure between 0 and
+3.06 volts, with a resolution of 0.012 volt.  IT8732F can measure between 0 and
+2.8 volts with a resolution of 0.0109 volt.  The battery voltage in8 does not
+have limit registers.
+
+On the IT8603E, IT8721F/IT8758E, IT8732F, IT8781F, IT8782F, and IT8783E/F, some
 voltage inputs are internal and scaled inside the chip:
 * in3 (optional)
 * in7 (optional for IT8781F, IT8782F, and IT8783E/F)
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index d0ee556..3ed6663 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -21,6 +21,7 @@
  *            IT8721F  Super I/O chip w/LPC interface
  *            IT8726F  Super I/O chip w/LPC interface
  *            IT8728F  Super I/O chip w/LPC interface
+ *            IT8732F  Super I/O chip w/LPC interface
  *            IT8758E  Super I/O chip w/LPC interface
  *            IT8771E  Super I/O chip w/LPC interface
  *            IT8772E  Super I/O chip w/LPC interface
@@ -69,8 +70,9 @@
 
 #define DRVNAME "it87"
 
-enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
-	     it8772, it8781, it8782, it8783, it8786, it8790, it8603, it8620 };
+enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8732,
+	     it8771, it8772, it8781, it8782, it8783, it8786, it8790, it8603,
+	     it8620 };
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -147,6 +149,7 @@ static inline void superio_exit(void)
 #define IT8720F_DEVID 0x8720
 #define IT8721F_DEVID 0x8721
 #define IT8726F_DEVID 0x8726
+#define IT8732F_DEVID 0x8732
 #define IT8728F_DEVID 0x8728
 #define IT8771E_DEVID 0x8771
 #define IT8772E_DEVID 0x8772
@@ -265,6 +268,7 @@ struct it87_devices {
 #define FEAT_VID		(1 << 9)	/* Set if chip supports VID */
 #define FEAT_IN7_INTERNAL	(1 << 10)	/* Set if in7 is internal */
 #define FEAT_SIX_FANS		(1 << 11)	/* Supports six fans */
+#define FEAT_10_9MV_ADC		(1 << 12)
 
 static const struct it87_devices it87_devices[] = {
 	[it87] = {
@@ -315,6 +319,15 @@ static const struct it87_devices it87_devices[] = {
 		  | FEAT_IN7_INTERNAL,
 		.peci_mask = 0x07,
 	},
+	[it8732] = {
+		.name = "it8732",
+		.suffix = "F",
+		.features = FEAT_NEWER_AUTOPWM | FEAT_16BIT_FANS
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_OLD_PECI | FEAT_TEMP_PECI
+		  | FEAT_10_9MV_ADC | FEAT_IN7_INTERNAL,
+		.peci_mask = 0x07,
+		.old_peci_mask = 0x02,	/* Actually reports PCH */
+	},
 	[it8771] = {
 		.name = "it8771",
 		.suffix = "E",
@@ -391,6 +404,7 @@ static const struct it87_devices it87_devices[] = {
 
 #define has_16bit_fans(data)	((data)->features & FEAT_16BIT_FANS)
 #define has_12mv_adc(data)	((data)->features & FEAT_12MV_ADC)
+#define has_10_9mv_adc(data)	((data)->features & FEAT_10_9MV_ADC)
 #define has_newer_autopwm(data)	((data)->features & FEAT_NEWER_AUTOPWM)
 #define has_old_autopwm(data)	((data)->features & FEAT_OLD_AUTOPWM)
 #define has_temp_offset(data)	((data)->features & FEAT_TEMP_OFFSET)
@@ -475,7 +489,14 @@ struct it87_data {
 
 static int adc_lsb(const struct it87_data *data, int nr)
 {
-	int lsb = has_12mv_adc(data) ? 12 : 16;
+	int lsb;
+
+	if (has_12mv_adc(data))
+		lsb = 120;
+	else if (has_10_9mv_adc(data))
+		lsb = 109;
+	else
+		lsb = 160;
 	if (data->in_scaled & (1 << nr))
 		lsb <<= 1;
 	return lsb;
@@ -483,13 +504,13 @@ static int adc_lsb(const struct it87_data *data, int nr)
 
 static u8 in_to_reg(const struct it87_data *data, int nr, long val)
 {
-	val = DIV_ROUND_CLOSEST(val, adc_lsb(data, nr));
+	val = DIV_ROUND_CLOSEST(val * 10, adc_lsb(data, nr));
 	return clamp_val(val, 0, 255);
 }
 
 static int in_from_reg(const struct it87_data *data, int nr, int val)
 {
-	return val * adc_lsb(data, nr);
+	return DIV_ROUND_CLOSEST(val * adc_lsb(data, nr), 10);
 }
 
 static inline u8 FAN_TO_REG(long rpm, int div)
@@ -1515,9 +1536,14 @@ static ssize_t show_label(struct device *dev, struct device_attribute *attr,
 	};
 	struct it87_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr(attr)->index;
+	const char *label;
 
-	return sprintf(buf, "%s\n", has_12mv_adc(data) ? labels_it8721[nr]
-						       : labels[nr]);
+	if (has_12mv_adc(data) || has_10_9mv_adc(data))
+		label = labels_it8721[nr];
+	else
+		label = labels[nr];
+
+	return sprintf(buf, "%s\n", label);
 }
 static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, show_label, NULL, 1);
@@ -1853,6 +1879,9 @@ static int __init it87_find(unsigned short *address,
 	case IT8728F_DEVID:
 		sio_data->type = it8728;
 		break;
+	case IT8732F_DEVID:
+		sio_data->type = it8732;
+		break;
 	case IT8771E_DEVID:
 		sio_data->type = it8771;
 		break;
-- 
2.5.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
