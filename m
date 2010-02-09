From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Feb 2010 09:59:11 +0000
Subject: Re: [lm-sensors] [PATCH V3] hwmon: add driver for ADT7411 voltage &
Message-Id: <20100209105911.4fb1972c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1265631110-640-1-git-send-email-w.sang@pengutronix.de>
In-Reply-To: <1265631110-640-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Wolfram,

On Mon,  8 Feb 2010 13:11:50 +0100, Wolfram Sang wrote:
> Add basic support for the ADT7411. Reads out all conversion results (via I2C,
> SPI yet missing) and allows some on-the-fly configuration. Tested with a custom
> board.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Jean Delvare <khali@linux-fr.org>

Patch applied, thanks.

Still, I think there is a locking issue in your driver, which I would
like you to address with an incremental patch. The problem is in
function adt7411_show_input():

> +static ssize_t adt7411_show_input(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(attr)->index;
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct adt7411_data *data = i2c_get_clientdata(client);
> +	int val;
> +	u8 lsb_reg, lsb_shift;
> +
> +	if (time_after_eq(jiffies, data->next_update)) {
> +		val = i2c_smbus_read_byte_data(client, ADT7411_REG_CFG3);
> +		if (val < 0)
> +			return val;
> +		data->ref_is_vdd = val & ADT7411_CFG3_REF_VDD;
> +
> +		if (data->ref_is_vdd) {
> +			val = adt7411_read_10_bit(client,
> +					ADT7411_REG_INT_TEMP_VDD_LSB,
> +					ADT7411_REG_VDD_MSB, 2);
> +			if (val < 0)
> +				return val;
> +
> +			data->vref_cached = val * 7000 / 1024;
> +		} else {
> +			data->vref_cached = 2250;
> +		}
> +
> +		data->next_update = jiffies + HZ;
> +	}
> +
> +	lsb_reg = ADT7411_REG_EXT_TEMP_AIN14_LSB + (nr >> 2);
> +	lsb_shift = 2 * (nr & 0x03);
> +	val = adt7411_read_10_bit(client, lsb_reg,
> +			ADT7411_REG_EXT_TEMP_AIN1_MSB + nr, lsb_shift);
> +
> +	return val < 0 ? val :
> +			sprintf(buf, "%u\n", val * data->vref_cached / 1024);
> +}

You cache the vref in data->ref_is_vdd (for no good reason BTW) and
data->vref_cached. The freshness of the cache is stored in
data->next_update. Now, what would happen if two readers access this
function simultaneously at a time the cache needs to be updated? Both
will read registers ADT7411_REG_CFG3, and possibly
ADT7411_REG_INT_TEMP_VDD_LSB and ADT7411_REG_VDD_MSB, to refresh the
cache. This is both slow (voiding the point of having a cache) and
unsafe: both might try to set data->vref_cached and data->vref_cached,
which isn't guaranteed to succeed because these aren't atomic types.
Even reading data->vref_cached at the end of this function is not
guaranteed to succeed in the absence of locking.

So I would like you to surround all access to the cached values and
their timestamp with locking, as is done in many other hwmon drivers.
And you might want to stop caching data->ref_is_vdd while you're
there...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
