From: Oliver Neukum <oneukum@suse.de>
Date: Fri, 20 Jul 2012 14:03:38 +0000
Subject: Re: [lm-sensors] [RFC][PATCH] hwmon: add support for Sensirion C1 sensor
Message-Id: <6190165.D1PKLQQHEK@linux-lqwf.site>
List-Id: <lm-sensors.vger.kernel.org>
References: <1342789042-13433-1-git-send-email-johannes.winkelmann@sensirion.com>
In-Reply-To: <1342789042-13433-1-git-send-email-johannes.winkelmann@sensirion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Johannes Winkelmann <johannes.winkelmann@gmail.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Johannes Winkelmann <johannes.winkelmann@sensirion.com>

On Friday 20 July 2012 14:57:22 Johannes Winkelmann wrote:

> +/* sysfs attributes */
> +static struct shtc1_data *shtc1_update_client(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct shtc1_data *data = i2c_get_clientdata(client);
> +
> +	char buf[SHTC1_RESPONSE_LENGTH];

Is this used for DMA?

> +	int val;
> +	int ret;
> +
> +	mutex_lock(&data->update_lock);
> +
> +	/*
> +	 * initialize 'ret' in case we had a valid result before, but
> +	 * read too quickly in which case we return the last values
> +	 */
> +	ret = !data->valid;
> +
> +	if (time_after(jiffies, data->last_updated + HZ / 10)
> +	    || !data->valid) {
> +		ret = shtc1_update_values(client, data, buf, sizeof(buf));
> +
> +		if (ret)
> +			goto out;
> +
> +		/*
> +		 * From datasheet:
> +		 *   T = -45 + 175 * ST / 2^16
> +		 *   RH = -10 + 120 * SRH / 2^16
> +		 *
> +		 * Adapted for integer fixed point (3 digit) arithmetic
> +		 */
> +		val = (buf[0] << 8) | buf[1];
> +		data->temperature = ((21875 * val) >> 13) - 45000;
> +		val = (buf[3] << 8) | buf[4];

We have dedicated macros for conversion of endianness.

> +		data->humidity = ((15000 * val) >> 13) - 10000;
> +
> +		data->last_updated = jiffies;
> +		data->valid = 1;
> +	}
> +
> +out:
> +	mutex_unlock(&data->update_lock);
> +
> +	return ret = 0 ? data : NULL;
> +}
	Regards
		Oliver


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
