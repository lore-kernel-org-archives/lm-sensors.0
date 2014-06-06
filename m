From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 06 Jun 2014 04:37:22 +0000
Subject: Re: [lm-sensors] [RFT][PATCH] hwmon: (atxp1) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140606043722.GB19182@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1401925891.5828.4.camel@phoenix>
In-Reply-To: <1401925891.5828.4.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 05, 2014 at 07:51:31AM +0800, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups.
> This simplifies the code a bit.
> 
> Also move atxp1_id and atxp1_driver to proper place to avoid forward
> declaration.
> 
Please split this into two patches, one per logical change.

Content-wise, you missed the necessary changes in the store functions.
	`client = to_i2c_client(dev);
no longer works. You have to get client from data->client.
As a general guideline, any leftover to_2c_client() are wrong
most of the time.

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> Hi,
> I don't have the h/w to test, I'd appreciate if someone can review and test this
> patch.
> Thanks,
> Axel
>  drivers/hwmon/atxp1.c | 95 +++++++++++++++++----------------------------------
>  1 file changed, 31 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
> index 6edce42..659fc0d 100644
> --- a/drivers/hwmon/atxp1.c
> +++ b/drivers/hwmon/atxp1.c
> @@ -45,32 +45,8 @@ MODULE_AUTHOR("Sebastian Witt <se.witt@gmx.net>");
>  
>  static const unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
>  
> -static int atxp1_probe(struct i2c_client *client,
> -		       const struct i2c_device_id *id);
> -static int atxp1_remove(struct i2c_client *client);
> -static struct atxp1_data *atxp1_update_device(struct device *dev);
> -static int atxp1_detect(struct i2c_client *client, struct i2c_board_info *info);
> -
> -static const struct i2c_device_id atxp1_id[] = {
> -	{ "atxp1", 0 },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, atxp1_id);
> -
> -static struct i2c_driver atxp1_driver = {
> -	.class		= I2C_CLASS_HWMON,
> -	.driver = {
> -		.name	= "atxp1",
> -	},
> -	.probe		= atxp1_probe,
> -	.remove		= atxp1_remove,
> -	.id_table	= atxp1_id,
> -	.detect		= atxp1_detect,
> -	.address_list	= normal_i2c,
> -};
> -
>  struct atxp1_data {
> -	struct device *hwmon_dev;
> +	struct i2c_client *client;
>  	struct mutex update_lock;
>  	unsigned long last_updated;
>  	u8 valid;
> @@ -85,11 +61,8 @@ struct atxp1_data {
>  
>  static struct atxp1_data *atxp1_update_device(struct device *dev)
>  {
> -	struct i2c_client *client;
> -	struct atxp1_data *data;
> -
> -	client = to_i2c_client(dev);
> -	data = i2c_get_clientdata(client);
> +	struct atxp1_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = data->client;
>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -284,17 +257,13 @@ static ssize_t atxp1_storegpio2(struct device *dev,
>   */
>  static DEVICE_ATTR(gpio2, S_IRUGO | S_IWUSR, atxp1_showgpio2, atxp1_storegpio2);
>  
> -static struct attribute *atxp1_attributes[] = {
> +static struct attribute *atxp1_attrs[] = {
>  	&dev_attr_gpio1.attr,
>  	&dev_attr_gpio2.attr,
>  	&dev_attr_cpu0_vid.attr,
>  	NULL
>  };
> -
> -static const struct attribute_group atxp1_group = {
> -	.attrs = atxp1_attributes,
> -};
> -
> +ATTRIBUTE_GROUPS(atxp1);
>  
>  /* Return 0 if detection is successful, -ENODEV otherwise */
>  static int atxp1_detect(struct i2c_client *new_client,
> @@ -338,52 +307,50 @@ static int atxp1_detect(struct i2c_client *new_client,
>  	return 0;
>  }
>  
> -static int atxp1_probe(struct i2c_client *new_client,
> +static int atxp1_probe(struct i2c_client *client,
>  		       const struct i2c_device_id *id)
>  {
> +	struct device *dev = &client->dev;
>  	struct atxp1_data *data;
> -	int err;
> +	struct device *hwmon_dev;
>  
> -	data = devm_kzalloc(&new_client->dev, sizeof(struct atxp1_data),
> -			    GFP_KERNEL);
> +	data = devm_kzalloc(dev, sizeof(struct atxp1_data), GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
>  
>  	/* Get VRM */
>  	data->vrm = vid_which_vrm();
>  
> -	i2c_set_clientdata(new_client, data);
> +	data->client = client;
>  	mutex_init(&data->update_lock);
>  
> -	/* Register sysfs hooks */
> -	err = sysfs_create_group(&new_client->dev.kobj, &atxp1_group);
> -	if (err)
> -		return err;
> +	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
> +							   data,
> +							   atxp1_groups);
> +	if (IS_ERR(hwmon_dev))
> +		return PTR_ERR(hwmon_dev);
>  
> -	data->hwmon_dev = hwmon_device_register(&new_client->dev);
> -	if (IS_ERR(data->hwmon_dev)) {
> -		err = PTR_ERR(data->hwmon_dev);
> -		goto exit_remove_files;
> -	}
> -
> -	dev_info(&new_client->dev, "Using VRM: %d.%d\n",
> -			 data->vrm / 10, data->vrm % 10);
> +	dev_info(&client->dev, "Using VRM: %d.%d\n", data->vrm / 10,

Please use the newly introduced dev here.

> +		 data->vrm % 10);
>  
>  	return 0;
> -
> -exit_remove_files:
> -	sysfs_remove_group(&new_client->dev.kobj, &atxp1_group);
> -	return err;
>  };
>  
> -static int atxp1_remove(struct i2c_client *client)
> -{
> -	struct atxp1_data *data = i2c_get_clientdata(client);
> -
> -	hwmon_device_unregister(data->hwmon_dev);
> -	sysfs_remove_group(&client->dev.kobj, &atxp1_group);
> +static const struct i2c_device_id atxp1_id[] = {
> +	{ "atxp1", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, atxp1_id);
>  
> -	return 0;
> +static struct i2c_driver atxp1_driver = {
> +	.class		= I2C_CLASS_HWMON,
> +	.driver = {
> +		.name	= "atxp1",
> +	},
> +	.probe		= atxp1_probe,
> +	.id_table	= atxp1_id,
> +	.detect		= atxp1_detect,
> +	.address_list	= normal_i2c,
>  };
>  
>  module_i2c_driver(atxp1_driver);
> -- 
> 1.8.3.2
> 
> 
> 
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
