From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Nov 2010 09:17:13 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <20101130101713.31398e28@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Gabriele,

On Mon, 29 Nov 2010 17:49:38 -0800, Gabriele Gorla wrote:
> Prevent setting fan_div from stomping on other fans that share the same i2c register. 
> Also allow div=1 (this is allowed in the ADM1026 datasheet) and prevent the mutex lock 
> when no update is necessary.
> 
> Signed-off-by: Gabriele Gorla <gorlik at penguintown.net>

Thanks for the patch. It's hard to believe the code has been broken for
so long and nobody complained...

Please run your patch through scripts/checkpatch.pl, and fix all the
style errors before you resubmit.

> ---
> 
> 
> diff -r -U 5 linux-source-2.6.26_orig/drivers/hwmon/adm1026.c linux-source-2.6.26/drivers/hwmon/adm1026.c
> --- linux-source-2.6.26_orig/drivers/hwmon/adm1026.c	2008-07-13 14:51:29.000000000 -0700
> +++ linux-source-2.6.26/drivers/hwmon/adm1026.c	2010-11-29 17:21:06.000000000 -0800
> @@ -918,37 +918,42 @@
>  {
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>  	int nr = sensor_attr->index;
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct adm1026_data *data = i2c_get_clientdata(client);
> -	int val, orig_div, new_div, shift;
> +	int val, orig_div, new_div;
>  
>  	val = simple_strtol(buf, NULL, 10);
> -	new_div = DIV_TO_REG(val);
> -	if (new_div = 0) {
> -		return -EINVAL;
> -	}
> -	mutex_lock(&data->update_lock);
> -	orig_div = data->fan_div[nr];
> -	data->fan_div[nr] = DIV_FROM_REG(new_div);
>  
> -	if (nr < 4) { /* 0 <= nr < 4 */
> -		shift = 2 * nr;
> -		adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
> -			((DIV_TO_REG(orig_div) & (~(0x03 << shift))) |
> -			(new_div << shift)));
> -	} else { /* 3 < nr < 8 */
> -		shift = 2 * (nr - 4);
> -		adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
> -			((DIV_TO_REG(orig_div) & (~(0x03 << (2 * shift)))) |
> -			(new_div << shift)));
> +	if(val<1 || val>8) {
> +	        return -EINVAL;

As underlined by Phil already, this is a little inconsistent. You
should reject all invalid values, as documented at the end of
Documentation/hwmon/sysfs-interface. But this should be done in a
separate patch, as this isn't really a bug fix and changes the driver's
behavior on invalid input.

>  	}
>  
> -	if (data->fan_div[nr] != orig_div) {
> +	new_div = DIV_TO_REG(val);
> +	if(data->fan_div[nr]!=DIV_FROM_REG(new_div)) {
> +

Undue blank line.

> +	        mutex_lock(&data->update_lock);
> +		orig_div = data->fan_div[nr];
> +		data->fan_div[nr] = DIV_FROM_REG(new_div);
> +
> +		if (nr < 4) { /* 0 <= nr < 4 */
> +		        adm1026_write_value(client, ADM1026_REG_FAN_DIV_0_3,
> +				    (DIV_TO_REG(data->fan_div[0]) << 0) |
> +				    (DIV_TO_REG(data->fan_div[1]) << 2) |
> +				    (DIV_TO_REG(data->fan_div[2]) << 4) |
> +				    (DIV_TO_REG(data->fan_div[3]) << 6) );
> +		} else { /* 3 < nr < 8 */
> +		        adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
> +				    (DIV_TO_REG(data->fan_div[4]) << 0) |
> +				    (DIV_TO_REG(data->fan_div[5]) << 2) |
> +				    (DIV_TO_REG(data->fan_div[6]) << 4) |
> +				    (DIV_TO_REG(data->fan_div[7]) << 6) );
> +		}

Note: this is horribly inefficient. In my opinion, data->fan_div should
hold split but un-decoded register values. Calling DIV_FROM_REG() is
cheap, calling DIV_TO_REG() is expensive. In fact DIV_TO_REG()
shouldn't exist in the first place, as the conversion should happen in
a single place. Again, this is material for a separate patch.

> +		
>  		fixup_fan_min(dev, nr, orig_div);
> +		mutex_unlock(&data->update_lock);
>  	}
> -	mutex_unlock(&data->update_lock);
>  	return count;
>  }
>  
>  #define fan_offset_div(offset)						\
>  static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
