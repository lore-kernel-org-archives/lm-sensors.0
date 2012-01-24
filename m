From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:40 +0000
Subject: [lm-sensors] [PATCH 01/79] hwmon: (adt7462) Fix checkpatch issues
Message-Id: <1327373398-997-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fixed:
ERROR: that open brace { should be on the previous line
WARNING: please, no space before tabs

Cc: Darrick J. Wong <djwong@us.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7462.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index fede95f..339269f 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -65,8 +65,8 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 #define ADT7462_REG_PWM_TEMP_MIN_MAX_ADDR	0x5F
 #define ADT7462_REG_PWM_TEMP_RANGE_BASE_ADDR	0x60
 #define ADT7462_REG_PWM_TEMP_RANGE_MAX_ADDR	0x63
-#define 	ADT7462_PWM_HYST_MASK		0x0F
-#define 	ADT7462_PWM_RANGE_MASK		0xF0
+#define	ADT7462_PWM_HYST_MASK			0x0F
+#define	ADT7462_PWM_RANGE_MASK			0xF0
 #define		ADT7462_PWM_RANGE_SHIFT		4
 #define ADT7462_REG_PWM_CFG_BASE_ADDR		0x21
 #define ADT7462_REG_PWM_CFG_MAX_ADDR		0x24
@@ -85,7 +85,7 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 #define		ADT7462_PIN15_INPUT		0x20
 #define		ADT7462_PIN13_INPUT		0x40
 #define		ADT7462_PIN8_INPUT		0x80
-#define 	ADT7462_PIN23_MASK		0x03
+#define		ADT7462_PIN23_MASK		0x03
 #define		ADT7462_PIN23_SHIFT		0
 #define		ADT7462_PIN26_MASK		0x0C	/* cfg2 */
 #define		ADT7462_PIN26_SHIFT		2
@@ -99,7 +99,7 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 #define		ADT7462_PIN28_VOLT		0x5
 
 #define ADT7462_REG_ALARM1			0xB8
-#define 	ADT7462_LT_ALARM		0x02
+#define	ADT7462_LT_ALARM			0x02
 #define		ADT7462_R1T_ALARM		0x04
 #define		ADT7462_R2T_ALARM		0x08
 #define		ADT7462_R3T_ALARM		0x10
@@ -135,9 +135,9 @@ static const unsigned short normal_i2c[] = { 0x58, 0x5C, I2C_CLIENT_END };
 #define ADT7462_ALARM_FLAG_MASK			0x0F
 
 #define ADT7462_TEMP_COUNT		4
-#define ADT7462_TEMP_REG(x)		(ADT7462_REG_TEMP_BASE_ADDR + (x * 2))
-#define ADT7462_TEMP_MIN_REG(x) 	(ADT7462_REG_MIN_TEMP_BASE_ADDR + (x))
-#define ADT7462_TEMP_MAX_REG(x) 	(ADT7462_REG_MAX_TEMP_BASE_ADDR + (x))
+#define ADT7462_TEMP_REG(x)		(ADT7462_REG_TEMP_BASE_ADDR + ((x) * 2))
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
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
