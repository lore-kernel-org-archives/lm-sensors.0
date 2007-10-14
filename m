From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 14 Oct 2007 08:36:56 +0000
Subject: Re: [lm-sensors] [patch 1/1] w83627hf hoist nr-1 offset out of
Message-Id: <20071014103656.47fc34b7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0710121550l3eef3a9dvd4ade68510ab8003@mail.gmail.com>
In-Reply-To: <cfe85dfa0710121550l3eef3a9dvd4ade68510ab8003@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Fri, 12 Oct 2007 17:56:41 -0600, Jim Cromie wrote:
> this patch replaces last, fixing (long) cast placement,
> and one previously missed (nr>=2) -> (nr)
> 
> This hoists nr-1 offset out of (show|store)_temp_*(.*) callbacks, and into
> SENSOR_DEVICE_ATTRs for sysfs tempN_X files.  It also combines
> temp[1] and temp_add[2] (array) fields in w83627hf_data into 3 elem arrays,
> which simplifies special-case handling of nr, allowing simplification
> of callback bodies and rerolling a flattened loop in
> w83627hf_update_device(struct device *dev).

Very nice cleanup, thanks.

> The array conversion changes temp[1] from u8 to u16, but this was
> happening implicitly via the helper functions anyway.
> 
> Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
> ---
> $ diffstat diff.hwmon-w83627hf-hoist-temp-offsets
>  drivers/hwmon/w83627hf.c |  120 +++++++++++++++++------------------------------
>  1 files changed, 44 insertions(+), 76 deletions(-)
> 
> 
> > size shrinks too:
> >   12982    2652      36   15670    3d36 hwmon-demacro/drivers/hwmon/w83627hf.ko
> >   12850    2652      36   15538    3cb2 hwmon-hf-2/drivers/hwmon/w83627hf.ko
> >
> > and the u8->u16 doesnt seem to cost anything in the data section. (padding?)

The struct w83627hf_data is allocated dynamically so it doesn't appear
in any section of the binary. The 3 static reg_temp arrays should show
in the data section... not sure why they don't.

Review:

> --- hwmon-demacro/drivers/hwmon/w83627hf.c	2007-10-11 16:03:10.000000000 -0600
> +++ hwmon-hf-1/drivers/hwmon/w83627hf.c	2007-10-12 17:42:11.000000000 -0600
> @@ -175,15 +175,10 @@ superio_exit(void)
>  
>  #define W83781D_REG_TEMP2_CONFIG 0x152
>  #define W83781D_REG_TEMP3_CONFIG 0x252
> -#define W83781D_REG_TEMP(nr)		((nr = 3) ? (0x0250) : \
> -					((nr = 2) ? (0x0150) : \
> -					             (0x27)))
> -#define W83781D_REG_TEMP_HYST(nr)	((nr = 3) ? (0x253) : \
> -					((nr = 2) ? (0x153) : \
> -					             (0x3A)))
> -#define W83781D_REG_TEMP_OVER(nr)	((nr = 3) ? (0x255) : \
> -					((nr = 2) ? (0x155) : \
> -					             (0x39)))
> +/* these are zero-based, unlike config constants above */
> +static u16 w83781d_reg_temp[]		= { 0x27, 0x150, 0x250 };
> +static u16 w83781d_reg_temp_hyst[]	= { 0x3A, 0x153, 0x253 };
> +static u16 w83781d_reg_temp_over[]	= { 0x39, 0x155, 0x255 };

Could be made const. Please also name these w83627hf_reg_* instead of
w83781d_reg_*. Ultimately we want to remove all references to w83781d
from this driver.

