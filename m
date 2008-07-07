From: Ken Milmore <ken@kenm.demon.co.uk>
Date: Mon, 07 Jul 2008 23:05:38 +0000
Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
Message-Id: <4872A142.6090204@kenm.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080307010905020300060208"
List-Id: <lm-sensors.vger.kernel.org>
References: <486F7926.6000304@kenm.demon.co.uk>
In-Reply-To: <486F7926.6000304@kenm.demon.co.uk>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080307010905020300060208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

George,

Thanks for incorporating those changes so quickly!

I'm afraid I didn't completely understand your new priority list code at 
first glance.  I will have to stare at it a bit longer until it sinks 
in! :-)

One thing that comes immediately to mind is that I think this 
table-stuffing should be done right up front, in a call from 
sm_asc7621_init(), not from asc7621_init_client().  Isn't 
asc7621_init_client called once for each aSC7621 *chip* that is 
detected?  If there are several chips (multi-CPU board?), then we don't 
want to repeat the table initialisation for each of them.

Another minor glitch is that I think you must be adding register address 
0 to the read lists, even though we don't need it (because 0 appears in 
all the empty entries of the msb and lsb arrays).  I'm sure this can 
easily be worked around, though.

Just to look at this from an alternative POV, I knocked up a read-only 
asc7621 mini-driver which doesn't use the table-driven paradigm (see 
patch).  It only supports the main inputs and alarms, but it could be 
very easily extended to cover about 90% of the functionality of the 
driver just by adding the required show_... functions, 
SENSOR_DEVICE_ATTR lines, and register reads.  For the remaining 10%, I 
realise that some of the PWM control knobs would be fiddly to implement, 
as they access bits of registers spattered all over the place.  I 
suppose that is what made you go down the table-driven design route in 
the first place.  Anyway, this is just FYI; I'm not trying to get you to 
alter course if you are happy with the existing design.

Cheers,

Ken.


