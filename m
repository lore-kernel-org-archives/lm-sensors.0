From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 03 Mar 2011 19:55:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Add support for max6642
Message-Id: <20110303195507.GA30112@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49052.79.160.13.2.1299171238.squirrel@webmail.s7.itpays.net>
In-Reply-To: <49052.79.160.13.2.1299171238.squirrel@webmail.s7.itpays.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Thu, Mar 03, 2011 at 11:53:58AM -0500, per.dalen@appeartv.com wrote:
> Signed-off-by: Per Dalen <per.dalen at appeartv.com>
> 
Jean knows the driver better than I do, so he may have additional feedback.

> ---
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 812781c..cc57f49 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -49,6 +49,8 @@
>   * chips, but support three temperature sensors instead of two. MAX6695
>   * and MAX6696 only differ in the pinout so they can be treated identically.
>   *
> + * This driver also supports the MAX6642 a sensor chips made by Maxim.
> + *
>   * This driver also supports the ADT7461 chip from Analog Devices.
>   * It's supported in both compatibility and extended mode. It is mostly
>   * compatible with LM90 except for a data format difference for the
> @@ -95,13 +97,15 @@
>   * MAX6659 can have address 0x4c, 0x4d or 0x4e.
>   * MAX6680 and MAX6681 can have address 0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b,
>   * 0x4c, 0x4d or 0x4e.
> + * MAX6642 can have address 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d, 0x4e or
> 0x4f.
>   */
> 
>  static const unsigned short normal_i2c[] = {
> -	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x4c, 0x4d, 0x4e, I2C_CLIENT_END };
> +	0x18, 0x19, 0x1a, 0x29, 0x2a, 0x2b, 0x48, 0x49, 0x4a, 0x4b, 0x4c, 0x4d,
> +	0x4e, 0x4f, I2C_CLIENT_END };
> 
>  enum chips { lm90, adm1032, lm99, lm86, max6657, max6659, adt7461, max6680,
> -	max6646, w83l771, max6696 };
> +	max6646, w83l771, max6696, max6642 };
> 
>  /*
>   * The LM90 registers
> @@ -188,6 +192,7 @@ static const struct i2c_device_id lm90_id[] = {
>  	{ "max6681", max6680 },
>  	{ "max6695", max6696 },
>  	{ "max6696", max6696 },
> +	{ "max6642", max6642 },

Alphabetical, please.

>  	{ "w83l771", w83l771 },
>  	{ }
>  };
> @@ -231,6 +236,11 @@ static const struct lm90_params lm90_params[] = {
>  		.alert_alarms = 0x7b,
>  		.max_convrate = 9,
>  	},
> +	[max6642] = {
> +		.flags = LM90_HAVE_LOCAL_EXT,
> +		.alert_alarms = 0x7c,
> +		.max_convrate = 8,

The chip does not support min limits, and thus also no min alarms.
The ability to support chips w/o those limits would need to be added 
to the driver to support this chip.

The maximum conversion rate register is not supported at all, which the driver
also does not expect. This would have to be added to the driver as well.

> +	},
>  	[max6646] = {
>  		.flags = LM90_HAVE_LOCAL_EXT,
>  		.alert_alarms = 0x7c,
> @@ -1089,7 +1099,8 @@ static int lm90_detect(struct i2c_client *new_client,
>  	struct i2c_adapter *adapter = new_client->adapter;
>  	int address = new_client->addr;
>  	const char *name = NULL;
> -	int man_id, chip_id, reg_config1, reg_convrate;
> +	int man_id, chip_id, reg_config1, reg_convrate, reg_local_high,
> +	    reg_remote_high;
> 
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		return -ENODEV;
> @@ -1102,7 +1113,11 @@ static int lm90_detect(struct i2c_client *new_client,
>  	 || (reg_config1 = i2c_smbus_read_byte_data(new_client,
>  						LM90_REG_R_CONFIG1)) < 0
>  	 || (reg_convrate = i2c_smbus_read_byte_data(new_client,
> -						LM90_REG_R_CONVRATE)) < 0)
> +						LM90_REG_R_CONVRATE)) < 0
> +	 || (reg_local_high = i2c_smbus_read_byte_data(new_client,
> +						LM90_REG_R_LOCAL_HIGH)) < 0
> +	 || (reg_remote_high = i2c_smbus_read_byte_data(new_client,
> +						LM90_REG_R_REMOTE_HIGHH)) < 0)

The above registers are only needed for Maxim chips, so this is the wrong place
to read them.

>  		return -ENODEV;
> 
>  	if ((address = 0x4C || address = 0x4D)
> @@ -1233,7 +1248,22 @@ static int lm90_detect(struct i2c_client *new_client,
>  		 && (reg_config1 & 0x3f) = 0x00
>  		 && reg_convrate <= 0x07) {
>  			name = "max6646";
> +		} else
> +		/*
> +		 * The MAX6642 do NOT have a chip_id register. Reading from
> +		 * that address will return the last read value, which in our
> +		 * case is those of the man_id register. The local_high register
> +		 * is equal to 0x46 and remote_high register is equal to 0x78.
> +		 */
> +		if (chip_id = man_id
> +		 && (address = 0x48 || address = 0x49 || address = 0x4A ||
> +		     address = 0x4B || address = 0x4C || address = 0x4D ||
> +		     address = 0x4E || address = 0x4F)
> +		 && (reg_local_high & 0x46) = 0x46
> +		 && (reg_remote_high & 0x78) = 0x78) {

Number of problems with this.
The chip may already have been detected as max6657 or max6659 (if the config register was 0).
LM90_REG_R_LOCAL_HIGH and LM90_REG_R_REMOTE_HIGHH may have a different value than the default
(eg from the BIOS or after a reboot), so you can not depend on those registers to detect the chip.
And the logical masks used above are simply wrong.

So, overall, you'll have to find a different means to identify the chip.

With all the differences and lacking registers, I wonder if it would be better 
to write a new driver, either based on this driver of based on the max1619 driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
