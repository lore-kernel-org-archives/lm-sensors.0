From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 30 May 2006 07:25:40 +0000
Subject: [lm-sensors] [PATCH] Fix the set pwm value will change fan mode
Message-Id: <20060530092540.2205ea93.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <444610F0.1070809@winbond.com.tw>
In-Reply-To: <444610F0.1070809@winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> Here comes the patch, please can you check, i add the lock and allow fan
> pwm input range 0-255 here, the write also unconditional, please can you check :)

Thanks for the updated patch. There are a few new issues in
store_pwm_mode:

> @@ -736,29 +735,34 @@ store_pwm_mode(struct device *dev, struc
>  			const char *buf, size_t count)
>  {
>  	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> -	int nr = sensor_attr->index - 1;
> +	int nr = sensor_attr->index;
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct w83792d_data *data = i2c_get_clientdata(client);
> -	u32 val;
> -	u8 pwm_mode_mask = 0;
> +	u32 val = simple_strtoul(buf, NULL, 10);
> 
> -	val = simple_strtoul(buf, NULL, 10);
> -	data->pwm_mode[nr] = SENSORS_LIMIT(val, 0, 1);
> -	pwm_mode_mask = w83792d_read_value(client,
> -		W83792D_REG_PWM[nr]) & 0x7f;
> -	w83792d_write_value(client, W83792D_REG_PWM[nr],
> -		((data->pwm_mode[nr]) << 7) | pwm_mode_mask);
> +	mutex_lock(&data->update_lock);
> +	data->pwm[nr] = w83792d_read_value(client, W83792D_REG_PWM[nr]);
> +	if (0 = val) {			/* DC mode */
> +		data->pwm[nr] &= 0x7f;
> +	} else if (1 = val) {		/* PWM mode */
> +		data->pwm[nr] = (data->pwm[nr] & 0x7f) | 0x80;

Equivalent to:
		data->pwm[nr] |= 0x80;

> +	} else {
> +		return -EINVAL;

You return with the update lock held! It's easier to test the input
value for validity before taking the lock, this avoids that kind of
trap and is also more efficient.

> +	}
> +
> +	w83792d_write_value(client, W83792D_REG_PWM[nr], data->pwm[nr]);
> +	mutex_unlock(&data->update_lock);
> 
>  	return count;
>  }

I've fixed both issues and applied your patch:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-w83792d-pwm-set-fix.patch

Rudolf, parts of this patch should be ported back to the Linux 2.4
version of the driver. Please take care of this once our new Subversion
repository is usable.

Thanks,
-- 
Jean Delvare

