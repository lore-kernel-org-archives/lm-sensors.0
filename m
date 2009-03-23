From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 23 Mar 2009 00:18:28 +0000
Subject: Re: [lm-sensors] [RFH] GMT G760A fan speed PWM controller
Message-Id: <20090322171828.e73f95a4.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090310092119.GA3260@deprecation.cyrius.com>
In-Reply-To: <20090310092119.GA3260@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 10 Mar 2009 19:05:53 +0100 Martin Michlmayr <tbm@cyrius.com> wrote:

> From: Herbert Valerio Riedel <hvr@gnu.org>
> Subject: hwmon: add support for GMT G760A fan speed PWM controller
> 
> This controller can be found on the D-Link DNS-323 for instance,
> where it is to be configured via static i2c_board_info in the
> board-specific mach-orion/dns323-setup.c; this driver supports only
> the new-style driver model.
> 
>
> ...
>
> +struct g760a_data {
> +	struct i2c_client *client;
> +	struct device *hwmon_dev;
> +	struct mutex update_lock;
> +
> +	/* board specific parameters */
> +	u32 clk; /* default 32kHz */
> +	u16 fan_div; /* default P=2 */
> +
> +	/* g760a register cache */
> +	int valid:1;

I think sparse gets upset about signed single-bit bit fields.  Because the
sole bit is also the sign bit, so does it have a value of 1, or of -1???

So it should be converted to unsigned.

> +	unsigned long last_updated; /* In jiffies */
> +
> +	u8 set_cnt; /* PWM (period) count number; 0xff stops fan	*/
> +	u8 act_cnt; /*   formula: cnt = (CLK * 30)/(rpm * P)		*/
> +	u8 fan_sta; /* bit 0: set when actual fan speed more than 20%
> +		     *   outside requested fan speed
> +		     * bit 1: set when fan speed below 1920 rpm		*/
> +};
> +
> +#define G760A_DEFAULT_CLK 32768
> +#define G760A_DEFAULT_FAN_DIV 2
> +
> +#define RPM_FROM_CNT(val, clk, div) \
> +	((0x00 = (val)) ? 0 : (((clk)*30)/((val)*(div))))

The macro evaluates its arguments multiple times hence is slow or buggy if
passed an expression with side effects.

Please convert it to a plain old lower-case C function.

> +#define PWM_FROM_CNT(cnt)	(0xff-(cnt))
> +#define PWM_TO_CNT(pwm)		(0xff-(pwm))
> +
>
> ...
>
> +static ssize_t show_fan(struct device *dev, struct device_attribute *da,
> +			char *buf)
> +{
> +	struct g760a_data *data = g760a_update_client(dev);
> +	int rpm = 0;

An unsigned type would be more appropriate here.

> +	mutex_lock(&data->update_lock);
> +	if (!(data->fan_sta & G760A_REG_FAN_STA_RPM_LOW))
> +		rpm = RPM_FROM_CNT(data->act_cnt, data->clk, data->fan_div);
> +	mutex_unlock(&data->update_lock);
> +
> +	return sprintf(buf, "%d\n", rpm);
> +}
> +
>
> ...
>
> +static ssize_t set_pwm(struct device *dev, struct device_attribute *da,
> +		       const char *buf, size_t count)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct g760a_data *data = g760a_update_client(dev);
> +
> +	const long val = simple_strtol(buf, NULL, 10);

strict_strtoul()?

> +	mutex_lock(&data->update_lock);
> +	data->set_cnt = PWM_TO_CNT(SENSORS_LIMIT(val, 0, 255));
> +	g760a_write_value(client, G760A_REG_SET_CNT, data->set_cnt);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
>
> ...
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
