From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 01 Feb 2006 19:23:05 +0000
Subject: [lm-sensors] [PATCH] I2C: add new rx8025 driver
Message-Id: <20060201202305.2b06dafb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060201102335.GA8223@digi.com>
In-Reply-To: <20060201102335.GA8223@digi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Uwe,

> below is a patch adding support for the Epson RX8025 SA/NB RTC module.

First of all: where is this chip found? Have you verified if this chip
isn't compatible with other chips we have drivers for already?

>  - There exists a RTC driver interface in include/asm-arm/rtc.h by
>    Russell King.  Should I use it even if it's ARM specific?
>    For now I used the ioctl interface directly.

See with Alessandro Zummo, he is working on a unified RTC core. Maybe
you can simplify your code by using it.

>  - Is it correct to name the config symbol SENSORS_RTCRX8025?
>    I question because in my eyes an RTC is not a sensor. OTOH the driver
>    for the 8564 chip (and serveral others) uses SENSORS_RTC8564.

No, please name it RTC_RX8025 instead. SENSORS_* names for non-sensors
drivers is a legacy which we are trying to get rid of.

My comments on your code follow.

> +#define RX8025_REG_ALDHOUR	0x0c
> +/* 0x0e is reserved */
> +#define RX8025_REG_CTRL1	0x0e
> +#define RX8025_REG_CTRL2	0x0f

Don't you mean 0x0d is reserved?

> +static struct i2c_client *rx8025_rtcclient = NULL;

Don't initialize a static global to NULL explicitly, the compiler will
do it for you.

