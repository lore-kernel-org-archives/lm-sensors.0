From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 30 Oct 2012 16:54:06 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83627ehf) Get rid of smatch warnings
Message-Id: <20121030165406.GC11394@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 30, 2012 at 02:27:39PM +0100, Jean Delvare wrote:
> The smatch static code analyzer complains:
> 
> drivers/hwmon/w83627ehf.c:911 w83627ehf_update_device() error: buffer overflow 'W83627EHF_REG_TEMP_OFFSET' 3 <= 8
> drivers/hwmon/w83627ehf.c:909 w83627ehf_update_device() error: buffer overflow 'data->temp_offset' 3 <= 8
> drivers/hwmon/w83627ehf.c:2672 w83627ehf_resume() error: buffer overflow 'W83627EHF_REG_TEMP_OFFSET' 3 <= 8
> drivers/hwmon/w83627ehf.c:2673 w83627ehf_resume() error: buffer overflow 'data->temp_offset' 3 <= 8
> 
> A deeper analysis of the code shows that these are false positives, as
> only the lower 3 bits of data->have_temp_offset can be set so the
> write is never attempted with i >= 3. However this shows that the code
> isn't very robust and future changes could easily introduce a buffer
> overflow. So let's add a safety check to prevent that and make smatch
> happy.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Peter Huewe <PeterHuewe@gmx.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/w83627ehf.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- linux-3.7-rc3.orig/drivers/hwmon/w83627ehf.c	2012-10-30 12:04:16.418693691 +0100
> +++ linux-3.7-rc3/drivers/hwmon/w83627ehf.c	2012-10-30 12:33:11.500486698 +0100
> @@ -905,6 +905,8 @@ static struct w83627ehf_data *w83627ehf_
>  				data->temp_max_hyst[i]
>  				  = w83627ehf_read_temp(data,
>  						data->reg_temp_hyst[i]);
> +			if (i > 2)
> +				continue;
>  			if (data->have_temp_offset & (1 << i))
>  				data->temp_offset[i]
>  				  = w83627ehf_read_value(data,
> @@ -2670,6 +2672,8 @@ static int w83627ehf_resume(struct devic
>  		if (data->reg_temp_hyst[i])
>  			w83627ehf_write_temp(data, data->reg_temp_hyst[i],
>  					     data->temp_max_hyst[i]);
> +		if (i > 2)
> +			continue;
>  		if (data->have_temp_offset & (1 << i))
>  			w83627ehf_write_value(data,
>  					      W83627EHF_REG_TEMP_OFFSET[i],
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
