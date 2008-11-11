From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 11 Nov 2008 09:14:57 +0000
Subject: [lm-sensors] PATCH: cleanups for watchdog support for the fschmd
Message-Id: <49194D11.5020103@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010405020404000509090601"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010405020404000509090601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean (and all),

Various small cleanups in preparation of adding watchdog support,
mostly removing _MASK postfix from defines which are not masks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


--------------010405020404000509090601
Content-Type: text/plain;
 name="hwmon-fschmd-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hwmon-fschmd-cleanup.patch"

Various small cleanups in preparation of adding watchdog support,
mostly removing _MASK postfix from defines which are not masks.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
diff -up linux-2.6.28-rc4/drivers/hwmon/fschmd.c.realorig linux-2.6.28-rc4/drivers/hwmon/fschmd.c
--- linux-2.6.28-rc4/drivers/hwmon/fschmd.c.realorig	2008-11-10 11:14:05.000000000 +0100
+++ linux-2.6.28-rc4/drivers/hwmon/fschmd.c	2008-11-10 12:17:43.000000000 +0100
@@ -1,6 +1,6 @@
 /* fschmd.c
  *
- * Copyright (C) 2007 Hans de Goede <j.w.r.degoede@hhs.nl>
+ * Copyright (C) 2007,2008 Hans de Goede <hdegoede@redhat.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -63,7 +63,7 @@ I2C_CLIENT_INSMOD_5(fscpos, fscher, fscs
 #define FSCHMD_REG_EVENT_STATE		0x04
 #define FSCHMD_REG_CONTROL		0x05
 
-#define FSCHMD_CONTROL_ALERT_LED_MASK	0x01
+#define FSCHMD_CONTROL_ALERT_LED	0x01
 
 /* watchdog (support to be implemented) */
 #define FSCHMD_REG_WDOG_PRESET		0x28
@@ -115,8 +115,8 @@ static const u8 FSCHMD_REG_FAN_RIPPLE[5]
 static const int FSCHMD_NO_FAN_SENSORS[5] = { 3, 3, 6, 4, 5 };
 
 /* Fan status register bitmasks */
-#define FSCHMD_FAN_ALARM_MASK		0x04 /* called fault by FSC! */
-#define FSCHMD_FAN_NOT_PRESENT_MASK	0x08 /* not documented */
+#define FSCHMD_FAN_ALARM	0x04 /* called fault by FSC! */
+#define FSCHMD_FAN_NOT_PRESENT	0x08 /* not documented */
 
 
 /* actual temperature registers */
@@ -158,14 +158,11 @@ static const u8 FSCHER_REG_TEMP_AUTOP2[]
 static const int FSCHMD_NO_TEMP_SENSORS[5] = { 3, 3, 4, 3, 5 };
 
 /* temp status register bitmasks */
-#define FSCHMD_TEMP_WORKING_MASK	0x01
-#define FSCHMD_TEMP_ALERT_MASK		0x02
+#define FSCHMD_TEMP_WORKING	0x01
+#define FSCHMD_TEMP_ALERT	0x02
 /* there only really is an alarm if the sensor is working and alert == 1 */
 #define FSCHMD_TEMP_ALARM_MASK \
-	(FSCHMD_TEMP_WORKING_MASK | FSCHMD_TEMP_ALERT_MASK)
-
-/* our driver name */
-#define FSCHMD_NAME "fschmd"
+	(FSCHMD_TEMP_WORKING | FSCHMD_TEMP_ALERT)
 
 /*
  * Functions declarations
@@ -195,7 +192,7 @@ MODULE_DEVICE_TABLE(i2c, fschmd_id);
 static struct i2c_driver fschmd_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
-		.name	= FSCHMD_NAME,
+		.name	= "fschmd",
 	},
 	.probe		= fschmd_probe,
 	.remove		= fschmd_remove,
@@ -300,7 +297,7 @@ static ssize_t show_temp_fault(struct de
 	struct fschmd_data *data = fschmd_update_device(dev);
 
 	/* bit 0 set means sensor working ok, so no fault! */
-	if (data->temp_status[index] & FSCHMD_TEMP_WORKING_MASK)
+	if (data->temp_status[index] & FSCHMD_TEMP_WORKING)
 		return sprintf(buf, "0\n");
 	else
 		return sprintf(buf, "1\n");
