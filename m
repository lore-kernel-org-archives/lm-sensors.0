From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:55:18 +0000
Subject: [lm-sensors] [PATCH 24/82] hwmon: (fschmd) Fix multi-line comments
Message-Id: <1327017376-20466-25-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/fschmd.c |  161 ++++++++++++++++++++++++++++++------------------
 1 files changed, 100 insertions(+), 61 deletions(-)

diff --git a/drivers/hwmon/fschmd.c b/drivers/hwmon/fschmd.c
index 06cbf77..4e706dd 100644
--- a/drivers/hwmon/fschmd.c
+++ b/drivers/hwmon/fschmd.c
@@ -1,4 +1,5 @@
-/* fschmd.c
+/*
+ * fschmd.c
  *
  * Copyright (C) 2007 - 2009 Hans de Goede <hdegoede@redhat.com>
  *
@@ -103,10 +104,12 @@ static const u8 FSCHMD_REG_VOLT[7][6] = {
 
 static const int FSCHMD_NO_VOLT_SENSORS[7] = { 3, 3, 3, 3, 3, 3, 6 };
 
-/* minimum pwm at which the fan is driven (pwm can by increased depending on
-   the temp. Notice that for the scy some fans share there minimum speed.
-   Also notice that with the scy the sensor order is different than with the
-   other chips, this order was in the 2.4 driver and kept for consistency. */
+/*
+ * minimum pwm at which the fan is driven (pwm can by increased depending on
+ * the temp. Notice that for the scy some fans share there minimum speed.
+ * Also notice that with the scy the sensor order is different than with the
+ * other chips, this order was in the 2.4 driver and kept for consistency.
+ */
 static const u8 FSCHMD_REG_FAN_MIN[7][7] = {
 	{ 0x55, 0x65 },					/* pos */
 	{ 0x55, 0x65, 0xb5 },				/* her */
@@ -182,11 +185,13 @@ static const u8 FSCHMD_REG_TEMP_STATE[7][11] = {
 	  0xb9, 0xc9, 0xd9, 0xe9, 0xf9 },
 };
 
-/* temperature high limit registers, FSC does not document these. Proven to be
-   there with field testing on the fscher and fschrc, already supported / used
-   in the fscscy 2.4 driver. FSC has confirmed that the fschmd has registers
-   at these addresses, but doesn't want to confirm they are the same as with
-   the fscher?? */
+/*
+ * temperature high limit registers, FSC does not document these. Proven to be
+ * there with field testing on the fscher and fschrc, already supported / used
+ * in the fscscy 2.4 driver. FSC has confirmed that the fschmd has registers
+ * at these addresses, but doesn't want to confirm they are the same as with
+ * the fscher??
+ */
 static const u8 FSCHMD_REG_TEMP_LIMIT[7][11] = {
 	{ 0, 0, 0 },					/* pos */
 	{ 0x76, 0x86, 0x96 },				/* her */
@@ -198,13 +203,15 @@ static const u8 FSCHMD_REG_TEMP_LIMIT[7][11] = {
 	  0xba, 0xca, 0xda, 0xea, 0xfa },
 };
 
-/* These were found through experimenting with an fscher, currently they are
-   not used, but we keep them around for future reference.
-   On the fscsyl AUTOP1 lives at 0x#c (so 0x5c for fan1, 0x6c for fan2, etc),
-   AUTOP2 lives at 0x#e, and 0x#1 is a bitmask defining which temps influence
-   the fan speed.
-static const u8 FSCHER_REG_TEMP_AUTOP1[] =	{ 0x73, 0x83, 0x93 };
-static const u8 FSCHER_REG_TEMP_AUTOP2[] =	{ 0x75, 0x85, 0x95 }; */
+/*
+ * These were found through experimenting with an fscher, currently they are
+ * not used, but we keep them around for future reference.
+ * On the fscsyl AUTOP1 lives at 0x#c (so 0x5c for fan1, 0x6c for fan2, etc),
+ * AUTOP2 lives at 0x#e, and 0x#1 is a bitmask defining which temps influence
+ * the fan speed.
+ * static const u8 FSCHER_REG_TEMP_AUTOP1[] =	{ 0x73, 0x83, 0x93 };
+ * static const u8 FSCHER_REG_TEMP_AUTOP2[] =	{ 0x75, 0x85, 0x95 };
+ */
 
 static const int FSCHMD_NO_TEMP_SENSORS[7] = { 3, 3, 4, 3, 5, 5, 11 };
 
@@ -290,24 +297,30 @@ struct fschmd_data {
 	u8 fan_ripple[7];	/* divider for rps */
 };
 
