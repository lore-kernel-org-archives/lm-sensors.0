From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 16 Jan 2012 08:49:09 +0000
Subject: [lm-sensors] [PATCH 07/39] hwmon: (adt7462) Fix checkpatch issues
Message-Id: <1326703781-14272-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fixed:
ERROR: that open brace { should be on the previous line
WARNING: please, no space before tabs

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7462.c |  111 +++++++++++++++++++++++------------------------
 1 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index 7a14948..3df331a 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -65,68 +65,68 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 #define ADT7462_REG_PWM_TEMP_MIN_MAX_ADDR	0x5F
 #define ADT7462_REG_PWM_TEMP_RANGE_BASE_ADDR	0x60
 #define ADT7462_REG_PWM_TEMP_RANGE_MAX_ADDR	0x63
-#define 	ADT7462_PWM_HYST_MASK		0x0F
-#define 	ADT7462_PWM_RANGE_MASK		0xF0
-#define		ADT7462_PWM_RANGE_SHIFT		4
+#define ADT7462_PWM_HYST_MASK			0x0F
+#define ADT7462_PWM_RANGE_MASK			0xF0
+#define	ADT7462_PWM_RANGE_SHIFT			4
 #define ADT7462_REG_PWM_CFG_BASE_ADDR		0x21
 #define ADT7462_REG_PWM_CFG_MAX_ADDR		0x24
-#define		ADT7462_PWM_CHANNEL_MASK	0xE0
-#define		ADT7462_PWM_CHANNEL_SHIFT	5
+#define	ADT7462_PWM_CHANNEL_MASK		0xE0
+#define	ADT7462_PWM_CHANNEL_SHIFT		5
 
 #define ADT7462_REG_PIN_CFG_BASE_ADDR		0x10
 #define ADT7462_REG_PIN_CFG_MAX_ADDR		0x13
-#define		ADT7462_PIN7_INPUT		0x01	/* cfg0 */
-#define		ADT7462_DIODE3_INPUT		0x20
-#define		ADT7462_DIODE1_INPUT		0x40
-#define		ADT7462_VID_INPUT		0x80
-#define		ADT7462_PIN22_INPUT		0x04	/* cfg1 */
-#define		ADT7462_PIN21_INPUT		0x08
-#define		ADT7462_PIN19_INPUT		0x10
-#define		ADT7462_PIN15_INPUT		0x20
-#define		ADT7462_PIN13_INPUT		0x40
-#define		ADT7462_PIN8_INPUT		0x80
-#define 	ADT7462_PIN23_MASK		0x03
-#define		ADT7462_PIN23_SHIFT		0
-#define		ADT7462_PIN26_MASK		0x0C	/* cfg2 */
-#define		ADT7462_PIN26_SHIFT		2
-#define		ADT7462_PIN25_MASK		0x30
-#define		ADT7462_PIN25_SHIFT		4
-#define		ADT7462_PIN24_MASK		0xC0
-#define		ADT7462_PIN24_SHIFT		6
-#define		ADT7462_PIN26_VOLT_INPUT	0x08
-#define		ADT7462_PIN25_VOLT_INPUT	0x20
-#define		ADT7462_PIN28_SHIFT		4	/* cfg3 */
-#define		ADT7462_PIN28_VOLT		0x5
+#define	ADT7462_PIN7_INPUT			0x01	/* cfg0 */
+#define	ADT7462_DIODE3_INPUT			0x20
+#define	ADT7462_DIODE1_INPUT			0x40
+#define	ADT7462_VID_INPUT			0x80
+#define	ADT7462_PIN22_INPUT			0x04	/* cfg1 */
+#define	ADT7462_PIN21_INPUT			0x08
+#define	ADT7462_PIN19_INPUT			0x10
+#define	ADT7462_PIN15_INPUT			0x20
+#define	ADT7462_PIN13_INPUT			0x40
+#define	ADT7462_PIN8_INPUT			0x80
+#define ADT7462_PIN23_MASK			0x03
+#define	ADT7462_PIN23_SHIFT			0
+#define	ADT7462_PIN26_MASK			0x0C	/* cfg2 */
+#define	ADT7462_PIN26_SHIFT			2
+#define	ADT7462_PIN25_MASK			0x30
+#define	ADT7462_PIN25_SHIFT			4
+#define	ADT7462_PIN24_MASK			0xC0
+#define	ADT7462_PIN24_SHIFT			6
+#define	ADT7462_PIN26_VOLT_INPUT		0x08
+#define	ADT7462_PIN25_VOLT_INPUT		0x20
+#define	ADT7462_PIN28_SHIFT			4	/* cfg3 */
+#define	ADT7462_PIN28_VOLT			0x5
 
 #define ADT7462_REG_ALARM1			0xB8
-#define 	ADT7462_LT_ALARM		0x02
-#define		ADT7462_R1T_ALARM		0x04
-#define		ADT7462_R2T_ALARM		0x08
-#define		ADT7462_R3T_ALARM		0x10
+#define ADT7462_LT_ALARM			0x02
+#define	ADT7462_R1T_ALARM			0x04
+#define	ADT7462_R2T_ALARM			0x08
+#define	ADT7462_R3T_ALARM			0x10
 #define ADT7462_REG_ALARM2			0xBB
-#define		ADT7462_V0_ALARM		0x01
-#define		ADT7462_V1_ALARM		0x02
-#define		ADT7462_V2_ALARM		0x04
-#define		ADT7462_V3_ALARM		0x08
-#define		ADT7462_V4_ALARM		0x10
-#define		ADT7462_V5_ALARM		0x20
-#define		ADT7462_V6_ALARM		0x40
-#define		ADT7462_V7_ALARM		0x80
+#define	ADT7462_V0_ALARM			0x01
+#define	ADT7462_V1_ALARM			0x02
+#define	ADT7462_V2_ALARM			0x04
+#define	ADT7462_V3_ALARM			0x08
+#define	ADT7462_V4_ALARM			0x10
+#define	ADT7462_V5_ALARM			0x20
+#define	ADT7462_V6_ALARM			0x40
+#define	ADT7462_V7_ALARM			0x80
 #define ADT7462_REG_ALARM3			0xBC
-#define		ADT7462_V8_ALARM		0x08
-#define		ADT7462_V9_ALARM		0x10
-#define		ADT7462_V10_ALARM		0x20
-#define		ADT7462_V11_ALARM		0x40
-#define		ADT7462_V12_ALARM		0x80
+#define	ADT7462_V8_ALARM			0x08
+#define	ADT7462_V9_ALARM			0x10
+#define	ADT7462_V10_ALARM			0x20
+#define	ADT7462_V11_ALARM			0x40
+#define	ADT7462_V12_ALARM			0x80
 #define ADT7462_REG_ALARM4			0xBD
-#define		ADT7462_F0_ALARM		0x01
-#define		ADT7462_F1_ALARM		0x02
-#define		ADT7462_F2_ALARM		0x04
-#define		ADT7462_F3_ALARM		0x08
-#define		ADT7462_F4_ALARM		0x10
-#define		ADT7462_F5_ALARM		0x20
-#define		ADT7462_F6_ALARM		0x40
-#define		ADT7462_F7_ALARM		0x80
+#define	ADT7462_F0_ALARM			0x01
+#define	ADT7462_F1_ALARM			0x02
+#define	ADT7462_F2_ALARM			0x04
+#define	ADT7462_F3_ALARM			0x08
+#define	ADT7462_F4_ALARM			0x10
+#define	ADT7462_F5_ALARM			0x20
+#define	ADT7462_F6_ALARM			0x40
+#define	ADT7462_F7_ALARM			0x80
 #define ADT7462_ALARM1				0x0000
 #define ADT7462_ALARM2				0x0100
 #define ADT7462_ALARM3				0x0200
@@ -136,8 +136,8 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 
 #define ADT7462_TEMP_COUNT		4
 #define ADT7462_TEMP_REG(x)		(ADT7462_REG_TEMP_BASE_ADDR + (x * 2))
-#define ADT7462_TEMP_MIN_REG(x) 	(ADT7462_REG_MIN_TEMP_BASE_ADDR + (x))
-#define ADT7462_TEMP_MAX_REG(x) 	(ADT7462_REG_MAX_TEMP_BASE_ADDR + (x))
+#define ADT7462_TEMP_MIN_REG(x)		(ADT7462_REG_MIN_TEMP_BASE_ADDR + (x))
+#define ADT7462_TEMP_MAX_REG(x)		(ADT7462_REG_MAX_TEMP_BASE_ADDR + (x))
 #define TEMP_FRAC_OFFSET		6
 
 #define ADT7462_FAN_COUNT		8
@@ -1727,8 +1727,7 @@ static SENSOR_DEVICE_ATTR(pwm3_auto_channels_temp, S_IWUSR | S_IRUGO,
 static SENSOR_DEVICE_ATTR(pwm4_auto_channels_temp, S_IWUSR | S_IRUGO,
 		    show_pwm_auto_temp, set_pwm_auto_temp, 3);
 
-static struct attribute *adt7462_attr[] -{
+static struct attribute *adt7462_attr[] = {
 	&sensor_dev_attr_temp1_max.dev_attr.attr,
 	&sensor_dev_attr_temp2_max.dev_attr.attr,
 	&sensor_dev_attr_temp3_max.dev_attr.attr,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