George Joseph wrote:
> Here's the patch against 2.6.25.10.
> 
> signed-off-by: George Joseph <George.joseph@fairview5.com>
> 
> Ken, look at the new implementation of the priority registers.  It's still a loop initialization but it does get run only once at driver load.  With 98 registers of interest, I'm concerned that creating additional static arrays will make it hard to figure out what's going on.
> 
> george
> 
> 
>> -----Original Message-----
>> From: lm-sensors-bounces@lm-sensors.org [mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of George
>> Joseph
>> Sent: Sunday, July 06, 2008 4:18 PM
>> To: Ken Milmore; Hans de Goede
>> Cc: lm-sensors@lm-sensors.org
>> Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
>>
>> New patch will follow tomorrow ( I need to update my build environment).  Other comments in line...
>>
>>> -----Original Message-----
>>> From: Ken Milmore [mailto:ken@kenm.demon.co.uk]
>>> Sent: Sunday, July 06, 2008 10:49 AM
>>> To: Hans de Goede
>>> Cc: George Joseph; lm-sensors@lm-sensors.org
>>> Subject: Re: [lm-sensors] patch: asc7621 driver bug fixes
>>>
>>> Hans / George,
>>>
>>> Although things are shaping up nicely, I think there is still quite a bit left to do to completely
>>> review the driver.
>>>
>>> The aSC7621 appears to have a lot of bells and whistles for closed loop temperature control etc. and
>>> George has tried to support as much of this feature set as possible.  Unfortunately that means
>> there's
>>> quite a lot to review - I haven't really looked at PWM control yet.
>>>
>>> In any case, a few more things have come to light:
>>>
>>> 1.  In my last posting I wasn't completely sure if my "patch #2" was a good idea or not.  Having
>>> looked at the Andigilog specs, I have become convinced that it will be necessary after all.  The
>> main
>>> problem is with the two-byte registers.  To get the read-locking to work, the MSB and LSB must be
>> read
>>> together, one after the other (although it is unimportant which one is read first!).  So it is
>>> necessary to sequence the reads so that the two-byte registers are handled correctly.  My patch will
>>> correct this problem, although as I have said, I think that other, cleaner solutions may be
>> possible.
>>
>> Yep, my goof.  I thought I had this accounted for but it must have been in a earlier version of the
>> driver.  I solved it in the client_init code without creating a static array.  It only gets run once
>> at module load and it solves the msb-lsb issue.
>>
>>> 2.  The voltage scaling used in the driver appears to be slightly off from the nominal values given
>> in
>>> the spec.  To get the scaling exactly right, it is necessary to use a "muldiv" scheme which I've
>>> included in the patch (see below).
>> Yep, fixed.
>>
>>> 3.  I fixed a problem in store_fan16() whereby it wasn't possible to set the minimum fan RPM to
>> zero.
>>> The aSC7621 explicitly allows this, and of course it is useful to prevent spurious alarms for fans
>>> which are missing or stopped.
>> Yep, fixed.
>>
>>> The attached patch rolls up all my changes so far.  It applies against George's original patch of 29
>>> May.  It includes all the bug fixes from my last submission, the voltage scaling and fan fixes
>>> mentioned above and some tidying up of the high and low priority register lists.
>> All patches applied except for the register priorities and ordering which I fixed keeping the existing
>> paradigm.
>>
>>>
>>> To sum up, by now I'm very happy with the following functions of the driver:
>>>
>>> * Reading of voltages, fans and temperatures.
>>>
>>> * Setting of alarm limits and display of alarms.
>>>
>>> The following areas still need to be reviewed and perhaps improved:
>>>
>>> * PWM control.  A few scary lookup tables in the code that I don't understand yet!
>> Yeah, unfortunately, I can't think of a better way to translate what the chip exposes to the sysfs
>> specs.  Input definitely welcome.
>>
>>> * The miscellaneous configuration knobs (Input selection, PECI config etc).  I haven't tested these.
>> Actually, pay particular attention to PECI.  On my Conroes and Wolfdales, one of the peci temps
>> (temp5_input) appears to be the elusive and undocumented Tjmax. :)
>>
>>> * I think there is space for improvement in how the low-priority register list is handled.  A full
>>> minute between updates is probably too long.
>> Easy enough to change.  I was just copying from the other drivers.  Let me know what makes sense.
>>
>>> I hope this is of some use.  I will try to look at reviewing the remaining parts of the driver as
>> time
>>> allows.
>> Absolutely.  Keep sending feedback.
>>
>>> George, I'd appreciate your feedback on my patches so far; I realise you might want to approach some
>>> of these changes differently to the way I've done them.
>> Patches are great and I appreciate the time you're putting into the review!!
>>
>> george
>>
>>
>>> Best wishes,
>>>
>>> Ken.
>>>
>>>
>>> Hans de Goede wrote:
>>>> Ken Milmore wrote:
>>>>> George,
>>>>>
>>>>> Here are some suggested bug fixes for the asc7621 driver source which
>>>>> you posted to lm_sensors on 29 May.
>>>>> (http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023257.htm
>>>>> l)
>>>>>
>>>> Thanks for doing this, I promised George to review this driver, but
>>>> sofar haven't gotten around to doing this. Any chance you could do a
>>>> complete review of it (or have you already done so, it sure looks that
>>>> way :)
>>>>
>>>> George, I assume you will post a new version of your patch soon with
>>>> these fixes incorperated?
>>>>
>>>> Regards,
>>>>
>>>> Hans
>>>>
>>
>> _______________________________________________
>> lm-sensors mailing list
>> lm-sensors@lm-sensors.org
>> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

--------------080307010905020300060208
Content-Type: text/plain;
 name="asc7621.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asc7621.c.diff"

