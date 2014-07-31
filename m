From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 31 Jul 2014 05:48:39 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (lm77) Prevent overflow problem when writing large limits
Message-Id: <53D9D8B7.1000501@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1406716429.28163.1.camel@phoenix>
In-Reply-To: <1406716429.28163.1.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 07/30/2014 03:33 AM, Axel Lin wrote:
> On platforms with sizeof(int) < sizeof(long), writing a temperature
> limit larger than MAXINT will result in unpredictable limit values
> written to the chip. Avoid auto-conversion from long to int to fix
> the problem.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/hwmon/lm77.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
> index 5ceb443..a9ad5cd 100644
> --- a/drivers/hwmon/lm77.c
> +++ b/drivers/hwmon/lm77.c
> @@ -78,7 +78,7 @@ struct lm77_data {
>    * In the temperature registers, the low 3 bits are not part of the
>    * temperature values; they are the status bits.
>    */
> -static inline s16 LM77_TEMP_TO_REG(int temp)
> +static inline s16 LM77_TEMP_TO_REG(long temp)
>   {
>   	int ntemp = clamp_val(temp, LM77_TEMP_MIN, LM77_TEMP_MAX);
>   	return (ntemp / 500) * 8;
>

This driver is way more broken than that. Looking into the code,
the following is typical.

         data->temp[nr] = val;
         lm77_write_value(client, temp_regs[nr], LM77_TEMP_TO_REG(val));

This means the clamp is only applied after the value is already stored.
Sure, that will "fix" itself after the next register update cycle,
but it is still wrong.

Easy fix might be to set 'valid' to 0 instead of writing data->temp[].
But writing the hysteresis value is bad even in this case, since its
calculation is also prone to overflows.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
