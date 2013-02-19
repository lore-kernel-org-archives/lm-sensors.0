From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Feb 2013 01:32:04 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (adt7410) Don't re-read non-volatile registers
Message-Id: <20130219013204.GC25124@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1361194739-16525-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Mon, Feb 18, 2013 at 02:38:56PM +0100, Lars-Peter Clausen wrote:
> Currently each time the temperature register is read the driver also reads the
> threshold and hysteresis registers. This increases the amount of I2C traffic and
> time needed to read the temperature by a factor of ~5. Neither the threshold nor
> the hysteresis change on their own, so once we've read them, we should be able
> to just use the cached value of the registers. This patch modifies the code
> accordingly and only reads the threshold and hysteresis registers once during
> probe.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
Just one comment (thanks to Hartmut), otherwise looks good.

> ---
> Changes since v1:
> 	* Fix error checking for i2c reads
> ---
[ ... ]

> +static int adt7410_fill_cache(struct i2c_client *client)
> +{
> +	struct adt7410_data *data = i2c_get_clientdata(client);
> +	int ret;
> +	int i;
> +
> +	for (i = 1; i < ARRAY_SIZE(ADT7410_REG_TEMP); i++) {
> +		ret = i2c_smbus_read_word_swapped(client, ADT7410_REG_TEMP[i]);
> +		if (ret < 0) {
> +			dev_dbg(&client->dev,
> +				"Failed to read value: reg %d, error %d\n",
> +				ADT7410_REG_TEMP[0], ret);

	ADT7410_REG_TEMP[i]

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
