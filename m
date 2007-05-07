From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 May 2007 12:18:57 +0000
Subject: Re: [lm-sensors] LM64 support in lm63.c
Message-Id: <20070507141857.247a12ce@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ramji,

On Wed, 25 Apr 2007 18:15:31 +0530, Ramji wrote:
> Attached, patch for LM64 chip in LM63 chip driver.
> 
> Please, review it.
> 
> Every review comments and suggestions are most welcome.

First of all:
* Please generate a patch that can be applied with "patch -p1".
* Please generate a patch against a recent tree. Your patch is against
  linux 2.6.10, which is two-year old. Things have changed so much
  since then that I am simply unable to apply your patch.

On the code itself:

> --- /home/shabbirali/linux-2.6.10_mvl401/drivers/i2c/chips/lm63.c	2006-11-20 19:25:26.000000000 +0530
> +++ lm63.c	2007-04-21 15:41:36.000000000 +0530
> @@ -37,6 +37,8 @@
>   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>  
> + /* MEDIO_BOARD : Medio 1.0 : Ramji Jiyani : Added support for National's LM64 sensor */
> + 

No history information in the code, please. We have a version tracking
system (git) for that.

>  #include <linux/config.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -48,15 +50,15 @@
>   * Addresses to scan
>   * Address is fully defined internally and cannot be changed.
>   */
> -
> -static unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
> +//	Need to add addresses for the two other LM64

This comment isn't particularly useful, as the reader doesn't know what
"other two" addresses these are in the list. Better list explicitly
what chip can be found at what address, as is done in the lm90 driver
for example.

> +static unsigned short normal_i2c[] = { 0x4c, 0x18, 0x4E, I2C_CLIENT_END };

Please don't mix upper-case hexadecimal values with lower-case
hexadecimal values, it's inconsistent. Also, please keep the address
values sorted.

>  static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
>  
>  /*
>   * Insmod parameters
>   */
> -
> -SENSORS_INSMOD_1(lm63);
> +/*MEDIO_BOARD : Medio 1.0 : RJ : Changed to support two chips, LM63 and LM64 */
> +SENSORS_INSMOD_2( lm63, lm64 );

No spaces inside the parentheses please.

>  
>  /*
>   * The LM63 registers
> @@ -140,6 +142,8 @@
>  static struct i2c_driver lm63_driver = {
>  	.owner		= THIS_MODULE,
>  	.name		= "lm63",
> +	/* MEDIO_BOARD: Medio 1.0 : RJ : Add id of the driver, define same in i2c-id.h */
> +	.id = I2C_DRIVERID_LM63, /* MEDIO_BOARD: Medio 1.0 : RJ : Add I2C_DRIVERID_LM63 = 1048 in i2c-id.h */

This has nothing to do in this patch (see below.)

>  	.flags		= I2C_DF_NOTIFY,
>  	.attach_adapter	= lm63_attach_adapter,
>  	.detach_client	= lm63_detach_client,
> @@ -171,6 +175,12 @@
>  	u8 alarms;
>  };
>  
> +/* MEDIO_BOARD: Medio 1.0 : RJ : Added to support LM64 */
> +/*
> + * Internal variables
> + */
> +static int lm63_id;

Same here: this has nothing to do with adding support for the LM64.

> +
>  /*
>   * Sysfs callback functions and files
>   */
> @@ -346,6 +356,8 @@
>  	struct i2c_client *new_client;
>  	struct lm63_data *data;
>  	int err = 0;
> +	/*MEDIO_BOARD:Medio 1.0:RJ: Added two support both LM64 and LM64 */
> +	const char *name = "";
>  
>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
>  		goto exit;
> @@ -365,6 +377,17 @@
>  	new_client->driver = &lm63_driver;
>  	new_client->flags = 0;
>  
> +	/*MEDIO_BOARD:Medio 1.0:RJ: Added following understanding.
> +	 * Now we do the remaining detection. A negative kind means that
> +	 * the driver was loaded with no force parameter (default), so we
> +	 * must both detect and identify the chip. A zero kind means that
> +	 * the driver was loaded with the force parameter, the detection
> +	 * step shall be skipped. A positive kind means that the driver
> +	 * was loaded with the force parameter and a given kind of chip is
> +	 * requested, so both the detection and the identification steps
> +	 * are skipped.
> +	 */

This comment partly contradicts the code below: a zero kind is treated
as if an LM63 chip had been forced, so the identification step is
skipped as well.