>  
>  #define W83781D_REG_BANK 0x4E
>  
> @@ -360,12 +355,9 @@ struct w83627hf_data {
>  	u8 in_min[9];		/* Register value */
>  	u8 fan[3];		/* Register value */
>  	u8 fan_min[3];		/* Register value */
> -	u8 temp;
> -	u8 temp_max;		/* Register value */
> -	u8 temp_max_hyst;	/* Register value */
> -	u16 temp_add[2];	/* Register value */
> -	u16 temp_max_add[2];	/* Register value */
> -	u16 temp_max_hyst_add[2]; /* Register value */
> +	u16 temp[3];

These are register values as well.

> +	u16 temp_max[3];	/* Register value */
> +	u16 temp_max_hyst[3];	/* Register value */
>  	u8 fan_div[3];		/* Register encoding, shifted right */
>  	u8 vid;			/* Register encoding, combined */
>  	u32 alarms;		/* Register encoding, combined */
> @@ -610,12 +602,10 @@ show_temp(struct device *dev, struct dev
>  {
>  	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> -		return sprintf(buf, "%ld\n",
> -			(long)LM75_TEMP_FROM_REG(data->temp_add[nr-2]));
> -	} else {	/* TEMP1 */
> -		return sprintf(buf, "%ld\n", (long)TEMP_FROM_REG(data->temp));
> -	}
> +
> +	u16 tmp = data->temp[nr];
> +	return sprintf(buf, "%ld\n", (nr) ? (long) LM75_TEMP_FROM_REG(tmp)
> +					  : (long) TEMP_FROM_REG(tmp));
>  }
>  
>  static ssize_t
> @@ -624,13 +614,10 @@ show_temp_max(struct device *dev, struct
>  {
>  	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> -		return sprintf(buf, "%ld\n",
> -			(long)LM75_TEMP_FROM_REG(data->temp_max_add[nr-2]));
> -	} else {	/* TEMP1 */
> -		return sprintf(buf, "%ld\n",
> -			(long)TEMP_FROM_REG(data->temp_max));
> -	}
> +
> +	u16 tmp = data->temp_max[nr];
> +	return sprintf(buf, "%ld\n", (nr) ? (long) LM75_TEMP_FROM_REG(tmp)
> +					  : (long) TEMP_FROM_REG(tmp));
>  }
>  
>  static ssize_t
> @@ -639,13 +626,10 @@ show_temp_max_hyst(struct device *dev, s
>  {
>  	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> -		return sprintf(buf, "%ld\n",
> -			(long)LM75_TEMP_FROM_REG(data->temp_max_hyst_add[nr-2]));
> -	} else {	/* TEMP1 */
> -		return sprintf(buf, "%ld\n",
> -			(long)TEMP_FROM_REG(data->temp_max_hyst));
> -	}
> +
> +	u16 tmp = data->temp_max_hyst[nr];
> +	return sprintf(buf, "%ld\n", (nr) ? (long) LM75_TEMP_FROM_REG(tmp)
> +					  : (long) TEMP_FROM_REG(tmp));
>  }
>  
>  static ssize_t
> @@ -655,18 +639,16 @@ store_temp_max(struct device *dev, struc
>  	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
> +	u16 tmp;
>  
>  	mutex_lock(&data->update_lock);
>  
> -	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> -		data->temp_max_add[nr-2] = LM75_TEMP_TO_REG(val);
> -		w83627hf_write_value(data, W83781D_REG_TEMP_OVER(nr),
> -				data->temp_max_add[nr-2]);
> -	} else {	/* TEMP1 */
> -		data->temp_max = TEMP_TO_REG(val);
> -		w83627hf_write_value(data, W83781D_REG_TEMP_OVER(nr),
> -			data->temp_max);
> -	}
> +	tmp = (nr) ? LM75_TEMP_TO_REG(val)
> +		   : TEMP_TO_REG(val);

This instruction could be moved outside of the lock-holding section.

> +
> +	data->temp_max[nr] = tmp;
> +	w83627hf_write_value(data, w83781d_reg_temp_over[nr], tmp);
> +
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> @@ -678,29 +660,27 @@ store_temp_max_hyst(struct device *dev, 
>  	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  	long val = simple_strtol(buf, NULL, 10);
> +	u16 tmp;
>  
>  	mutex_lock(&data->update_lock);
>  
> -	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> -		data->temp_max_hyst_add[nr-2] = LM75_TEMP_TO_REG(val);
> -		w83627hf_write_value(data, W83781D_REG_TEMP_HYST(nr),
> -				data->temp_max_hyst_add[nr-2]);
> -	} else {	/* TEMP1 */
> -		data->temp_max_hyst = TEMP_TO_REG(val);
> -		w83627hf_write_value(data, W83781D_REG_TEMP_HYST(nr),
> -			data->temp_max_hyst);
> -	}
> +	tmp = (nr) ? LM75_TEMP_TO_REG(val)
> +		   : TEMP_TO_REG(val);

Same here.

> +
> +	data->temp_max_hyst[nr] = tmp;
> +	w83627hf_write_value(data, w83781d_reg_temp_hyst[nr], tmp);
> +
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
>  
>  #define sysfs_temp_decl(offset) \
>  static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
> -			  show_temp, NULL, offset);			\
> +			  show_temp, NULL, offset - 1);			\
>  static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO|S_IWUSR,	 	\
> -			  show_temp_max, store_temp_max, offset);	\
> +			  show_temp_max, store_temp_max, offset - 1);	\
>  static SENSOR_DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO|S_IWUSR,	\
> -			  show_temp_max_hyst, store_temp_max_hyst, offset);
> +			  show_temp_max_hyst, store_temp_max_hyst, offset - 1);
>  
>  sysfs_temp_decl(1);
>  sysfs_temp_decl(2);
> @@ -1543,7 +1523,7 @@ static void __devinit w83627hf_init_devi
>  static struct w83627hf_data *w83627hf_update_device(struct device *dev)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> -	int i;
> +	int i, num_temps = (data->type = w83697hf) ? 2 : 3;
>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -1596,25 +1576,13 @@ static struct w83627hf_data *w83627hf_up
>  					break;
>  			}
>  		}
> -
> -		data->temp = w83627hf_read_value(data, W83781D_REG_TEMP(1));
> -		data->temp_max > -		    w83627hf_read_value(data, W83781D_REG_TEMP_OVER(1));
> -		data->temp_max_hyst > -		    w83627hf_read_value(data, W83781D_REG_TEMP_HYST(1));
> -		data->temp_add[0] > -		    w83627hf_read_value(data, W83781D_REG_TEMP(2));
> -		data->temp_max_add[0] > -		    w83627hf_read_value(data, W83781D_REG_TEMP_OVER(2));
> -		data->temp_max_hyst_add[0] > -		    w83627hf_read_value(data, W83781D_REG_TEMP_HYST(2));
> -		if (data->type != w83697hf) {
> -			data->temp_add[1] > -			  w83627hf_read_value(data, W83781D_REG_TEMP(3));
> -			data->temp_max_add[1] > -			  w83627hf_read_value(data, W83781D_REG_TEMP_OVER(3));
> -			data->temp_max_hyst_add[1] > -			  w83627hf_read_value(data, W83781D_REG_TEMP_HYST(3));
> +		for (i=0; i<num_temps; i++) {

Coding style: add spaces around "=" and "<".

> +			data->temp[i] = w83627hf_read_value(
> +						data, w83781d_reg_temp[i]);
> +			data->temp_max[i] = w83627hf_read_value(
> +						data, w83781d_reg_temp_over[i]);
> +			data->temp_max_hyst[i] = w83627hf_read_value(
> +						data, w83781d_reg_temp_hyst[i]);
>  		}
>  
>  		i = w83627hf_read_value(data, W83781D_REG_VID_FANDIV);

Other than these minor things, the patch looks OK and testing is OK as
well. Please send an updated version and I'll ack it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
