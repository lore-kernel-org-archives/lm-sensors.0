From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue, 12 Apr 2011 19:34:36 +0000
Subject: [lm-sensors] [PATCH v2 1/4] hwmon: (sht15) general code clean-up
Message-Id: <1302636879-16615-2-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Add a documentation file for the device.
* Respect a bit more the kernel-doc syntax.
* Rename some variables for clarity.
* Use bool type for flags.
* Use an enum for states (actions being done).

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 Documentation/hwmon/sht15 |   43 +++++++
 drivers/hwmon/sht15.c     |  268 ++++++++++++++++++++++++++-------------------
 include/linux/sht15.h     |   12 ++-
 3 files changed, 204 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/hwmon/sht15

diff --git a/Documentation/hwmon/sht15 b/Documentation/hwmon/sht15
new file mode 100644
index 0000000..50c07f5
--- /dev/null
+++ b/Documentation/hwmon/sht15
@@ -0,0 +1,43 @@
+Kernel driver sht15
+=========+
+Authors:
+  * Wouter Horre
+  * Jonathan Cameron
+
+Supported chips:
+  * Sensirion SHT10
+    Prefix: 'sht10'
+
+  * Sensirion SHT11
+    Prefix: 'sht11'
+
+  * Sensirion SHT15
+    Prefix: 'sht15'
+
+  * Sensirion SHT71
+    Prefix: 'sht71'
+
+  * Sensirion SHT75
+    Prefix: 'sht75'
+
+Datasheet: Publicly available at the Sensirion website
+http://www.sensirion.ch/en/pdf/product_information/Datasheet-humidity-sensor-SHT1x.pdf
+
+Description
+-----------
+
+The SHT10, SHT11, SHT15, SHT71, and SHT75 are humidity and temperature
+sensors.
+
+The devices communicate using two GPIO lines and use the default
+resolution settings of 14 bits for temperature and 12 bits for humidity.
+
+Note: The regulator supply name is set to "vcc".
+
+Sysfs interface
+---------------
+
+* temp1_input:     temperature input
+* humidity1_input: humidity input
+
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 1a9c32d..5fd880d 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -9,16 +9,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  *
- * Currently ignoring checksum on readings.
- * Default resolution only (14bit temp, 12bit humidity)
- * Ignoring battery status.
- * Heater not enabled.
- * Timings are all conservative.
- *
- * Data sheet available (1/2009) at
- * http://www.sensirion.ch/en/pdf/product_information/Datasheet-humidity-sensor-SHT1x.pdf
- *
- * Regulator supply name = vcc
+ * For further information, see the Documentation/hwmon/sht15 file.
  */
 
 #include <linux/interrupt.h>
@@ -39,17 +30,21 @@
 #include <linux/slab.h>
 #include <asm/atomic.h>
 
-#define SHT15_MEASURE_TEMP	3
-#define SHT15_MEASURE_RH	5
+/* Commands */
+#define SHT15_MEASURE_TEMP		0x03
+#define SHT15_MEASURE_RH		0x05
 
-#define SHT15_READING_NOTHING	0
-#define SHT15_READING_TEMP	1
-#define SHT15_READING_HUMID	2
+/* Min timings */
+#define SHT15_TSCKL			100	/* (nsecs) clock low */
+#define SHT15_TSCKH			100	/* (nsecs) clock high */
+#define SHT15_TSU			150	/* (nsecs) data setup time */
 
