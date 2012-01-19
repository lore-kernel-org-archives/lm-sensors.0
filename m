From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:05 +0000
Subject: [lm-sensors] [PATCH 71/82] hwmon: (vt1211) Fix multi-line comments
Message-Id: <1327017376-20466-72-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Juerg Haefliger <juergh@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/vt1211.c |  110 +++++++++++++++++++++++++++++++----------------
 1 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/drivers/hwmon/vt1211.c b/drivers/hwmon/vt1211.c
index 7ca0ebe..694bf66 100644
--- a/drivers/hwmon/vt1211.c
+++ b/drivers/hwmon/vt1211.c
@@ -53,7 +53,8 @@ static struct platform_device *pdev;
 
 #define DRVNAME "vt1211"
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Registers
  *
  * The sensors are defined as follows.
@@ -69,7 +70,8 @@ static struct platform_device *pdev;
  * UCH5            in4            temp7       +12V
  * 3.3V            in5                        Internal VDD (+3.3V)
  *
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 /* Voltages (in) numbered 0-5 (ix) */
 #define VT1211_REG_IN(ix)		(0x21 + (ix))
@@ -108,9 +110,11 @@ static const u8 bitalarmin[]	= {11, 0, 1, 3, 8, 2, 9};
 static const u8 bitalarmtemp[]	= {4, 15, 11, 0, 1, 3, 8};
 static const u8 bitalarmfan[]	= {6, 7};
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Data structures and manipulation thereof
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 struct vt1211_data {
 	unsigned short addr;
@@ -151,8 +155,10 @@ struct vt1211_data {
 #define ISTEMP(ix, uch_config)	((ix) < 2 ? 1 : \
 				 ((uch_config) >> (ix)) & 1)
 
-/* in5 (ix = 5) is special. It's the internal 3.3V so it's scaled in the
-   driver according to the VT1211 BIOS porting guide */
+/*
+ * in5 (ix = 5) is special. It's the internal 3.3V so it's scaled in the
+ * driver according to the VT1211 BIOS porting guide
+ */
 #define IN_FROM_REG(ix, reg)	((reg) < 3 ? 0 : (ix) = 5 ? \
 				 (((reg) - 3) * 15882 + 479) / 958 : \
 				 (((reg) - 3) * 10000 + 479) / 958)
@@ -160,11 +166,13 @@ struct vt1211_data {
 				 ((val) * 958 + 7941) / 15882 + 3 : \
 				 ((val) * 958 + 5000) / 10000 + 3, 0, 255))
 
-/* temp1 (ix = 0) is an intel thermal diode which is scaled in user space.
-   temp2 (ix = 1) is the internal temp diode so it's scaled in the driver
-   according to some measurements that I took on an EPIA M10000.
-   temp3-7 are thermistor based so the driver returns the voltage measured at
-   the pin (range 0V - 2.2V). */
+/*
+ * temp1 (ix = 0) is an intel thermal diode which is scaled in user space.
+ * temp2 (ix = 1) is the internal temp diode so it's scaled in the driver
+ * according to some measurements that I took on an EPIA M10000.
+ * temp3-7 are thermistor based so the driver returns the voltage measured at
+ * the pin (range 0V - 2.2V).
+ */
 #define TEMP_FROM_REG(ix, reg)	((ix) = 0 ? (reg) * 1000 : \
 				 (ix) = 1 ? (reg) < 51 ? 0 : \
 				 ((reg) - 51) * 1000 : \
@@ -182,12 +190,16 @@ struct vt1211_data {
 				 SENSORS_LIMIT((1310720 / (val) / \
 				 DIV_FROM_REG(div)), 1, 254))
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Super-I/O constants and functions
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
-/* Configuration index port registers
- * The vt1211 can live at 2 different addresses so we need to probe both */
+/*
+ * Configuration index port registers
+ * The vt1211 can live at 2 different addresses so we need to probe both
+ */
 #define SIO_REG_CIP1		0x2e
 #define SIO_REG_CIP2		0x4e
 
