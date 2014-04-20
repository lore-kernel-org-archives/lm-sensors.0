From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Apr 2014 20:08:00 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] hwmon: (lm92) Drop function macros
Message-Id: <53542920.8010005@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397861485-31740-3-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397861485-31740-3-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/18/2014 03:51 PM, Guenter Roeck wrote:
> Function macros obfuscate code and increase code size, so drop them.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/lm92.c |  165 +++++++++++++++++++++++++-------------------------
>   1 file changed, 82 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
> index 7193a92..faa9a65 100644
> --- a/drivers/hwmon/lm92.c
> +++ b/drivers/hwmon/lm92.c
> @@ -89,6 +89,23 @@ static inline u8 ALARMS_FROM_REG(s16 reg)
>   	return reg & 0x0007;
>   }
>
> +enum temp_index {
> +	t_input,
> +	t_crit,
> +	t_min,
> +	t_max,
> +	t_hyst,
> +	t_num_regs,

I dropped this comma ,,,
> +};
> +
> +static u8 regs[] = {

and made the array a const.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
