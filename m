From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 09 Mar 2011 19:57:15 +0000
Subject: [lm-sensors] [PATCH 09/10] hwmon/f71882fg: Add support for f71869f
Message-Id: <1299700636-9699-10-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Note that these 2 are register compatible and report the same superio id,
but they are 2 distinct chips / models!

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/hwmon/f71882fg |    4 ++
 drivers/hwmon/f71882fg.c     |  120 ++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 119 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/f71882fg b/Documentation/hwmon/f71882fg
index 9aa210c..4d0bc70 100644
--- a/Documentation/hwmon/f71882fg
+++ b/Documentation/hwmon/f71882fg
@@ -10,6 +10,10 @@ Supported chips:
     Prefix: 'f71862fg'
     Addresses scanned: none, address read from Super I/O config space
     Datasheet: Available from the Fintek website
+  * Fintek F71869F and F71869E
+    Prefix: 'f71869'
+    Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Available from the Fintek website
   * Fintek F71882FG and F71883FG
     Prefix: 'f71882fg'
     Addresses scanned: none, address read from Super I/O config space
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 29e9512..753c756 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -49,6 +49,7 @@
 #define SIO_FINTEK_ID		0x1934	/* Manufacturers ID */
 #define SIO_F71858_ID		0x0507  /* Chipset ID */
 #define SIO_F71862_ID		0x0601	/* Chipset ID */
+#define SIO_F71869_ID		0x0814	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
 #define SIO_F71889E_ID		0x0909	/* Chipset ID */
@@ -103,38 +104,42 @@ static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f71889ed, f8000 };
+enum chips { f71858fg, f71862fg, f71869, f71882fg, f71889fg, f71889ed, f8000 };
 
 static const char *f71882fg_names[] = {
 	"f71858fg",
 	"f71862fg",
+	"f71869", /* Both f71869f and f71869e, reg. compatible and same id */
 	"f71882fg",
 	"f71889fg",
 	"f71889ed",
 	"f8000",
 };
 
-static const char f71882fg_has_in[6][F71882FG_MAX_INS] = {
+static const char f71882fg_has_in[7][F71882FG_MAX_INS] = {
 	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f71858fg */
 	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71862fg */
+	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71869 */
 	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71882fg */
 	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71889fg */
 	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71889ed */
 	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f8000 */
 };
 
-static const char f71882fg_has_in1_alarm[6] = {
+static const char f71882fg_has_in1_alarm[7] = {
 	0, /* f71858fg */
 	0, /* f71862fg */
+	0, /* f71869 */
 	1, /* f71882fg */
 	1, /* f71889fg */
 	1, /* f71889ed */
 	0, /* f8000 */
 };
 
-static const char f71882fg_has_beep[6] = {
+static const char f71882fg_has_beep[7] = {
 	0, /* f71858fg */
 	1, /* f71862fg */
+	1, /* f71869 */
 	1, /* f71882fg */
 	1, /* f71889fg */
 	1, /* f71889ed */
@@ -585,6 +590,86 @@ static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[] = {
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
 };
 
+/* PWM attr for the f71869, almost identical to the f71862fg, but the
+   pwm setting when the temperature is above the pwmX_auto_point1_temp can be
+   programmed instead of being hardcoded to 0xff */
+static struct sensor_device_attribute_2 f71869_auto_pwm_attr[] = {
+	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
+
+	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
+
+	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
+};
+
 /* PWM attr for the standard models */
 static struct sensor_device_attribute_2 fxxxx_auto_pwm_attr[4][14] = { {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
@@ -1036,7 +1121,7 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 			    f71882fg_read8(data,
 					   F71882FG_REG_POINT_MAPPING(nr));
 
-			if (data->type != f71862fg) {
+			if (data->type != f71862fg && data->type != f71869) {
 				int point;
 				for (point = 0; point < 5; point++) {
 					data->pwm_auto_point_pwm[nr][point] @@ -1051,6 +1136,12 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 							(nr, point));
 				}
 			} else {
+				if (data->type = f71869) {
+					data->pwm_auto_point_pwm[nr][0] +						f71882fg_read8(data,
+							F71882FG_REG_POINT_PWM
+							(nr, 0));
+				}
 				data->pwm_auto_point_pwm[nr][1]  					f71882fg_read8(data,
 						F71882FG_REG_POINT_PWM
@@ -2029,6 +2120,10 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 
 	if (start_reg & 0x02) {
 		switch (data->type) {
+		case f71869:
+			/* The f71869 always has signed auto point temps */
+			data->auto_point_temp_signed = 1;
+			/* Fall through to select correct fan/pwm reg bank! */
 		case f71889fg:
 		case f71889ed:
 			reg = f71882fg_read8(data, F71882FG_REG_FAN_FAULT_T);
@@ -2056,6 +2151,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		case f71862fg:
 			err = (data->pwm_enable & 0x15) != 0x15;
 			break;
+		case f71869:
 		case f71882fg:
 		case f71889fg:
 		case f71889ed:
@@ -2086,6 +2182,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		}
 
 		switch (data->type) {
+		case f71869:
 		case f71889fg:
 		case f71889ed:
 			for (i = 0; i < nr_fans; i++) {
@@ -2114,6 +2211,11 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 					f71862fg_auto_pwm_attr,
 					ARRAY_SIZE(f71862fg_auto_pwm_attr));
 			break;
+		case f71869:
+			err = f71882fg_create_sysfs_files(pdev,
+					f71869_auto_pwm_attr,
+					ARRAY_SIZE(f71869_auto_pwm_attr));
+			break;
 		case f8000:
 			err = f71882fg_create_sysfs_files(pdev,
 					f8000_fan_attr,
@@ -2225,6 +2327,11 @@ static int f71882fg_remove(struct platform_device *pdev)
 					f71862fg_auto_pwm_attr,
 					ARRAY_SIZE(f71862fg_auto_pwm_attr));
 			break;
+		case f71869:
+			f71882fg_remove_sysfs_files(pdev,
+					f71869_auto_pwm_attr,
+					ARRAY_SIZE(f71869_auto_pwm_attr));
+			break;
 		case f8000:
 			f71882fg_remove_sysfs_files(pdev,
 					f8000_fan_attr,
@@ -2268,6 +2375,9 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 	case SIO_F71862_ID:
 		sio_data->type = f71862fg;
 		break;
+	case SIO_F71869_ID:
+		sio_data->type = f71869;
+		break;
 	case SIO_F71882_ID:
 		sio_data->type = f71882fg;
 		break;
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
