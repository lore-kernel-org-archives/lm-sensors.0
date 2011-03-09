From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 09 Mar 2011 19:57:16 +0000
Subject: [lm-sensors] [PATCH 10/10] hwmon/f71882fg: Add support for f71808e
Message-Id: <1299700636-9699-11-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/f71882fg.c |   61 ++++++++++++++++++++++++++++++----------------
 1 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 753c756..84fbf36 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -47,6 +47,7 @@
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
 
 #define SIO_FINTEK_ID		0x1934	/* Manufacturers ID */
+#define SIO_F71808E_ID		0x0901	/* Chipset ID */
 #define SIO_F71858_ID		0x0507  /* Chipset ID */
 #define SIO_F71862_ID		0x0601	/* Chipset ID */
 #define SIO_F71869_ID		0x0814	/* Chipset ID */
@@ -104,9 +105,11 @@ static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-enum chips { f71858fg, f71862fg, f71869, f71882fg, f71889fg, f71889ed, f8000 };
+enum chips { f71808e, f71858fg, f71862fg, f71869, f71882fg, f71889fg,
+	     f71889ed, f8000 };
 
 static const char *f71882fg_names[] = {
+	"f71808e",
 	"f71858fg",
 	"f71862fg",
 	"f71869", /* Both f71869f and f71869e, reg. compatible and same id */
@@ -116,7 +119,8 @@ static const char *f71882fg_names[] = {
 	"f8000",
 };
 
-static const char f71882fg_has_in[7][F71882FG_MAX_INS] = {
+static const char f71882fg_has_in[8][F71882FG_MAX_INS] = {
+	{ 1, 1, 1, 1, 1, 1, 0, 1, 1 }, /* f71808e */
 	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f71858fg */
 	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71862fg */
 	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71869 */
@@ -126,7 +130,8 @@ static const char f71882fg_has_in[7][F71882FG_MAX_INS] = {
 	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f8000 */
 };
 
-static const char f71882fg_has_in1_alarm[7] = {
+static const char f71882fg_has_in1_alarm[8] = {
+	0, /* f71808e */
 	0, /* f71858fg */
 	0, /* f71862fg */
 	0, /* f71869 */
@@ -136,7 +141,8 @@ static const char f71882fg_has_in1_alarm[7] = {
 	0, /* f8000 */
 };
 
-static const char f71882fg_has_beep[7] = {
+static const char f71882fg_has_beep[8] = {
+	0, /* f71808e */
 	0, /* f71858fg */
 	1, /* f71862fg */
 	1, /* f71869 */
@@ -181,7 +187,7 @@ struct f71882fg_data {
 	u16	fan_full_speed[4];
 	u8	fan_status;
 	u8	fan_beep;
-	/* Note: all models have only 3 temperature channels, but on some
+	/* Note: all models have max 3 temperature channels, but on some
 	   they are addressed as 0-2 and on others as 1-3, so for coding
 	   convenience we reserve space for 4 channels */
 	u16	temp[4];
@@ -590,7 +596,7 @@ static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[] = {
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
 };
 
-/* PWM attr for the f71869, almost identical to the f71862fg, but the
+/* PWM attr for the f71808e/f71869, almost identical to the f71862fg, but the
    pwm setting when the temperature is above the pwmX_auto_point1_temp can be
    programmed instead of being hardcoded to 0xff */
 static struct sensor_device_attribute_2 f71869_auto_pwm_attr[] = {
@@ -1065,8 +1071,9 @@ static u16 f71882fg_read_temp(struct f71882fg_data *data, int nr)
 static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int nr, reg;
+	int nr, reg, point;
 	int nr_fans = (data->type = f71882fg) ? 4 : 3;
+	int nr_temps = (data->type = f71808e) ? 3 : 2;
 
 	mutex_lock(&data->update_lock);
 
@@ -1081,7 +1088,8 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 		}
 
 		/* Get High & boundary temps*/
-		for (nr = data->temp_start; nr < 3 + data->temp_start; nr++) {
+		for (nr = data->temp_start; nr < nr_temps + data->temp_start;
+									nr++) {
 			data->temp_ovt[nr] = f71882fg_read8(data,
 						F71882FG_REG_TEMP_OVT(nr));
 			data->temp_high[nr] = f71882fg_read8(data,
@@ -1121,8 +1129,8 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 			    f71882fg_read8(data,
 					   F71882FG_REG_POINT_MAPPING(nr));
 
-			if (data->type != f71862fg && data->type != f71869) {
-				int point;
+			switch (data->type) {
+			default:
 				for (point = 0; point < 5; point++) {
 					data->pwm_auto_point_pwm[nr][point]  						f71882fg_read8(data,
@@ -1135,13 +1143,14 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 							F71882FG_REG_POINT_TEMP
 							(nr, point));
 				}
-			} else {
-				if (data->type = f71869) {
-					data->pwm_auto_point_pwm[nr][0] -						f71882fg_read8(data,
-							F71882FG_REG_POINT_PWM
-							(nr, 0));
-				}
+				break;
+			case f71808e:
+			case f71869:
+				data->pwm_auto_point_pwm[nr][0] +					f71882fg_read8(data,
+						F71882FG_REG_POINT_PWM(nr, 0));
+				/* Fall through */
+			case f71862fg:
 				data->pwm_auto_point_pwm[nr][1]  					f71882fg_read8(data,
 						F71882FG_REG_POINT_PWM
@@ -1158,6 +1167,7 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 					f71882fg_read8(data,
 						F71882FG_REG_POINT_TEMP
 						(nr, 3));
+				break;
 			}
 		}
 		data->last_limits = jiffies;
@@ -1169,7 +1179,8 @@ static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 						F71882FG_REG_TEMP_STATUS);
 		data->temp_diode_open = f71882fg_read8(data,
 						F71882FG_REG_TEMP_DIODE_OPEN);
-		for (nr = data->temp_start; nr < 3 + data->temp_start; nr++)
+		for (nr = data->temp_start; nr < nr_temps + data->temp_start;
+									nr++)
 			data->temp[nr] = f71882fg_read_temp(data, nr);
 
 		data->fan_status = f71882fg_read8(data,
@@ -2032,7 +2043,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 	struct f71882fg_data *data;
 	struct f71882fg_sio_data *sio_data = pdev->dev.platform_data;
 	int err, i, nr_fans = (sio_data->type = f71882fg) ? 4 : 3;
-	int nr_temps = 3;
+	int nr_temps = (sio_data->type = f71808e) ? 3 : 2;
 	u8 start_reg, reg;
 
 	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
@@ -2120,8 +2131,9 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 
 	if (start_reg & 0x02) {
 		switch (data->type) {
+		case f71808e:
 		case f71869:
-			/* The f71869 always has signed auto point temps */
+			/* These always have signed auto point temps */
 			data->auto_point_temp_signed = 1;
 			/* Fall through to select correct fan/pwm reg bank! */
 		case f71889fg:
@@ -2151,6 +2163,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		case f71862fg:
 			err = (data->pwm_enable & 0x15) != 0x15;
 			break;
+		case f71808e:
 		case f71869:
 		case f71882fg:
 		case f71889fg:
@@ -2182,6 +2195,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 		}
 
 		switch (data->type) {
+		case f71808e:
 		case f71869:
 		case f71889fg:
 		case f71889ed:
@@ -2211,6 +2225,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 					f71862fg_auto_pwm_attr,
 					ARRAY_SIZE(f71862fg_auto_pwm_attr));
 			break;
+		case f71808e:
 		case f71869:
 			err = f71882fg_create_sysfs_files(pdev,
 					f71869_auto_pwm_attr,
@@ -2262,7 +2277,7 @@ static int f71882fg_remove(struct platform_device *pdev)
 {
 	struct f71882fg_data *data = platform_get_drvdata(pdev);
 	int i, nr_fans = (data->type = f71882fg) ? 4 : 3;
-	int nr_temps = 3;
+	int nr_temps = (data->type = f71808e) ? 3 : 2;
 	u8 start_reg = f71882fg_read8(data, F71882FG_REG_START);
 
 	platform_set_drvdata(pdev, NULL);
@@ -2327,6 +2342,7 @@ static int f71882fg_remove(struct platform_device *pdev)
 					f71862fg_auto_pwm_attr,
 					ARRAY_SIZE(f71862fg_auto_pwm_attr));
 			break;
+		case f71808e:
 		case f71869:
 			f71882fg_remove_sysfs_files(pdev,
 					f71869_auto_pwm_attr,
@@ -2369,6 +2385,9 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 
 	devid = force_id ? force_id : superio_inw(sioaddr, SIO_REG_DEVID);
 	switch (devid) {
+	case SIO_F71808E_ID:
+		sio_data->type = f71808e;
+		break;
 	case SIO_F71858_ID:
 		sio_data->type = f71858fg;
 		break;
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
