From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Feb 2008 10:25:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83793) VID and VRM handling cleanups
Message-Id: <20080212112507.5c67cd0f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Rework the device initialization function so as to read the
"Multi-Function Pin Control" register (0x58) once instead of twice.
I2C transactions aren't cheap so this speeds up the driver loading.

* Only create the "vrm" attribute if at least one VID value is
available.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Gong Jun <jgong@winbond.com>
Cc: Rudolf Marek <r.marek@assembler.cz>
---
Gong Jun and/or Rudolf, can you please review and/or test this patch?

 drivers/hwmon/w83793.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

--- linux-2.6.24-rc7.orig/drivers/hwmon/w83793.c	2008-01-12 22:28:09.000000000 +0100
+++ linux-2.6.24-rc7/drivers/hwmon/w83793.c	2008-01-13 13:51:56.000000000 +0100
@@ -1023,10 +1023,9 @@ static struct sensor_device_attribute_2 
 	SENSOR_ATTR_2(cpu0_vid, S_IRUGO, show_vid, NULL, NOT_USED, 0),
 	SENSOR_ATTR_2(cpu1_vid, S_IRUGO, show_vid, NULL, NOT_USED, 1),
 };
+static DEVICE_ATTR(vrm, S_IWUSR | S_IRUGO, show_vrm, store_vrm);
 
 static struct sensor_device_attribute_2 sda_single_files[] = {
-	SENSOR_ATTR_2(vrm, S_IWUSR | S_IRUGO, show_vrm, store_vrm,
-		      NOT_USED, NOT_USED),
 	SENSOR_ATTR_2(chassis, S_IWUSR | S_IRUGO, show_alarm_beep,
 		      store_chassis_clear, ALARM_STATUS, 30),
 	SENSOR_ATTR_2(beep_enable, S_IWUSR | S_IRUGO, show_beep_enable,
@@ -1079,6 +1078,7 @@ static int w83793_detach_client(struct i
 
 		for (i = 0; i < ARRAY_SIZE(w83793_vid); i++)
 			device_remove_file(dev, &w83793_vid[i].dev_attr);
+		device_remove_file(dev, &dev_attr_vrm);
 
 		for (i = 0; i < ARRAY_SIZE(w83793_left_fan); i++)
 			device_remove_file(dev, &w83793_left_fan[i].dev_attr);
@@ -1281,7 +1281,6 @@ static int w83793_detect(struct i2c_adap
 	/* Initialize the chip */
 	w83793_init_client(client);
 
-	data->vrm = vid_which_vrm();
 	/*
 	   Only fan 1-5 has their own input pins,
 	   Pwm 1-3 has their own pins
@@ -1292,7 +1291,9 @@ static int w83793_detect(struct i2c_adap
 	val = w83793_read_value(client, W83793_REG_FANIN_CTRL);
 
 	/* check the function of pins 49-56 */
-	if (!(tmp & 0x80)) {
+	if (tmp & 0x80) {
+		data->has_vid |= 0x2;	/* has VIDB */
+	} else {
 		data->has_pwm |= 0x18;	/* pwm 4,5 */
 		if (val & 0x01) {	/* fan 6 */
 			data->has_fan |= 0x20;
@@ -1308,13 +1309,15 @@ static int w83793_detect(struct i2c_adap
 		}
 	}
 
+	/* check the function of pins 37-40 */
+	if (!(tmp & 0x29))
+		data->has_vid |= 0x1;	/* has VIDA */
 	if (0x08 = (tmp & 0x0c)) {
 		if (val & 0x08)	/* fan 9 */
 			data->has_fan |= 0x100;
 		if (val & 0x10)	/* fan 10 */
 			data->has_fan |= 0x200;
 	}
-
 	if (0x20 = (tmp & 0x30)) {
 		if (val & 0x20)	/* fan 11 */
 			data->has_fan |= 0x400;
@@ -1358,13 +1361,6 @@ static int w83793_detect(struct i2c_adap
 	if (tmp & 0x02)
 		data->has_temp |= 0x20;
 
-	/* Detect the VID usage and ignore unused input */
-	tmp = w83793_read_value(client, W83793_REG_MFC);
-	if (!(tmp & 0x29))
-		data->has_vid |= 0x1;	/* has VIDA */
-	if (tmp & 0x80)
-		data->has_vid |= 0x2;	/* has VIDB */
-
 	/* Register sysfs hooks */
 	for (i = 0; i < ARRAY_SIZE(w83793_sensor_attr_2); i++) {
 		err = device_create_file(dev,
@@ -1380,6 +1376,12 @@ static int w83793_detect(struct i2c_adap
 		if (err)
 			goto exit_remove;
 	}
+	if (data->has_vid) {
+		data->vrm = vid_which_vrm();
+		err = device_create_file(dev, &dev_attr_vrm);
+		if (err)
+			goto exit_remove;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(sda_single_files); i++) {
 		err = device_create_file(dev, &sda_single_files[i].dev_attr);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