@@ -231,9 +243,11 @@ static inline void superio_exit(int sio_cip)
 	outb(0xaa, sio_cip);
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Device I/O access
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static inline u8 vt1211_read8(struct vt1211_data *data, u8 reg)
 {
@@ -328,10 +342,12 @@ static struct vt1211_data *vt1211_update_device(struct device *dev)
 	return data;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Voltage sysfs interfaces
  * ix = [0-5]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SHOW_IN_INPUT	0
 #define SHOW_SET_IN_MIN	1
@@ -402,10 +418,12 @@ static ssize_t set_in(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Temperature sysfs interfaces
  * ix = [0-6]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SHOW_TEMP_INPUT		0
 #define SHOW_SET_TEMP_MAX	1
@@ -478,10 +496,12 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Fan sysfs interfaces
  * ix = [0-1]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SHOW_FAN_INPUT		0
 #define SHOW_SET_FAN_MIN	1
@@ -583,10 +603,12 @@ EXIT:
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * PWM sysfs interfaces
  * ix = [0-1]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SHOW_PWM			0
 #define SHOW_SET_PWM_ENABLE		1
@@ -655,8 +677,10 @@ static ssize_t set_pwm(struct device *dev, struct device_attribute *attr,
 		switch (val) {
 		case 0:
 			data->pwm_ctl[ix] &= 7;
-			/* disable SmartGuardian if both PWM outputs are
-			 * disabled */
+			/*
+			 * disable SmartGuardian if both PWM outputs are
+			 * disabled
+			 */
 			if ((data->pwm_ctl[ix ^ 1] & 1) = 0)
 				data->fan_ctl &= 0xe;
 			break;
@@ -719,11 +743,13 @@ EXIT:
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * PWM auto point definitions
  * ix = [0-1]
  * ap = [0-3]
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 /*
  * pwm[ix+1]_auto_point[ap+1]_temp mapping table:
@@ -805,7 +831,7 @@ static ssize_t set_pwm_auto_point_temp(struct device *dev,
  * 1  1  : pwm2 low speed duty cycle  (pwm_auto_pwm[1][1])
  * 1  2  : pwm2 high speed duty cycle (pwm_auto_pwm[1][2])
  * 1  3  : pwm2 full speed            (pwm_auto_pwm[1][3], hard-wired to 255)
-*/
+ */
 
 static ssize_t show_pwm_auto_point_pwm(struct device *dev,
 				       struct device_attribute *attr,
@@ -845,9 +871,11 @@ static ssize_t set_pwm_auto_point_pwm(struct device *dev,
 	return count;
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Miscellaneous sysfs interfaces (VRM, VID, name, and (legacy) alarms)
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
 			char *buf)
@@ -897,9 +925,11 @@ static ssize_t show_alarms(struct device *dev,
 	return sprintf(buf, "%d\n", data->alarms);
 }
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Device attribute structs
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 #define SENSOR_ATTR_IN_INPUT(ix) \
 	SENSOR_ATTR_2(in##ix##_input, S_IRUGO, \
@@ -1087,9 +1117,11 @@ static struct device_attribute vt1211_sysfs_misc[] = {
 	__ATTR(alarms, S_IRUGO, show_alarms, NULL),
 };
 
-/* ---------------------------------------------------------------------
+/*
+ * ---------------------------------------------------------------------
  * Device registration and initialization
- * --------------------------------------------------------------------- */
+ * ---------------------------------------------------------------------
+ */
 
 static void __devinit vt1211_init_device(struct vt1211_data *data)
 {
@@ -1104,7 +1136,8 @@ static void __devinit vt1211_init_device(struct vt1211_data *data)
 		vt1211_write8(data, VT1211_REG_UCH_CONFIG, data->uch_config);
 	}
 
-	/* Initialize the interrupt mode (if request at module load time).
+	/*
+	 * Initialize the interrupt mode (if request at module load time).
 	 * The VT1211 implements 3 different modes for clearing interrupts:
 	 * 0: Clear INT when status register is read. Regenerate INT as long
 	 *    as temp stays above hysteresis limit.
@@ -1114,7 +1147,8 @@ static void __devinit vt1211_init_device(struct vt1211_data *data)
 	 * 2: Clear INT when temp falls below max limit.
 	 *
 	 * The driver only allows to force mode 0 since that's the only one
-	 * that makes sense for 'sensors' */
+	 * that makes sense for 'sensors'
+	 */
 	if (int_mode = 0) {
 		vt1211_write8(data, VT1211_REG_TEMP1_CONFIG, 0);
 		vt1211_write8(data, VT1211_REG_TEMP2_CONFIG, 0);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
