From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Feb 2012 16:38:48 +0000
Subject: Re: [lm-sensors] [PATCH V4] hwmon: Add MCP3021 ADC driver
Message-Id: <20120220173848.477158b5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1329711239-11856-1-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1329711239-11856-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Xie,

On Mon, 20 Feb 2012 12:13:59 +0800, Xie Xiaobo wrote:
> Add I2C driver for MCP3021 that is an ADC chip from Microchip.
> The MCP3021 is a successive approximation A/D converter (ADC)
> with 10-bit resolution.
> The driver export the value of Vin to sysfs, the voltage unit is
> mV. Through the sysfs interface, lm-sensors tool can also display
> Vin voltage.
> 
> Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
> Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> ---

When submitting a new version of a previous patch, please include a
changelog here so that reviewers know what changed. I'm using quilt's
wonderful snapshot feature to get an idea but it would take me less
time if I knew what to expect.

Still a few issues remaining in this version, although most problems
were properly fixed (thanks!)

> +static inline u16 volts_from_reg(u16 vdd, u16 val)
> +{
> +	if (val = 0)
> +		return 0;
> +
> +	val = val * MCP3021_OUTPUT_SCALE - MCP3021_OUTPUT_SCALE / 2;
> +
> +	return val * DIV_ROUND_CLOSEST(vdd,
> +			(1 << MCP3021_OUTPUT_RES) * MCP3021_OUTPUT_SCALE);
> +}

I did not notice before, but can't this overflow? Say val = 0xfff0,
0xfff0 * 4 - 4 / 2 = 0x3ffbe, that doesn't fit in u16. I think you
should introduce a local int variable and return its value (as an int,
not u16.)

> +
> +static ssize_t show_in_input(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct mcp3021_data *data = i2c_get_clientdata(client);
> +	int reg, in_input;
> +
> +	reg = mcp3021_read16(client);
> +	if (reg >= 0)
> +		in_input = volts_from_reg(data->vdd, reg);
> +	else
> +		in_input = reg;

No, this would be interpreted by userspace as a negative voltage, not
an error. You want to return reg directly, not print it.

> +	return sprintf(buf, "%d\n", in_input);
> +}
> +
> +static DEVICE_ATTR(in0_input, S_IRUGO, show_in_input, NULL);
> +
> +static struct attribute *mcp3021_attributes[] = {
> +	&dev_attr_in0_input.attr,
> +	NULL
> +};

You hardly need an array for one attribute, just access the attribute
directly.

All the rest looks good.
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