> +static int rx8025_get_rtctime(struct rtc_time *dt)
> +{
> +	u8 command = RX8025_REG_CTRL1 << 4 | 0x08;

I'd suggest parentheses for more clarity.

> +	u8 result[9] = { 0, };

Doesn't seem to actually require an initialization.

> +	if(down_interruptible(&rx8025_lock))
> +		return -ERESTARTSYS;

Coding style: space between "if" and opening parenthesis.

Also, what exactly are you protecting with this mutex?

> +	dev_dbg(&rx8025_rtcclient->dev,
> +			"rx8025_get_rtctime: read 0x%02x 0x%02x 0x%02x 0x%02x"
> +			" 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n", result[0],
> +			result[1], result[2], result[3], result[4], result[5],
> +			result[6], result[7], result[8]);

When splitting strings, please have the middle space at the end of the
first half rather than the beginning of the second half. It makes it
easier to spot missing spaces.

> +	/* according to the documention read-only-bits read as 0 */
> +#define CHECK_ROBITS(reg, mask)						\
> +	if (unlikely(result[2 + (reg)] & ~(mask))) {			\
> +		dev_warn(&rx8025_rtcclient->dev,			\
> +				"value for " #reg " out of spec: %x\n",	\
> +				result[2 + (reg)]);			\
> +		result[2 + RX8025_REG_SEC] &= (mask);			\
> +	}
> +	CHECK_ROBITS(RX8025_REG_SEC, 0x7f);
> +	CHECK_ROBITS(RX8025_REG_MIN, 0x7f);
> +	CHECK_ROBITS(RX8025_REG_HOUR, 0x3f);
> +	CHECK_ROBITS(RX8025_REG_WDAY, 0x07);
> +	CHECK_ROBITS(RX8025_REG_MDAY, 0x3f);
> +	CHECK_ROBITS(RX8025_REG_MONTH, 0x1f);

Since you end up checking all unused bits regardless of what the
datasheet says, it would be more efficient - and more readble - to just
mask the values you read.

+	/* I don't have to do more checking, don't I? */

English: "don't I" should be "do I".

> +static int rx8025_set_rtctime(struct rtc_time *dt)
> +{
> (...)
> +	if(down_interruptible(&rx8025_lock))
> +		return -ERESTARTSYS;

Coding style.

> +	if (dt->tm_wday < 0 || dt->tm_wday >= 7) {
> +		dev_err(&rx8025_rtcclient->dev,
> +			"rx8025_set_rtctime: hours out of range: %d\n",
> +			dt->tm_wday);

Typo: "hours" should be "week day".

> +	if (dt->tm_year < 70 || dt->tm_mon >= 170) {

Typo: "dt->tm_mon" should be "dt->tm_year".

> +	/*
> +	 * BUG: The HW assumes every year that is a multiple of 4 to be a leap
> +	 * year.  Next time this is wrong is 2100, which will not be a leap
> +	 * year.
> +	 */
> +	if (dt->tm_mday > 31 ||
> +			((dt->tm_mon = 3 || dt->tm_mon = 5 ||
> +			  dt->tm_mon = 8 || dt->tm_mon = 10)
> +			 && dt->tm_mday > 30) ||
> +			(dt->tm_mon = 1 && dt->tm_mday > 28 +
> +			 (dt->tm_year & 3 ? 0 : 1))) {
> +		dev_err(&rx8025_rtcclient->dev,
> +			"rx8025_set_rtctime: day out of range (with month=%d, "
> +			"year=%d): %d\n", dt->tm_mon, dt->tm_year, dt->tm_mon);
> +		err = -EINVAL;
> +		goto errout_unlock;
> +	}

Other RTC drivers typically use a 12-element array defining the number
of day in each month. It's probably cleaner and more efficient. See
i2c-x1205 for an example.

Also, last parameter of dev_err() should be dt->tm_mday, not dt->tm_mon.

> +	if ((ctrl1 = i2c_smbus_read_byte_data(rx8025_rtcclient,
> +					RX8025_REG_CTRL1 << 4)) < 0) {
> +		dev_err(&rx8025_rtcclient->dev,
> +				"rx8025_set_rtctime: failed to read out "
> +				"RX8025_REG_CTRL1\n");
> +		err = -EINVAL;
> +		goto errout_unlock;
> +	}

-EINVAL doesn't seem to be appropriate. -EIO?

> +	if ((err = i2c_transfer(rx8025_rtcclient->adapter, &msg, 1)) < 1) {
> +		err = err >= 0 ? -EIO : err;
> +		goto errout_unlock;
> +	}

i2c_master_send is a convenient wrapper to i2c_transfer when sending a
single message (but see right below.)

> +static int rx8025_detect(struct i2c_adapter *adapter, int address, int kind)
> +{
> +	int err = 0;
> +	struct rx8025_data *data;
> +	struct i2c_client *new_client;

Use "client" instead of "new_client" please. Another legacy we try to
get rid of.

> +	if (!i2c_check_functionality(adapter, I2C_FUNC_I2C)) {
> +		dev_dbg(&adapter->dev, "doesn't support full I2C\n");
> +		goto errout;
> +	}

Given that all block transfers you do are standard I2C block transfers,
you may consider switching to i2c_smbus_{read,write}_i2c_block_data for
SMBus compatibility. This would also make your code more simple, I
think.

> +	new_client->flags = 0;

Not needed, as you've kzalloc'd the client structure.

> +	if (kind < 0) {
> +		u8 command = RX8025_REG_SEC << 4 | 0x08;
> +		u8 result[8] = { 0, };

Initalization not needed AFAICS.

> +		/* bits 7 of RX8025_REG_MONTH and RX8025_REG_DIGOFF
> +		 * "should be set as "0".  Their value when read will be "0""
> +		 *
> +		 * There are serveral more read-only bits who's "value when
> +		 * read is always "0"" according to the spec, but setting them
> +		 * yields a "1" sometimes.
> +		 */
> +		if (((result[RX8025_REG_MONTH] | result[RX8025_REG_DIGOFF])
> +					& 0x80)) {
> +			dev_dbg(&adapter->dev, "RX8025_REG_MONTH = %x, "
> +					"RX8025_REG_DIGOFF = %x\n",
> +					result[RX8025_REG_MONTH],
> +					result[RX8025_REG_DIGOFF]);
> +
> +
> +			goto errout_free;
> +		}

Detection is a bit poor. It could be made much more robust by checking
the acual values of the registers. See i2c-x1205.

> +		if ((err = misc_register(&rx8025_rtc_dev))) {
> +			rx8025_rtcclient = NULL;
> +			printk(KERN_ERR "Failed to register rtc device\n");
> +		}

Please use dev_err().

> +	printk(KERN_INFO "loaded driver for RX-8025 SA/NB on addr %d\n",
> +	       address);

Misleading message. What you did here is register the device with the
driver. The driver could have been loaded without ever registering
anything. Also, you should use dev_info.

> +static int rx8025_detach_client(struct i2c_client *client)
> +{
> (...)
> +	if (rx8025_rtcclient = client) {
> +		struct list_head *lh = rx8025_clients.next;
> +
> +
> +		if (list_entry(lh, struct rx8025_data, list) = data)
> +			lh = lh->next;

No double blank line please.

Additionally, some documentation file in Documentation/i2c/chips would
be welcome. And feel free to add yourself in MAINTAINERS as the
maintainer of this new driver if you want to take care of it in the
future.

-- 
Jean Delvare

