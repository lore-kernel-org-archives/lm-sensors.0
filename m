From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 28 Oct 2013 17:35:18 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: lm73: reset device during lm73_probe()
Message-Id: <20131028173518.GA10658@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 28, 2013 at 09:05:05AM -0700, Chris Verges wrote:
> The LM73 datasheet recommends resetting the sensor at power-up to avoid
> certain VDD ramp-up problems.  The full sequence and rationale is
> described in the LM73 datasheet, May 2009 revision, page 19, section
> "Power Supply Ramp-Up Considerations."
> 
> This patch augments the lm73_probe() behavior to perform the described
> reset sequence at device initialization time.  The sequence performed
> is:
> 
>   1. Power down the LM73 using the "PD" bit in the CONF register.
>   2. Wait at least 115 msec for the LM73 to process the request.
>   3. Power up the LM73 using the reverse process.
> 
> The datasheet recommends running the reset sequence only after VDD has
> been cut/restored to a LM73.  This patch assumes that VDD is provided to
> the sensor at system boot and is not cut/restored during the runtime of
> the system.  For embedded systems that may provide such control,
> additional patching of the driver or module unloading/loading would be
> required.
> 
Hi Chris,

common assumption is that the chip is enabled and pre-configured by the BIOS
or ROMMON.  If so, this code is unnecessary and just adds 100+ ms to the
system boot time for each LM73 sensor. I don't think that would be a good idea.

The datasheet says "... In systems where there is a large amount of capacitance
on the VDD node, the LM73 power supply ramp-up time can become excessively
long", which is defined as "A linear power-on-ramp of less than 0.7V/msec and
an exponential ramp with an RC time constant of more than 1.25 msec is
categorized as a slow power-supply ramp". The soft-reset is only required if
this is the case.

Are there indications that this condition is actually seen on real hardware,
and not taken care of by the BIOS/ROMMON ? If so, a module parameter, platform
data, and/or devicetree property to indicate the condition might be acceptable,
but not a one-for-all mandatory chip reset and associated delay.

More comments below.

Thanks,
Guenter

> Signed-off-by: Chris Verges <kg4ysn@gmail.com>
> ---
>  Documentation/hwmon/lm73 |    9 ++++++++
>  drivers/hwmon/lm73.c     |   52 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/lm73 b/Documentation/hwmon/lm73
> index 8af059d..a116fc8 100644
> --- a/Documentation/hwmon/lm73
> +++ b/Documentation/hwmon/lm73
> @@ -18,6 +18,15 @@ Description
>  The LM73 is a digital temperature sensor.  All temperature values are
>  given in degrees Celsius.
>  
> +Initialization
> +--------------
> +
> +At initialization, the LM73 driver attempts to detect the device by
> +reading the control, configuration, and id registers.  The device is
> +next probed, at which time a "soft reset" is performed, as recommended
> +by TI in the "Power Supply Ramp-Up Considerations" section of the LM73
> +datasheet (May 2009 revision, Page 19).
> +
>  Measurement Resolution Support
>  ------------------------------
>  
> diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
> index 9bde964..0f6ce2a 100644
> --- a/drivers/hwmon/lm73.c
> +++ b/drivers/hwmon/lm73.c
> @@ -21,7 +21,7 @@
>  #include <linux/hwmon.h>
>  #include <linux/hwmon-sysfs.h>
>  #include <linux/err.h>
> -
> +#include <linux/delay.h>
>  
>  /* Addresses scanned */
>  static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
> @@ -47,6 +47,15 @@ static const unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4c,
>  #define LM73_CTRL_HI_SHIFT	2
>  #define LM73_CTRL_LO_SHIFT	1
>  
> +#define LM73_CONF_PD_MASK	BIT(7)
> +
> +/*
> + * When resetting the LM73, we must wait longer than the maximum
> + * conversion time specified in "Temperature-to-Digital Converter
> + * Characteristics" (LM73 datasheet, May 2009 rev, page 5)
> + */
> +#define LM73_MIN_RESET_TIME_MS	115
> +
>  static const unsigned short lm73_convrates[] = {
>  	14,	/* 11-bits (0.25000 C/LSB): RES1 Bit = 0, RES0 Bit = 0 */
>  	28,	/* 12-bits (0.12500 C/LSB): RES1 Bit = 0, RES0 Bit = 1 */
> @@ -201,6 +210,44 @@ static const struct attribute_group lm73_group = {
>  
>  /* device probe and removal */
>  
> +static int lm73_soft_reset(struct i2c_client *client)
> +{
> +	struct device *hwmon_dev = i2c_get_clientdata(client);
> +	s32 err;
> +	u8 value;
> +
> +	err = i2c_smbus_read_byte_data(client, LM73_REG_CONF);
> +	if (err < 0)
> +		goto reset_error;
> +
> +	value = err;
> +	value &= ~(3 << 0); /* always clear bits 1:0 */
> +	value |= (1 << 6);  /* always set bit 6 */
> +
You are using BIT() above, making this inconsistent.

> +	dev_dbg(&client->dev, "%s: powering down the sensor\n",
> +		dev_name(hwmon_dev));

Kind of redundant to use dev_err and then display the device name again.
Same below. Besides, I don't think the debug messages provide real value.

> +	value |= LM73_CONF_PD_MASK;
> +	err = i2c_smbus_write_byte_data(client, LM73_REG_CONF, value);
> +	if (err < 0)
> +		goto reset_error;
> +
> +	mdelay(LM73_MIN_RESET_TIME_MS);
> +
Datasheet says one has to wait for the conversion time, which depends on the
configured resolution. This means that, most of the time, you are waiting way
too long here - especially in the presumed context that the chip has not been
initialized by the ROMMON/BIOS.

> +	dev_dbg(&client->dev, "%s: powering up the sensor\n",
> +		dev_name(hwmon_dev));
> +	value &= ~LM73_CONF_PD_MASK;
> +	err = i2c_smbus_write_byte_data(client, LM73_REG_CONF, value);
> +	if (err < 0)
> +		goto reset_error;
> +
> +	return 0;
> +
> +reset_error:
> +	dev_err(&client->dev, "%s: unable to reset device\n",
> +		dev_name(hwmon_dev));
> +	return err;
> +}
> +
>  static int
>  lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  {
> @@ -235,6 +282,9 @@ lm73_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	dev_info(&client->dev, "%s: sensor '%s'\n",
>  		 dev_name(data->hwmon_dev), client->name);
>  
> +	/* Reset the device */
> +	status = lm73_soft_reset(client);
> +
What exactly is the point of returning status ...

>  	return 0;

just to ignore it ?

>  
>  exit_remove:
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
