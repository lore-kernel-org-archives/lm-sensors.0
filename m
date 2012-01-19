From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:54:56 +0000
Subject: [lm-sensors] [PATCH 02/82] hwmon: (abituguru3) Fix multi-line comments
Message-Id: <1327017376-20466-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Alistair John Strachan <alistair@devzero.co.uk>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/abituguru3.c |  211 +++++++++++++++++++++++++++-----------------
 1 files changed, 129 insertions(+), 82 deletions(-)

diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index 93ab1a5..a5bc428 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -1,28 +1,28 @@
 /*
-    abituguru3.c
-
-    Copyright (c) 2006-2008 Hans de Goede <hdegoede@redhat.com>
-    Copyright (c) 2008 Alistair John Strachan <alistair@devzero.co.uk>
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License
-    along with this program; if not, write to the Free Software
-    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
+ * abituguru3.c
+ *
+ * Copyright (c) 2006-2008 Hans de Goede <hdegoede@redhat.com>
+ * Copyright (c) 2008 Alistair John Strachan <alistair@devzero.co.uk>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
 /*
-    This driver supports the sensor part of revision 3 of the custom Abit uGuru
-    chip found on newer Abit uGuru motherboards. Note: because of lack of specs
-    only reading the sensors and their settings is supported.
-*/
+ * This driver supports the sensor part of revision 3 of the custom Abit uGuru
+ * chip found on newer Abit uGuru motherboards. Note: because of lack of specs
+ * only reading the sensors and their settings is supported.
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -62,13 +62,17 @@
 #define ABIT_UGURU3_TEMP_SENSOR			1
 #define ABIT_UGURU3_FAN_SENSOR			2
 
-/* Timeouts / Retries, if these turn out to need a lot of fiddling we could
-   convert them to params. Determined by trial and error. I assume this is
-   cpu-speed independent, since the ISA-bus and not the CPU should be the
-   bottleneck. */
+/*
+ * Timeouts / Retries, if these turn out to need a lot of fiddling we could
+ * convert them to params. Determined by trial and error. I assume this is
+ * cpu-speed independent, since the ISA-bus and not the CPU should be the
+ * bottleneck.
+ */
 #define ABIT_UGURU3_WAIT_TIMEOUT		250
-/* Normally the 0xAC at the end of synchronize() is reported after the
-   first read, but sometimes not and we need to poll */
+/*
+ * Normally the 0xAC at the end of synchronize() is reported after the
+ * first read, but sometimes not and we need to poll
+ */
 #define ABIT_UGURU3_SYNCHRONIZE_TIMEOUT		5
 /* utility macros */
 #define ABIT_UGURU3_NAME			"abituguru3"
@@ -78,33 +82,45 @@
 
 /* Macros to help calculate the sysfs_names array length */
 #define ABIT_UGURU3_MAX_NO_SENSORS 26
-/* sum of strlen +1 of: in??_input\0, in??_{min,max}\0, in??_{min,max}_alarm\0,
-   in??_{min,max}_alarm_enable\0, in??_beep\0, in??_shutdown\0, in??_label\0 */
+/*
+ * sum of strlen +1 of: in??_input\0, in??_{min,max}\0, in??_{min,max}_alarm\0,
+ * in??_{min,max}_alarm_enable\0, in??_beep\0, in??_shutdown\0, in??_label\0
+ */
 #define ABIT_UGURU3_IN_NAMES_LENGTH \
 				(11 + 2 * 9 + 2 * 15 + 2 * 22 + 10 + 14 + 11)
-/* sum of strlen +1 of: temp??_input\0, temp??_max\0, temp??_crit\0,
-   temp??_alarm\0, temp??_alarm_enable\0, temp??_beep\0, temp??_shutdown\0,
-   temp??_label\0 */
+/*
+ * sum of strlen +1 of: temp??_input\0, temp??_max\0, temp??_crit\0,
+ * temp??_alarm\0, temp??_alarm_enable\0, temp??_beep\0, temp??_shutdown\0,
+ * temp??_label\0
+ */
 #define ABIT_UGURU3_TEMP_NAMES_LENGTH (13 + 11 + 12 + 13 + 20 + 12 + 16 + 13)
