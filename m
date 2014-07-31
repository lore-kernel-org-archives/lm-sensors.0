From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 31 Jul 2014 06:35:32 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm92) Prevent overflow problem when writing large limits
Message-Id: <53D9E3B4.1020400@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406716501.28163.3.camel@phoenix>
In-Reply-To: <1406716501.28163.3.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/30/2014 03:35 AM, Axel Lin wrote:
> On platforms with sizeof(int) < sizeof(long), writing a temperature
> limit larger than MAXINT will result in unpredictable limit values
> written to the chip. Avoid auto-conversion from long to int to fix
> the problem.
>
> Also uses clamp_val to simplify the code a bit.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/hwmon/lm92.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
> index d2060e2..3dbced2 100644
> --- a/drivers/hwmon/lm92.c
> +++ b/drivers/hwmon/lm92.c
> @@ -74,12 +74,9 @@ static inline int TEMP_FROM_REG(s16 reg)
>   	return reg / 8 * 625 / 10;
>   }
>
> -static inline s16 TEMP_TO_REG(int val)
> +static inline s16 TEMP_TO_REG(long val)
>   {
> -	if (val <= -60000)
> -		return -60000 * 10 / 625 * 8;
> -	if (val >= 160000)
> -		return 160000 * 10 / 625 * 8;
> +	val = clamp_val(val, -60000, 160000);
>   	return val * 10 / 625 * 8;
>   }
>

Still something wrong.

With your patch applied, I still get:

temp1_crit_hyst: Suspected overflow: [-95000 vs. -33000 ]

This is triggered by writing 100000000 and then 4294967296000 into the attribute.
Problem seems to be that the hysteresis write function does not clamp the value
it gets from the user, which triggers another overflow. Overall I think it would
probably be better to clamp the values to the supported limits first, and only
then translate the result into register values.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
