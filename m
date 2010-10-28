From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 28 Oct 2010 13:16:32 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ltc4261) Add missing newline in
Message-Id: <20101028151632.081a0fdf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 28 Oct 2010 06:20:23 -0700, Guenter Roeck wrote:
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>

Obviously correct.

Acked-by: Jean Delvare <khali@linux-fr.org>

> ---
>  drivers/hwmon/ltc4261.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
> index 2676261..15f137b 100644
> --- a/drivers/hwmon/ltc4261.c
> +++ b/drivers/hwmon/ltc4261.c
> @@ -82,7 +82,7 @@ static struct ltc4261_data *ltc4261_update_device(struct device *dev)
>  			val = i2c_smbus_read_byte_data(client, i);
>  			if (unlikely(val < 0)) {
>  				dev_dbg(dev,
> -					"Failed to read ADC value: error %d",
> +					"Failed to read ADC value: error %d\n",
>  					val);
>  				ret = ERR_PTR(val);
>  				goto abort;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
