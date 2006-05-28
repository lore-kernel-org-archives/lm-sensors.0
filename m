From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 28 May 2006 15:03:34 +0000
Subject: [lm-sensors] [PATCH] Fix the set pwm value will change fan mode
Message-Id: <20060528170334.0ebe83a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <444610F0.1070809@winbond.com.tw>
In-Reply-To: <444610F0.1070809@winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

> W83792D use pwm register low 4 bits to store fan PWM/DC
> value, bit 7 is used to store fan PWM/DC mode. The store_pwm
> function use a wrong limit 0-255, so it may change the fan
> mode when set value is large than 127.

Good catch, thanks for working on this (and sorry for the late answer.)

> This fix the problem. Change the "index" value of
> pwm*_mode and pwm* SENSOR_ATTR to simplify code.

That's not totally correct, unfortunately.

> --- linux-2.6.17-rc2.orig/drivers/hwmon/w83792d.c	2006-04-19 18:04:04.000000000 +0800
> +++ linux-2.6.17-rc2/drivers/hwmon/w83792d.c	2006-04-19 18:07:05.000000000 +0800
> @@ -250,8 +250,6 @@ FAN_TO_REG(long rpm, int div)
>   			: (val)) / 1000, 0, 0xff))
>   #define TEMP_ADD_TO_REG_LOW(val)	((val%1000) ? 0x80 : 0x00)
> 
> -#define PWM_FROM_REG(val)		(val)
> -#define PWM_TO_REG(val)			(SENSORS_LIMIT((val),0,255))
>   #define DIV_FROM_REG(val)		(1 << (val))
> 
>   static inline u8
> @@ -288,10 +286,8 @@ struct w83792d_data {
>   	u8 temp1[3];		/* current, over, thyst */
>   	u8 temp_add[2][6];	/* Register value */
>   	u8 fan_div[7];		/* Register encoding, shifted right */
> -	u8 pwm[7];		/* We only consider the first 3 set of pwm,
> -				   although 792 chip has 7 set of pwm. */
> +	u8 pwm[7];		/* Register value */

The comment still seems valid to me, pwm4-7 aren't handled by the
driver, right?

>   	u8 pwmenable[3];
> -	u8 pwm_mode[7];		/* indicates PWM or DC mode: 1->PWM; 0->DC */
>   	u32 alarms;		/* realtime status register encoding,combined */
>   	u8 chassis;		/* Chassis status */
>   	u8 chassis_clear;	/* CLR_CHS, clear chassis intrusion detection */
> @@ -627,7 +623,8 @@ show_pwm(struct device *dev, struct devi
>   	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>   	int nr = sensor_attr->index;
>   	struct w83792d_data *data = w83792d_update_device(dev);
> -	return sprintf(buf, "%ld\n", (long) PWM_FROM_REG(data->pwm[nr-1]));
> +
> +	return sprintf(buf, "%d\n", data->pwm[nr] & 0x0f);
>   }

No, Documentation/hwmon/sysfs-interface says that the PWM values must
range from 0 (fan stopped) to 255 (fan at full speed). Here you range
from 0 to 15 only. You must scale the result so that it fits the
standard range.

> 
>   static ssize_t
> @@ -659,14 +656,16 @@ store_pwm(struct device *dev, struct dev
>   		const char *buf, size_t count)
>   {
>   	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> -	int nr = sensor_attr->index - 1;
> +	int nr = sensor_attr->index;
>   	struct i2c_client *client = to_i2c_client(dev);
>   	struct w83792d_data *data = i2c_get_clientdata(client);
> -	u32 val;
> +	u8 val = data->pwm[nr] & 0xf0;
> 
> -	val = simple_strtoul(buf, NULL, 10);
> -	data->pwm[nr] = PWM_TO_REG(val);
> -	w83792d_write_value(client, W83792D_REG_PWM[nr], data->pwm[nr]);
> +	val |= SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 0x0f);
> +	if (val != data->pwm[nr]) {
> +		data->pwm[nr] = val;
> +		w83792d_write_value(client, W83792D_REG_PWM[nr], val);
> +	}
> 
>   	return count;
>   }

The write shouldn't be conditional. You base your condition on a cached
value, which can be very old if the user didn't read any register
lately. And you should be holding the lock here, else data->pwm[nr] may
change in your back.

Please also keep in mind that the allowed input range IS 0 to 255, as
per interface specification. It is the driver's job to scale it to what
the chip expects.