-/* Min timings in nsecs */
-#define SHT15_TSCKL		100	/* clock low */
-#define SHT15_TSCKH		100	/* clock high */
-#define SHT15_TSU		150	/* data setup time */
+/* Actions the driver may be doing */
+enum sht15_state {
+	SHT15_READING_NOTHING,
+	SHT15_READING_TEMP,
+	SHT15_READING_HUMID
+};
 
 /**
  * struct sht15_temppair - elements of voltage dependant temp calc
@@ -61,9 +56,7 @@ struct sht15_temppair {
 	int d1;
 };
 
-/* Table 9 from data sheet - relates temperature calculation
- * to supply voltage.
- */
+/* Table 9 from datasheet - relates temperature calculation to supply voltage */
 static const struct sht15_temppair temppoints[] = {
 	{ 2500000, -39400 },
 	{ 3000000, -39600 },
@@ -74,27 +67,27 @@ static const struct sht15_temppair temppoints[] = {
 
 /**
  * struct sht15_data - device instance specific data
- * @pdata:	platform data (gpio's etc)
- * @read_work:	bh of interrupt handler
- * @wait_queue:	wait queue for getting values from device
- * @val_temp:	last temperature value read from device
- * @val_humid: 	last humidity value read from device
- * @flag:	status flag used to identify what the last request was
- * @valid:	are the current stored values valid (start condition)
- * @last_updat:	time of last update
- * @read_lock:	mutex to ensure only one read in progress
- *		at a time.
- * @dev:	associate device structure
- * @hwmon_dev:	device associated with hwmon subsystem
- * @reg:	associated regulator (if specified)
- * @nb:		notifier block to handle notifications of voltage changes
- * @supply_uV:	local copy of supply voltage used to allow
- *		use of regulator consumer if available
- * @supply_uV_valid:   indicates that an updated value has not yet
- *		been obtained from the regulator and so any calculations
- *		based upon it will be invalid.
- * @update_supply_work:	work struct that is used to update the supply_uV
- * @interrupt_handled:	flag used to indicate a hander has been scheduled
+ * @pdata:		platform data (gpio's etc).
+ * @read_work:		bh of interrupt handler.
+ * @wait_queue:		wait queue for getting values from device.
+ * @val_temp:		last temperature value read from device.
+ * @val_humid:		last humidity value read from device.
+ * @state:		state identifying the action the driver is doing.
+ * @measurements_valid:	are the current stored measures valid (start condition).
+ * @last_measurement:	time of last measure.
+ * @read_lock:		mutex to ensure only one read in progress at a time.
+ * @dev:		associate device structure.
+ * @hwmon_dev:		device associated with hwmon subsystem.
+ * @reg:		associated regulator (if specified).
+ * @nb:			notifier block to handle notifications of voltage
+ *                      changes.
+ * @supply_uV:		local copy of supply voltage used to allow use of
+ *                      regulator consumer if available.
+ * @supply_uV_valid:	indicates that an updated value has not yet been
+ *			obtained from the regulator and so any calculations
+ *			based upon it will be invalid.
+ * @update_supply_work:	work struct that is used to update the supply_uV.
+ * @interrupt_handled:	flag used to indicate a handler has been scheduled.
  */
 struct sht15_data {
 	struct sht15_platform_data	*pdata;
@@ -102,16 +95,16 @@ struct sht15_data {
 	wait_queue_head_t		wait_queue;
 	uint16_t			val_temp;
 	uint16_t			val_humid;
-	u8				flag;
-	u8				valid;
-	unsigned long			last_updat;
+	enum sht15_state		state;
+	bool				measurements_valid;
+	unsigned long			last_measurement;
 	struct mutex			read_lock;
 	struct device			*dev;
 	struct device			*hwmon_dev;
 	struct regulator		*reg;
 	struct notifier_block		nb;
 	int				supply_uV;
-	int				supply_uV_valid;
+	bool				supply_uV_valid;
 	struct work_struct		update_supply_work;
 	atomic_t			interrupt_handled;
 };
@@ -125,6 +118,7 @@ struct sht15_data {
 static void sht15_connection_reset(struct sht15_data *data)
 {
 	int i;
+
 	gpio_direction_output(data->pdata->gpio_data, 1);
 	ndelay(SHT15_TSCKL);
 	gpio_set_value(data->pdata->gpio_sck, 0);
@@ -136,14 +130,14 @@ static void sht15_connection_reset(struct sht15_data *data)
 		ndelay(SHT15_TSCKL);
 	}
 }
+
 /**
  * sht15_send_bit() - send an individual bit to the device
  * @data:	device state data
  * @val:	value of bit to be sent
- **/
+ */
 static inline void sht15_send_bit(struct sht15_data *data, int val)
 {
-
 	gpio_set_value(data->pdata->gpio_data, val);
 	ndelay(SHT15_TSU);
 	gpio_set_value(data->pdata->gpio_sck, 1);
@@ -154,12 +148,12 @@ static inline void sht15_send_bit(struct sht15_data *data, int val)
 
 /**
  * sht15_transmission_start() - specific sequence for new transmission
- *
  * @data:	device state data
+ *
  * Timings for this are not documented on the data sheet, so very
  * conservative ones used in implementation. This implements
  * figure 12 on the data sheet.
- **/
+ */
 static void sht15_transmission_start(struct sht15_data *data)
 {
 	/* ensure data is high and output */
@@ -180,23 +174,26 @@ static void sht15_transmission_start(struct sht15_data *data)
 	gpio_set_value(data->pdata->gpio_sck, 0);
 	ndelay(SHT15_TSCKL);
 }
+
 /**
  * sht15_send_byte() - send a single byte to the device
  * @data:	device state
  * @byte:	value to be sent
- **/
+ */
 static void sht15_send_byte(struct sht15_data *data, u8 byte)
 {
 	int i;
+
 	for (i = 0; i < 8; i++) {
 		sht15_send_bit(data, !!(byte & 0x80));
 		byte <<= 1;
 	}
 }
+
 /**
  * sht15_wait_for_response() - checks for ack from device
  * @data:	device state
- **/
+ */
 static int sht15_wait_for_response(struct sht15_data *data)
 {
 	gpio_direction_input(data->pdata->gpio_data);
@@ -220,27 +217,30 @@ static int sht15_wait_for_response(struct sht15_data *data)
  *
  * On entry, sck is output low, data is output pull high
  * and the interrupt disabled.
- **/
+ */
 static int sht15_send_cmd(struct sht15_data *data, u8 cmd)
 {
 	int ret = 0;
+
 	sht15_transmission_start(data);
 	sht15_send_byte(data, cmd);
 	ret = sht15_wait_for_response(data);
 	return ret;
 }
+
 /**
- * sht15_update_single_val() - get a new value from device
+ * sht15_measurement() - get a new value from device
  * @data:		device instance specific data
  * @command:		command sent to request value
  * @timeout_msecs:	timeout after which comms are assumed
  *			to have failed are reset.
- **/
-static inline int sht15_update_single_val(struct sht15_data *data,
-					  int command,
-					  int timeout_msecs)
+ */
+static int sht15_measurement(struct sht15_data *data,
+			     int command,
+			     int timeout_msecs)
 {
 	int ret;
+
 	ret = sht15_send_cmd(data, command);
 	if (ret)
 		return ret;
@@ -256,7 +256,7 @@ static inline int sht15_update_single_val(struct sht15_data *data,
 			schedule_work(&data->read_work);
 	}
 	ret = wait_event_timeout(data->wait_queue,
-				 (data->flag = SHT15_READING_NOTHING),
+				 (data->state = SHT15_READING_NOTHING),
 				 msecs_to_jiffies(timeout_msecs));
 	if (ret = 0) {/* timeout occurred */
 		disable_irq_nosync(gpio_to_irq(data->pdata->gpio_data));
@@ -267,27 +267,27 @@ static inline int sht15_update_single_val(struct sht15_data *data,
 }
 
 /**
- * sht15_update_vals() - get updated readings from device if too old
+ * sht15_update_measurements() - get updated measures from device if too old
  * @data:	device state
- **/
-static int sht15_update_vals(struct sht15_data *data)
+ */
+static int sht15_update_measurements(struct sht15_data *data)
 {
 	int ret = 0;
 	int timeout = HZ;
 
 	mutex_lock(&data->read_lock);
-	if (time_after(jiffies, data->last_updat + timeout)
-	    || !data->valid) {
-		data->flag = SHT15_READING_HUMID;
-		ret = sht15_update_single_val(data, SHT15_MEASURE_RH, 160);
+	if (time_after(jiffies, data->last_measurement + timeout)
+	    || !data->measurements_valid) {
+		data->state = SHT15_READING_HUMID;
+		ret = sht15_measurement(data, SHT15_MEASURE_RH, 160);
 		if (ret)
 			goto error_ret;
-		data->flag = SHT15_READING_TEMP;
-		ret = sht15_update_single_val(data, SHT15_MEASURE_TEMP, 400);
+		data->state = SHT15_READING_TEMP;
+		ret = sht15_measurement(data, SHT15_MEASURE_TEMP, 400);
 		if (ret)
 			goto error_ret;
-		data->valid = 1;
-		data->last_updat = jiffies;
+		data->measurements_valid = true;
+		data->last_measurement = jiffies;
 	}
 error_ret:
 	mutex_unlock(&data->read_lock);
@@ -300,7 +300,7 @@ error_ret:
  * @data:	device state
  *
  * As per section 4.3 of the data sheet.
- **/
+ */
 static inline int sht15_calc_temp(struct sht15_data *data)
 {
 	int d1 = temppoints[0].d1;
@@ -316,7 +316,7 @@ static inline int sht15_calc_temp(struct sht15_data *data)
 			break;
 		}
 
-	return data->val_temp*10 + d1;
+	return data->val_temp * 10 + d1;
 }
 
 /**
@@ -325,23 +325,35 @@ static inline int sht15_calc_temp(struct sht15_data *data)
  *
  * This is the temperature compensated version as per section 4.2 of
  * the data sheet.
- **/
+ *
+ * The sensor is assumed to be V3, which is compatible with V4.
+ * Humidity conversion coefficients are shown in table 7 of the datasheet.
+ */
 static inline int sht15_calc_humid(struct sht15_data *data)
 {
-	int RHlinear; /* milli percent */
+	int rh_linear; /* milli percent */
 	int temp = sht15_calc_temp(data);
 
 	const int c1 = -4;
 	const int c2 = 40500; /* x 10 ^ -6 */
-	const int c3 = -28; /* x 10 ^ -7 */
+	const int c3 = -28;   /* x 10 ^ -7 */
 
-	RHlinear = c1*1000
-		+ c2 * data->val_humid/1000
+	rh_linear = c1 * 1000
+		+ c2 * data->val_humid / 1000
 		+ (data->val_humid * data->val_humid * c3) / 10000;
 	return (temp - 25000) * (10000 + 80 * data->val_humid)
-		/ 1000000 + RHlinear;
+		/ 1000000 + rh_linear;
 }
 
+/**
+ * sht15_show_temp() - show temperature measurement value in sysfs
+ * @dev:	device.
+ * @attr:	device attribute.
+ * @buf:	sysfs buffer where measurement values are written to.
+ *
+ * Will be called on read access to temp1_input sysfs attribute.
+ * Returns number of bytes written into buffer, negative errno on error.
+ */
 static ssize_t sht15_show_temp(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
@@ -350,12 +362,21 @@ static ssize_t sht15_show_temp(struct device *dev,
 	struct sht15_data *data = dev_get_drvdata(dev);
 
 	/* Technically no need to read humidity as well */
-	ret = sht15_update_vals(data);
+	ret = sht15_update_measurements(data);
 
 	return ret ? ret : sprintf(buf, "%d\n",
 				   sht15_calc_temp(data));
 }
 
+/**
+ * sht15_show_humidity() - show humidity measurement value in sysfs
+ * @dev:	device.
+ * @attr:	device attribute.
+ * @buf:	sysfs buffer where measurement values are written to.
+ *
+ * Will be called on read access to humidity1_input sysfs attribute.
+ * Returns number of bytes written into buffer, negative errno on error.
+ */
 static ssize_t sht15_show_humidity(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
@@ -363,11 +384,12 @@ static ssize_t sht15_show_humidity(struct device *dev,
 	int ret;
 	struct sht15_data *data = dev_get_drvdata(dev);
 
-	ret = sht15_update_vals(data);
+	ret = sht15_update_measurements(data);
 
 	return ret ? ret : sprintf(buf, "%d\n", sht15_calc_humid(data));
 
-};
+}
+
 static ssize_t show_name(struct device *dev,
 			 struct device_attribute *attr,
 			 char *buf)
@@ -376,12 +398,10 @@ static ssize_t show_name(struct device *dev,
 	return sprintf(buf, "%s\n", pdev->name);
 }
 
-static SENSOR_DEVICE_ATTR(temp1_input,
-			  S_IRUGO, sht15_show_temp,
-			  NULL, 0);
-static SENSOR_DEVICE_ATTR(humidity1_input,
-			  S_IRUGO, sht15_show_humidity,
-			  NULL, 0);
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO,
+			  sht15_show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(humidity1_input, S_IRUGO,
+			  sht15_show_humidity, NULL, 0);
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 static struct attribute *sht15_attrs[] = {
 	&sensor_dev_attr_temp1_input.dev_attr.attr,
@@ -397,16 +417,20 @@ static const struct attribute_group sht15_attr_group = {
 static irqreturn_t sht15_interrupt_fired(int irq, void *d)
 {
 	struct sht15_data *data = d;
+
 	/* First disable the interrupt */
 	disable_irq_nosync(irq);
 	atomic_inc(&data->interrupt_handled);
 	/* Then schedule a reading work struct */
-	if (data->flag != SHT15_READING_NOTHING)
+	if (data->state != SHT15_READING_NOTHING)
 		schedule_work(&data->read_work);
 	return IRQ_HANDLED;
 }
 
-/* Each byte of data is acknowledged by pulling the data line
+/**
+ * sht15_ack() - Send an ack to the device
+ *
+ * Each byte of data is acknowledged by pulling the data line
  * low for one clock pulse.
  */
 static void sht15_ack(struct sht15_data *data)
@@ -421,12 +445,13 @@ static void sht15_ack(struct sht15_data *data)
 
 	gpio_direction_input(data->pdata->gpio_data);
 }
+
 /**
  * sht15_end_transmission() - notify device of end of transmission
  * @data:	device state
  *
  * This is basically a NAK. (single clock pulse, data high)
- **/
+ */
 static void sht15_end_transmission(struct sht15_data *data)
 {
 	gpio_direction_output(data->pdata->gpio_data, 1);
@@ -444,12 +469,13 @@ static void sht15_bh_read_data(struct work_struct *work_s)
 	struct sht15_data *data
 		= container_of(work_s, struct sht15_data,
 			       read_work);
+
 	/* Firstly, verify the line is low */
 	if (gpio_get_value(data->pdata->gpio_data)) {
-		/* If not, then start the interrupt again - care
-		   here as could have gone low in meantime so verify
-		   it hasn't!
-		*/
+		/*
+		 * If not, then start the interrupt again - care here as could
+		 * have gone low in meantime so verify it hasn't!
+		 */
 		atomic_set(&data->interrupt_handled, 0);
 		enable_irq(gpio_to_irq(data->pdata->gpio_data));
 		/* If still not occured or another handler has been scheduled */
@@ -457,6 +483,7 @@ static void sht15_bh_read_data(struct work_struct *work_s)
 		    || atomic_read(&data->interrupt_handled))
 			return;
 	}
+
 	/* Read the data back from the device */
 	for (i = 0; i < 16; ++i) {
 		val <<= 1;
@@ -468,19 +495,22 @@ static void sht15_bh_read_data(struct work_struct *work_s)
 		if (i = 7)
 			sht15_ack(data);
 	}
+
 	/* Tell the device we are done */
 	sht15_end_transmission(data);
 
-	switch (data->flag) {
+	switch (data->state) {
 	case SHT15_READING_TEMP:
 		data->val_temp = val;
 		break;
 	case SHT15_READING_HUMID:
 		data->val_humid = val;
 		break;
+	default:
+		break;
 	}
 
-	data->flag = SHT15_READING_NOTHING;
+	data->state = SHT15_READING_NOTHING;
 	wake_up(&data->wait_queue);
 }
 
@@ -500,10 +530,10 @@ static void sht15_update_voltage(struct work_struct *work_s)
  *
  * Note that as the notification code holds the regulator lock, we have
  * to schedule an update of the supply voltage rather than getting it directly.
- **/
+ */
 static int sht15_invalidate_voltage(struct notifier_block *nb,
-				unsigned long event,
-				void *ignored)
+				    unsigned long event,
+				    void *ignored)
 {
 	struct sht15_data *data = container_of(nb, struct sht15_data, nb);
 
@@ -521,7 +551,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 
 	if (!data) {
 		ret = -ENOMEM;
-		dev_err(&pdev->dev, "kzalloc failed");
+		dev_err(&pdev->dev, "kzalloc failed\n");
 		goto error_ret;
 	}
 
@@ -533,13 +563,16 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 	init_waitqueue_head(&data->wait_queue);
 
 	if (pdev->dev.platform_data = NULL) {
-		dev_err(&pdev->dev, "no platform data supplied");
+		dev_err(&pdev->dev, "no platform data supplied\n");
 		goto err_free_data;
 	}
 	data->pdata = pdev->dev.platform_data;
-	data->supply_uV = data->pdata->supply_mv*1000;
+	data->supply_uV = data->pdata->supply_mv * 1000;
 
-/* If a regulator is available, query what the supply voltage actually is!*/
+	/*
+	 * If a regulator is available,
+	 * query what the supply voltage actually is!
+	 */
 	data->reg = regulator_get(data->dev, "vcc");
 	if (!IS_ERR(data->reg)) {
 		int voltage;
@@ -549,21 +582,25 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 			data->supply_uV = voltage;
 
 		regulator_enable(data->reg);
-		/* setup a notifier block to update this if another device
-		 *  causes the voltage to change */
+		/*
+		 * Setup a notifier block to update this if another device
+		 * causes the voltage to change
+		 */
 		data->nb.notifier_call = &sht15_invalidate_voltage;
 		ret = regulator_register_notifier(data->reg, &data->nb);
 	}
-/* Try requesting the GPIOs */
+
+	/* Try requesting the GPIOs */
 	ret = gpio_request(data->pdata->gpio_sck, "SHT15 sck");
 	if (ret) {
-		dev_err(&pdev->dev, "gpio request failed");
+		dev_err(&pdev->dev, "gpio request failed\n");
 		goto err_free_data;
 	}
 	gpio_direction_output(data->pdata->gpio_sck, 0);
+
 	ret = gpio_request(data->pdata->gpio_data, "SHT15 data");
 	if (ret) {
-		dev_err(&pdev->dev, "gpio request failed");
+		dev_err(&pdev->dev, "gpio request failed\n");
 		goto err_release_gpio_sck;
 	}
 	ret = sysfs_create_group(&pdev->dev.kobj, &sht15_attr_group);
@@ -578,7 +615,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 			  "sht15 data",
 			  data);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to get irq for data line");
+		dev_err(&pdev->dev, "failed to get irq for data line\n");
 		goto err_release_gpio_data;
 	}
 	disable_irq_nosync(gpio_to_irq(data->pdata->gpio_data));
@@ -590,6 +627,7 @@ static int __devinit sht15_probe(struct platform_device *pdev)
 		ret = PTR_ERR(data->hwmon_dev);
 		goto err_release_irq;
 	}
+
 	return 0;
 
 err_release_irq:
@@ -601,7 +639,6 @@ err_release_gpio_sck:
 err_free_data:
 	kfree(data);
 error_ret:
-
 	return ret;
 }
 
@@ -609,8 +646,10 @@ static int __devexit sht15_remove(struct platform_device *pdev)
 {
 	struct sht15_data *data = platform_get_drvdata(pdev);
 
-	/* Make sure any reads from the device are done and
-	 * prevent new ones from beginning */
+	/*
+	 * Make sure any reads from the device are done and
+	 * prevent new ones beginning
+	 */
 	mutex_lock(&data->read_lock);
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &sht15_attr_group);
@@ -625,10 +664,10 @@ static int __devexit sht15_remove(struct platform_device *pdev)
 	gpio_free(data->pdata->gpio_sck);
 	mutex_unlock(&data->read_lock);
 	kfree(data);
+
 	return 0;
 }
 
-
 /*
  * sht_drivers simultaneously refers to __devinit and __devexit function
  * which causes spurious section mismatch warning. So use __refdata to
@@ -673,7 +712,6 @@ static struct platform_driver __refdata sht_drivers[] = {
 	},
 };
 
-
 static int __init sht15_init(void)
 {
 	int ret;
diff --git a/include/linux/sht15.h b/include/linux/sht15.h
index 046bce0..1e30214 100644
--- a/include/linux/sht15.h
+++ b/include/linux/sht15.h
@@ -8,14 +8,18 @@
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
+ *
+ * For further information, see the Documentation/hwmon/sht15 file.
  */
 
 /**
  * struct sht15_platform_data - sht15 connectivity info
- * @gpio_data:	no. of gpio to which bidirectional data line is connected
- * @gpio_sck:	no. of gpio to which the data clock is connected.
- * @supply_mv:	supply voltage in mv. Overridden by regulator if available.
- **/
+ * @gpio_data:		no. of gpio to which bidirectional data line is
+ *			connected.
+ * @gpio_sck:		no. of gpio to which the data clock is connected.
+ * @supply_mv:		supply voltage in mv. Overridden by regulator if
+ *			available.
+ */
 struct sht15_platform_data {
 	int gpio_data;
 	int gpio_sck;
-- 
1.7.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
