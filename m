From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 06 Oct 2009 20:27:09 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (tmp401/tmp421) Clean up
Message-Id: <20091006202709.GA6359@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 06, 2009 at 08:09:19PM +0200, Jean Delvare wrote:
> As kind is now hard-coded to -1, there is room for code clean-ups.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Andre Prendel <andre.prendel@gmx.de>

Acked-by: Andre Prendel <andre.prendel@gmx.de>

Out of curiosity, could you please point me to the commit changing
this in i2c-core?

Thanks,
Andre

> ---
>  drivers/hwmon/tmp401.c |   57 ++++++++++++++++++++++--------------------------
>  drivers/hwmon/tmp421.c |   43 ++++++++++++++++--------------------
>  2 files changed, 47 insertions(+), 53 deletions(-)
> 
> --- linux-2.6.32-rc3.orig/drivers/hwmon/tmp401.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/tmp401.c	2009-10-06 16:53:13.000000000 +0200
> @@ -488,46 +488,43 @@ static void tmp401_init_client(struct i2
>  		i2c_smbus_write_byte_data(client, TMP401_CONFIG_WRITE, config);
>  }
>  
> -static int tmp401_detect(struct i2c_client *client, int kind,
> +static int tmp401_detect(struct i2c_client *client, int _kind,
>  			 struct i2c_board_info *info)
>  {
> +	enum chips kind;
>  	struct i2c_adapter *adapter = client->adapter;
> +	u8 reg;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
>  	/* Detect and identify the chip */
> -	if (kind <= 0) {
> -		u8 reg;
> +	reg = i2c_smbus_read_byte_data(client, TMP401_MANUFACTURER_ID_REG);
> +	if (reg != TMP401_MANUFACTURER_ID)
> +		return -ENODEV;
> +
> +	reg = i2c_smbus_read_byte_data(client, TMP401_DEVICE_ID_REG);
>  
> -		reg = i2c_smbus_read_byte_data(client,
> -					       TMP401_MANUFACTURER_ID_REG);
> -		if (reg != TMP401_MANUFACTURER_ID)
> -			return -ENODEV;
> -
> -		reg = i2c_smbus_read_byte_data(client, TMP401_DEVICE_ID_REG);
> -
> -		switch (reg) {
> -		case TMP401_DEVICE_ID:
> -			kind = tmp401;
> -			break;
> -		case TMP411_DEVICE_ID:
> -			kind = tmp411;
> -			break;
> -		default:
> -			return -ENODEV;
> -		}
> -
> -		reg = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
> -		if (reg & 0x1b)
> -			return -ENODEV;
> -
> -		reg = i2c_smbus_read_byte_data(client,
> -					       TMP401_CONVERSION_RATE_READ);
> -		/* Datasheet says: 0x1-0x6 */
> -		if (reg > 15)
> -			return -ENODEV;
> +	switch (reg) {
> +	case TMP401_DEVICE_ID:
> +		kind = tmp401;
> +		break;
> +	case TMP411_DEVICE_ID:
> +		kind = tmp411;
> +		break;
> +	default:
> +		return -ENODEV;
>  	}
> +
> +	reg = i2c_smbus_read_byte_data(client, TMP401_CONFIG_READ);
> +	if (reg & 0x1b)
> +		return -ENODEV;
> +
> +	reg = i2c_smbus_read_byte_data(client, TMP401_CONVERSION_RATE_READ);
> +	/* Datasheet says: 0x1-0x6 */
> +	if (reg > 15)
> +		return -ENODEV;
> +
>  	strlcpy(info->type, tmp401_id[kind - 1].name, I2C_NAME_SIZE);
>  
>  	return 0;
> --- linux-2.6.32-rc3.orig/drivers/hwmon/tmp421.c	2009-10-06 10:33:15.000000000 +0200
> +++ linux-2.6.32-rc3/drivers/hwmon/tmp421.c	2009-10-06 16:53:13.000000000 +0200
> @@ -223,39 +223,36 @@ static int tmp421_init_client(struct i2c
>  	return 0;
>  }
>  
> -static int tmp421_detect(struct i2c_client *client, int kind,
> +static int tmp421_detect(struct i2c_client *client, int _kind,
>  			 struct i2c_board_info *info)
>  {
> +	enum chips kind;
>  	struct i2c_adapter *adapter = client->adapter;
>  	const char *names[] = { "TMP421", "TMP422", "TMP423" };
> +	u8 reg;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
>  
> -	if (kind <= 0) {
> -		u8 reg;
> -
> -		reg = i2c_smbus_read_byte_data(client,
> -					       TMP421_MANUFACTURER_ID_REG);
> -		if (reg != TMP421_MANUFACTURER_ID)
> -			return -ENODEV;
> +	reg = i2c_smbus_read_byte_data(client, TMP421_MANUFACTURER_ID_REG);
> +	if (reg != TMP421_MANUFACTURER_ID)
> +		return -ENODEV;
>  
> -		reg = i2c_smbus_read_byte_data(client,
> -					       TMP421_DEVICE_ID_REG);
> -		switch (reg) {
> -		case TMP421_DEVICE_ID:
> -			kind = tmp421;
> -			break;
> -		case TMP422_DEVICE_ID:
> -			kind = tmp422;
> -			break;
> -		case TMP423_DEVICE_ID:
> -			kind = tmp423;
> -			break;
> -		default:
> -			return -ENODEV;
> -		}
> +	reg = i2c_smbus_read_byte_data(client, TMP421_DEVICE_ID_REG);
> +	switch (reg) {
> +	case TMP421_DEVICE_ID:
> +		kind = tmp421;
> +		break;
> +	case TMP422_DEVICE_ID:
> +		kind = tmp422;
> +		break;
> +	case TMP423_DEVICE_ID:
> +		kind = tmp423;
> +		break;
> +	default:
> +		return -ENODEV;
>  	}
> +
>  	strlcpy(info->type, tmp421_id[kind - 1].name, I2C_NAME_SIZE);
>  	dev_info(&adapter->dev, "Detected TI %s chip at 0x%02x\n",
>  		 names[kind - 1], client->addr);
> 
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
