From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Mar 2010 12:43:56 +0000
Subject: Re: [lm-sensors] e5e9f44c causes buffer under-runs
Message-Id: <20100303134356.072914bf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100303070914.GE5086@bicker>
In-Reply-To: <20100303070914.GE5086@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Hi Dan,

On Wed, 3 Mar 2010 10:09:14 +0300, Dan Carpenter wrote:
> Smatch complains about:  e5e9f44c2 i2c: Drop I2C_CLIENT_INSMOD_2 to 8
> 
> The original define had an "any_chip", but this patch removed it.
> 
> -#define I2C_CLIENT_INSMOD_8(chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8) \
> -enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6,       \
> -            chip7, chip8 }
> 
> This causes some buffer under runs.
> 
> drivers/hwmon/fschmd.c +1040 fschmd_detect(33) warn: array offset '(kind-1)' can be negative (-1)
> drivers/hwmon/tmp401.c +527 tmp401_detect(37) warn: array offset '(kind-1)' can be negative (-1)
> drivers/hwmon/tmp421.c +255 tmp421_detect(30) warn: array offset '(kind-1)' can be negative (-1)
> drivers/hwmon/tmp421.c +256 tmp421_detect(31) warn: array offset '(kind-1)' can be negative (-1)
> 
> (From a test version of smatch).

Thanks a lot for reporting. I was well aware that these drivers would
need special care when getting rid of the I2C_CLIENT_INSMOD_* macros,
and I _thought_ I had taken care, I even seem to remember changing the
code in question... but apparently I managed to lose the changes
somewhere in the process. Sigh.

The following patch should fix it. Please apply it, run smatch again
and confirm the warnings are gone.

Hans, please confirm that I got the fschmd driver right. Andre, please
confirm that I got the tmp421 driver right (I decided to change the
device data to be explicitly the channel count, otherwise the code was
simply too confusing.) As for the tmp401 driver, it is simple enough
that I am confident I got it right.

* * * * *

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: Fix off-by-one kind values

Recent changes on the I2C front have left off-by-one array indexes in
3 hwmon drivers. Fix them.

Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andre Prendel <andre.prendel@gmx.de>
---
 drivers/hwmon/fschmd.c |   15 ++++++---------
 drivers/hwmon/tmp401.c |    7 +++----
 drivers/hwmon/tmp421.c |   18 +++++++++---------
 3 files changed, 18 insertions(+), 22 deletions(-)