> @@ -707,9 +706,9 @@ store_pwmenable(struct device *dev, stru
>   }
> 
>   static struct sensor_device_attribute sda_pwm[] = {
> -	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1),
> -	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2),
> -	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3),
> +	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0),
> +	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1),
> +	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2),
>   };
>   static struct sensor_device_attribute sda_pwm_enable[] = {
>   	SENSOR_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
> @@ -728,7 +727,7 @@ show_pwm_mode(struct device *dev, struct
>   	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
>   	int nr = sensor_attr->index;
>   	struct w83792d_data *data = w83792d_update_device(dev);
> -	return sprintf(buf, "%d\n", data->pwm_mode[nr-1]);
> +	return sprintf(buf, "%d\n", data->pwm[nr] >> 7);
>   }
> 
>   static ssize_t
> @@ -736,29 +735,28 @@ store_pwm_mode(struct device *dev, struc
>   			const char *buf, size_t count)
>   {
>   	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> -	int nr = sensor_attr->index - 1;
> +	int nr = sensor_attr->index;
>   	struct i2c_client *client = to_i2c_client(dev);
>   	struct w83792d_data *data = i2c_get_clientdata(client);
> -	u32 val;
> -	u8 pwm_mode_mask = 0;
> +	u8 val = data->pwm[nr] & 0x7f;
> 
> -	val = simple_strtoul(buf, NULL, 10);
> -	data->pwm_mode[nr] = SENSORS_LIMIT(val, 0, 1);
> -	pwm_mode_mask = w83792d_read_value(client,
> -		W83792D_REG_PWM[nr]) & 0x7f;
> -	w83792d_write_value(client, W83792D_REG_PWM[nr],
> -		((data->pwm_mode[nr]) << 7) | pwm_mode_mask);
> +	val |= SENSORS_LIMIT(simple_strtol(buf, NULL, 10), 0, 1) ? 0x80 : 0;
> +
> +	if (val != data->pwm[nr]) {
> +		data->pwm[nr] = val;
> +		w83792d_write_value(client, W83792D_REG_PWM[nr], val);
> +	}
> 
>   	return count;
>   }

Same here, write should be unconditional, and you should be holding the
lock. Also, you don't want to use SENSORS_LIMIT here. Instead, reject
invalid values (return -EINVAL).

> 
>   static struct sensor_device_attribute sda_pwm_mode[] = {
>   	SENSOR_ATTR(pwm1_mode, S_IWUSR | S_IRUGO,
> -		    show_pwm_mode, store_pwm_mode, 1),
> +		    show_pwm_mode, store_pwm_mode, 0),
>   	SENSOR_ATTR(pwm2_mode, S_IWUSR | S_IRUGO,
> -		    show_pwm_mode, store_pwm_mode, 2),
> +		    show_pwm_mode, store_pwm_mode, 1),
>   	SENSOR_ATTR(pwm3_mode, S_IWUSR | S_IRUGO,
> -		    show_pwm_mode, store_pwm_mode, 3),
> +		    show_pwm_mode, store_pwm_mode, 2),
>   };
> 
> 
> @@ -1373,7 +1371,7 @@ static struct w83792d_data *w83792d_upda
>   	struct i2c_client *client = to_i2c_client(dev);
>   	struct w83792d_data *data = i2c_get_clientdata(client);
>   	int i, j;
> -	u8 reg_array_tmp[4], pwm_array_tmp[7], reg_tmp;
> +	u8 reg_array_tmp[4], reg_tmp;
> 
>   	mutex_lock(&data->update_lock);
> 
> @@ -1402,10 +1400,8 @@ static struct w83792d_data *w83792d_upda
>   			data->fan_min[i] = w83792d_read_value(client,
>   						W83792D_REG_FAN_MIN[i]);
>   			/* Update the PWM/DC Value and PWM/DC flag */
> -			pwm_array_tmp[i] = w83792d_read_value(client,
> +			data->pwm[i] = w83792d_read_value(client,
>   						W83792D_REG_PWM[i]);
> -			data->pwm[i] = pwm_array_tmp[i] & 0x0f;
> -			data->pwm_mode[i] = pwm_array_tmp[i] >> 7;
>   		}
> 
>   		reg_tmp = w83792d_read_value(client, W83792D_REG_FAN_CFG);
> @@ -1513,7 +1509,6 @@ static void w83792d_print_debug(struct w
>   		dev_dbg(dev, "fan[%d] is: 0x%x\n", i, data->fan[i]);
>   		dev_dbg(dev, "fan[%d] min is: 0x%x\n", i, data->fan_min[i]);
>   		dev_dbg(dev, "pwm[%d]     is: 0x%x\n", i, data->pwm[i]);
> -		dev_dbg(dev, "pwm_mode[%d] is: 0x%x\n", i, data->pwm_mode[i]);
>   	}
>   	dev_dbg(dev, "3 set of Temperatures: ===>\n");
>   	for (i=0; i<3; i++) {

I'm fine with all the other changes. Care to update this patch, test it
and submit it again?

Thanks,
-- 
Jean Delvare