@@ -385,7 +382,7 @@ static ssize_t show_fan_alarm(struct dev
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct fschmd_data *data = fschmd_update_device(dev);
 
-	if (data->fan_status[index] & FSCHMD_FAN_ALARM_MASK)
+	if (data->fan_status[index] & FSCHMD_FAN_ALARM)
 		return sprintf(buf, "1\n");
 	else
 		return sprintf(buf, "0\n");
@@ -397,7 +394,7 @@ static ssize_t show_fan_fault(struct dev
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct fschmd_data *data = fschmd_update_device(dev);
 
-	if (data->fan_status[index] & FSCHMD_FAN_NOT_PRESENT_MASK)
+	if (data->fan_status[index] & FSCHMD_FAN_NOT_PRESENT)
 		return sprintf(buf, "1\n");
 	else
 		return sprintf(buf, "0\n");
@@ -449,7 +446,7 @@ static ssize_t show_alert_led(struct dev
 {
 	struct fschmd_data *data = fschmd_update_device(dev);
 
-	if (data->global_control & FSCHMD_CONTROL_ALERT_LED_MASK)
+	if (data->global_control & FSCHMD_CONTROL_ALERT_LED)
 		return sprintf(buf, "1\n");
 	else
 		return sprintf(buf, "0\n");
@@ -467,9 +464,9 @@ static ssize_t store_alert_led(struct de
 	reg = i2c_smbus_read_byte_data(to_i2c_client(dev), FSCHMD_REG_CONTROL);
 
 	if (v)
-		reg |= FSCHMD_CONTROL_ALERT_LED_MASK;
+		reg |= FSCHMD_CONTROL_ALERT_LED;
 	else
-		reg &= ~FSCHMD_CONTROL_ALERT_LED_MASK;
+		reg &= ~FSCHMD_CONTROL_ALERT_LED;
 
 	i2c_smbus_write_byte_data(to_i2c_client(dev), FSCHMD_REG_CONTROL, reg);
 
@@ -683,11 +680,11 @@ static int fschmd_probe(struct i2c_clien
 	}
 
 	/* Read the special DMI table for fscher and newer chips */
-	if (kind == fscher || kind >= fschrc) {
+	if ((kind == fscher || kind >= fschrc) && dmi_vref == -1) {
 		dmi_walk(fschmd_dmi_decode);
 		if (dmi_vref == -1) {
-			printk(KERN_WARNING FSCHMD_NAME
-				": Couldn't get voltage scaling factors from "
+			dev_warn(&client->dev,
+				"Couldn't get voltage scaling factors from "
 				"BIOS DMI table, using builtin defaults\n");
 			dmi_vref = 33;
 		}
@@ -736,7 +733,7 @@ static int fschmd_probe(struct i2c_clien
 	}
 
 	revision = i2c_smbus_read_byte_data(client, FSCHMD_REG_REVISION);
-	printk(KERN_INFO FSCHMD_NAME ": Detected FSC %s chip, revision: %d\n",
+	dev_info(&client->dev, "Detected FSC %s chip, revision: %d\n",
 		names[data->kind], (int) revision);
 
 	return 0;
@@ -798,7 +795,7 @@ static struct fschmd_data *fschmd_update
 					data->temp_act[i] < data->temp_max[i])
 				i2c_smbus_write_byte_data(client,
 					FSCHMD_REG_TEMP_STATE[data->kind][i],
-					FSCHMD_TEMP_ALERT_MASK);
+					FSCHMD_TEMP_ALERT);
 		}
 
 		for (i = 0; i < FSCHMD_NO_FAN_SENSORS[data->kind]; i++) {
@@ -816,11 +813,11 @@ static struct fschmd_data *fschmd_update
 					FSCHMD_REG_FAN_MIN[data->kind][i]);
 
 			/* reset fan status if speed is back to > 0 */
-			if ((data->fan_status[i] & FSCHMD_FAN_ALARM_MASK) &&
+			if ((data->fan_status[i] & FSCHMD_FAN_ALARM) &&
 					data->fan_act[i])
 				i2c_smbus_write_byte_data(client,
 					FSCHMD_REG_FAN_STATE[data->kind][i],
-					FSCHMD_FAN_ALARM_MASK);
+					FSCHMD_FAN_ALARM);
 		}
 
 		for (i = 0; i < 3; i++)
@@ -857,7 +854,7 @@ static void __exit fschmd_exit(void)
 	i2c_del_driver(&fschmd_driver);
 }
 
-MODULE_AUTHOR("Hans de Goede <j.w.r.degoede@hhs.nl>");
+MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com>");
 MODULE_DESCRIPTION("FSC Poseidon, Hermes, Scylla, Heracles and "
 			"Heimdall driver");
 MODULE_LICENSE("GPL");

--------------010405020404000509090601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010405020404000509090601--
