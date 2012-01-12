From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jan 2012 21:04:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adm1031) Fix coding style issues
Message-Id: <20120112220458.44c69089@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326363794-18299-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1326363794-18299-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 12 Jan 2012 02:23:14 -0800, Guenter Roeck wrote:
> Fix almost all coding style issues except for the multi-line macro errors,
> which do not really apply since the macros are not multi-line statements but
> declarations.
> 
> Based on merged patch series from Zac Storer; fixed remaining checkpatch
> errors and warnings.
> 
> Cc: Zac Storer <zac.3.14159@gmail.com>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/adm1031.c |  152 +++++++++++++++++++++++++++++++---------------
>  1 files changed, 102 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
> index e6291da..4c10fe9 100644
> --- a/drivers/hwmon/adm1031.c
> +++ b/drivers/hwmon/adm1031.c
> @@ -155,7 +155,7 @@ adm1031_write_value(struct i2c_client *client, u8 reg, unsigned int value)
>  #define TEMP_OFFSET_FROM_REG(val)	TEMP_FROM_REG((val) < 0 ? \
>  						      (val) | 0x70 : (val))
>  
> -#define FAN_FROM_REG(reg, div)		((reg) ? (11250 * 60) / ((reg) * (div)) : 0)
> +#define FAN_FROM_REG(reg, div)	((reg) ? (11250 * 60) / ((reg) * (div)) : 0)

This breaks alignment. I'd rather preserve the alignment and split the
line.

All the rest looks good so I'll adjust the above myself, no need to
resend. Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
