From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Dec 2013 16:31:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Do not return -EAGAIN for low temperatures
Message-Id: <52AC87C6.1090204@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1386439557-27341-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1386439557-27341-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 12/07/2013 10:05 AM, Guenter Roeck wrote:
> Some Intel CPUs do not set the 'valid' bit in IA32_THERM_STATUS if the
> temperature is too low to be measured. This condition will not change until
> the CPU is hot enough for its temperature to be measured. Returning an error
> in such conditions is not very useful. Drop checking the valid bit and just
> return the reported temperature instead.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I don't think we ever closed on this. Giving it a shot.
>

Comments, anyone ?

Guenter

>   drivers/hwmon/coretemp.c |   17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 310ce19..6e0579e 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -177,18 +177,19 @@ static ssize_t show_temp(struct device *dev,
>   	/* Check whether the time interval has elapsed */
>   	if (!tdata->valid || time_after(jiffies, tdata->last_updated + HZ)) {
>   		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
> -		tdata->valid = 0;
> -		/* Check whether the data is valid */
> -		if (eax & 0x80000000) {
> -			tdata->temp = tdata->tjmax -
> -					((eax >> 16) & 0x7f) * 1000;
> -			tdata->valid = 1;
> -		}
> +		/*
> +		 * Ignore the valid bit. In all observed cases the register
> +		 * value is either low or zero if the valid bit is 0.
> +		 * Return it instead of reporting an error which doesn't
> +		 * really help at all.
> +		 */
> +		tdata->temp = tdata->tjmax - ((eax >> 16) & 0x7f) * 1000;
> +		tdata->valid = 1;
>   		tdata->last_updated = jiffies;
>   	}
>
>   	mutex_unlock(&tdata->update_lock);
> -	return tdata->valid ? sprintf(buf, "%d\n", tdata->temp) : -EAGAIN;
> +	return sprintf(buf, "%d\n", tdata->temp);
>   }
>
>   struct tjmax_pci {
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
