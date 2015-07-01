From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Jul 2015 03:11:14 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (mcp3021) Fix broken output scaling
Message-Id: <55935A52.1060607@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150629214453.GA30170@nick.stevens-ubuntu>
In-Reply-To: <20150629214453.GA30170@nick.stevens-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nick,

On 06/29/2015 02:45 PM, Stevens, Nick wrote:
> The mcp3021 scaling code is dividing the VDD (full-scale) value in
> millivolts by the A2D resolution to obtain the scaling factor. When VDD
> is 3300mV (the standard value) and the resolution is 12-bit (4096
> divisions), the result is a scale factor of 3300/4096, which is always
> one.  Effectively, the raw A2D reading is always being returned because
> no scaling is applied.
>
> This patch fixes the issue while still using only integer math by
> converting VDD to microvolts before dividing by resolution, and then
> converting back to millivolts at return.
>
> Signed-off-by: Nick Stevens <Nick.Stevens@digi.com>
> ---
>   drivers/hwmon/mcp3021.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
> index d219c06..c3bbba2 100644
> --- a/drivers/hwmon/mcp3021.c
> +++ b/drivers/hwmon/mcp3021.c
> @@ -87,10 +87,15 @@ static inline u16 volts_from_reg(struct mcp3021_data *data, u16 val)
>   	if (val = 0)
>   		return 0;
>
> -	val = val * data->output_scale - data->output_scale / 2;
> +	/* Convert VDD setting to uV and divide by resolution to get uV/bit */
> +	u32 uv_per_bit = (data->vdd * 1000) / (
> +				(1 << data->output_res) * data->output_scale);
>
> -	return val * DIV_ROUND_CLOSEST(data->vdd,
> -			(1 << data->output_res) * data->output_scale);
> +	/* Scale raw reading by uV/bit */
> +	u32 uv_val = val * uv_per_bit;
> +
> +	/* Convert back from uV to mV */
> +	return (u16)DIV_ROUND_CLOSEST(uv_val, 1000);

How about simplifying this to
	return DIV_ROUND_CLOSEST(val * data->vdd,
			(1 << data->output_res) * data->output_scale);
instead ? Result is pretty much the same as far as I can see.

You forgot to multiply uv_val with scale, which causes the results
for MCP3021 to be wrong by a factor of 4.

I have no idea why
	val = val * data->output_scale - data->output_scale / 2;
in the original code subtracts data->output_scale / 2; that seems wrong to me.
Any idea ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
