From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:54:55 +0000
Subject: [lm-sensors] [PATCH 01/82] hwmon: (abituguru) Fix multi-line comments
Message-Id: <1327017376-20466-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Cc: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/abituguru.c |  422 +++++++++++++++++++++++++++------------------
 1 files changed, 257 insertions(+), 165 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index e08f757..a72bf25 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -1,25 +1,25 @@
 /*
-    abituguru.c Copyright (c) 2005-2006 Hans de Goede <hdegoede@redhat.com>
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
+ * abituguru.c Copyright (c) 2005-2006 Hans de Goede <hdegoede@redhat.com>
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
-    This driver supports the sensor part of the first and second revision of
-    the custom Abit uGuru chip found on Abit uGuru motherboards. Note: because
-    of lack of specs the CPU/RAM voltage & frequency control is not supported!
-*/
+ * This driver supports the sensor part of the first and second revision of
+ * the custom Abit uGuru chip found on Abit uGuru motherboards. Note: because
+ * of lack of specs the CPU/RAM voltage & frequency control is not supported!
+ */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
@@ -44,8 +44,10 @@
 #define ABIT_UGURU_SENSOR_BANK2			0x26 /* fans */
 /* max nr of sensors in bank1, a bank1 sensor can be in, temp or nc */
 #define ABIT_UGURU_MAX_BANK1_SENSORS		16
-/* Warning if you increase one of the 2 MAX defines below to 10 or higher you
-   should adjust the belonging _NAMES_LENGTH macro for the 2 digit number! */
+/*
+ * Warning if you increase one of the 2 MAX defines below to 10 or higher you
+ * should adjust the belonging _NAMES_LENGTH macro for the 2 digit number!
+ */
 /* max nr of sensors in bank2, currently mb's with max 6 fans are known */
 #define ABIT_UGURU_MAX_BANK2_SENSORS		6
 /* max nr of pwm outputs, currently mb's with max 5 pwm outputs are known */
@@ -70,16 +72,22 @@
 #define ABIT_UGURU_IN_SENSOR			0
 #define ABIT_UGURU_TEMP_SENSOR			1
 #define ABIT_UGURU_NC				2
-/* In many cases we need to wait for the uGuru to reach a certain status, most
-   of the time it will reach this status within 30 - 90 ISA reads, and thus we
-   can best busy wait. This define gives the total amount of reads to try. */
+/*
+ * In many cases we need to wait for the uGuru to reach a certain status, most
+ * of the time it will reach this status within 30 - 90 ISA reads, and thus we
+ * can best busy wait. This define gives the total amount of reads to try.
+ */
 #define ABIT_UGURU_WAIT_TIMEOUT			125
-/* However sometimes older versions of the uGuru seem to be distracted and they
-   do not respond for a long time. To handle this we sleep before each of the
-   last ABIT_UGURU_WAIT_TIMEOUT_SLEEP tries. */
+/*
+ * However sometimes older versions of the uGuru seem to be distracted and they
+ * do not respond for a long time. To handle this we sleep before each of the
+ * last ABIT_UGURU_WAIT_TIMEOUT_SLEEP tries.
+ */
 #define ABIT_UGURU_WAIT_TIMEOUT_SLEEP		5
-/* Normally all expected status in abituguru_ready, are reported after the
-   first read, but sometimes not and we need to poll. */
+/*
+ * Normally all expected status in abituguru_ready, are reported after the
+ * first read, but sometimes not and we need to poll.
+ */
 #define ABIT_UGURU_READY_TIMEOUT		5
 /* Maximum 3 retries on timedout reads/writes, delay 200 ms before retrying */
 #define ABIT_UGURU_MAX_RETRIES			3