-/* sum of strlen +1 of: fan??_input\0, fan??_min\0, fan??_alarm\0,
-   fan??_alarm_enable\0, fan??_beep\0, fan??_shutdown\0, fan??_label\0 */
+/*
+ * sum of strlen +1 of: fan??_input\0, fan??_min\0, fan??_alarm\0,
+ * fan??_alarm_enable\0, fan??_beep\0, fan??_shutdown\0, fan??_label\0
+ */
 #define ABIT_UGURU3_FAN_NAMES_LENGTH (12 + 10 + 12 + 19 + 11 + 15 + 12)
-/* Worst case scenario 16 in sensors (longest names_length) and the rest
-   temp sensors (second longest names_length). */
+/*
+ * Worst case scenario 16 in sensors (longest names_length) and the rest
+ * temp sensors (second longest names_length).
+ */
 #define ABIT_UGURU3_SYSFS_NAMES_LENGTH (16 * ABIT_UGURU3_IN_NAMES_LENGTH + \
 	(ABIT_UGURU3_MAX_NO_SENSORS - 16) * ABIT_UGURU3_TEMP_NAMES_LENGTH)
 
-/* All the macros below are named identical to the openguru2 program
-   reverse engineered by Louis Kruger, hence the names might not be 100%
-   logical. I could come up with better names, but I prefer keeping the names
-   identical so that this driver can be compared with his work more easily. */
+/*
+ * All the macros below are named identical to the openguru2 program
+ * reverse engineered by Louis Kruger, hence the names might not be 100%
+ * logical. I could come up with better names, but I prefer keeping the names
+ * identical so that this driver can be compared with his work more easily.
+ */
 /* Two i/o-ports are used by uGuru */
 #define ABIT_UGURU3_BASE			0x00E0
 #define ABIT_UGURU3_CMD				0x00
 #define ABIT_UGURU3_DATA			0x04
 #define ABIT_UGURU3_REGION_LENGTH		5
-/* The wait_xxx functions return this on success and the last contents
-   of the DATA register (0-255) on failure. */
+/*
+ * The wait_xxx functions return this on success and the last contents
+ * of the DATA register (0-255) on failure.
+ */
 #define ABIT_UGURU3_SUCCESS			-1
 /* uGuru status flags */
 #define ABIT_UGURU3_STATUS_READY_FOR_READ	0x01
@@ -131,9 +147,11 @@ struct abituguru3_motherboard_info {
 	struct abituguru3_sensor_info sensors[ABIT_UGURU3_MAX_NO_SENSORS + 1];
 };
 
