From: Samuel Ortiz <sameo@linux.intel.com>
Date: Mon, 28 Feb 2011 01:00:46 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 v2] mfd: twl4030: Driver for twl4030
Message-Id: <20110228010045.GD2749@sortiz-mobl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298560713-18790-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1298560713-18790-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Keerthy <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, linux-omap@vger.kernel.org

Hi Keerthy,

On Thu, Feb 24, 2011 at 08:48:33PM +0530, Keerthy wrote:
> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for monitoring
> ADC. This driver monitors the real time conversion of analog signals like
> battery temperature, battery cuurent etc.
Looks mostly good to me, one minor comment though:

> +static int twl4030_madc_read_channels(struct twl4030_madc_data *madc,
> +				      u8 reg_base, u16 channels, int *buf)
> +{
> +	int count = 0, count_req = 0;
> +	u8 reg, i;
> +
> +	for (i = 0; i < TWL4030_MADC_MAX_CHANNELS; i++) {
> +		if (channels & (1 << i)) {
You may want to use for_each_set_bit() here.


> +			reg = reg_base + 2 * i;
> +			buf[i] = twl4030_madc_channel_raw_read(madc, reg);
> +			if (buf[i] < 0) {
> +				dev_err(madc->dev,
> +				"Unable to read register 0x%X\n", reg);
> +				count_req++;
For a clearer code, just call continue here, and the following blck will look
nicer.

> +static irqreturn_t twl4030_madc_threaded_irq_handler(int irq, void *_madc)
> +{
> +	struct twl4030_madc_data *madc = _madc;
> +	const struct twl4030_madc_conversion_method *method;
> +	u8 isr_val, imr_val;
> +	int i, len, ret;
> +	struct twl4030_madc_request *r;

Don't you want to take the madc lock around here ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