-/* Global variables to hold information read from special DMI tables, which are
-   available on FSC machines with an fscher or later chip. There is no need to
-   protect these with a lock as they are only modified from our attach function
-   which always gets called with the i2c-core lock held and never accessed
-   before the attach function is done with them. */
+/*
+ * Global variables to hold information read from special DMI tables, which are
+ * available on FSC machines with an fscher or later chip. There is no need to
+ * protect these with a lock as they are only modified from our attach function
+ * which always gets called with the i2c-core lock held and never accessed
+ * before the attach function is done with them.
+ */
 static int dmi_mult[6] = { 490, 200, 100, 100, 200, 100 };
 static int dmi_offset[6] = { 0, 0, 0, 0, 0, 0 };
 static int dmi_vref = -1;
 
-/* Somewhat ugly :( global data pointer list with all fschmd devices, so that
-   we can find our device data as when using misc_register there is no other
-   method to get to ones device data from the open fop. */
+/*
+ * Somewhat ugly :( global data pointer list with all fschmd devices, so that
+ * we can find our device data as when using misc_register there is no other
+ * method to get to ones device data from the open fop.
+ */
 static LIST_HEAD(watchdog_data_list);
 /* Note this lock not only protect list access, but also data.kref access */
 static DEFINE_MUTEX(watchdog_data_mutex);
 
