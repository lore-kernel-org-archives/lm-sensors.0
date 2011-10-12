From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Oct 2011 15:47:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon:lm75 add ADT75 support - requires
Message-Id: <20111012174734.2c56eaee@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Oct 2011 11:36:58 +0200, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> The Analog Devices ADT75 has an additional register at 0x04
> for initiating oneshot captures. It is not actively used in
> this driver but we must avoid assuming it will behave as
> 0x05-0x07 do and return the last read value. In fact register 0x04
> reads the same as register 0x00. And all registers are repetitive
> mirrored around register 0x04. This fact is used to detect the ADT75.

I object. The detection of the original LM75 is there for historical
reasons (that chip was very popular on PC motherboards at the end of
the 90's. Other compatible chips were never so popular on PC
motherboards and this is the reason why they are _not_ detected by the
lm75 driver. If you have any of these chips, you have to instantiate
them explicitly.

Same goes for the ADT75. I don't expect it on PC boards, but rather on
embedded designs where it should simply be instantiated, rather than
detected.

It's still fine to document the ADT75 as being supported by the driver,
and adding an lm75_type enum value for it. But no detection, please.

> 
> This patch is based on an reworked proposal from Jonathan Cameron <jic23@cam.ac.uk>
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  Documentation/hwmon/lm75 |    5 +++++
>  drivers/hwmon/Kconfig    |    1 +
>  drivers/hwmon/lm75.c     |   30 ++++++++++++++++++++++++++----
>  3 files changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
> index a179040..8d40d0f 100644
> --- a/Documentation/hwmon/lm75
> +++ b/Documentation/hwmon/lm75
> @@ -32,6 +32,11 @@ Supported chips:
>      Addresses scanned: I2C 0x48 - 0x4f
>      Datasheet: Publicly available at the Microchip website
>                 http://www.microchip.com/
> +  * Analog Devices ADT75
> +    Prefix: 'adt75'
> +    Addresses scanned: I2C 0x48 - 0x4f
> +    Datasheet: Publicly available at the Analog Devices website
> +               http://www.analog.com/adt75
>  
>  Author: Frodo Looijaard <frodol@dds.nl>
>  
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 0b62c3c..497fd14 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -531,6 +531,7 @@ config SENSORS_LM75
>  	  If you say yes here you get support for one common type of
>  	  temperature sensor chip, with models including:
>  
> +		- Analog Devices ADT75
>  		- Dallas Semiconductor DS75 and DS1775
>  		- Maxim MAX6625 and MAX6626
>  		- Microchip MCP980x
> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> index ef902d5..0f0291c 100644
> --- a/drivers/hwmon/lm75.c
> +++ b/drivers/hwmon/lm75.c
> @@ -35,6 +35,7 @@
>   */
>  
>  enum lm75_type {		/* keep sorted in alphabetical order */
> +	adt75,
>  	ds1775,
>  	ds75,
>  	lm75,
> @@ -213,6 +214,7 @@ static int lm75_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id lm75_ids[] = {
> +	{ "adt75", adt75, },
>  	{ "ds1775", ds1775, },
>  	{ "ds75", ds75, },
>  	{ "lm75", lm75, },
> @@ -241,7 +243,7 @@ static int lm75_detect(struct i2c_client *new_client,
>  	struct i2c_adapter *adapter = new_client->adapter;
>  	int i;
>  	int conf, hyst, os;
> -	bool is_lm75a = 0;
> +	bool is_lm75a = 0, is_adt75 = 0;
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
>  				     I2C_FUNC_SMBUS_WORD_DATA))
> @@ -259,7 +261,15 @@ static int lm75_detect(struct i2c_client *new_client,
>  	   LM75s.  It has an ID byte of 0xaX (where X is the chip
>  	   revision, with 1 being the only revision in existence) in
>  	   register 7, and unused registers return 0xff rather than the
> -	   last read value. */
> +	   last read value.
> +
> +	   The Analog Devices ADT75 has an additional register at 0x04
> +	   for initiating oneshot captures. It is not actively used in
> +	   this driver but we must avoid assuming it will behave as
> +	   0x05-0x07 do and return the last read value. In fact register 0x04
> +	   reads the same as register 0x00. And all registers are repetitive
> +	   mirrored around register 0x04.
> +	*/
>  
>  	/* Unused bits */
>  	conf = i2c_smbus_read_byte_data(new_client, 1);
> @@ -277,7 +287,16 @@ static int lm75_detect(struct i2c_client *new_client,
>  		is_lm75a = 1;
>  		hyst = i2c_smbus_read_byte_data(new_client, 2);
>  		os = i2c_smbus_read_byte_data(new_client, 3);
> -	} else { /* Traditional style LM75 detection */
> +	} else { /* ADT75 detection: mirrored registers */
> +		os = i2c_smbus_read_byte_data(new_client, 3);
> +		hyst = i2c_smbus_read_byte_data(new_client, 2);
> +		if (i2c_smbus_read_byte_data(new_client, 7) = os
> +		 || i2c_smbus_read_byte_data(new_client, 11) = os
> +		 || i2c_smbus_read_byte_data(new_client, 15) = os)
> +			is_adt75 = 1;
> +	}
> +
> +	if (!is_lm75a && !is_adt75) { /* Traditional style LM75 detection */
>  		/* Unused addresses */
>  		hyst = i2c_smbus_read_byte_data(new_client, 2);
>  		if (i2c_smbus_read_byte_data(new_client, 4) != hyst
> @@ -304,7 +323,10 @@ static int lm75_detect(struct i2c_client *new_client,
>  			return -ENODEV;
>  	}
>  
> -	strlcpy(info->type, is_lm75a ? "lm75a" : "lm75", I2C_NAME_SIZE);
> +	if (!is_adt75)
> +		strlcpy(info->type, is_lm75a ? "lm75a" : "lm75", I2C_NAME_SIZE);
> +	else
> +		strlcpy(info->type, "adt75", I2C_NAME_SIZE);
>  
>  	return 0;
>  }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
