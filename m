From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 15 Jun 2008 12:18:14 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm90) Support ADT7461 in
Message-Id: <20080615141814.482e28d8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1213374973-3262-3-git-send-email-ncase@xes-inc.com>
In-Reply-To: <1213374973-3262-3-git-send-email-ncase@xes-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nate,

On Fri, 13 Jun 2008 11:36:13 -0500, Nate Case wrote:
> Put ADT7461 into extended temperature range mode, which will change
> the range of readings from 0..127 to -64..191 degC.  Adjust the
> register conversion functions accordingly.  This also eliminates the
> need to check the compatibility mode bit during probing since we
> always force extended mode now.

I am reluctant to do this. We are not necessarily the only ones reading
temperature data from the ADT7461 chip. On a multi-master bus, another
master may be polling the temperature value for its own needs.
Additionally, the BIOS may be reading from the chip at boot time, and
may not expect the mode to change. So changing the mode by default
doesn't sound good. I think that the driver should stick to the mode it
finds the device in by default. I agree that it means more code in the
driver, but at least we are sure we won't break anything.

Changing the device configuration could be done on a per-platform
basis, after the lm90 driver has been converted to a new-style driver
(I'm working on this already.) Embedded platforms should know whether
enabling the extended mode is safe for them or not.

> 
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> ---
>  drivers/hwmon/lm90.c |   76 ++++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 56 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
> index 5f2db18..5a1fc2d 100644
> --- a/drivers/hwmon/lm90.c
> +++ b/drivers/hwmon/lm90.c
> @@ -51,12 +51,11 @@
>   * The MAX6680 and MAX6681 only differ in the pinout so they can be
>   * treated identically.
>   *
> - * This driver also supports the ADT7461 chip from Analog Devices but
> - * only in its "compatability mode". If an ADT7461 chip is found but
> - * is configured in non-compatible mode (where its temperature
> - * register values are decoded differently) it is ignored by this
> - * driver. Complete datasheet can be obtained from Analog's website
> - * at:
> + * This driver also supports the ADT7461 chip from Analog Devices.
> + * The chip is placed into "extended mode" to support a range of
> + * -64..191 degC.  It is mostly compatible with LM90 except for this
> + * data format difference in extended mode. Complete datasheet can be
> + * obtained from Analog's website at:
>   *   http://www.analog.com/en/prod/0,2877,ADT7461,00.html
>   *
>   * Since the LM90 was the first chipset supported by this driver, most
> @@ -242,22 +241,32 @@ static s16 temp2_to_reg(int val)
>  }
>  
>  /*
> - * ADT7461 is almost identical to LM90 except that attempts to write
> - * values that are outside the range 0 < temp < 127 are treated as
> - * the boundary value.
> + * ADT7461 versions of the above for "extended mode" operation
> + * which follows the same data format as LM90, but with an offset
> + * of 64 and unsigned integers.  The range is restricted to -64..191 degC.
>   */

It's a bit confusing to say it "follows the same data format as LM90
but with an offset of 64 and unsigned integers", firstly because the
LM90 format has nothing special (it's standard 2's complement binary
encoding), secondly because, once you apply the offset and work with
unsigned values... there's really nothing left in common with the LM90.
So, please rephrase.

> +static int temp1_from_reg_adt7461(s8 val)
> +{
> +	return ((u8) val - 64) * 1000;
> +}
> +
> +static int temp2_from_reg_adt7461(s16 val)
> +{
> +	return ((u16) val - 0x4000) / 32 * 125;
> +}

According to the datasheet, the resolution of this chip is 0.25 degree
C, not 0.125 as the other chips do, so this should be / 64 * 250.

> +
>  static s8 temp1_to_reg_adt7461(int val)
>  {
> -	return val <= 0 ? 0 :
> -			  val >= 127000 ? 127 :
> -			  (val + 500) / 1000;
> +	return val <= -64000 ? 0 :
> +			       val >= 191000 ? (s8) 0xff :
> +			       (s8) ((val + 500) / 1000 + 64);
>  }

This one is off-by-one for negative temperatures (for example -55
degrees C translates to register value 0x0a while the datasheet says it
should be 0x09.) This is because you add the offset after dividing. You
should add the offset first (otherwise you have to check the sign to
figure out if you must add or remove 500 before dividing.)

