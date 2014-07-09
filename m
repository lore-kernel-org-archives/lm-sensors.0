From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 09 Jul 2014 01:54:34 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (ds620) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53BCA0DA.8050503@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404869335.12195.8.camel@phoenix>
In-Reply-To: <1404869335.12195.8.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/08/2014 06:28 PM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Crashes.

[262262.955927]  [<ffffffff815aa4e6>] i2c_smbus_read_word_data+0x36/0x40
[262262.956776]  [<ffffffffa0512170>] ? ds620_update_client+0x90/0xc0 [ds620]
[262262.957590]  [<ffffffffa0512247>] show_alarm+0x37/0xb0 [ds620]
[262262.958390]  [<ffffffff81499710>] dev_attr_show+0x20/0x60

Hint: leftover to_i2c_client in show_alarm().

Guenter

> ---
>   drivers/hwmon/ds620.c | 56 +++++++++++++--------------------------------------
>   1 file changed, 14 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
> index 0918b91..77d6c7d 100644
> --- a/drivers/hwmon/ds620.c
> +++ b/drivers/hwmon/ds620.c
> @@ -67,7 +67,7 @@ static const u8 DS620_REG_TEMP[3] = {
>
>   /* Each client has this additional data */
>   struct ds620_data {
> -	struct device *hwmon_dev;
> +	struct i2c_client *client;
>   	struct mutex update_lock;
>   	char valid;		/* !=0 if following fields are valid */
>   	unsigned long last_updated;	/* In jiffies */
> @@ -106,8 +106,8 @@ static void ds620_init_client(struct i2c_client *client)
>
>   static struct ds620_data *ds620_update_client(struct device *dev)
>   {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct ds620_data *data = i2c_get_clientdata(client);
> +	struct ds620_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>   	struct ds620_data *ret = data;
>
>   	mutex_lock(&data->update_lock);
> @@ -158,8 +158,8 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *da,
>   	long val;
>
>   	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct ds620_data *data = i2c_get_clientdata(client);
> +	struct ds620_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>
>   	res = kstrtol(buf, 10, &val);
>
> @@ -213,7 +213,7 @@ static SENSOR_DEVICE_ATTR(temp1_min_alarm, S_IRUGO, show_alarm, NULL,
>   static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, show_alarm, NULL,
>   			  DS620_REG_CONFIG_THF);
>
> -static struct attribute *ds620_attributes[] = {
> +static struct attribute *ds620_attrs[] = {
>   	&sensor_dev_attr_temp1_input.dev_attr.attr,
>   	&sensor_dev_attr_temp1_min.dev_attr.attr,
>   	&sensor_dev_attr_temp1_max.dev_attr.attr,
> @@ -222,55 +222,28 @@ static struct attribute *ds620_attributes[] = {
>   	NULL
>   };
>
> -static const struct attribute_group ds620_group = {
> -	.attrs = ds620_attributes,
> -};
> +ATTRIBUTE_GROUPS(ds620);
>
>   static int ds620_probe(struct i2c_client *client,
>   		       const struct i2c_device_id *id)
>   {
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
>   	struct ds620_data *data;
> -	int err;
>
> -	data = devm_kzalloc(&client->dev, sizeof(struct ds620_data),
> -			    GFP_KERNEL);
> +	data = devm_kzalloc(dev, sizeof(struct ds620_data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>
> -	i2c_set_clientdata(client, data);
> +	data->client = client;
>   	mutex_init(&data->update_lock);
>
>   	/* Initialize the DS620 chip */
>   	ds620_init_client(client);
>
> -	/* Register sysfs hooks */
> -	err = sysfs_create_group(&client->dev.kobj, &ds620_group);
> -	if (err)
> -		return err;
> -
> -	data->hwmon_dev = hwmon_device_register(&client->dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		err = PTR_ERR(data->hwmon_dev);
> -		goto exit_remove_files;
> -	}
> -
> -	dev_info(&client->dev, "temperature sensor found\n");
> -
> -	return 0;
> -
> -exit_remove_files:
> -	sysfs_remove_group(&client->dev.kobj, &ds620_group);
> -	return err;
> -}
> -
> -static int ds620_remove(struct i2c_client *client)
> -{
> -	struct ds620_data *data = i2c_get_clientdata(client);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	sysfs_remove_group(&client->dev.kobj, &ds620_group);
> -
> -	return 0;
> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> +							   data, ds620_groups);
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
>   }
>
>   static const struct i2c_device_id ds620_id[] = {
> @@ -287,7 +260,6 @@ static struct i2c_driver ds620_driver = {
>   		   .name = "ds620",
>   	},
>   	.probe = ds620_probe,
> -	.remove = ds620_remove,
>   	.id_table = ds620_id,
>   };
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
