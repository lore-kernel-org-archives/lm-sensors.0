From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Jul 2012 15:07:11 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (w83627ehf) Add missing break statement
Message-Id: <20120707170711.45c526d8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 21 Jun 2012 06:56:55 -0700, Guenter Roeck wrote:
> A case statement in nct6775_write_fan_div() is missing a break. Fix it.
> 
> This patch addresses Coverity #141439: Missing break in switch.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/w83627ehf.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
> index 54922ed..1821b74 100644
> --- a/drivers/hwmon/w83627ehf.c
> +++ b/drivers/hwmon/w83627ehf.c
> @@ -599,6 +599,7 @@ static void nct6775_write_fan_div(struct w83627ehf_data *data, int nr)
>  		reg = (w83627ehf_read_value(data, NCT6775_REG_FANDIV1) & 0x7)
>  		    | ((data->fan_div[1] << 4) & 0x70);
>  		w83627ehf_write_value(data, NCT6775_REG_FANDIV1, reg);
> +		break;
>  	case 2:
>  		reg = (w83627ehf_read_value(data, NCT6775_REG_FANDIV2) & 0x70)
>  		    | (data->fan_div[2] & 0x7);

Acked-by: Jean Delvare <khali@linux-fr.org>

Good catch, thankfully it is harmless as we are simply writing an
unchanged value to the other register.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