@@ -92,17 +100,25 @@
 	if (level <= verbose)						\
 		printk(KERN_DEBUG ABIT_UGURU_NAME ": "	format , ## arg)
 /* Macros to help calculate the sysfs_names array length */
-/* sum of strlen of: in??_input\0, in??_{min,max}\0, in??_{min,max}_alarm\0,
-   in??_{min,max}_alarm_enable\0, in??_beep\0, in??_shutdown\0 */
+/*
+ * sum of strlen of: in??_input\0, in??_{min,max}\0, in??_{min,max}_alarm\0,
+ * in??_{min,max}_alarm_enable\0, in??_beep\0, in??_shutdown\0
+ */
 #define ABITUGURU_IN_NAMES_LENGTH	(11 + 2 * 9 + 2 * 15 + 2 * 22 + 10 + 14)
-/* sum of strlen of: temp??_input\0, temp??_max\0, temp??_crit\0,
-   temp??_alarm\0, temp??_alarm_enable\0, temp??_beep\0, temp??_shutdown\0 */
+/*
+ * sum of strlen of: temp??_input\0, temp??_max\0, temp??_crit\0,
+ * temp??_alarm\0, temp??_alarm_enable\0, temp??_beep\0, temp??_shutdown\0
+ */
 #define ABITUGURU_TEMP_NAMES_LENGTH	(13 + 11 + 12 + 13 + 20 + 12 + 16)
-/* sum of strlen of: fan?_input\0, fan?_min\0, fan?_alarm\0,
-   fan?_alarm_enable\0, fan?_beep\0, fan?_shutdown\0 */
+/*
+ * sum of strlen of: fan?_input\0, fan?_min\0, fan?_alarm\0,
+ * fan?_alarm_enable\0, fan?_beep\0, fan?_shutdown\0
+ */
 #define ABITUGURU_FAN_NAMES_LENGTH	(11 + 9 + 11 + 18 + 10 + 14)
-/* sum of strlen of: pwm?_enable\0, pwm?_auto_channels_temp\0,
-   pwm?_auto_point{1,2}_pwm\0, pwm?_auto_point{1,2}_temp\0 */
+/*
+ * sum of strlen of: pwm?_enable\0, pwm?_auto_channels_temp\0,
+ * pwm?_auto_point{1,2}_pwm\0, pwm?_auto_point{1,2}_temp\0
+ */
 #define ABITUGURU_PWM_NAMES_LENGTH	(12 + 24 + 2 * 21 + 2 * 22)
 /* IN_NAMES_LENGTH > TEMP_NAMES_LENGTH so assume all bank1 sensors are in */
 #define ABITUGURU_SYSFS_NAMES_LENGTH	( \
@@ -110,10 +126,12 @@
 	ABIT_UGURU_MAX_BANK2_SENSORS * ABITUGURU_FAN_NAMES_LENGTH + \
 	ABIT_UGURU_MAX_PWMS * ABITUGURU_PWM_NAMES_LENGTH)
 
-/* All the macros below are named identical to the oguru and oguru2 programs
-   reverse engineered by Olle Sandberg, hence the names might not be 100%
-   logical. I could come up with better names, but I prefer keeping the names
-   identical so that this driver can be compared with his work more easily. */
+/*
+ * All the macros below are named identical to the oguru and oguru2 programs
+ * reverse engineered by Olle Sandberg, hence the names might not be 100%
+ * logical. I could come up with better names, but I prefer keeping the names
+ * identical so that this driver can be compared with his work more easily.
+ */
 /* Two i/o-ports are used by uGuru */
 #define ABIT_UGURU_BASE				0x00E0
 /* Used to tell uGuru what to read and to read the actual data */
@@ -130,16 +148,22 @@
 /* Constants */
 /* in (Volt) sensors go up to 3494 mV, temp to 255000 millidegrees Celsius */
 static const int abituguru_bank1_max_value[2] = { 3494, 255000 };
-/* Min / Max allowed values for sensor2 (fan) alarm threshold, these values
-   correspond to 300-3000 RPM */
+/*
+ * Min / Max allowed values for sensor2 (fan) alarm threshold, these values
+ * correspond to 300-3000 RPM
+ */
 static const u8 abituguru_bank2_min_threshold = 5;
 static const u8 abituguru_bank2_max_threshold = 50;
-/* Register 0 is a bitfield, 1 and 2 are pwm settings (255 = 100%), 3 and 4
-   are temperature trip points. */
+/*
+ * Register 0 is a bitfield, 1 and 2 are pwm settings (255 = 100%), 3 and 4
+ * are temperature trip points.
+ */
 static const int abituguru_pwm_settings_multiplier[5] = { 0, 1, 1, 1000, 1000 };