-/* Release our data struct when we're detached from the i2c client *and* all
-   references to our watchdog device are released */
+/*
+ * Release our data struct when we're detached from the i2c client *and* all
+ * references to our watchdog device are released
+ */
 static void fschmd_release_resources(struct kref *ref)
 {
 	struct fschmd_data *data = container_of(ref, struct fschmd_data, kref);
@@ -543,8 +556,10 @@ static ssize_t store_pwm_auto_point1_pwm(struct device *dev,
 }
 
 
-/* The FSC hwmon family has the ability to force an attached alert led to flash
-   from software, we export this as an alert_led sysfs attr */
+/*
+ * The FSC hwmon family has the ability to force an attached alert led to flash
+ * from software, we export this as an alert_led sysfs attr
+ */
 static ssize_t show_alert_led(struct device *dev,
 	struct device_attribute *devattr, char *buf)
 {
@@ -780,8 +795,10 @@ static int watchdog_stop(struct fschmd_data *data)
 	}
 
 	data->watchdog_control &= ~FSCHMD_WDOG_CONTROL_STARTED;
-	/* Don't store the stop flag in our watchdog control register copy, as
-	   its a write only bit (read always returns 0) */
+	/*
+	 * Don't store the stop flag in our watchdog control register copy, as
+	 * its a write only bit (read always returns 0)
+	 */
 	i2c_smbus_write_byte_data(data->client,
 		FSCHMD_REG_WDOG_CONTROL[data->kind],
 		data->watchdog_control | FSCHMD_WDOG_CONTROL_STOP);
@@ -795,10 +812,12 @@ static int watchdog_open(struct inode *inode, struct file *filp)
 	struct fschmd_data *pos, *data = NULL;
 	int watchdog_is_open;
 
-	/* We get called from drivers/char/misc.c with misc_mtx hold, and we
-	   call misc_register() from fschmd_probe() with watchdog_data_mutex
-	   hold, as misc_register() takes the misc_mtx lock, this is a possible
-	   deadlock, so we use mutex_trylock here. */
+	/*
+	 * We get called from drivers/char/misc.c with misc_mtx hold, and we
+	 * call misc_register() from fschmd_probe() with watchdog_data_mutex
+	 * hold, as misc_register() takes the misc_mtx lock, this is a possible
+	 * deadlock, so we use mutex_trylock here.
+	 */
 	if (!mutex_trylock(&watchdog_data_mutex))
 		return -ERESTARTSYS;
 	list_for_each_entry(pos, &watchdog_data_list, list) {
@@ -957,30 +976,38 @@ static const struct file_operations watchdog_fops = {
  * Detect, register, unregister and update device functions
  */
 
-/* DMI decode routine to read voltage scaling factors from special DMI tables,
-   which are available on FSC machines with an fscher or later chip. */
+/*
+ * DMI decode routine to read voltage scaling factors from special DMI tables,
+ * which are available on FSC machines with an fscher or later chip.
+ */
 static void fschmd_dmi_decode(const struct dmi_header *header, void *dummy)
 {
 	int i, mult[3] = { 0 }, offset[3] = { 0 }, vref = 0, found = 0;
 
-	/* dmi code ugliness, we get passed the address of the contents of
-	   a complete DMI record, but in the form of a dmi_header pointer, in
-	   reality this address holds header->length bytes of which the header
-	   are the first 4 bytes */
+	/*
+	 * dmi code ugliness, we get passed the address of the contents of
+	 * a complete DMI record, but in the form of a dmi_header pointer, in
+	 * reality this address holds header->length bytes of which the header
+	 * are the first 4 bytes
+	 */
 	u8 *dmi_data = (u8 *)header;
 
 	/* We are looking for OEM-specific type 185 */
 	if (header->type != 185)
 		return;
 
-	/* we are looking for what Siemens calls "subtype" 19, the subtype
-	   is stored in byte 5 of the dmi block */
+	/*
+	 * we are looking for what Siemens calls "subtype" 19, the subtype
+	 * is stored in byte 5 of the dmi block
+	 */
 	if (header->length < 5 || dmi_data[4] != 19)
 		return;
 
-	/* After the subtype comes 1 unknown byte and then blocks of 5 bytes,
-	   consisting of what Siemens calls an "Entity" number, followed by
-	   2 16-bit words in LSB first order */
+	/*
+	 * After the subtype comes 1 unknown byte and then blocks of 5 bytes,
+	 * consisting of what Siemens calls an "Entity" number, followed by
+	 * 2 16-bit words in LSB first order
+	 */
 	for (i = 6; (i + 4) < header->length; i += 5) {
 		/* entity 1 - 3: voltage multiplier and offset */
 		if (dmi_data[i] >= 1 && dmi_data[i] <= 3) {
@@ -1015,9 +1042,11 @@ static void fschmd_dmi_decode(const struct dmi_header *header, void *dummy)
 			dmi_mult[i] = mult[i] * 10;
 			dmi_offset[i] = offset[i] * 10;
 		}
-		/* According to the docs there should be separate dmi entries
-		   for the mult's and offsets of in3-5 of the syl, but on
-		   my test machine these are not present */
+		/*
+		 * According to the docs there should be separate dmi entries
+		 * for the mult's and offsets of in3-5 of the syl, but on
+		 * my test machine these are not present
+		 */
 		dmi_mult[3] = dmi_mult[2];
 		dmi_mult[4] = dmi_mult[1];
 		dmi_mult[5] = dmi_mult[2];
@@ -1085,15 +1114,19 @@ static int fschmd_probe(struct i2c_client *client,
 	mutex_init(&data->watchdog_lock);
 	INIT_LIST_HEAD(&data->list);
 	kref_init(&data->kref);
-	/* Store client pointer in our data struct for watchdog usage
-	   (where the client is found through a data ptr instead of the
-	   otherway around) */
+	/*
+	 * Store client pointer in our data struct for watchdog usage
+	 * (where the client is found through a data ptr instead of the
+	 * otherway around)
+	 */
 	data->client = client;
 	data->kind = kind;
 
 	if (kind = fscpos) {
-		/* The Poseidon has hardwired temp limits, fill these
-		   in for the alarm resetting code */
+		/*
+		 * The Poseidon has hardwired temp limits, fill these
+		 * in for the alarm resetting code
+		 */
 		data->temp_max[0] = 70 + 128;
 		data->temp_max[1] = 50 + 128;
 		data->temp_max[2] = 50 + 128;
@@ -1184,9 +1217,11 @@ static int fschmd_probe(struct i2c_client *client,
 		goto exit_detach;
 	}
 
-	/* We take the data_mutex lock early so that watchdog_open() cannot
-	   run when misc_register() has completed, but we've not yet added
-	   our data to the watchdog_data_list (and set the default timeout) */
+	/*
+	 * We take the data_mutex lock early so that watchdog_open() cannot
+	 * run when misc_register() has completed, but we've not yet added
+	 * our data to the watchdog_data_list (and set the default timeout)
+	 */
 	mutex_lock(&watchdog_data_mutex);
 	for (i = 0; i < ARRAY_SIZE(watchdog_minors); i++) {
 		/* Register our watchdog part */
@@ -1252,8 +1287,10 @@ static int fschmd_remove(struct i2c_client *client)
 		mutex_unlock(&data->watchdog_lock);
 	}
 
-	/* Check if registered in case we're called from fschmd_detect
-	   to cleanup after an error */
+	/*
+	 * Check if registered in case we're called from fschmd_detect
+	 * to cleanup after an error
+	 */
 	if (data->hwmon_dev)
 		hwmon_device_unregister(data->hwmon_dev);
 
@@ -1296,8 +1333,10 @@ static struct fschmd_data *fschmd_update_device(struct device *dev)
 					client,
 					FSCHMD_REG_TEMP_LIMIT[data->kind][i]);
 
-			/* reset alarm if the alarm condition is gone,
-			   the chip doesn't do this itself */
+			/*
+			 * reset alarm if the alarm condition is gone,
+			 * the chip doesn't do this itself
+			 */
 			if ((data->temp_status[i] & FSCHMD_TEMP_ALARM_MASK) =
 					FSCHMD_TEMP_ALARM_MASK &&
 					data->temp_act[i] < data->temp_max[i])
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