--- linux-2.6.34-rc0.orig/drivers/hwmon/fschmd.c	2010-03-03 11:22:50.000000000 +0100
+++ linux-2.6.34-rc0/drivers/hwmon/fschmd.c	2010-03-03 12:15:07.000000000 +0100
@@ -267,7 +267,7 @@ struct fschmd_data {
 	struct list_head list; /* member of the watchdog_data_list */
 	struct kref kref;
 	struct miscdevice watchdog_miscdev;
-	int kind;
+	enum chips kind;
 	unsigned long watchdog_is_open;
 	char watchdog_expect_close;
 	char watchdog_name[10]; /* must be unique to avoid sysfs conflict */
@@ -325,8 +325,7 @@ static ssize_t show_in_value(struct devi
 	int index = to_sensor_dev_attr(devattr)->index;
 	struct fschmd_data *data = fschmd_update_device(dev);
 
-	/* fscher / fschrc - 1 as data->kind is an array index, not a chips */
-	if (data->kind = (fscher - 1) || data->kind >= (fschrc - 1))
+	if (data->kind = fscher || data->kind >= fschrc)
 		return sprintf(buf, "%d\n", (data->volt[index] * dmi_vref *
 			dmi_mult[index]) / 255 + dmi_offset[index]);
 	else
@@ -492,7 +491,7 @@ static ssize_t show_pwm_auto_point1_pwm(
 	int val = data->fan_min[index];
 
 	/* 0 = allow turning off (except on the syl), 1-255 = 50-100% */
-	if (val || data->kind = fscsyl - 1)
+	if (val || data->kind = fscsyl)
 		val = val / 2 + 128;
 
 	return sprintf(buf, "%d\n", val);
@@ -506,7 +505,7 @@ static ssize_t store_pwm_auto_point1_pwm
 	unsigned long v = simple_strtoul(buf, NULL, 10);
 
 	/* reg: 0 = allow turning off (except on the syl), 1-255 = 50-100% */
-	if (v || data->kind = fscsyl - 1) {
+	if (v || data->kind = fscsyl) {
 		v = SENSORS_LIMIT(v, 128, 255);
 		v = (v - 128) * 2 + 1;
 	}
@@ -1037,7 +1036,7 @@ static int fschmd_detect(struct i2c_clie
 	else
 		return -ENODEV;
 
-	strlcpy(info->type, fschmd_id[kind - 1].name, I2C_NAME_SIZE);
+	strlcpy(info->type, fschmd_id[kind].name, I2C_NAME_SIZE);
 
 	return 0;
 }
@@ -1065,6 +1064,7 @@ static int fschmd_probe(struct i2c_clien
 	   (where the client is found through a data ptr instead of the
 	   otherway around) */
 	data->client = client;
+	data->kind = kind;
 
 	if (kind = fscpos) {
 		/* The Poseidon has hardwired temp limits, fill these
@@ -1085,9 +1085,6 @@ static int fschmd_probe(struct i2c_clien
 		}
 	}
 
-	/* i2c kind goes from 1-6, we want from 0-5 to address arrays */
-	data->kind = kind - 1;
-
 	/* Read in some never changing registers */
 	data->revision = i2c_smbus_read_byte_data(client, FSCHMD_REG_REVISION);
 	data->global_control = i2c_smbus_read_byte_data(client,
--- linux-2.6.34-rc0.orig/drivers/hwmon/tmp401.c	2010-02-25 09:12:22.000000000 +0100
+++ linux-2.6.34-rc0/drivers/hwmon/tmp401.c	2010-03-03 11:40:35.000000000 +0100
@@ -134,7 +134,7 @@ struct tmp401_data {
 	struct mutex update_lock;
 	char valid; /* zero until following fields are valid */
 	unsigned long last_updated; /* in jiffies */
-	int kind;
+	enum chips kind;
 
 	/* register values */
 	u8 status;
@@ -524,7 +524,7 @@ static int tmp401_detect(struct i2c_clie
 	if (reg > 15)
 		return -ENODEV;
 
-	strlcpy(info->type, tmp401_id[kind - 1].name, I2C_NAME_SIZE);
+	strlcpy(info->type, tmp401_id[kind].name, I2C_NAME_SIZE);
 
 	return 0;
 }
@@ -572,8 +572,7 @@ static int tmp401_probe(struct i2c_clien
 		goto exit_remove;
 	}
 
-	dev_info(&client->dev, "Detected TI %s chip\n",
-		 names[data->kind - 1]);
+	dev_info(&client->dev, "Detected TI %s chip\n", names[data->kind]);
 
 	return 0;
 
--- linux-2.6.34-rc0.orig/drivers/hwmon/tmp421.c	2010-02-25 09:12:22.000000000 +0100
+++ linux-2.6.34-rc0/drivers/hwmon/tmp421.c	2010-03-03 12:56:05.000000000 +0100
@@ -61,9 +61,9 @@ static const u8 TMP421_TEMP_LSB[4]		= {
 #define TMP423_DEVICE_ID			0x23
 
 static const struct i2c_device_id tmp421_id[] = {
-	{ "tmp421", tmp421 },
-	{ "tmp422", tmp422 },
-	{ "tmp423", tmp423 },
+	{ "tmp421", 2 },
+	{ "tmp422", 3 },
+	{ "tmp423", 4 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tmp421_id);
@@ -73,7 +73,7 @@ struct tmp421_data {
 	struct mutex update_lock;
 	char valid;
 	unsigned long last_updated;
-	int kind;
+	int channels;
 	u8 config;
 	s16 temp[4];
 };
@@ -107,7 +107,7 @@ static struct tmp421_data *tmp421_update
 		data->config = i2c_smbus_read_byte_data(client,
 			TMP421_CONFIG_REG_1);
 
-		for (i = 0; i <= data->kind; i++) {
+		for (i = 0; i < data->channels; i++) {
 			data->temp[i] = i2c_smbus_read_byte_data(client,
 				TMP421_TEMP_MSB[i]) << 8;
 			data->temp[i] |= i2c_smbus_read_byte_data(client,
@@ -166,7 +166,7 @@ static mode_t tmp421_is_visible(struct k
 	devattr = container_of(a, struct device_attribute, attr);
 	index = to_sensor_dev_attr(devattr)->index;
 
-	if (data->kind > index)
+	if (index < data->channels)
 		return a->mode;
 
 	return 0;
@@ -252,9 +252,9 @@ static int tmp421_detect(struct i2c_clie
 		return -ENODEV;
 	}
 
-	strlcpy(info->type, tmp421_id[kind - 1].name, I2C_NAME_SIZE);
+	strlcpy(info->type, tmp421_id[kind].name, I2C_NAME_SIZE);
 	dev_info(&adapter->dev, "Detected TI %s chip at 0x%02x\n",
-		 names[kind - 1], client->addr);
+		 names[kind], client->addr);
 
 	return 0;
 }
@@ -271,7 +271,7 @@ static int tmp421_probe(struct i2c_clien
 
 	i2c_set_clientdata(client, data);
 	mutex_init(&data->update_lock);
-	data->kind = id->driver_data;
+	data->channels = id->driver_data;
 
 	err = tmp421_init_client(client);
 	if (err)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
