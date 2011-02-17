From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Feb 2011 12:42:03 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: Add support for Texas
Message-Id: <20110217134203.0556a7ab@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110214112228.59269651@endymion.delvare>
	<1297689710-17840-1-git-send-email-eibach@gdsys.de>
In-Reply-To: <1297689710-17840-1-git-send-email-eibach@gdsys.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dirk Eibach <eibach@gdsys.de>
Cc: linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, rdunlap@xenotime.net, linux-doc@vger.kernel.org

Hi Dirk,

On Mon, 14 Feb 2011 14:21:50 +0100, Dirk Eibach wrote:
> Signed-off-by: Dirk Eibach <eibach@gdsys.de>
> ---
> Changes since v1:
> - fixed/extended Documentation
> - removed unused register definitions
> - hardcoded PGA fullscale table size
> - made sure patch applies against v2.6.38-rc4
> - reordered functions to avoid forward declaration
> - results from i2c_smbus_read_word_data() are handled correctly
> - moved locking into ads1015_read_value()
> - removed unnecessray clearing of bit
> - proper error handling in ads1015_read_value()
> - use DIV_ROUND_CLOSEST for scaling result
> - removed detect()

Thanks for the quick update. Second review:

> (...)
> --- /dev/null
> +++ b/Documentation/hwmon/ads1015
> @@ -0,0 +1,33 @@
> +Kernel driver ads1015
> +==========> +
> +Supported chips:
> +  * Texas Instruments ADS1015
> +    Prefix: 'ads1015'
> +    Addresses scanned: I2C 0x48, 0x49, 0x4a, 0x4b

With the detect function being gone, this is no longer true.

> +    Datasheet: Publicly available at the Texas Instruments website :
> +               http://focus.ti.com/lit/ds/symlink/ads1015.pdf
> +
> +Authors:
> +        Dirk Eibach, Guntermann & Drunck GmbH <eibach@gdsys.de>
> +
> +Description
> +-----------
> +
> +This driver implements support for the Texas Instruments ADS1015.
> +
> +This device is a 12-bit A-D converter with 4 inputs.
> +
> +The inputs can be used single ended or in certain differential combinations.
> +
> +On certain systems it makes sense to access absolute voltage values as well
> +as voltage differences. So all available combinations are made available by
> +8 "virtual" inputs:
> +in0: Voltage over AIN0 and AIN1.
> +in1: Voltage over AIN0 and AIN3.
> +in2: Voltage over AIN1 and AIN3.
> +in3: Voltage over AIN2 and AIN3.
> +in4: Voltage over AIN0 and GND.
> +in5: Voltage over AIN1 and GND.
> +in6: Voltage over AIN2 and GND.
> +in7: Voltage over AIN3 and GND.

I see you've updated the comment, presumably this is how you addressed
my concern about exposing all 8 input settings. I am really curious how
it can make sense to expose both direct and differential values
involving the same pins. The pcf8591 driver, which has to handle a
smiliar case, only exposes channels which make physical sense together
(it does so using a module parameter for historical reason, nowadays we
would use platform data for this.)

So I am still convinced that this part should be reworked. That being
said, you obviously know more than I do with regards to how you intend
to use the driver, so I'll leave you the last work on this.

> (...)
> --- /dev/null
> +++ b/drivers/hwmon/ads1015.c
> (...)
> +static int ads1015_read_value(struct i2c_client *client, unsigned int channel,
> +			      int *value)
> +{
> +	u16 config;
> +	s16 conversion;
> +	unsigned int pga;
> +	int fullscale;
> +	unsigned int k;
> +	struct ads1015_data *data = i2c_get_clientdata(client);
> +	int res;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/* get fullscale voltage */
> +	res = ads1015_read_reg(client, ADS1015_CONFIG);
> +	if (res < 0)
> +		goto err_unlock;
> +	config = res;
> +	pga = (config >> 9) & 0x0007;
> +	fullscale = fullscale_table[pga];
> +
> +	/* set channel and start single conversion */
> +	config &= ~(0x0007 << 12);
> +	config |= (1 << 15) | (1 << 8) | (channel & 0x0007) << 12;
> +
> +	/* wait until conversion finished */
> +	res = ads1015_write_reg(client, ADS1015_CONFIG, config);
> +	if (res < 0)
> +		goto err_unlock;
> +	for (k = 0; k < 5; ++k) {
> +		schedule_timeout(msecs_to_jiffies(1));
> +		res = ads1015_read_reg(client, ADS1015_CONFIG);
> +		if (res < 0)
> +			goto err_unlock;
> +		config = res;
> +		if (config & (1 << 15))
> +			break;
> +	}
> +	if (k = 5)
> +		return -EIO;

You return with data->update_lock held.

> +
> +	res = ads1015_read_reg(client, ADS1015_CONVERSION);
> +	if (res < 0)
> +		goto err_unlock;
> +	conversion = res;
> +
> +	mutex_unlock(&data->update_lock);
> +
> +	*value = DIV_ROUND_CLOSEST(conversion * fullscale, 0x7ff0);
> +
> +	return 0;
> +
> +err_unlock:
> +	mutex_unlock(&data->update_lock);
> +	return res;
> +}

> (...)
> +/* This is the driver that will be inserted */
> +static struct i2c_driver ads1015_driver = {
> +	.class = I2C_CLASS_HWMON,
> +	.driver = {
> +		.name = "ads1015",
> +	},
> +	.probe = ads1015_probe,
> +	.remove = ads1015_remove,
> +	.id_table = ads1015_id,
> +	.address_list = normal_i2c,
> +};

The only purpose of the address list is for the detect function, which
you just dropped. So you can remove the address list too. Same goes for
the class.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
