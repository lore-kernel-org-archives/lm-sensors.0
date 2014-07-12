From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 12 Jul 2014 08:29:52 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ds620) Convert to devm_hwmon_device_register_with_groups
Message-Id: <53C0F200.4010200@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1404871191.7760.1.camel@phoenix>
In-Reply-To: <1404871191.7760.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/08/2014 06:59 PM, Axel Lin wrote:
> Use ATTRIBUTE_GROUPS macro and devm_hwmon_device_register_with_groups() to
> simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/hwmon/ds620.c | 58 +++++++++++++--------------------------------------
>   1 file changed, 15 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/hwmon/ds620.c b/drivers/hwmon/ds620.c
> index 0918b91..1bdb6246 100644
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
> @@ -181,7 +181,7 @@ static ssize_t show_alarm(struct device *dev, struct device_attribute *da,
>   {
>   	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
>   	struct ds620_data *data = ds620_update_client(dev);
> -	struct i2c_client *client = to_i2c_client(dev);
> +	struct i2c_client *client = data->client;

Hi Axel,

turns out this has a problem: data can be an ERR_PTR, so the client assignment
must only happen after the ERR_PTR check.

Can you please send me an updated patch ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