> +	
>  	/* Default to an LM63 if forced */
>  	if (kind = 0)
>  		kind = lm63;
> @@ -386,22 +409,42 @@
>  		reg_alert_mask = i2c_smbus_read_byte_data(new_client,
>  				 LM63_REG_ALERT_MASK);
>  
> -		if (man_id = 0x01 /* National Semiconductor */
> -		 && chip_id = 0x41 /* LM63 */
> -		 && (reg_config1 & 0x18) = 0x00
> -		 && (reg_config2 & 0xF8) = 0x00
> -		 && (reg_alert_status & 0x20) = 0x00
> -		 && (reg_alert_mask & 0xA4) = 0xA4) {
> -			kind = lm63;
> -		} else { /* failed */
> +		/*MEDIO_BOARD:Medio 1.0:RJ: Added for LM64 detection */
> +		if (man_id = 0x01
> +			&& (reg_config2 & 0xF8) = 0x00
> +			&& (reg_alert_status & 0x20) = 0x00
> +			&& (reg_alert_mask & 0xA4) = 0xA4) /* National Semiconductor */{

Please leave the indentation the way it was. Also, the comment
"National Semiconductor" really corresponds to the first test so don't
move it.

> +				if( chip_id = 0x41 /* LM63 */
> +				&& (reg_config1 & 0x18) = 0x00) {
> +					kind = lm63;
> +				}else if( chip_id = 0x51 /* LM64 */
> +				 && (reg_config1 & 0x1E) = 0x00 ){
> +					kind = lm64;
> +				}else{

You could make the detection a bit more robust by additionally checking
the address. For example, an LM63 at address 0x18 isn't possible.

> +				dev_dbg(&adapter->dev, "Unsupported chip of National Semiconductor"
> +					"(man_id=0x%02X, chip_id=0x%02X).\n",
> +					man_id, chip_id);
> +				goto exit_free;
> +				}
> +		}else { /* failed */

Missing space.

>  			dev_dbg(&adapter->dev, "Unsupported chip "
>  				"(man_id=0x%02X, chip_id=0x%02X).\n",
>  				man_id, chip_id);
>  			goto exit_free;
>  		}
>  	}
> +	
> +	/*MEDIO_BOARD:Medio 1.0:RJ: Added to support both LM63 and LM64 */
> +	if( kind = lm63 ){
> +		name = "lm63";
> +	}else if( kind = lm64 ){
> +		name = "lm64";
> +	}

Please respect the coding style that is used in the rest of the source
file, all hardware monitoring drivers, and more generally in the vast
majority of the linux kernel source: no space inside the parentheses,
but spaces around curly braces - not the other way around. This applies
to your whole patch.

>  
> -	strlcpy(new_client->name, "lm63", I2C_NAME_SIZE);
> +	/*MEDIO_BOARD:Medio 1.0:RJ: replaced "lm63" by name */
> +	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> +	/*MEDIO_BOARD:Medio 1.0:RJ: added to support LM64 */
> +	new_client->id = lm63_id++;

This won't even compile with a recent kernel: the i2c_client.id field
has been dropped long ago.

>  	data->valid = 0;
>  	init_MUTEX(&data->update_lock);
>  
> @@ -460,9 +503,13 @@
>  		data->pwm1_freq = 1;
>  
>  	/* Show some debug info about the LM63 configuration */
> -	dev_dbg(&client->dev, "Alert/tach pin configured for %s\n",
> -		(data->config & 0x04) ? "tachometer input" :
> -		"alert output");
> +	/*MEDIO_BOARD:Medio 1.0:RJ: Added if test to support LM64 */
> +	if( data->client.id = I2C_DRIVERID_LM63 )
> +	{
> +		dev_dbg(&client->dev, "Alert/tach pin configured for %s\n",
> +			(data->config & 0x04) ? "tachometer input" :
> +			"alert output");
> +	}

This is totally broken, but I think I see what you're trying to do. If
you want to differentiate between an LM63 and an LM64, you have to add
a "kind" field in the lm63_data structure, fill it in the detect
function, and use it later as needed. Again, see the lm90 for an
example.

>  	dev_dbg(&client->dev, "PWM clock %s kHz, output frequency %u Hz\n",
>  		(data->config_fan & 0x04) ? "1.4" : "360",
>  		((data->config_fan & 0x04) ? 700 : 180000) / data->pwm1_freq);
> @@ -495,7 +542,8 @@
>  	if ((jiffies - data->last_updated > HZ) ||
>  	    (jiffies < data->last_updated) ||
>  	    !data->valid) {
> -		if (data->config & 0x04) { /* tachometer enabled  */
> +		/* MEDIO_BOARD:Medio 1.0:RJ: Changed if test to enalble case for LM64 as well */
> +		if ( (data->config & 0x04) ||  ( client->id != I2C_DRIVERID_LM63 ) ){ /* tachometer enabled  */
>  			/* order matters for fan1_input */
>  			data->fan1_input = i2c_smbus_read_byte_data(client,
>  					   LM63_REG_TACH_COUNT_LSB) & 0xFC;

Additionally, you will have to document the LM64 support:
* in Documentation/hwmon/lm63
* in drivers/hwmon/Kconfig
* in the header comment of lm63.c, as is done in lm90.c

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
