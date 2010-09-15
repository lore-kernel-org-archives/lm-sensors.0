From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Sep 2010 13:56:40 +0000
Subject: [lm-sensors] [patch 12/36] hwmon: (w83795) Add const markers
Message-Id: <20100915155640.3d3fa10b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Attribute structures can be made const. Same for the I2C address
list.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83795.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- linux-2.6.36-rc4.orig/drivers/hwmon/w83795.c	2010-09-15 15:12:22.000000000 +0200
+++ linux-2.6.36-rc4/drivers/hwmon/w83795.c	2010-09-15 15:12:45.000000000 +0200
@@ -36,7 +36,9 @@
 #include <linux/delay.h>
 
 /* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
+static const unsigned short normal_i2c[] = {
+	0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END
+};
 
 
 static int reset;
@@ -70,7 +72,7 @@ MODULE_PARM_DESC(reset, "Set to 1 to res
 #define TEMP_CTRL_SHIFT			4
 #define TEMP_CTRL_HASIN_SHIFT		5
 /* temp mode may effect VSEN17-12 (in20-15) */
-static u16 W83795_REG_TEMP_CTRL[][6] = {
+static const u16 W83795_REG_TEMP_CTRL[][6] = {
 	/* Disable, TD, VSEN, TR, register shift value, has_in shift num */
 	{0x00, 0x01, 0x02, 0x03, 0, 17},	/* TR1 */
 	{0x00, 0x04, 0x08, 0x0C, 2, 18},	/* TR2 */
@@ -87,7 +89,7 @@ static u16 W83795_REG_TEMP_CTRL[][6] = {
 #define TEMP_WARN_HYST			4
 /* only crit and crit_hyst affect real-time alarm status
  * current crit crit_hyst warn warn_hyst */
-static u16 W83795_REG_TEMP[][5] = {
+static const u16 W83795_REG_TEMP[][5] = {
 	{0x21, 0x96, 0x97, 0x98, 0x99},	/* TD1/TR1 */
 	{0x22, 0x9a, 0x9b, 0x9c, 0x9d},	/* TD2/TR2 */
 	{0x23, 0x9e, 0x9f, 0xa0, 0xa1},	/* TD3/TR3 */
@@ -1593,7 +1595,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_IN(20),
 };
 
-static struct sensor_device_attribute_2 w83795_fan[][4] = {
+static const struct sensor_device_attribute_2 w83795_fan[][4] = {
 	SENSOR_ATTR_FAN(1),
 	SENSOR_ATTR_FAN(2),
 	SENSOR_ATTR_FAN(3),
@@ -1610,7 +1612,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_FAN(14),
 };
 
-static struct sensor_device_attribute_2 w83795_temp[][29] = {
+static const struct sensor_device_attribute_2 w83795_temp[][29] = {
 	SENSOR_ATTR_TEMP(1),
 	SENSOR_ATTR_TEMP(2),
 	SENSOR_ATTR_TEMP(3),
@@ -1619,7 +1621,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_TEMP(6),
 };
 
-static struct sensor_device_attribute_2 w83795_dts[][8] = {
+static const struct sensor_device_attribute_2 w83795_dts[][8] = {
 	SENSOR_ATTR_DTS(7),
 	SENSOR_ATTR_DTS(8),
 	SENSOR_ATTR_DTS(9),
@@ -1630,7 +1632,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_DTS(14),
 };
 
-static struct sensor_device_attribute_2 w83795_pwm[][7] = {
+static const struct sensor_device_attribute_2 w83795_pwm[][7] = {
 	SENSOR_ATTR_PWM(1),
 	SENSOR_ATTR_PWM(2),
 	SENSOR_ATTR_PWM(3),
@@ -1641,7 +1643,7 @@ static struct sensor_device_attribute_2
 	SENSOR_ATTR_PWM(8),
 };
 
-static struct sensor_device_attribute_2 sda_single_files[] = {
+static const struct sensor_device_attribute_2 sda_single_files[] = {
 	SENSOR_ATTR_2(chassis, S_IWUSR | S_IRUGO, show_alarm_beep,
 		      store_chassis_clear, ALARM_STATUS, 46),
 	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_beep_enable,


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
