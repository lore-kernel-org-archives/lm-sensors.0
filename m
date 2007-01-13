From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 13 Jan 2007 19:24:24 +0000
Subject: [lm-sensors] [PATCH] W83793: ignore the temperature readings
Message-Id: <20070113202424.06329baa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45A77F63.5080808@assembler.cz>
In-Reply-To: <45A77F63.5080808@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf, Gong,

On Fri, 12 Jan 2007 13:30:27 +0100, Rudolf Marek wrote:
> w83793: ignore the temperature readings when its channel is disabled.
> 
> Signed-off-by: Gong Jun <jgong at winbond.com>
> Signed-off-by: Rudolf Marek <r.marek at assembler.cz>
> 
> Looks OK to me, Jean. I just fixed the the indentation, strip version to p1, and
> renamed the temp_enable to has_temp, to be coherent with what he have until now.
> Please apply.

Hm, the patch is incomplete. The following changes are missing:
* The temp files are no longer deleted if an error occurs in
  w83793_detect().
* The temp files are no longer deleted when the driver in unloaded.
* All the temperature registers are still read in w83793_update_device()
  and w83793_update_nonvolatile(). It would be better to skip the
  unused temperature registers to speed up the functions.
* The user still has the possibility to change the temperature sensor
  type. This is confusing because the driver will not react properly
  if the user disables a temperature channel that was previously
  enabled. So we should no longer let the user set the temperature
  sensor types to 0.

I also have minor comments on the code:

> @@ -1320,6 +1325,30 @@
>  		data->has_pwm |= 0x80;
>  	}
>  
> +	/* check the temp1-6 mode */
> +	data->has_temp = 0;

Not needed, kzalloc() zeroed it for you.

> +
> +	tmp = w83793_read_value(client,W83793_REG_TEMP_MODE[0]);
> +
> +	if (tmp & 0x03)
> +		data->has_temp |= 0x01;
> +
> +	if (tmp & 0x0c)
> +		data->has_temp |= 0x02;
> +
> +	if (tmp & 0x30)
> +		data->has_temp |= 0x04;
> +
> +	if (tmp & 0xc0)
> +		data->has_temp |= 0x08;

A few less blank lines would be welcome, as all these instructions are
related.

> +
> +	tmp = w83793_read_value(client,W83793_REG_TEMP_MODE[1]);
> +
> +	if (tmp & 0x01)
> +		data->has_temp |= 0x10;
> +	if (tmp & 0x02)
> +		data->has_temp |= 0x20;
> +
>  	/* Register sysfs hooks */
>  	for (i = 0; i < ARRAY_SIZE(w83793_sensor_attr_2); i++) {
>  		err = device_create_file(dev,

Please add the missing parts, test again and send the updated patch to
me.

Thanks,
-- 
Jean Delvare