-/* For the Abit uGuru, we need to keep some data in memory.
-   The structure is dynamically allocated, at the same time when a new
-   abituguru3 device is allocated. */
+/*
+ * For the Abit uGuru, we need to keep some data in memory.
+ * The structure is dynamically allocated, at the same time when a new
+ * abituguru3 device is allocated.
+ */
 struct abituguru3_data {
 	struct device *hwmon_dev;	/* hwmon registered device */
 	struct mutex update_lock;	/* protect access to data and uGuru */
@@ -141,8 +159,10 @@ struct abituguru3_data {
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
-	/* For convenience the sysfs attr and their names are generated
-	   automatically. We have max 10 entries per sensor (for in sensors) */
+	/*
+	 * For convenience the sysfs attr and their names are generated
+	 * automatically. We have max 10 entries per sensor (for in sensors)
+	 */
 	struct sensor_device_attribute_2 sysfs_attr[ABIT_UGURU3_MAX_NO_SENSORS
 		* 10];
 
@@ -152,9 +172,11 @@ struct abituguru3_data {
 	/* Pointer to the sensors info for the detected motherboard */
 	const struct abituguru3_sensor_info *sensors;
 
-	/* The abituguru3 supports up to 48 sensors, and thus has registers
-	   sets for 48 sensors, for convienence reasons / simplicity of the
-	   code we always read and store all registers for all 48 sensors */
+	/*
+	 * The abituguru3 supports up to 48 sensors, and thus has registers
+	 * sets for 48 sensors, for convienence reasons / simplicity of the
+	 * code we always read and store all registers for all 48 sensors
+	 */
 
 	/* Alarms for all 48 sensors (1 bit per sensor) */
 	u8 alarms[48/8];
@@ -162,9 +184,11 @@ struct abituguru3_data {
 	/* Value of all 48 sensors */
 	u8 value[48];
 
-	/* Settings of all 48 sensors, note in and temp sensors (the first 32
-	   sensors) have 3 bytes of settings, while fans only have 2 bytes,
-	   for convenience we use 3 bytes for all sensors */
+	/*
+	 * Settings of all 48 sensors, note in and temp sensors (the first 32
+	 * sensors) have 3 bytes of settings, while fans only have 2 bytes,
+	 * for convenience we use 3 bytes for all sensors
+	 */
 	u8 settings[48][3];
 };
 
@@ -627,8 +651,10 @@ static int abituguru3_wait_while_busy(struct abituguru3_data *data)
 		timeout--;
 		if (timeout = 0)
 			return x;
-		/* sleep a bit before our last try, to give the uGuru3 one
-		   last chance to respond. */
+		/*
+		 * sleep a bit before our last try, to give the uGuru3 one
+		 * last chance to respond.
+		 */
 		if (timeout = 1)
 			msleep(1);
 	}
@@ -646,16 +672,20 @@ static int abituguru3_wait_for_read(struct abituguru3_data *data)
 		timeout--;
 		if (timeout = 0)
 			return x;
-		/* sleep a bit before our last try, to give the uGuru3 one
-		   last chance to respond. */
+		/*
+		 * sleep a bit before our last try, to give the uGuru3 one
+		 * last chance to respond.
+		 */
 		if (timeout = 1)
 			msleep(1);
 	}
 	return ABIT_UGURU3_SUCCESS;
 }
 
-/* This synchronizes us with the uGuru3's protocol state machine, this
-   must be done before each command. */
+/*
+ * This synchronizes us with the uGuru3's protocol state machine, this
+ * must be done before each command.
+ */
 static int abituguru3_synchronize(struct abituguru3_data *data)
 {
 	int x, timeout = ABIT_UGURU3_SYNCHRONIZE_TIMEOUT;
@@ -711,8 +741,10 @@ static int abituguru3_synchronize(struct abituguru3_data *data)
 	return 0;
 }
 
