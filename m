From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 28 Aug 2007 13:40:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon/dme1737: cleanups
Message-Id: <20070828154046.09aaf759@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0707232039m2261d4e0vca612ffa882ba559@mail.gmail.com>
In-Reply-To: <191fb4ca0707232039m2261d4e0vca612ffa882ba559@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Sun, 26 Aug 2007 20:23:27 -0700, Juerg Haefliger wrote:
> This patch cleans up and prepares the dme1737 driver for support of the sch311x
> chips. (Almost) no functional changes.
> 
> - Replaced whitespaces with tabs.
> - Removed empty lines.
> - Added _i2c_ to names of functions that are strictly I2C related.
> - Added 4 new functions: dme1737_create_files, dme1737_remove_files,
>   dme1737_sio_enter, and dme1737_sio_exit.
> - Added error messages in case client attach/detach fails.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>
> 
> Jean: I'd really appreciate it if you take a look at the patches.

Sorry, I just noticed this request. Next time please include it in the
patch 0/n instead, so that I'm more likely to read it.

Overall I'm fine with this patch, with the suggestions below:

> --- linux-2.6.orig/drivers/hwmon/dme1737.c	2007-08-23 22:23:50.000000000 -0700
> +++ linux-2.6/drivers/hwmon/dme1737.c	2007-08-26 20:08:01.000000000 -0700
> @@ -493,8 +493,8 @@
>  
>  static struct dme1737_data *dme1737_update_device(struct device *dev)
>  {
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct dme1737_data *data = i2c_get_clientdata(client);
> +	struct dme1737_data *data = dev_get_drvdata(dev);
> +	struct i2c_client *client = &data->client;
>  	int ix;
>  	u8 lsb[5];
>  
> @@ -674,7 +674,7 @@
>  		break;
>  	default:
>  		res = 0;
> -		dev_dbg(dev, "Unknown attr fetch (%d)\n", fn);
> +		dev_dbg(dev, "Unknown function %d.\n", fn);
>  	}
>  
>  	return sprintf(buf, "%d\n", res);

I would back out this family of changes. This is only a debug message
and it will never show up anyway so why bother changing it? And your
patch is quite big so making it a bit smaller can't hurt. But it's up
to you.

> (...)
> -static int dme1737_detect(struct i2c_adapter *adapter, int address,
> -			  int kind)
> +static int dme1737_i2c_detect(struct i2c_adapter *adapter, int address,
> +			      int kind)
>  {
>  	u8 company, verstep = 0;
>  	struct i2c_client *client;
>  	struct dme1737_data *data;
> -	int ix, err = 0;
> +	struct device *dev;
> +	int err = 0;
>  	const char *name;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
> @@ -1886,6 +1982,7 @@
>  	}
>  
>  	if (!(data = kzalloc(sizeof(struct dme1737_data), GFP_KERNEL))) {
> +		dev_err(&adapter->dev, "Failed to allocate memory.\n");

i2c-core will already emit an error message in this unlikely case, so I
don't think it's worth adding something here.

>  		err = -ENOMEM;
>  		goto exit;
>  	}
> @@ -1894,7 +1991,8 @@
>  	i2c_set_clientdata(client, data);
>  	client->addr = address;
>  	client->adapter = adapter;
> -	client->driver = &dme1737_driver;
> +	client->driver = &dme1737_i2c_driver;
> +	dev = &client->dev;
>  
>  	/* A negative kind means that the driver was loaded with no force
>  	 * parameter (default), so we must identify the chip. */
> @@ -1919,95 +2017,37 @@
>  
>  	/* Tell the I2C layer a new client has arrived */
>  	if ((err = i2c_attach_client(client))) {
> +		dev_err(&adapter->dev, "Failed to attach client.\n");
>  		goto exit_kfree;
>  	}

i2c_attach_client logs a message in case of error already, so this is
redundant too.

> (...)
> -static int dme1737_detach_client(struct i2c_client *client)
> +static int dme1737_i2c_detach_client(struct i2c_client *client)
>  {
>  	struct dme1737_data *data = i2c_get_clientdata(client);
> -	int ix, err;
> +	int err;
>  
>  	hwmon_device_unregister(data->class_dev);
> -
> -	for (ix = 0; ix < ARRAY_SIZE(dme1737_fan_group); ix++) {
> -		if (data->has_fan & (1 << ix)) {
> -			sysfs_remove_group(&client->dev.kobj,
> -					   &dme1737_fan_group[ix]);
> -		}
> -	}
> -	for (ix = 0; ix < ARRAY_SIZE(dme1737_pwm_group); ix++) {
> -		if (data->has_pwm & (1 << ix)) {
> -			sysfs_remove_group(&client->dev.kobj,
> -					   &dme1737_pwm_group[ix]);
> -		}
> -	}
> -	sysfs_remove_group(&client->dev.kobj, &dme1737_group);
> +	dme1737_remove_files(&client->dev);
>  
>  	if ((err = i2c_detach_client(client))) {
> +		dev_err(&client->dev, "Failed to detach client.\n");
>  		return err;
>  	}
>  

Again, i2c_detach_client already logs a message if it fails. I did
remove these redundant messages from all drivers some times ago, so
please don't add them back!

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h{ef559455fc71f66f8573cc1aafe1dd33966c1c

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
