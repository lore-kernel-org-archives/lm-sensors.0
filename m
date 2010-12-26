From: Grant Coady <gcoady.lk@gmail.com>
Date: Sun, 26 Dec 2010 23:31:23 +0000
Subject: Re: [lm-sensors] [PATCH 1/4 v2] hwmon: (adm9240) Implement the
Message-Id: <sqjfh693p3re5c91vcaacg4qvuhobiabfb@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101103133650.21d4dd5a@endymion.delvare>
In-Reply-To: <20101103133650.21d4dd5a@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

I'm sorry, other issues prevented me from testing this (I spent Xmas day 
in hospital) -- it may be couple weeks or more before I can test that box, 
I still have it, but need to do an OS reinstall) so I can test the new 
stuff on it.

Cheers,
Grant.

On Wed, 3 Nov 2010 13:36:50 +0100, you wrote:

>We have a standard intrusion detection interface now, drivers should
>implement it. I've left the old interface in place for the time being,
>with a deprecation warning, it will be removed later.
>
>Signed-off-by: Jean Delvare <khali@linux-fr.org>
>---
>Grant, would you by any chance be still able to test the adm9240 driver?
>
> Documentation/hwmon/adm9240 |    2 +-
> drivers/hwmon/adm9240.c     |   32 +++++++++++++++++++++++++++++---
> 2 files changed, 30 insertions(+), 4 deletions(-)
>
>--- linux-2.6.37-rc1.orig/drivers/hwmon/adm9240.c	2010-11-02 17:39:20.000000000 +0100
>+++ linux-2.6.37-rc1/drivers/hwmon/adm9240.c	2010-11-03 11:35:54.000000000 +0100
>@@ -20,7 +20,7 @@
>  * Alarms	16-bit map of active alarms
>  * Analog Out	0..1250 mV output
>  *
>- * Chassis Intrusion: clear CI latch with 'echo 1 > chassis_clear'
>+ * Chassis Intrusion: clear CI latch with 'echo 0 > intrusion0_alarm'
>  *
>  * Test hardware: Intel SE440BX-2 desktop motherboard --Grant
>  *
>@@ -476,13 +476,16 @@ static ssize_t set_aout(struct device *d
> static DEVICE_ATTR(aout_output, S_IRUGO | S_IWUSR, show_aout, set_aout);
> 
> /* chassis_clear */
>-static ssize_t chassis_clear(struct device *dev,
>+static ssize_t chassis_clear_legacy(struct device *dev,
> 		struct device_attribute *attr,
> 		const char *buf, size_t count)
> {
> 	struct i2c_client *client = to_i2c_client(dev);
> 	unsigned long val = simple_strtol(buf, NULL, 10);
> 
>+	dev_warn(dev, "Attribute chassis_clear is deprecated, "
>+		 "use intrusion0_alarm instead\n");
>+
> 	if (val = 1) {
> 		i2c_smbus_write_byte_data(client,
> 				ADM9240_REG_CHASSIS_CLEAR, 0x80);
>@@ -490,7 +493,29 @@ static ssize_t chassis_clear(struct devi
> 	}
> 	return count;
> }
>-static DEVICE_ATTR(chassis_clear, S_IWUSR, NULL, chassis_clear);
>+static DEVICE_ATTR(chassis_clear, S_IWUSR, NULL, chassis_clear_legacy);
>+
>+static ssize_t chassis_clear(struct device *dev,
>+		struct device_attribute *attr,
>+		const char *buf, size_t count)
>+{
>+	struct i2c_client *client = to_i2c_client(dev);
>+	struct adm9240_data *data = i2c_get_clientdata(client);
>+	unsigned long val;
>+
>+	if (strict_strtoul(buf, 10, &val) || val != 0)
>+		return -EINVAL;
>+
>+	mutex_lock(&data->update_lock);
>+	i2c_smbus_write_byte_data(client, ADM9240_REG_CHASSIS_CLEAR, 0x80);
>+	data->valid = 0;		/* Force cache refresh */
>+	mutex_unlock(&data->update_lock);
>+	dev_dbg(&client->dev, "chassis intrusion latch cleared\n");
>+
>+	return count;
>+}
>+static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IRUGO | S_IWUSR, show_alarm,
>+		chassis_clear, 12);
> 
> static struct attribute *adm9240_attributes[] = {
> 	&sensor_dev_attr_in0_input.dev_attr.attr,
>@@ -532,6 +557,7 @@ static struct attribute *adm9240_attribu
> 	&dev_attr_alarms.attr,
> 	&dev_attr_aout_output.attr,
> 	&dev_attr_chassis_clear.attr,
>+	&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,
> 	&dev_attr_cpu0_vid.attr,
> 	NULL
> };
>--- linux-2.6.37-rc1.orig/Documentation/hwmon/adm9240	2010-11-02 17:39:20.000000000 +0100
>+++ linux-2.6.37-rc1/Documentation/hwmon/adm9240	2010-11-02 20:08:17.000000000 +0100
>@@ -155,7 +155,7 @@ connected to a normally open switch.
> The ADM9240 provides an internal open drain on this line, and may output
> a 20 ms active low pulse to reset an external Chassis Intrusion latch.
> 
>-Clear the CI latch by writing value 1 to the sysfs chassis_clear file.
>+Clear the CI latch by writing value 0 to the sysfs intrusion0_alarm file.
> 
> Alarm flags reported as 16-bit word
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
