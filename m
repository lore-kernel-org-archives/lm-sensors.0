From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 20 Apr 2014 20:08:57 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: (max1619) Drop function macros
Message-Id: <53542959.1010101@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397946493-4455-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397946493-4455-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/19/2014 03:28 PM, Guenter Roeck wrote:
> Function macros make the code larger and difficult ro read.
> Drop them and reduce code size (on x86_64) by ~1800 bytes.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>   drivers/hwmon/max1619.c |  141 ++++++++++++++++++++++++-----------------------
>   1 file changed, 73 insertions(+), 68 deletions(-)
>
> diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
> index c8a7297..699c57d 100644
> --- a/drivers/hwmon/max1619.c
> +++ b/drivers/hwmon/max1619.c
> @@ -71,6 +71,16 @@ static int temp_to_reg(int val)
>   	return (val < 0 ? val+0x100*1000 : val) / 1000;
>   }
>
> +enum temp_index {
> +	t_input1 = 0,
> +	t_input2,
> +	t_low2,
> +	t_high2,
> +	t_crit2,
> +	t_hyst2,
> +	t_num_regs,

I dropped the comma here ...
> +};
> +
>   /*
>    * Client data (each client gets its own)
>    */
> @@ -82,35 +92,39 @@ struct max1619_data {
>   	unsigned long last_updated; /* in jiffies */
>
>   	/* registers values */
> -	u8 temp_input1; /* local */
> -	u8 temp_input2, temp_low2, temp_high2; /* remote */
> -	u8 temp_crit2;
> -	u8 temp_hyst2;
> +	u8 temp[t_num_regs];	/* index with enum temp_index */
>   	u8 alarms;
>   };
>
> +static u8 regs_read[] = {
> +	[t_input1] = MAX1619_REG_R_LOCAL_TEMP,
> +	[t_input2] = MAX1619_REG_R_REMOTE_TEMP,
> +	[t_low2] = MAX1619_REG_R_REMOTE_LOW,
> +	[t_high2] = MAX1619_REG_R_REMOTE_HIGH,
> +	[t_crit2] = MAX1619_REG_R_REMOTE_CRIT,
> +	[t_hyst2] = MAX1619_REG_R_TCRIT_HYST,
> +};
> +
> +static u8 regs_write[] = {

and made those two arrays const.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
