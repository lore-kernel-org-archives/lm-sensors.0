From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 01 Jul 2015 17:15:41 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (mcp3021) Fix broken output scaling
Message-Id: <20150701171541.GE12711@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20150701160638.GA7430@nick.stevens-ubuntu>
In-Reply-To: <20150701160638.GA7430@nick.stevens-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nick,

On Wed, Jul 01, 2015 at 04:07:41PM +0000, Stevens, Nick wrote:
> The mcp3021 scaling code is dividing the VDD (full-scale) value in
> millivolts by the A2D resolution to obtain the scaling factor. When VDD
> is 3300mV (the standard value) and the resolution is 12-bit (4096
> divisions), the result is a scale factor of 3300/4096, which is always
> one.  Effectively, the raw A2D reading is always being returned because
> no scaling is applied.
> 
> This patch fixes the issue and simplifies the register-to-volts
> calculation, removing the unneeded "output_scale" struct member.
> 
> Signed-off-by: Nick Stevens <Nick.Stevens@digi.com>

Code looks good. I'll apply it, with a minor change as mentioned below.

Thanks,
Guenter

> ---
> 
> Changes since v1:
>   * Simplify calculation based on discussion with Guenter Roeck
>     <linux@roeck-us.net>
>   * Remove "output_scale" struct member made obsolete by simplifying
>     calculation
> 
>  drivers/hwmon/mcp3021.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/mcp3021.c b/drivers/hwmon/mcp3021.c
> index d219c06..4f6b053 100644
> --- a/drivers/hwmon/mcp3021.c
> +++ b/drivers/hwmon/mcp3021.c
> @@ -31,14 +31,11 @@
>  /* output format */
>  #define MCP3021_SAR_SHIFT	2
>  #define MCP3021_SAR_MASK	0x3ff
> -
>  #define MCP3021_OUTPUT_RES	10	/* 10-bit resolution */
> -#define MCP3021_OUTPUT_SCALE	4
>  
>  #define MCP3221_SAR_SHIFT	0
>  #define MCP3221_SAR_MASK	0xfff
>  #define MCP3221_OUTPUT_RES	12	/* 12-bit resolution */
> -#define MCP3221_OUTPUT_SCALE	1
>  
>  enum chips {
>  	mcp3021,
> @@ -54,7 +51,6 @@ struct mcp3021_data {
>  	u16 sar_shift;
>  	u16 sar_mask;
>  	u8 output_res;
> -	u8 output_scale;
>  };
>  
>  static int mcp3021_read16(struct i2c_client *client)
> @@ -87,10 +83,7 @@ static inline u16 volts_from_reg(struct mcp3021_data *data, u16 val)
>  	if (val = 0)
>  		return 0;
>  
This check is no longer needed and can be dropped.

> -	val = val * data->output_scale - data->output_scale / 2;
> -
> -	return val * DIV_ROUND_CLOSEST(data->vdd,
> -			(1 << data->output_res) * data->output_scale);
> +	return DIV_ROUND_CLOSEST(data->vdd * val, 1 << data->output_res);
>  }
>  
>  static ssize_t show_in_input(struct device *dev, struct device_attribute *attr,
> @@ -132,14 +125,12 @@ static int mcp3021_probe(struct i2c_client *client,
>  		data->sar_shift = MCP3021_SAR_SHIFT;
>  		data->sar_mask = MCP3021_SAR_MASK;
>  		data->output_res = MCP3021_OUTPUT_RES;
> -		data->output_scale = MCP3021_OUTPUT_SCALE;
>  		break;
>  
>  	case mcp3221:
>  		data->sar_shift = MCP3221_SAR_SHIFT;
>  		data->sar_mask = MCP3221_SAR_MASK;
>  		data->output_res = MCP3221_OUTPUT_RES;
> -		data->output_scale = MCP3221_OUTPUT_SCALE;
>  		break;
>  	}
>  
> -- 
> 2.2.0

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
