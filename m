From: Grant Coady <gcoady.lk@gmail.com>
Date: Fri, 04 Jul 2014 05:39:22 +0000
Subject: Re: [lm-sensors] [RFT][PATCH 1/2] hwmon: (adm9240) Avoid forward declaration
Message-Id: <odfcr911ru07dpp2qttsgjkipljdtsfehd@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404395989.4895.12.camel@phoenix>
In-Reply-To: <1404395989.4895.12.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel, others,

Please note I no longer have the hardware to test this driver.

Thanks,
Grant.

On Thu, 03 Jul 2014 21:59:49 +0800, you wrote:

>Reorder functions to avoid forward declaration.
>
>Signed-off-by: Axel Lin <axel.lin@ingics.com>
>---
> drivers/hwmon/adm9240.c | 315 +++++++++++++++++++++++-------------------------
> 1 file changed, 153 insertions(+), 162 deletions(-)
>
>diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
>index 086d02a..8235ae4 100644
>--- a/drivers/hwmon/adm9240.c
>+++ b/drivers/hwmon/adm9240.c
>@@ -130,35 +130,6 @@ static inline unsigned int AOUT_FROM_REG(u8 reg)
> 	return SCALE(reg, 1250, 255);
> }
> 
>-static int adm9240_probe(struct i2c_client *client,
>-			 const struct i2c_device_id *id);
>-static int adm9240_detect(struct i2c_client *client,
>-			  struct i2c_board_info *info);
>-static void adm9240_init_client(struct i2c_client *client);
>-static int adm9240_remove(struct i2c_client *client);
>-static struct adm9240_data *adm9240_update_device(struct device *dev);
>-
>-/* driver data */
>-static const struct i2c_device_id adm9240_id[] = {
>-	{ "adm9240", adm9240 },
>-	{ "ds1780", ds1780 },
>-	{ "lm81", lm81 },
>-	{ }
>-};
>-MODULE_DEVICE_TABLE(i2c, adm9240_id);
>-
>-static struct i2c_driver adm9240_driver = {
>-	.class		= I2C_CLASS_HWMON,
>-	.driver = {
>-		.name	= "adm9240",
>-	},
>-	.probe		= adm9240_probe,
>-	.remove		= adm9240_remove,
>-	.id_table	= adm9240_id,
>-	.detect		= adm9240_detect,
>-	.address_list	= normal_i2c,
>-};
>-
> /* per client data */
> struct adm9240_data {
> 	struct device *hwmon_dev;
>@@ -181,6 +152,110 @@ struct adm9240_data {
> 	u8 vrm;			/* --	vrm set on startup, no accessor */
> };
> 
>+/* write new fan div, callers must hold data->update_lock */
>+static void adm9240_write_fan_div(struct i2c_client *client, int nr,
>+		u8 fan_div)
>+{
>+	u8 reg, old, shift = (nr + 2) * 2;
>+
>+	reg = i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
>+	old = (reg >> shift) & 3;
>+	reg &= ~(3 << shift);
>+	reg |= (fan_div << shift);
>+	i2c_smbus_write_byte_data(client, ADM9240_REG_VID_FAN_DIV, reg);
>+	dev_dbg(&client->dev,
>+		"fan%d clock divider changed from %u to %u\n",
>+		nr + 1, 1 << old, 1 << fan_div);
>+}
>+
>+static struct adm9240_data *adm9240_update_device(struct device *dev)
>+{
>+	struct i2c_client *client = to_i2c_client(dev);
>+	struct adm9240_data *data = i2c_get_clientdata(client);
>+	int i;
>+
>+	mutex_lock(&data->update_lock);
>+
>+	/* minimum measurement cycle: 1.75 seconds */
>+	if (time_after(jiffies, data->last_updated_measure + (HZ * 7 / 4))
>+			|| !data->valid) {
>+
>+		for (i = 0; i < 6; i++) { /* read voltages */
>+			data->in[i] = i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_IN(i));
>+		}
>+		data->alarms = i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_INT(0)) |
>+					i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_INT(1)) << 8;
>+
>+		/*
>+		 * read temperature: assume temperature changes less than
>+		 * 0.5'C per two measurement cycles thus ignore possible
>+		 * but unlikely aliasing error on lsb reading. --Grant
>+		 */
>+		data->temp = ((i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_TEMP) << 8) |
>+					i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_TEMP_CONF)) / 128;
>+
>+		for (i = 0; i < 2; i++) { /* read fans */
>+			data->fan[i] = i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_FAN(i));
>+
>+			/* adjust fan clock divider on overflow */
>+			if (data->valid && data->fan[i] = 255 &&
>+					data->fan_div[i] < 3) {
>+
>+				adm9240_write_fan_div(client, i,
>+						++data->fan_div[i]);
>+
>+				/* adjust fan_min if active, but not to 0 */
>+				if (data->fan_min[i] < 255 &&
>+						data->fan_min[i] >= 2)
>+					data->fan_min[i] /= 2;
>+			}
>+		}
>+		data->last_updated_measure = jiffies;
>+	}
>+
>+	/* minimum config reading cycle: 300 seconds */
>+	if (time_after(jiffies, data->last_updated_config + (HZ * 300))
>+			|| !data->valid) {
>+
>+		for (i = 0; i < 6; i++) {
>+			data->in_min[i] = i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_IN_MIN(i));
>+			data->in_max[i] = i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_IN_MAX(i));
>+		}
>+		for (i = 0; i < 2; i++) {
>+			data->fan_min[i] = i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_FAN_MIN(i));
>+		}
>+		data->temp_max[0] = i2c_smbus_read_byte_data(client,
>+				ADM9240_REG_TEMP_MAX(0));
>+		data->temp_max[1] = i2c_smbus_read_byte_data(client,
>+				ADM9240_REG_TEMP_MAX(1));
>+
>+		/* read fan divs and 5-bit VID */
>+		i = i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
>+		data->fan_div[0] = (i >> 4) & 3;
>+		data->fan_div[1] = (i >> 6) & 3;
>+		data->vid = i & 0x0f;
>+		data->vid |= (i2c_smbus_read_byte_data(client,
>+					ADM9240_REG_VID4) & 1) << 4;
>+		/* read analog out */
>+		data->aout = i2c_smbus_read_byte_data(client,
>+				ADM9240_REG_ANALOG_OUT);
>+
>+		data->last_updated_config = jiffies;
>+		data->valid = 1;
>+	}
>+	mutex_unlock(&data->update_lock);
>+	return data;
>+}
>+
> /*** sysfs accessors ***/
> 
> /* temperature */
>@@ -340,22 +415,6 @@ static ssize_t show_fan_div(struct device *dev,
> 	return sprintf(buf, "%d\n", 1 << data->fan_div[attr->index]);
> }
> 
>-/* write new fan div, callers must hold data->update_lock */
>-static void adm9240_write_fan_div(struct i2c_client *client, int nr,
>-		u8 fan_div)
>-{
>-	u8 reg, old, shift = (nr + 2) * 2;
>-
>-	reg = i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
>-	old = (reg >> shift) & 3;
>-	reg &= ~(3 << shift);
>-	reg |= (fan_div << shift);
>-	i2c_smbus_write_byte_data(client, ADM9240_REG_VID_FAN_DIV, reg);
>-	dev_dbg(&client->dev,
>-		"fan%d clock divider changed from %u to %u\n",
>-		nr + 1, 1 << old, 1 << fan_div);
>-}
>-
> /*
>  * set fan speed low limit:
>  *
>@@ -620,49 +679,6 @@ static int adm9240_detect(struct i2c_client *new_client,
> 	return 0;
> }
> 
>-static int adm9240_probe(struct i2c_client *new_client,
>-			 const struct i2c_device_id *id)
>-{
>-	struct adm9240_data *data;
>-	int err;
>-
>-	data = devm_kzalloc(&new_client->dev, sizeof(*data), GFP_KERNEL);
>-	if (!data)
>-		return -ENOMEM;
>-
>-	i2c_set_clientdata(new_client, data);
>-	mutex_init(&data->update_lock);
>-
>-	adm9240_init_client(new_client);
>-
>-	/* populate sysfs filesystem */
>-	err = sysfs_create_group(&new_client->dev.kobj, &adm9240_group);
>-	if (err)
>-		return err;
>-
>-	data->hwmon_dev = hwmon_device_register(&new_client->dev);
>-	if (IS_ERR(data->hwmon_dev)) {
>-		err = PTR_ERR(data->hwmon_dev);
>-		goto exit_remove;
>-	}
>-
>-	return 0;
>-
>-exit_remove:
>-	sysfs_remove_group(&new_client->dev.kobj, &adm9240_group);
>-	return err;
>-}
>-
>-static int adm9240_remove(struct i2c_client *client)
>-{
>-	struct adm9240_data *data = i2c_get_clientdata(client);
>-
>-	hwmon_device_unregister(data->hwmon_dev);
>-	sysfs_remove_group(&client->dev.kobj, &adm9240_group);
>-
>-	return 0;
>-}
>-
> static void adm9240_init_client(struct i2c_client *client)
> {
> 	struct adm9240_data *data = i2c_get_clientdata(client);
>@@ -705,93 +721,68 @@ static void adm9240_init_client(struct i2c_client *client)
> 	}
> }
> 
>-static struct adm9240_data *adm9240_update_device(struct device *dev)
>+static int adm9240_probe(struct i2c_client *new_client,
>+			 const struct i2c_device_id *id)
> {
>-	struct i2c_client *client = to_i2c_client(dev);
>-	struct adm9240_data *data = i2c_get_clientdata(client);
>-	int i;
>+	struct adm9240_data *data;
>+	int err;
> 
>-	mutex_lock(&data->update_lock);
>+	data = devm_kzalloc(&new_client->dev, sizeof(*data), GFP_KERNEL);
>+	if (!data)
>+		return -ENOMEM;
> 
>-	/* minimum measurement cycle: 1.75 seconds */
>-	if (time_after(jiffies, data->last_updated_measure + (HZ * 7 / 4))
>-			|| !data->valid) {
>+	i2c_set_clientdata(new_client, data);
>+	mutex_init(&data->update_lock);
> 
>-		for (i = 0; i < 6; i++) { /* read voltages */
>-			data->in[i] = i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_IN(i));
>-		}
>-		data->alarms = i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_INT(0)) |
>-					i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_INT(1)) << 8;
>+	adm9240_init_client(new_client);
> 
>-		/*
>-		 * read temperature: assume temperature changes less than
>-		 * 0.5'C per two measurement cycles thus ignore possible
>-		 * but unlikely aliasing error on lsb reading. --Grant
>-		 */
>-		data->temp = ((i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_TEMP) << 8) |
>-					i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_TEMP_CONF)) / 128;
>+	/* populate sysfs filesystem */
>+	err = sysfs_create_group(&new_client->dev.kobj, &adm9240_group);
>+	if (err)
>+		return err;
> 
>-		for (i = 0; i < 2; i++) { /* read fans */
>-			data->fan[i] = i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_FAN(i));
>+	data->hwmon_dev = hwmon_device_register(&new_client->dev);
>+	if (IS_ERR(data->hwmon_dev)) {
>+		err = PTR_ERR(data->hwmon_dev);
>+		goto exit_remove;
>+	}
> 
>-			/* adjust fan clock divider on overflow */
>-			if (data->valid && data->fan[i] = 255 &&
>-					data->fan_div[i] < 3) {
>+	return 0;
> 
>-				adm9240_write_fan_div(client, i,
>-						++data->fan_div[i]);
>+exit_remove:
>+	sysfs_remove_group(&new_client->dev.kobj, &adm9240_group);
>+	return err;
>+}
> 
>-				/* adjust fan_min if active, but not to 0 */
>-				if (data->fan_min[i] < 255 &&
>-						data->fan_min[i] >= 2)
>-					data->fan_min[i] /= 2;
>-			}
>-		}
>-		data->last_updated_measure = jiffies;
>-	}
>+static int adm9240_remove(struct i2c_client *client)
>+{
>+	struct adm9240_data *data = i2c_get_clientdata(client);
> 
>-	/* minimum config reading cycle: 300 seconds */
>-	if (time_after(jiffies, data->last_updated_config + (HZ * 300))
>-			|| !data->valid) {
>+	hwmon_device_unregister(data->hwmon_dev);
>+	sysfs_remove_group(&client->dev.kobj, &adm9240_group);
> 
>-		for (i = 0; i < 6; i++) {
>-			data->in_min[i] = i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_IN_MIN(i));
>-			data->in_max[i] = i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_IN_MAX(i));
>-		}
>-		for (i = 0; i < 2; i++) {
>-			data->fan_min[i] = i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_FAN_MIN(i));
>-		}
>-		data->temp_max[0] = i2c_smbus_read_byte_data(client,
>-				ADM9240_REG_TEMP_MAX(0));
>-		data->temp_max[1] = i2c_smbus_read_byte_data(client,
>-				ADM9240_REG_TEMP_MAX(1));
>+	return 0;
>+}
> 
>-		/* read fan divs and 5-bit VID */
>-		i = i2c_smbus_read_byte_data(client, ADM9240_REG_VID_FAN_DIV);
>-		data->fan_div[0] = (i >> 4) & 3;
>-		data->fan_div[1] = (i >> 6) & 3;
>-		data->vid = i & 0x0f;
>-		data->vid |= (i2c_smbus_read_byte_data(client,
>-					ADM9240_REG_VID4) & 1) << 4;
>-		/* read analog out */
>-		data->aout = i2c_smbus_read_byte_data(client,
>-				ADM9240_REG_ANALOG_OUT);
>+static const struct i2c_device_id adm9240_id[] = {
>+	{ "adm9240", adm9240 },
>+	{ "ds1780", ds1780 },
>+	{ "lm81", lm81 },
>+	{ }
>+};
>+MODULE_DEVICE_TABLE(i2c, adm9240_id);
> 
>-		data->last_updated_config = jiffies;
>-		data->valid = 1;
>-	}
>-	mutex_unlock(&data->update_lock);
>-	return data;
>-}
>+static struct i2c_driver adm9240_driver = {
>+	.class		= I2C_CLASS_HWMON,
>+	.driver = {
>+		.name	= "adm9240",
>+	},
>+	.probe		= adm9240_probe,
>+	.remove		= adm9240_remove,
>+	.id_table	= adm9240_id,
>+	.detect		= adm9240_detect,
>+	.address_list	= normal_i2c,
>+};
> 
> module_i2c_driver(adm9240_driver);
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
