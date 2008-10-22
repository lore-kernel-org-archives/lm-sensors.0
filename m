From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Oct 2008 07:21:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <20081022092126.600908f3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081020160308.GA22915@ovro.caltech.edu>
In-Reply-To: <20081020160308.GA22915@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ira,

On Tue, 21 Oct 2008 10:44:18 -0700, Ira Snyder wrote:
> Add Linux support for the Linear Technology LTC4245 Multiple Supply Hot
> Swap controller I2C monitoring interface.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> This should be the final revision of the driver. For real this time :)
> 
> Jean, please feel free to just delete the "#if 0" block if you feel it
> shouldn't be there. The comment is just fine.
> 
> Changes v4 -> v5:
>   * rename the variable "current" to "curr" to workaround brokenness
>     in asm/current.h on x86, powerpc64, etc.
>   * check for errors when reading from i2c
>   * disable probing, add example usage of force param to documentation
>   * add missing #include <linux/kernel.h>
>   * use i2c_smbus_read_byte_data() rather than ltc4245_read_reg()
>   * const-ify some variables
> 
> Changes v3 -> v4:
>   * simplify ltc4245_get_voltage(), removing special casing for -12v
>   * power should always be a positive value
> 
> Changes v2 -> v3:
>   * fix units (power?_input in uW, curr?_input in mA)
>   * combine all alarm functions
>   * rename power[1-4]_alarm to in[5-8]_min_alarm, per suggestions
> 
> Changes v1 -> v2:
>   * fixed checkpatch warnings
>   * removed raw register access, per suggestions
>   * changed sysfs interface, per suggestions (current, power, alarms)
> 
> 
>  Documentation/hwmon/ltc4245 |   81 ++++++
>  drivers/hwmon/Kconfig       |   11 +
>  drivers/hwmon/Makefile      |    1 +
>  drivers/hwmon/ltc4245.c     |  578 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 671 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/ltc4245
>  create mode 100644 drivers/hwmon/ltc4245.c

I'm fine with all changes except:

> --- /dev/null
> +++ b/Documentation/hwmon/ltc4245
> (...)
> +Usage Notes
> +-------------

2 dashes too many.

> (...)
> +struct ltc4245_data {
> +	struct device *hwmon_dev;
> +
> +	struct mutex update_lock;
> +	bool valid;
> +	unsigned long last_updated; /* in jiffies */
> +
> +	/* Control registers */
> +	s32 cregs[0x08];
> +
> +	/* Voltage registers */
> +	s32 vregs[0x0f];
> +};

You changed these arrays from u8 to s32. This makes your data structure
much larger. It would make some sense if you meant to store error
values in order to process them later and report them as such to the
user. However...

> (...)
> +static int ltc4245_get_voltage(struct device *dev, u8 reg)
> +{
> +	struct ltc4245_data *data = ltc4245_update_device(dev);
> +	const s32 val = data->vregs[reg - 0x10];
> +	const u8 regval = val;
> +	u32 voltage = 0;
> +
> +	if (unlikely(val < 0))
> +		return 0;

All you do in case of error is return 0, that is, exactly as if the
register contained 0. So in the end you're not really handling the
error.

If you don't handle the error then it's much cheaper memory-wise to
turn errors into 0 as soon as you read the value from the register in
ltc4245_update_device() so that you can use arrays of u8 in your data
structure.

If you do want to handle the error (most drivers don't) then you have
to transmit the error code up all the way to the sysfs callback
function. This implies changing the prototype of your
ltc4245_get_voltage() function so that it can return both the error
value and the voltage value.

As a summary, please either handle the errors completely or don't
handle them at all. Doing it half way makes the driver bigger with no
benefit.

> (...)
> +static int ltc4245_check_control_reg(struct i2c_client *client, u8 reg, u8 bits)
> +{
> +	int i;
> +	s32 v, voff1, voff2;
> +
> +	/* Read register and check for error */
> +	v = i2c_smbus_read_byte_data(client, reg);
> +	if (v < 0)
> +		return v;
> +
> +	v &= bits;
> +	if (v < 0)
> +		return -ENODEV;

This test and return were supposed to be removed, weren't they?

> +
> +	for (i = 0x00; i < 0xff; i += 0x20) {
> +
> +		voff1 = i2c_smbus_read_byte_data(client, reg + i);
> +		if (voff1 < 0)
> +			return voff1;
> +
> +		voff2 = i2c_smbus_read_byte_data(client, reg + i + 0x08);
> +		if (voff2 < 0)
> +			return voff2;
> +
> +		voff1 &= bits;
> +		voff2 &= bits;
> +
> +		if (v != voff1 || v != voff2)
> +			return -ENODEV;
> +	}
> +
> +	return 0;
> +}

All the rest looks alright to me now. I'll do some tests with
lm-sensors now to test the sysfs interface.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