Values above 63 degrees C are also broken due to the cast to s8. You
wrote yourself above that the ADT7461 treats the values as unsigned, so
this conversion function should really return a u8 not s8. The cast
from u8 to s8 and back should happen only when you write the value to
struct lm90_data and read it back from the structure, respectively (and
I guess this will be done implicitly so you may not even have to care.)
I agree that you end up writing the same value to the chip register,
but it's convenient to also be able to use the value inside the driver
(for debugging purposes if nothing else) so it should be correct all
along the way.

>  
>  static s16 temp2_to_reg_adt7461(int val)
>  {
> -	return val <= 0 ? 0 :
> -			  val >= 127750 ? 0x7FC0 :
> -			  (val + 125) / 250 * 64;
> +	return val <= -64000 ? 0 :
> +			       val >= 191750 ? (s16) 0xffc0 :
> +			       (s16) ((val + 125) / 250 * 64 + 0x4000);
>  }

This one is broken as well. -55 degrees C gives me a register value of
0x0940 instead of the expected 0x0900. Positive values are OK up to 64
degrees C, same as the previous function: the cast to s16 breaks the
greater values. You want to return a u16 here, and cast to s16 just when
writing the value to struct lm90_data.

>  
>  /*
> @@ -269,7 +278,14 @@ static ssize_t show_temp8(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct lm90_data *data = lm90_update_device(dev);
> -	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index]));
> +	int temp;
> +
> +	if (data->kind = adt7461)
> +		temp = temp1_from_reg_adt7461(data->temp8[attr->index]);
> +	else
> +		temp = temp1_from_reg(data->temp8[attr->index]);
> +
> +	return sprintf(buf, "%d\n", temp);
>  }
>  
>  static ssize_t set_temp8(struct device *dev, struct device_attribute *devattr,
> @@ -303,7 +319,14 @@ static ssize_t show_temp11(struct device *dev, struct device_attribute *devattr,
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct lm90_data *data = lm90_update_device(dev);
> -	return sprintf(buf, "%d\n", temp2_from_reg(data->temp11[attr->index]));
> +	int temp;
> +
> +	if (data->kind = adt7461)
> +		temp = temp2_from_reg_adt7461(data->temp11[attr->index]);
> +	else
> +		temp = temp2_from_reg(data->temp11[attr->index]);
> +
> +	return sprintf(buf, "%d\n", temp);
>  }
>  
>  static ssize_t set_temp11(struct device *dev, struct device_attribute *devattr,
> @@ -342,8 +365,14 @@ static ssize_t show_temphyst(struct device *dev, struct device_attribute *devatt
>  {
>  	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct lm90_data *data = lm90_update_device(dev);
> -	return sprintf(buf, "%d\n", temp1_from_reg(data->temp8[attr->index])
> -		       - temp1_from_reg(data->temp_hyst));
> +	int temp;
> +
> +	if (data->kind = adt7461)
> +		temp = temp1_from_reg_adt7461(data->temp8[attr->index]);
> +	else
> +		temp = temp1_from_reg(data->temp8[attr->index]);
> +
> +	return sprintf(buf, "%d\n", temp - temp1_from_reg(data->temp_hyst));
>  }
>  
>  static ssize_t set_temphyst(struct device *dev, struct device_attribute *dummy,
> @@ -600,7 +629,6 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
>  				kind = adm1032;
>  			} else
>  			if (chip_id = 0x51 /* ADT7461 */
> -			 && (reg_config1 & 0x1F) = 0x00 /* check compat mode */

The compatibility mode is just bit 2 of the configuration register. You
still want to check the other unused bits, as is done for the other
types:

			 && (reg_config1 & 0x1B) = 0x00

This makes the detection a little more robust.

>  			 && reg_convrate <= 0x0A) {
>  				kind = adt7461;
>  			}
> @@ -733,6 +761,14 @@ static void lm90_init_client(struct i2c_client *client)
>  		config |= 0x18;
>  	}
>  
> +	/*
> +	 * Put ADT7461 into extended temperature range mode, which will
> +	 * change the range of readings from 0..127 to -64..191 degC.
> +	 * This also affects the format of the limit registers.
> +	 */
> +	if (data->kind = adt7461)
> +		config |= 0x04;
> +
>  	config &= 0xBF;	/* run */
>  	if (config != config_orig) /* Only write if changed */
>  		i2c_smbus_write_byte_data(client, LM90_REG_W_CONFIG1, config);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