-/* Min / Max allowed values for pwm_settings. Note: pwm1 (CPU fan) is a
-   special case the minium allowed pwm% setting for this is 30% (77) on
-   some MB's this special case is handled in the code! */
+/*
+ * Min / Max allowed values for pwm_settings. Note: pwm1 (CPU fan) is a
+ * special case the minium allowed pwm% setting for this is 30% (77) on
+ * some MB's this special case is handled in the code!
+ */
 static const u8 abituguru_pwm_min[5] = { 0, 170, 170, 25, 25 };
 static const u8 abituguru_pwm_max[5] = { 0, 255, 255, 75, 75 };
 
@@ -175,23 +199,29 @@ MODULE_PARM_DESC(verbose, "How verbose should the driver be? (0-3):\n"
 	"   3 + retryable error reporting");
 
 
-/* For the Abit uGuru, we need to keep some data in memory.
-   The structure is dynamically allocated, at the same time when a new
-   abituguru device is allocated. */
+/*
+ * For the Abit uGuru, we need to keep some data in memory.
+ * The structure is dynamically allocated, at the same time when a new
+ * abituguru device is allocated.
+ */
 struct abituguru_data {
 	struct device *hwmon_dev;	/* hwmon registered device */
 	struct mutex update_lock;	/* protect access to data and uGuru */
 	unsigned long last_updated;	/* In jiffies */
 	unsigned short addr;		/* uguru base address */
 	char uguru_ready;		/* is the uguru in ready state? */
-	unsigned char update_timeouts;	/* number of update timeouts since last
-					   successful update */
-
-	/* The sysfs attr and their names are generated automatically, for bank1
-	   we cannot use a predefined array because we don't know beforehand
-	   of a sensor is a volt or a temp sensor, for bank2 and the pwms its
-	   easier todo things the same way.  For in sensors we have 9 (temp 7)
-	   sysfs entries per sensor, for bank2 and pwms 6. */
+	unsigned char update_timeouts;	/*
+					 * number of update timeouts since last
+					 * successful update
+					 */
+
+	/*
+	 * The sysfs attr and their names are generated automatically, for bank1
+	 * we cannot use a predefined array because we don't know beforehand
+	 * of a sensor is a volt or a temp sensor, for bank2 and the pwms its
+	 * easier todo things the same way.  For in sensors we have 9 (temp 7)
+	 * sysfs entries per sensor, for bank2 and pwms 6.
+	 */
 	struct sensor_device_attribute_2 sysfs_attr[
 		ABIT_UGURU_MAX_BANK1_SENSORS * 9 +
 		ABIT_UGURU_MAX_BANK2_SENSORS * 6 + ABIT_UGURU_MAX_PWMS * 6];
@@ -203,11 +233,15 @@ struct abituguru_data {
 	u8 bank1_sensors[2];
 	u8 bank1_address[2][ABIT_UGURU_MAX_BANK1_SENSORS];
 	u8 bank1_value[ABIT_UGURU_MAX_BANK1_SENSORS];
-	/* This array holds 3 entries per sensor for the bank 1 sensor settings
-	   (flags, min, max for voltage / flags, warn, shutdown for temp). */
+	/*
+	 * This array holds 3 entries per sensor for the bank 1 sensor settings
+	 * (flags, min, max for voltage / flags, warn, shutdown for temp).
+	 */
 	u8 bank1_settings[ABIT_UGURU_MAX_BANK1_SENSORS][3];
-	/* Maximum value for each sensor used for scaling in mV/millidegrees
-	   Celsius. */
+	/*
+	 * Maximum value for each sensor used for scaling in mV/millidegrees
+	 * Celsius.
+	 */
 	int bank1_max_value[ABIT_UGURU_MAX_BANK1_SENSORS];
 
 	/* Bank 2 data, ABIT_UGURU_MAX_BANK2_SENSORS entries for bank2 */
@@ -236,8 +270,10 @@ static int abituguru_wait(struct abituguru_data *data, u8 state)
 		timeout--;
 		if (timeout = 0)
 			return -EBUSY;
-		/* sleep a bit before our last few tries, see the comment on
-		   this where ABIT_UGURU_WAIT_TIMEOUT_SLEEP is defined. */
+		/*
+		 * sleep a bit before our last few tries, see the comment on
+		 * this where ABIT_UGURU_WAIT_TIMEOUT_SLEEP is defined.
+		 */
 		if (timeout <= ABIT_UGURU_WAIT_TIMEOUT_SLEEP)
 			msleep(0);
 	}
@@ -273,8 +309,10 @@ static int abituguru_ready(struct abituguru_data *data)
 		msleep(0);
 	}
 