-/* Read count bytes from sensor sensor_addr in bank bank_addr and store the
-   result in buf */
+/*
+ * Read count bytes from sensor sensor_addr in bank bank_addr and store the
+ * result in buf
+ */
 static int abituguru3_read(struct abituguru3_data *data, u8 bank, u8 offset,
 	u8 count, u8 *buf)
 {
@@ -771,8 +803,10 @@ static int abituguru3_read(struct abituguru3_data *data, u8 bank, u8 offset,
 	return i;
 }
 
-/* Sensor settings are stored 1 byte per offset with the bytes
-   placed add consecutive offsets. */
+/*
+ * Sensor settings are stored 1 byte per offset with the bytes
+ * placed add consecutive offsets.
+ */
 static int abituguru3_read_increment_offset(struct abituguru3_data *data,
 					    u8 bank, u8 offset, u8 count,
 					    u8 *buf, int offset_count)
@@ -792,9 +826,11 @@ static int abituguru3_read_increment_offset(struct abituguru3_data *data,
 	return i * count;
 }
 
-/* Following are the sysfs callback functions. These functions expect:
-   sensor_device_attribute_2->index:   index into the data->sensors array
-   sensor_device_attribute_2->nr:      register offset, bitmask or NA. */
+/*
+ * Following are the sysfs callback functions. These functions expect:
+ * sensor_device_attribute_2->index:   index into the data->sensors array
+ * sensor_device_attribute_2->nr:      register offset, bitmask or NA.
+ */
 static struct abituguru3_data *abituguru3_update_device(struct device *dev);
 
 static ssize_t show_value(struct device *dev,
@@ -820,8 +856,10 @@ static ssize_t show_value(struct device *dev,
 	value = (value * sensor->multiplier) / sensor->divisor +
 		sensor->offset;
 
-	/* alternatively we could update the sensors settings struct for this,
-	   but then its contents would differ from the windows sw ini files */
+	/*
+	 * alternatively we could update the sensors settings struct for this,
+	 * but then its contents would differ from the windows sw ini files
+	 */
 	if (sensor->type = ABIT_UGURU3_TEMP_SENSOR)
 		value *= 1000;
 
@@ -840,10 +878,12 @@ static ssize_t show_alarm(struct device *dev,
 
 	port = data->sensors[attr->index].port;
 
-	/* See if the alarm bit for this sensor is set and if a bitmask is
-	   given in attr->nr also check if the alarm matches the type of alarm
-	   we're looking for (for volt it can be either low or high). The type
-	   is stored in a few readonly bits in the settings of the sensor. */
+	/*
+	 * See if the alarm bit for this sensor is set and if a bitmask is
+	 * given in attr->nr also check if the alarm matches the type of alarm
+	 * we're looking for (for volt it can be either low or high). The type
+	 * is stored in a few readonly bits in the settings of the sensor.
+	 */
 	if ((data->alarms[port / 8] & (0x01 << (port % 8))) &&
 			(!attr->nr || (data->settings[port][0] & attr->nr)))
 		return sprintf(buf, "1\n");
@@ -1105,8 +1145,10 @@ LEAVE_UPDATE:
 static int abituguru3_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct abituguru3_data *data = platform_get_drvdata(pdev);
-	/* make sure all communications with the uguru3 are done and no new
-	   ones are started */
+	/*
+	 * make sure all communications with the uguru3 are done and no new
+	 * ones are started
+	 */
 	mutex_lock(&data->update_lock);
 	return 0;
 }
@@ -1148,7 +1190,8 @@ static int __init abituguru3_dmi_detect(void)
 	if (!board_name)
 		return err;
 
-	/* At the moment, we don't care about the part of the vendor
+	/*
+	 * At the moment, we don't care about the part of the vendor
 	 * DMI string contained in brackets. Truncate the string at
 	 * the first occurrence of a bracket. Trim any trailing space
 	 * from the substring.
@@ -1171,15 +1214,18 @@ static int __init abituguru3_dmi_detect(void)
 	return 1;
 }
 
-/* FIXME: Manual detection should die eventually; we need to collect stable
+/*
+ * FIXME: Manual detection should die eventually; we need to collect stable
  *        DMI model names first before we can rely entirely on CONFIG_DMI.
  */
 
 static int __init abituguru3_detect(void)
 {
-	/* See if there is an uguru3 there. An idle uGuru3 will hold 0x00 or
-	   0x08 at DATA and 0xAC at CMD. Sometimes the uGuru3 will hold 0x05
-	   or 0x55 at CMD instead, why is unknown. */
+	/*
+	 * See if there is an uguru3 there. An idle uGuru3 will hold 0x00 or
+	 * 0x08 at DATA and 0xAC at CMD. Sometimes the uGuru3 will hold 0x05
+	 * or 0x55 at CMD instead, why is unknown.
+	 */
 	u8 data_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_DATA);
 	u8 cmd_val = inb_p(ABIT_UGURU3_BASE + ABIT_UGURU3_CMD);
 	if (((data_val = 0x00) || (data_val = 0x08)) &&
@@ -1211,7 +1257,8 @@ static int __init abituguru3_init(void)
 	if (err < 0)
 		return err;
 
-	/* Fall back to manual detection if there was no exact
+	/*
+	 * Fall back to manual detection if there was no exact
 	 * board name match, or force was specified.
 	 */
 	if (err > 0) {
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