--- /dev/null	2005-11-21 03:22:37.000000000 +0000
+++ asc7621.c	2008-07-07 23:17:48.000000000 +0100
@@ -0,0 +1,382 @@
+/*
+    asc7621.c - Andigilog aSC7621 driver
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/err.h>
+#include <linux/mutex.h>
+
+#define ASC7621_UPDATE_INTERVAL (HZ * 2)
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = {
+	0x2c, 0x2d, 0x2e, I2C_CLIENT_END
+};
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_2(asc7621, asc7621a);
+
+/* Each client has this additional data */
+struct asc7621_data {
+	struct i2c_client client;
+	struct device *hwmon_dev;
+	struct mutex update_lock;
+	bool valid;
+	unsigned long last_updated; /* In jiffies */
+
+	/* Register values: */
+	u16 in_input[5];
+	u16 fan_input[4];
+	u16 temp_input[8];
+	u8 alarm[3];
+};
+
+static struct asc7621_data *asc7621_update_device(struct device *dev);
+
+/* Data Handlers: */
+
+static const s32 asc7621_in_scale[] = { 2500, 2250, 3300, 5000, 12000 };
+
+static ssize_t show_in_input(struct device *dev,
+		struct device_attribute *attr, char *buf) {
+
+	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	struct asc7621_data *data = asc7621_update_device(dev);
+	int index = sda->index;
+	s32 val = data->in_input[index];
+
+	val >>= 6;
+	val *= asc7621_in_scale[index];
+	val /= (192 << 2);
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t show_fan_input(struct device *dev,
+		struct device_attribute *attr, char *buf) {
+
+	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	struct asc7621_data *data = asc7621_update_device(dev);
+	int index = sda->index;
+	s32 val = data->fan_input[index];
+
+	if(val == 0)
+		val = -1;
+	else if(val == 0xffff)
+		val = 0;
+	else
+		val = (90000 * 60) / val;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t show_temp_input(struct device *dev,
+		struct device_attribute *attr, char *buf) {
+
+	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	struct asc7621_data *data = asc7621_update_device(dev);
+	int index = sda->index;
+	s32 val = (s16)(data->temp_input[index]); /* sign extension */
+
+	val >>= 6;
+	val *= 250;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t show_alarm(struct device *dev,
+		struct device_attribute *attr, char *buf) {
+
+	struct sensor_device_attribute *sda = to_sensor_dev_attr(attr);
+	struct asc7621_data *data = asc7621_update_device(dev);
+	int index = sda->index;
+	s32 val = data->alarm[index / 8];
+
+	val >>= (index % 8);
+	val &= 0x1;
+
+	return sprintf(buf, "%d\n", val);
+}
+
+static u8 asc7621_read_byte(struct i2c_client *client, u8 adr)
+{
+	u8 val = i2c_smbus_read_byte_data(client, adr) & 0xff;
+	return val;
+}
+
+static u16 asc7621_read_word(struct i2c_client *client, u8 ladr, u8 madr)
+{
+	u8 lval = i2c_smbus_read_byte_data(client, ladr) & 0xff;
+	u8 mval = i2c_smbus_read_byte_data(client, madr) & 0xff;
+	return (mval << 8) + lval;
+}
+
+void asc7621_read(struct i2c_client *client, struct asc7621_data *data)
+{
+	data->in_input[0]   = asc7621_read_word(client, 0x13, 0x20);
+	data->in_input[1]   = asc7621_read_word(client, 0x18, 0x21);
+	data->in_input[2]   = asc7621_read_word(client, 0x11, 0x22);
+	data->in_input[3]   = asc7621_read_word(client, 0x12, 0x23);
+	data->in_input[4]   = asc7621_read_word(client, 0x14, 0x24);
+
+	data->fan_input[0]  = asc7621_read_word(client, 0x28, 0x29);
+	data->fan_input[1]  = asc7621_read_word(client, 0x2a, 0x2b);
+	data->fan_input[2]  = asc7621_read_word(client, 0x2c, 0x2d);
+	data->fan_input[3]  = asc7621_read_word(client, 0x2e, 0x2f);
+
+	data->temp_input[0] = asc7621_read_word(client, 0x10, 0x25);
+	data->temp_input[1] = asc7621_read_word(client, 0x15, 0x26);
+	data->temp_input[2] = asc7621_read_word(client, 0x16, 0x27);
+	data->temp_input[3] = asc7621_read_word(client, 0x17, 0x33);
+	data->temp_input[4] = asc7621_read_word(client, 0xf6, 0xf7);
+	data->temp_input[5] = asc7621_read_word(client, 0xf8, 0xf9);
+	data->temp_input[6] = asc7621_read_word(client, 0xfa, 0xfb);
+	data->temp_input[7] = asc7621_read_word(client, 0xfc, 0xfd);
+
+	data->alarm[0]      = asc7621_read_byte(client, 0x41);
+	data->alarm[0]      = asc7621_read_byte(client, 0x42);
+	data->alarm[0]      = asc7621_read_byte(client, 0x43);
+}
+
+static struct asc7621_data *asc7621_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct asc7621_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+
+	if (!data->valid ||
+		time_after(jiffies, data->last_updated + ASC7621_UPDATE_INTERVAL)) {
+
+		asc7621_read(client, data);
+
+		data->last_updated = jiffies;
+		data->valid = true;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
+
+/* Sysfs attributes: */
+
+static SENSOR_DEVICE_ATTR(in0_input,   S_IRUGO, show_in_input,   NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_input,   S_IRUGO, show_in_input,   NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_input,   S_IRUGO, show_in_input,   NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_input,   S_IRUGO, show_in_input,   NULL, 3);
+static SENSOR_DEVICE_ATTR(in4_input,   S_IRUGO, show_in_input,   NULL, 4);
+
+static SENSOR_DEVICE_ATTR(fan1_input,  S_IRUGO, show_fan_input,  NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input,  S_IRUGO, show_fan_input,  NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_input,  S_IRUGO, show_fan_input,  NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_input,  S_IRUGO, show_fan_input,  NULL, 3);
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp_input, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp_input, NULL, 2);
+static SENSOR_DEVICE_ATTR(temp4_input, S_IRUGO, show_temp_input, NULL, 3);
+static SENSOR_DEVICE_ATTR(temp5_input, S_IRUGO, show_temp_input, NULL, 4);
+static SENSOR_DEVICE_ATTR(temp6_input, S_IRUGO, show_temp_input, NULL, 5);
+static SENSOR_DEVICE_ATTR(temp7_input, S_IRUGO, show_temp_input, NULL, 6);
+static SENSOR_DEVICE_ATTR(temp8_input, S_IRUGO, show_temp_input, NULL, 7);
+
+static SENSOR_DEVICE_ATTR(in0_alarm,   S_IRUGO, show_alarm,      NULL, 0);
+static SENSOR_DEVICE_ATTR(in1_alarm,   S_IRUGO, show_alarm,      NULL, 1);
+static SENSOR_DEVICE_ATTR(in2_alarm,   S_IRUGO, show_alarm,      NULL, 2);
+static SENSOR_DEVICE_ATTR(in3_alarm,   S_IRUGO, show_alarm,      NULL, 3);
+static SENSOR_DEVICE_ATTR(temp1_alarm, S_IRUGO, show_alarm,      NULL, 4);
+static SENSOR_DEVICE_ATTR(temp2_alarm, S_IRUGO, show_alarm,      NULL, 5);
+static SENSOR_DEVICE_ATTR(temp3_alarm, S_IRUGO, show_alarm,      NULL, 6);
+static SENSOR_DEVICE_ATTR(in4_alarm,   S_IRUGO, show_alarm,      NULL, 8);
+static SENSOR_DEVICE_ATTR(fan1_alarm,  S_IRUGO, show_alarm,      NULL, 10);
+static SENSOR_DEVICE_ATTR(fan2_alarm,  S_IRUGO, show_alarm,      NULL, 11);
+static SENSOR_DEVICE_ATTR(fan3_alarm,  S_IRUGO, show_alarm,      NULL, 12);
+static SENSOR_DEVICE_ATTR(fan4_alarm,  S_IRUGO, show_alarm,      NULL, 13);
+static SENSOR_DEVICE_ATTR(temp4_alarm, S_IRUGO, show_alarm,      NULL, 16);
+
+static struct attribute *asc7621_attributes[] = {
+	&sensor_dev_attr_in0_input.dev_attr.attr,
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp4_input.dev_attr.attr,
+	&sensor_dev_attr_temp5_input.dev_attr.attr,
+	&sensor_dev_attr_temp6_input.dev_attr.attr,
+	&sensor_dev_attr_temp7_input.dev_attr.attr,
+	&sensor_dev_attr_temp8_input.dev_attr.attr,
+	&sensor_dev_attr_in0_alarm.dev_attr.attr,
+	&sensor_dev_attr_in1_alarm.dev_attr.attr,
+	&sensor_dev_attr_in2_alarm.dev_attr.attr,
+	&sensor_dev_attr_in3_alarm.dev_attr.attr,
+	&sensor_dev_attr_in4_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
+	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
+	&sensor_dev_attr_temp4_alarm.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group asc7621_group = {
+	.attrs = asc7621_attributes,
+};
+
+static int asc7621_attach_adapter(struct i2c_adapter *adapter);
+static int asc7621_detach_client(struct i2c_client *client);
+
+static struct i2c_driver asc7621_driver = {
+	.driver = {
+		.name = "asc7621",
+	},
+	.attach_adapter = asc7621_attach_adapter,
+	.detach_client = asc7621_detach_client,
+};
+
+static int asc7621_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct i2c_client *client;
+	struct asc7621_data *data;
+	const char *name;
+	int err = 0;
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto exit;
+
+	/* Create the client structure */
+	if (!(data = kzalloc(sizeof(struct asc7621_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	/* Fill in enough client fields so that we can read from the chip */
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &asc7621_driver;
+	client->flags = 0;
+
+	/* A negative kind means that the driver was loaded with no force
+	   parameter (default), so we must identify the chip. */
+	if (kind < 0) {
+		u8 company, verstep;
+
+		company = i2c_smbus_read_byte_data(client, 0x3e); /* Company ID */
+		if(company != 0x61) /* Andigilog */
+			goto exit_free;
+
+		verstep = i2c_smbus_read_byte_data(client, 0x3f); /* Version/stepping */
+		if(verstep == 0x6c) /* aSC7621 */
+			kind = asc7621;
+		else if(verstep == 0x6d) /* aSC7621a */
+			kind = asc7621a;
+		else
+			goto exit_free;
+	}
+
+	/* Give it the proper name */
+	if (kind == asc7621)
+		name = "asc7621";
+	else if (kind == asc7621a)
+		name = "asc7621a";
+	else
+	{
+		err = -ENODEV;
+		goto exit_free;
+	}
+
+	/* Fill in the remaining client fields */
+	strlcpy(client->name, name, I2C_NAME_SIZE);
+	data->valid = false;
+	mutex_init(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(client)))
+		goto exit_free;
+
+	/* Register sysfs hooks */
+	if ((err = sysfs_create_group(&client->dev.kobj, &asc7621_group)))
+		goto exit_detach;
+
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		err = PTR_ERR(data->hwmon_dev);
+		goto exit_remove;
+	}
+
+	return 0;
+
+exit_remove:
+	sysfs_remove_group(&client->dev.kobj, &asc7621_group);
+exit_detach:
+	i2c_detach_client(client);
+exit_free:
+	kfree(data);
+exit:
+	return err;
+}
+
+static int asc7621_detach_client(struct i2c_client *client)
+{
+	struct asc7621_data *data = i2c_get_clientdata(client);
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &asc7621_group);
+	i2c_detach_client(client);
+	kfree(data);
+	return 0;
+}
+
+static int asc7621_attach_adapter(struct i2c_adapter *adapter)
+{
+	if (!(adapter->class & I2C_CLASS_HWMON))
+			return 0;
+	return i2c_probe(adapter, &addr_data, asc7621_detect);
+}
+
+static int __init sm_asc7621_init(void)
+{
+	return i2c_add_driver(&asc7621_driver);
+}
+
+static void __exit sm_asc7621_exit(void)
+{
+	i2c_del_driver(&asc7621_driver);
+}
+
+MODULE_DESCRIPTION("Andigilog aSC7621 driver");
+MODULE_LICENSE("GPL");
+
+module_init(sm_asc7621_init);
+module_exit(sm_asc7621_exit);

--------------080307010905020300060208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080307010905020300060208--