-	/* After this the ABIT_UGURU_DATA port should contain
-	   ABIT_UGURU_STATUS_INPUT */
+	/*
+	 * After this the ABIT_UGURU_DATA port should contain
+	 * ABIT_UGURU_STATUS_INPUT
+	 */
 	timeout = ABIT_UGURU_READY_TIMEOUT;
 	while (inb_p(data->addr + ABIT_UGURU_DATA) != ABIT_UGURU_STATUS_INPUT) {
 		timeout--;
@@ -290,27 +328,35 @@ static int abituguru_ready(struct abituguru_data *data)
 	return 0;
 }
 
-/* Send the bank and then sensor address to the uGuru for the next read/write
-   cycle. This function gets called as the first part of a read/write by
-   abituguru_read and abituguru_write. This function should never be
-   called by any other function. */
+/*
+ * Send the bank and then sensor address to the uGuru for the next read/write
+ * cycle. This function gets called as the first part of a read/write by
+ * abituguru_read and abituguru_write. This function should never be
+ * called by any other function.
+ */
 static int abituguru_send_address(struct abituguru_data *data,
 	u8 bank_addr, u8 sensor_addr, int retries)
 {
-	/* assume the caller does error handling itself if it has not requested
-	   any retries, and thus be quiet. */
+	/*
+	 * assume the caller does error handling itself if it has not requested
+	 * any retries, and thus be quiet.
+	 */
 	int report_errors = retries;
 
 	for (;;) {
-		/* Make sure the uguru is ready and then send the bank address,
-		   after this the uguru is no longer "ready". */
+		/*
+		 * Make sure the uguru is ready and then send the bank address,
+		 * after this the uguru is no longer "ready".
+		 */
 		if (abituguru_ready(data) != 0)
 			return -EIO;
 		outb(bank_addr, data->addr + ABIT_UGURU_DATA);
 		data->uguru_ready = 0;
 
-		/* Wait till the uguru is ABIT_UGURU_STATUS_INPUT state again
-		   and send the sensor addr */
+		/*
+		 * Wait till the uguru is ABIT_UGURU_STATUS_INPUT state again
+		 * and send the sensor addr
+		 */
 		if (abituguru_wait(data, ABIT_UGURU_STATUS_INPUT)) {
 			if (retries) {
 				ABIT_UGURU_DEBUG(3, "timeout exceeded "
@@ -332,8 +378,10 @@ static int abituguru_send_address(struct abituguru_data *data,
 	}
 }
 
-/* Read count bytes from sensor sensor_addr in bank bank_addr and store the
-   result in buf, retry the send address part of the read retries times. */
+/*
+ * Read count bytes from sensor sensor_addr in bank bank_addr and store the
+ * result in buf, retry the send address part of the read retries times.
+ */
 static int abituguru_read(struct abituguru_data *data,
 	u8 bank_addr, u8 sensor_addr, u8 *buf, int count, int retries)
 {
@@ -362,13 +410,17 @@ static int abituguru_read(struct abituguru_data *data,
 	return i;
 }
 
-/* Write count bytes from buf to sensor sensor_addr in bank bank_addr, the send
-   address part of the write is always retried ABIT_UGURU_MAX_RETRIES times. */
+/*
+ * Write count bytes from buf to sensor sensor_addr in bank bank_addr, the send
+ * address part of the write is always retried ABIT_UGURU_MAX_RETRIES times.
+ */
 static int abituguru_write(struct abituguru_data *data,
 	u8 bank_addr, u8 sensor_addr, u8 *buf, int count)
 {
-	/* We use the ready timeout as we have to wait for 0xAC just like the
-	   ready function */
+	/*
+	 * We use the ready timeout as we have to wait for 0xAC just like the
+	 * ready function
+	 */
 	int i, timeout = ABIT_UGURU_READY_TIMEOUT;
 
 	/* Send the address */
@@ -388,9 +440,11 @@ static int abituguru_write(struct abituguru_data *data,
 		outb(buf[i], data->addr + ABIT_UGURU_CMD);
 	}
 
-	/* Now we need to wait till the chip is ready to be read again,
-	   so that we can read 0xAC as confirmation that our write has
-	   succeeded. */
+	/*
+	 * Now we need to wait till the chip is ready to be read again,
+	 * so that we can read 0xAC as confirmation that our write has
+	 * succeeded.
+	 */
 	if (abituguru_wait(data, ABIT_UGURU_STATUS_READ)) {
 		ABIT_UGURU_DEBUG(1, "timeout exceeded waiting for read state "
 			"after write (bank: %d, sensor: %d)\n", (int)bank_addr,
@@ -416,12 +470,14 @@ static int abituguru_write(struct abituguru_data *data,
 	return i;
 }
 
-/* Detect sensor type. Temp and Volt sensors are enabled with
-   different masks and will ignore enable masks not meant for them.
-   This enables us to test what kind of sensor we're dealing with.
-   By setting the alarm thresholds so that we will always get an
-   alarm for sensor type X and then enabling the sensor as sensor type
-   X, if we then get an alarm it is a sensor of type X. */
+/*
+ * Detect sensor type. Temp and Volt sensors are enabled with
+ * different masks and will ignore enable masks not meant for them.
+ * This enables us to test what kind of sensor we're dealing with.
+ * By setting the alarm thresholds so that we will always get an
+ * alarm for sensor type X and then enabling the sensor as sensor type
+ * X, if we then get an alarm it is a sensor of type X.
+ */
 static int __devinit
 abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 				   u8 sensor_addr)
@@ -448,16 +504,20 @@ abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 		pr_warn("bank1-sensor: %d reading (%d) too close to limits, "
 			"unable to determine sensor type, skipping sensor\n",
 			(int)sensor_addr, (int)val);
-		/* assume no sensor is there for sensors for which we can't
-		   determine the sensor type because their reading is too close
-		   to their limits, this usually means no sensor is there. */
+		/*
+		 * assume no sensor is there for sensors for which we can't
+		 * determine the sensor type because their reading is too close
+		 * to their limits, this usually means no sensor is there.
+		 */
 		return ABIT_UGURU_NC;
 	}
 
 	ABIT_UGURU_DEBUG(2, "testing bank1 sensor %d\n", (int)sensor_addr);
-	/* Volt sensor test, enable volt low alarm, set min value ridicously
-	   high, or vica versa if the reading is very high. If its a volt
-	   sensor this should always give us an alarm. */
+	/*
+	 * Volt sensor test, enable volt low alarm, set min value ridicously
+	 * high, or vica versa if the reading is very high. If its a volt
+	 * sensor this should always give us an alarm.
+	 */
 	if (val <= 240u) {
 		buf[0] = ABIT_UGURU_VOLT_LOW_ALARM_ENABLE;
 		buf[1] = 245;
@@ -473,8 +533,10 @@ abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2, sensor_addr,
 			buf, 3) != 3)
 		goto abituguru_detect_bank1_sensor_type_exit;
-	/* Now we need 20 ms to give the uguru time to read the sensors
-	   and raise a voltage alarm */
+	/*
+	 * Now we need 20 ms to give the uguru time to read the sensors
+	 * and raise a voltage alarm
+	 */
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/50);
 	/* Check for alarm and check the alarm is a volt low alarm. */
@@ -497,17 +559,21 @@ abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 		ABIT_UGURU_DEBUG(2, "  alarm not raised during volt sensor "
 			"test\n");
 
-	/* Temp sensor test, enable sensor as a temp sensor, set beep value
-	   ridicously low (but not too low, otherwise uguru ignores it).
-	   If its a temp sensor this should always give us an alarm. */
+	/*
+	 * Temp sensor test, enable sensor as a temp sensor, set beep value
+	 * ridicously low (but not too low, otherwise uguru ignores it).
+	 * If its a temp sensor this should always give us an alarm.
+	 */
 	buf[0] = ABIT_UGURU_TEMP_HIGH_ALARM_ENABLE;
 	buf[1] = 5;
 	buf[2] = 10;
 	if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2, sensor_addr,
 			buf, 3) != 3)
 		goto abituguru_detect_bank1_sensor_type_exit;
-	/* Now we need 50 ms to give the uguru time to read the sensors
-	   and raise a temp alarm */
+	/*
+	 * Now we need 50 ms to give the uguru time to read the sensors
+	 * and raise a temp alarm
+	 */
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ/20);
 	/* Check for alarm and check the alarm is a temp high alarm. */
@@ -532,9 +598,11 @@ abituguru_detect_bank1_sensor_type(struct abituguru_data *data,
 
 	ret = ABIT_UGURU_NC;
 abituguru_detect_bank1_sensor_type_exit:
-	/* Restore original settings, failing here is really BAD, it has been
-	   reported that some BIOS-es hang when entering the uGuru menu with
-	   invalid settings present in the uGuru, so we try this 3 times. */
+	/*
+	 * Restore original settings, failing here is really BAD, it has been
+	 * reported that some BIOS-es hang when entering the uGuru menu with
+	 * invalid settings present in the uGuru, so we try this 3 times.
+	 */
 	for (i = 0; i < 3; i++)
 		if (abituguru_write(data, ABIT_UGURU_SENSOR_BANK1 + 2,
 				sensor_addr, data->bank1_settings[sensor_addr],
@@ -548,23 +616,25 @@ abituguru_detect_bank1_sensor_type_exit:
 	return ret;
 }
 
-/* These functions try to find out how many sensors there are in bank2 and how
-   many pwms there are. The purpose of this is to make sure that we don't give
-   the user the possibility to change settings for non-existent sensors / pwm.
-   The uGuru will happily read / write whatever memory happens to be after the
-   memory storing the PWM settings when reading/writing to a PWM which is not
-   there. Notice even if we detect a PWM which doesn't exist we normally won't
-   write to it, unless the user tries to change the settings.
-
-   Although the uGuru allows reading (settings) from non existing bank2
-   sensors, my version of the uGuru does seem to stop writing to them, the
-   write function above aborts in this case with:
-   "CMD reg does not hold 0xAC after write"
-
-   Notice these 2 tests are non destructive iow read-only tests, otherwise
-   they would defeat their purpose. Although for the bank2_sensors detection a
-   read/write test would be feasible because of the reaction above, I've
-   however opted to stay on the safe side. */
+/*
+ * These functions try to find out how many sensors there are in bank2 and how
+ * many pwms there are. The purpose of this is to make sure that we don't give
+ * the user the possibility to change settings for non-existent sensors / pwm.
+ * The uGuru will happily read / write whatever memory happens to be after the
+ * memory storing the PWM settings when reading/writing to a PWM which is not
+ * there. Notice even if we detect a PWM which doesn't exist we normally won't
+ * write to it, unless the user tries to change the settings.
+ *
+ * Although the uGuru allows reading (settings) from non existing bank2
+ * sensors, my version of the uGuru does seem to stop writing to them, the
+ * write function above aborts in this case with:
+ * "CMD reg does not hold 0xAC after write"
+ *
+ * Notice these 2 tests are non destructive iow read-only tests, otherwise
+ * they would defeat their purpose. Although for the bank2_sensors detection a
+ * read/write test would be feasible because of the reaction above, I've
+ * however opted to stay on the safe side.
+ */
 static void __devinit
 abituguru_detect_no_bank2_sensors(struct abituguru_data *data)
 {
@@ -580,12 +650,14 @@ abituguru_detect_no_bank2_sensors(struct abituguru_data *data)
 
 	ABIT_UGURU_DEBUG(2, "detecting number of fan sensors\n");
 	for (i = 0; i < ABIT_UGURU_MAX_BANK2_SENSORS; i++) {
-		/* 0x89 are the known used bits:
-		   -0x80 enable shutdown
-		   -0x08 enable beep
-		   -0x01 enable alarm
-		   All other bits should be 0, but on some motherboards
-		   0x40 (bit 6) is also high for some of the fans?? */
+		/*
+		 * 0x89 are the known used bits:
+		 * -0x80 enable shutdown
+		 * -0x08 enable beep
+		 * -0x01 enable alarm
+		 * All other bits should be 0, but on some motherboards
+		 * 0x40 (bit 6) is also high for some of the fans??
+		 */
 		if (data->bank2_settings[i][0] & ~0xC9) {
 			ABIT_UGURU_DEBUG(2, "  bank2 sensor %d does not seem "
 				"to be a fan sensor: settings[0] = %02X\n",
@@ -633,9 +705,11 @@ abituguru_detect_no_pwms(struct abituguru_data *data)
 
 	ABIT_UGURU_DEBUG(2, "detecting number of PWM outputs\n");
 	for (i = 0; i < ABIT_UGURU_MAX_PWMS; i++) {
-		/* 0x80 is the enable bit and the low
-		   nibble is which temp sensor to use,
-		   the other bits should be 0 */
+		/*
+		 * 0x80 is the enable bit and the low
+		 * nibble is which temp sensor to use,
+		 * the other bits should be 0
+		 */
 		if (data->pwm_settings[i][0] & ~0x8F) {
 			ABIT_UGURU_DEBUG(2, "  pwm channel %d does not seem "
 				"to be a pwm channel: settings[0] = %02X\n",
@@ -643,8 +717,10 @@ abituguru_detect_no_pwms(struct abituguru_data *data)
 			break;
 		}
 
-		/* the low nibble must correspond to one of the temp sensors
-		   we've found */
+		/*
+		 * the low nibble must correspond to one of the temp sensors
+		 * we've found
+		 */
 		for (j = 0; j < data->bank1_sensors[ABIT_UGURU_TEMP_SENSOR];
 				j++) {
 			if (data->bank1_address[ABIT_UGURU_TEMP_SENSOR][j] =
@@ -711,9 +787,11 @@ abituguru_detect_no_pwms_exit:
 	ABIT_UGURU_DEBUG(2, " found: %d PWM outputs\n", (int)data->pwms);
 }
 
-/* Following are the sysfs callback functions. These functions expect:
-   sensor_device_attribute_2->index:   sensor address/offset in the bank
-   sensor_device_attribute_2->nr:      register offset, bitmask or NA. */
+/*
+ * Following are the sysfs callback functions. These functions expect:
+ * sensor_device_attribute_2->index:   sensor address/offset in the bank
+ * sensor_device_attribute_2->nr:      register offset, bitmask or NA.
+ */
 static struct abituguru_data *abituguru_update_device(struct device *dev);
 
 static ssize_t show_bank1_value(struct device *dev,
@@ -833,11 +911,13 @@ static ssize_t show_bank1_alarm(struct device *dev,
 	struct abituguru_data *data = abituguru_update_device(dev);
 	if (!data)
 		return -EIO;
-	/* See if the alarm bit for this sensor is set, and if the
-	   alarm matches the type of alarm we're looking for (for volt
-	   it can be either low or high). The type is stored in a few
-	   readonly bits in the settings part of the relevant sensor.
-	   The bitmask of the type is passed to us in attr->nr. */
+	/*
+	 * See if the alarm bit for this sensor is set, and if the
+	 * alarm matches the type of alarm we're looking for (for volt
+	 * it can be either low or high). The type is stored in a few
+	 * readonly bits in the settings part of the relevant sensor.
+	 * The bitmask of the type is passed to us in attr->nr.
+	 */
 	if ((data->alarms[attr->index / 8] & (0x01 << (attr->index % 8))) &&
 			(data->bank1_settings[attr->index][0] & attr->nr))
 		return sprintf(buf, "1\n");
@@ -1012,8 +1092,10 @@ static ssize_t show_pwm_sensor(struct device *dev,
 	struct sensor_device_attribute_2 *attr = to_sensor_dev_attr_2(devattr);
 	struct abituguru_data *data = dev_get_drvdata(dev);
 	int i;
-	/* We need to walk to the temp sensor addresses to find what
-	   the userspace id of the configured temp sensor is. */
+	/*
+	 * We need to walk to the temp sensor addresses to find what
+	 * the userspace id of the configured temp sensor is.
+	 */
 	for (i = 0; i < data->bank1_sensors[ABIT_UGURU_TEMP_SENSOR]; i++)
 		if (data->bank1_address[ABIT_UGURU_TEMP_SENSOR][i] =
 				(data->pwm_settings[attr->index][0] & 0x0F))
@@ -1188,8 +1270,10 @@ static int __devinit abituguru_probe(struct platform_device *pdev)
 	int i, j, used, sysfs_names_free, sysfs_attr_i, res = -ENODEV;
 	char *sysfs_filename;
 
-	/* El weirdo probe order, to keep the sysfs order identical to the
-	   BIOS and window-appliction listing order. */
+	/*
+	 * El weirdo probe order, to keep the sysfs order identical to the
+	 * BIOS and window-appliction listing order.
+	 */
 	const u8 probe_order[ABIT_UGURU_MAX_BANK1_SENSORS] = {
 		0x00, 0x01, 0x03, 0x04, 0x0A, 0x08, 0x0E, 0x02,
 		0x09, 0x06, 0x05, 0x0B, 0x0F, 0x0D, 0x07, 0x0C };
@@ -1206,9 +1290,11 @@ static int __devinit abituguru_probe(struct platform_device *pdev)
 	if (inb_p(data->addr + ABIT_UGURU_DATA) = ABIT_UGURU_STATUS_INPUT)
 		data->uguru_ready = 1;
 
-	/* Completely read the uGuru this has 2 purposes:
-	   - testread / see if one really is there.
-	   - make an in memory copy of all the uguru settings for future use. */
+	/*
+	 * Completely read the uGuru this has 2 purposes:
+	 * - testread / see if one really is there.
+	 * - make an in memory copy of all the uguru settings for future use.
+	 */
 	if (abituguru_read(data, ABIT_UGURU_ALARM_BANK, 0,
 			data->alarms, 3, ABIT_UGURU_MAX_RETRIES) != 3)
 		goto abituguru_probe_error;
@@ -1223,11 +1309,13 @@ static int __devinit abituguru_probe(struct platform_device *pdev)
 				ABIT_UGURU_MAX_RETRIES) != 3)
 			goto abituguru_probe_error;
 	}
-	/* Note: We don't know how many bank2 sensors / pwms there really are,
-	   but in order to "detect" this we need to read the maximum amount
-	   anyways. If we read sensors/pwms not there we'll just read crap
-	   this can't hurt. We need the detection because we don't want
-	   unwanted writes, which will hurt! */
+	/*
+	 * Note: We don't know how many bank2 sensors / pwms there really are,
+	 * but in order to "detect" this we need to read the maximum amount
+	 * anyways. If we read sensors/pwms not there we'll just read crap
+	 * this can't hurt. We need the detection because we don't want
+	 * unwanted writes, which will hurt!
+	 */
 	for (i = 0; i < ABIT_UGURU_MAX_BANK2_SENSORS; i++) {
 		if (abituguru_read(data, ABIT_UGURU_SENSOR_BANK2, i,
 				&data->bank2_value[i], 1,
@@ -1429,8 +1517,10 @@ LEAVE_UPDATE:
 static int abituguru_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct abituguru_data *data = platform_get_drvdata(pdev);
-	/* make sure all communications with the uguru are done and no new
-	   ones are started */
+	/*
+	 * make sure all communications with the uguru are done and no new
+	 * ones are started
+	 */
 	mutex_lock(&data->update_lock);
 	return 0;
 }
@@ -1462,12 +1552,14 @@ static struct platform_driver abituguru_driver = {
 
 static int __init abituguru_detect(void)
 {
-	/* See if there is an uguru there. After a reboot uGuru will hold 0x00
-	   at DATA and 0xAC, when this driver has already been loaded once
-	   DATA will hold 0x08. For most uGuru's CMD will hold 0xAC in either
-	   scenario but some will hold 0x00.
-	   Some uGuru's initially hold 0x09 at DATA and will only hold 0x08
-	   after reading CMD first, so CMD must be read first! */
+	/*
+	 * See if there is an uguru there. After a reboot uGuru will hold 0x00
+	 * at DATA and 0xAC, when this driver has already been loaded once
+	 * DATA will hold 0x08. For most uGuru's CMD will hold 0xAC in either
+	 * scenario but some will hold 0x00.
+	 * Some uGuru's initially hold 0x09 at DATA and will only hold 0x08
+	 * after reading CMD first, so CMD must be read first!
+	 */
 	u8 cmd_val = inb_p(ABIT_UGURU_BASE + ABIT_UGURU_CMD);
 	u8 data_val = inb_p(ABIT_UGURU_BASE + ABIT_UGURU_DATA);
 	if (((data_val = 0x00) || (data_val = 0x08)) &&
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
