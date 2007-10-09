From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Oct 2007 21:32:05 +0000
Subject: Re: [lm-sensors] [patch 1/1] de-macro w83627hf
Message-Id: <20071009233205.7519b061@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0709301138u30442dbch1f2508c4c8ccf337@mail.gmail.com>
In-Reply-To: <cfe85dfa0709301138u30442dbch1f2508c4c8ccf337@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark, hi Jim,

On Tue, 9 Oct 2007 09:04:02 -0400, Mark M. Hoffman wrote:
> * Jean Delvare <khali@linux-fr.org> [2007-10-02 12:50:55 +0200]:
> > Once you send a patch that I can apply on top of Mark's tree, I'll
> > review it.
> 
> Here you go, I merged it for you.  Or git did, but I resolved one conflict.

OK, thank you. After reviewing and testing, here are the problems I've found:

> diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
> index a2ccf93..75e8904 100644
> --- a/drivers/hwmon/w83627hf.c
> +++ b/drivers/hwmon/w83627hf.c
> @@ -45,6 +45,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/platform_device.h>
>  #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <linux/hwmon-vid.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> @@ -218,7 +219,7 @@ static const u8 regpwm_627hf[] = { W83627HF_REG_PWM1, W83627HF_REG_PWM2 };
>  static const u8 regpwm[] = { W83627THF_REG_PWM1, W83627THF_REG_PWM2,
>                               W83627THF_REG_PWM3 };
>  #define W836X7HF_REG_PWM(type, nr) (((type) = w83627hf) ? \
> -                                     regpwm_627hf[(nr) - 1] : regpwm[(nr) - 1])
> +                                     regpwm_627hf[nr] : regpwm[nr])

Tabs should be used for indentation (not introduced by your patch but
still worth fixing.)

>  
>  #define W83627HF_REG_PWM_FREQ		0x5C	/* Only for the 627HF */
>  
> @@ -400,72 +401,71 @@ static struct platform_driver w83627hf_driver = {
>  	.remove		= __devexit_p(w83627hf_remove),
>  };
>  
> -/* following are the sysfs callback functions */
> -#define show_in_reg(reg) \
> -static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> -{ \
> -	struct w83627hf_data *data = w83627hf_update_device(dev); \
> -	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
> +static ssize_t
> +show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->in[nr]));

Missing space after comma (not introduced by your patch but still worth
fixing.)

>  }
> -show_in_reg(in)
> -show_in_reg(in_min)
> -show_in_reg(in_max)
> -
> -#define store_in_reg(REG, reg) \
> -static ssize_t \
> -store_in_##reg (struct device *dev, const char *buf, size_t count, int nr) \
> -{ \
> -	struct w83627hf_data *data = dev_get_drvdata(dev); \
> -	u32 val; \
> -	 \
> -	val = simple_strtoul(buf, NULL, 10); \
> -	 \
> -	mutex_lock(&data->update_lock); \
> -	data->in_##reg[nr] = IN_TO_REG(val); \
> -	w83627hf_write_value(data, W83781D_REG_IN_##REG(nr), \
> -			    data->in_##reg[nr]); \
> -	 \
> -	mutex_unlock(&data->update_lock); \
> -	return count; \
> +static ssize_t
> +show_in_min(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", (long)IN_FROM_REG(data->in_min[nr]));
> +}
> +static ssize_t
> +show_in_max(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", (long)IN_FROM_REG(data->in_max[nr]));
>  }
> -store_in_reg(MIN, min)
> -store_in_reg(MAX, max)
> +static ssize_t
> +store_in_min(struct device *dev, struct device_attribute *devattr,
> +	     const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = dev_get_drvdata(dev);
> +	long val = simple_strtol(buf, NULL, 10);
>  
> -#define sysfs_in_offset(offset) \
> -static ssize_t \
> -show_regs_in_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -        return show_in(dev, buf, offset); \
> -} \
> -static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
> +	mutex_lock(&data->update_lock);
> +	data->in_min[nr] = IN_TO_REG(val);
> +	w83627hf_write_value(data, W83781D_REG_IN_MIN(nr), data->in_min[nr]);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +static ssize_t
> +store_in_max(struct device *dev, struct device_attribute *devattr,
> +	     const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = dev_get_drvdata(dev);
> +	long val = simple_strtol(buf, NULL, 10);
>  
> -#define sysfs_in_reg_offset(reg, offset) \
> -static ssize_t show_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_in_##reg (dev, buf, offset); \
> -} \
> -static ssize_t \
> -store_regs_in_##reg##offset (struct device *dev, struct device_attribute *attr, \
> -			    const char *buf, size_t count) \
> -{ \
> -	return store_in_##reg (dev, buf, count, offset); \
> -} \
> -static DEVICE_ATTR(in##offset##_##reg, S_IRUGO| S_IWUSR, \
> -		  show_regs_in_##reg##offset, store_regs_in_##reg##offset);
> -
> -#define sysfs_in_offsets(offset) \
> -sysfs_in_offset(offset) \
> -sysfs_in_reg_offset(min, offset) \
> -sysfs_in_reg_offset(max, offset)
> -
> -sysfs_in_offsets(1);
> -sysfs_in_offsets(2);
> -sysfs_in_offsets(3);
> -sysfs_in_offsets(4);
> -sysfs_in_offsets(5);
> -sysfs_in_offsets(6);
> -sysfs_in_offsets(7);
> -sysfs_in_offsets(8);
> +	mutex_lock(&data->update_lock);
> +	data->in_max[nr] = IN_TO_REG(val);
> +	w83627hf_write_value(data, W83781D_REG_IN_MAX(nr), data->in_max[nr]);
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +#define sysfs_vin_decl(offset) \
> +static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
> +			  show_in_input, NULL, offset);		\
> +static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO|S_IWUSR,	\
> +			  show_in_min, store_in_min, offset);	\
> +static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO|S_IWUSR,	\
> +			  show_in_max, store_in_max, offset);
> +
> +sysfs_vin_decl(1);
> +sysfs_vin_decl(2);
> +sysfs_vin_decl(3);
> +sysfs_vin_decl(4);
> +sysfs_vin_decl(5);
> +sysfs_vin_decl(6);
> +sysfs_vin_decl(7);
> +sysfs_vin_decl(8);
>  
>  /* use a different set of functions for in0 */
>  static ssize_t show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
> @@ -563,134 +563,148 @@ static DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
>  static DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
>  	show_regs_in_max0, store_regs_in_max0);
>  
> -#define show_fan_reg(reg) \
> -static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> -{ \
> -	struct w83627hf_data *data = w83627hf_update_device(dev); \
> -	return sprintf(buf,"%ld\n", \
> -		FAN_FROM_REG(data->reg[nr-1], \
> -			    (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
> +static ssize_t
> +show_fan_input(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", FAN_FROM_REG(data->fan[nr],
> +				(long)DIV_FROM_REG(data->fan_div[nr])));
> +}
> +static ssize_t
> +show_fan_min(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", FAN_FROM_REG(data->fan_min[nr],
> +				(long)DIV_FROM_REG(data->fan_div[nr])));
>  }
> -show_fan_reg(fan);
> -show_fan_reg(fan_min);
> -
>  static ssize_t
> -store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
> +store_fan_min(struct device *dev, struct device_attribute *devattr,
> +	      const char *buf, size_t count)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> -	u32 val;
> -
> -	val = simple_strtoul(buf, NULL, 10);
> +	u32 val = simple_strtoul(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> -	data->fan_min[nr - 1] > -	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
> -	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr),
> -			    data->fan_min[nr - 1]);
> +	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
> +	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr+1),
> +			     data->fan_min[nr]);
>  
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
> +#define sysfs_fan_decl(offset)	\
> +static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,			\
> +			  show_fan_input, NULL, offset - 1);		\
> +static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
> +			  show_fan_min, store_fan_min, offset - 1);
>  
> -#define sysfs_fan_offset(offset) \
> -static ssize_t show_regs_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_fan(dev, buf, offset); \
> -} \
> -static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
> +sysfs_fan_decl(1);
> +sysfs_fan_decl(2);
> +sysfs_fan_decl(3);
>  
> -#define sysfs_fan_min_offset(offset) \
> -static ssize_t show_regs_fan_min##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_fan_min(dev, buf, offset); \
> -} \
> -static ssize_t \
> -store_regs_fan_min##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
> -{ \
> -	return store_fan_min(dev, buf, count, offset); \
> -} \
> -static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
> -		  show_regs_fan_min##offset, store_regs_fan_min##offset);
> -
> -sysfs_fan_offset(1);
> -sysfs_fan_min_offset(1);
> -sysfs_fan_offset(2);
> -sysfs_fan_min_offset(2);
> -sysfs_fan_offset(3);
> -sysfs_fan_min_offset(3);
> -
> -#define show_temp_reg(reg) \
> -static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> -{ \
> -	struct w83627hf_data *data = w83627hf_update_device(dev); \
> -	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
> -		return sprintf(buf,"%ld\n", \
> -			(long)LM75_TEMP_FROM_REG(data->reg##_add[nr-2])); \
> -	} else {	/* TEMP1 */ \
> -		return sprintf(buf,"%ld\n", (long)TEMP_FROM_REG(data->reg)); \
> -	} \
> +static ssize_t
> +show_temp(struct device *dev, struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> +		return sprintf(buf, "%ld\n",
> +			(long)LM75_TEMP_FROM_REG(data->temp_add[nr-2]));
> +	} else {	/* TEMP1 */
> +		return sprintf(buf, "%ld\n", (long)TEMP_FROM_REG(data->temp));
> +	}
>  }
> -show_temp_reg(temp);
> -show_temp_reg(temp_max);
> -show_temp_reg(temp_max_hyst);
>  
> -#define store_temp_reg(REG, reg) \
> -static ssize_t \
> -store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
> -{ \
> -	struct w83627hf_data *data = dev_get_drvdata(dev); \
> -	long val; \
> -	 \
> -	val = simple_strtol(buf, NULL, 10); \
> -	 \
> -	mutex_lock(&data->update_lock); \
> -	 \
> -	if (nr >= 2) {	/* TEMP2 and TEMP3 */ \
> -		data->temp_##reg##_add[nr-2] = LM75_TEMP_TO_REG(val); \
> -		w83627hf_write_value(data, W83781D_REG_TEMP_##REG(nr), \
> -				data->temp_##reg##_add[nr-2]); \
> -	} else {	/* TEMP1 */ \
> -		data->temp_##reg = TEMP_TO_REG(val); \
> -		w83627hf_write_value(data, W83781D_REG_TEMP_##REG(nr), \
> -			data->temp_##reg); \
> -	} \
> -	 \
> -	mutex_unlock(&data->update_lock); \
> -	return count; \
> +static ssize_t
> +show_temp_max(struct device *dev, struct device_attribute *devattr,
> +	      char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> +		return sprintf(buf, "%ld\n",
> +			(long)LM75_TEMP_FROM_REG(data->temp_max_add[nr-2]));
> +	} else {	/* TEMP1 */
> +		return sprintf(buf, "%ld\n",
> +			(long)TEMP_FROM_REG(data->temp_max));
> +	}
>  }
> -store_temp_reg(OVER, max);
> -store_temp_reg(HYST, max_hyst);
>  
> -#define sysfs_temp_offset(offset) \
> -static ssize_t \
> -show_regs_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_temp(dev, buf, offset); \
> -} \
> -static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
> +static ssize_t
> +show_temp_max_hyst(struct device *dev, struct device_attribute *devattr,
> +		   char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> +		return sprintf(buf, "%ld\n",
> +			(long)LM75_TEMP_FROM_REG(data->temp_max_hyst_add[nr-2]));
> +	} else {	/* TEMP1 */
> +		return sprintf(buf, "%ld\n",
> +			(long)TEMP_FROM_REG(data->temp_max_hyst));
> +	}
> +}
>  
> -#define sysfs_temp_reg_offset(reg, offset) \
> -static ssize_t show_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_temp_##reg (dev, buf, offset); \
> -} \
> -static ssize_t \
> -store_regs_temp_##reg##offset (struct device *dev, struct device_attribute *attr, \
> -			      const char *buf, size_t count) \
> -{ \
> -	return store_temp_##reg (dev, buf, count, offset); \
> -} \
> -static DEVICE_ATTR(temp##offset##_##reg, S_IRUGO| S_IWUSR, \
> -		  show_regs_temp_##reg##offset, store_regs_temp_##reg##offset);
> +static ssize_t
> +store_temp_max(struct device *dev, struct device_attribute *devattr,
> +	       const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = dev_get_drvdata(dev);
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> +		data->temp_max_add[nr-2] = LM75_TEMP_TO_REG(val);
> +		w83627hf_write_value(data, W83781D_REG_TEMP_OVER(nr),
> +				data->temp_max_add[nr-2]);
> +	} else {	/* TEMP1 */
> +		data->temp_max = TEMP_TO_REG(val);
> +		w83627hf_write_value(data, W83781D_REG_TEMP_OVER(nr),
> +			data->temp_max);
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t
> +store_temp_max_hyst(struct device *dev, struct device_attribute *devattr,
> +		    const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = dev_get_drvdata(dev);
> +	long val = simple_strtol(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +
> +	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> +		data->temp_max_hyst_add[nr-2] = LM75_TEMP_TO_REG(val);
> +		w83627hf_write_value(data, W83781D_REG_TEMP_HYST(nr),
> +				data->temp_max_hyst_add[nr-2]);
> +	} else {	/* TEMP1 */
> +		data->temp_max_hyst = TEMP_TO_REG(val);
> +		w83627hf_write_value(data, W83781D_REG_TEMP_HYST(nr),
> +			data->temp_max_hyst);
> +	}
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
>  
> -#define sysfs_temp_offsets(offset) \
> -sysfs_temp_offset(offset) \
> -sysfs_temp_reg_offset(max, offset) \
> -sysfs_temp_reg_offset(max_hyst, offset)
> +#define sysfs_temp_decl(offset) \
> +static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
> +			  show_temp, NULL, offset);			\
> +static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO|S_IWUSR,	 	\
> +			  show_temp_max, store_temp_max, offset);	\
> +static SENSOR_DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO|S_IWUSR,	\
> +			  show_temp_max_hyst, store_temp_max_hyst, offset);
>  
> -sysfs_temp_offsets(1);
> -sysfs_temp_offsets(2);
> -sysfs_temp_offsets(3);
> +sysfs_temp_decl(1);
> +sysfs_temp_decl(2);
> +sysfs_temp_decl(3);
>  
>  static ssize_t
>  show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
> @@ -788,20 +802,22 @@ sysfs_beep(ENABLE, enable);
>  sysfs_beep(MASK, mask);
>  
>  static ssize_t
> -show_fan_div_reg(struct device *dev, char *buf, int nr)
> +show_fan_div(struct device *dev, struct device_attribute *devattr, char *buf)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	return sprintf(buf, "%ld\n",
> -		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
> +		       (long) DIV_FROM_REG(data->fan_div[nr]));
>  }
> -
>  /* Note: we save and restore the fan minimum here, because its value is
>     determined in part by the fan divisor.  This follows the principle of
>     least surprise; the user doesn't expect the fan minimum to change just
>     because the divisor changed. */
>  static ssize_t
> -store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
> +store_fan_div(struct device *dev, struct device_attribute *devattr,
> +	      const char *buf, size_t count)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  	unsigned long min;
>  	u8 reg;
> @@ -833,92 +849,72 @@ store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
>  	return count;
>  }
>  
> -#define sysfs_fan_div(offset) \
> -static ssize_t show_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_fan_div_reg(dev, buf, offset); \
> -} \
> -static ssize_t \
> -store_regs_fan_div_##offset (struct device *dev, struct device_attribute *attr, \
> -			    const char *buf, size_t count) \
> -{ \
> -	return store_fan_div_reg(dev, buf, count, offset - 1); \
> -} \
> -static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
> -		  show_regs_fan_div_##offset, store_regs_fan_div_##offset);
> -
> -sysfs_fan_div(1);
> -sysfs_fan_div(2);
> -sysfs_fan_div(3);
> +static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO|S_IWUSR,
> +			  show_fan_div, store_fan_div, 0);
> +static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO|S_IWUSR,
> +			  show_fan_div, store_fan_div, 1);
> +static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO|S_IWUSR,
> +			  show_fan_div, store_fan_div, 2);
>  
>  static ssize_t
> -show_pwm_reg(struct device *dev, char *buf, int nr)
> +show_pwm(struct device *dev, struct device_attribute *devattr, char *buf)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	return sprintf(buf, "%ld\n", (long) data->pwm[nr - 1]);
> +	return sprintf(buf, "%ld\n", (long) data->pwm[nr]);
>  }
>  
>  static ssize_t
> -store_pwm_reg(struct device *dev, const char *buf, size_t count, int nr)
> +store_pwm(struct device *dev, struct device_attribute *devattr,
> +	  const char *buf, size_t count)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> -	u32 val;
> -
> -	val = simple_strtoul(buf, NULL, 10);
> +	u32 val = simple_strtoul(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
>  
>  	if (data->type = w83627thf) {
>  		/* bits 0-3 are reserved  in 627THF */
> -		data->pwm[nr - 1] = PWM_TO_REG(val) & 0xf0;
> +		data->pwm[nr] = PWM_TO_REG(val) & 0xf0;
>  		w83627hf_write_value(data,
>  				     W836X7HF_REG_PWM(data->type, nr),
> -				     data->pwm[nr - 1] |
> +				     data->pwm[nr] |
>  				     (w83627hf_read_value(data,
>  				     W836X7HF_REG_PWM(data->type, nr)) & 0x0f));
>  	} else {
> -		data->pwm[nr - 1] = PWM_TO_REG(val);
> +		data->pwm[nr] = PWM_TO_REG(val);
>  		w83627hf_write_value(data,
>  				     W836X7HF_REG_PWM(data->type, nr),
> -				     data->pwm[nr - 1]);
> +				     data->pwm[nr]);
>  	}
>  
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
>  
> -#define sysfs_pwm(offset) \
> -static ssize_t show_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_pwm_reg(dev, buf, offset); \
> -} \
> -static ssize_t \
> -store_regs_pwm_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
> -{ \
> -	return store_pwm_reg(dev, buf, count, offset); \
> -} \
> -static DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR, \
> -		  show_regs_pwm_##offset, store_regs_pwm_##offset);
> -
> -sysfs_pwm(1);
> -sysfs_pwm(2);
> -sysfs_pwm(3);
> +static SENSOR_DEVICE_ATTR(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0);
> +static SENSOR_DEVICE_ATTR(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 1);
> +static SENSOR_DEVICE_ATTR(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 2);
>  
>  static ssize_t
> -show_pwm_freq_reg(struct device *dev, char *buf, int nr)
> +show_pwm_freq(struct device *dev, struct device_attribute *devattr, char *buf)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	if (data->type = w83627hf)
>  		return sprintf(buf, "%ld\n",
> -			pwm_freq_from_reg_627hf(data->pwm_freq[nr - 1]));
> +			pwm_freq_from_reg_627hf(data->pwm_freq[nr]));
>  	else
>  		return sprintf(buf, "%ld\n",
> -			pwm_freq_from_reg(data->pwm_freq[nr - 1]));
> +			pwm_freq_from_reg(data->pwm_freq[nr]));
>  }
>  
>  static ssize_t
> -store_pwm_freq_reg(struct device *dev, const char *buf, size_t count, int nr)
> +store_pwm_freq(struct device *dev, struct device_attribute *devattr,
> +	       const char *buf, size_t count)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  	static const u8 mask[]={0xF8, 0x8F};
>  	u32 val;
> @@ -928,50 +924,42 @@ store_pwm_freq_reg(struct device *dev, const char *buf, size_t count, int nr)
>  	mutex_lock(&data->update_lock);
>  
>  	if (data->type = w83627hf) {
> -		data->pwm_freq[nr - 1] = pwm_freq_to_reg_627hf(val);
> +		data->pwm_freq[nr] = pwm_freq_to_reg_627hf(val);
>  		w83627hf_write_value(data, W83627HF_REG_PWM_FREQ,
> -				(data->pwm_freq[nr - 1] << ((nr - 1)*4)) |
> +				(data->pwm_freq[nr] << (nr*4)) |
>  				(w83627hf_read_value(data,
> -				W83627HF_REG_PWM_FREQ) & mask[nr - 1]));
> +				W83627HF_REG_PWM_FREQ) & mask[nr]));
>  	} else {
> -		data->pwm_freq[nr - 1] = pwm_freq_to_reg(val);
> -		w83627hf_write_value(data, W83637HF_REG_PWM_FREQ[nr - 1],
> -				data->pwm_freq[nr - 1]);
> +		data->pwm_freq[nr] = pwm_freq_to_reg(val);
> +		w83627hf_write_value(data, W83637HF_REG_PWM_FREQ[nr],
> +				data->pwm_freq[nr]);
>  	}
>  
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
>  
> -#define sysfs_pwm_freq(offset) \
> -static ssize_t show_regs_pwm_freq_##offset(struct device *dev, \
> -		struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_pwm_freq_reg(dev, buf, offset); \
> -} \
> -static ssize_t \
> -store_regs_pwm_freq_##offset(struct device *dev, \
> -		struct device_attribute *attr, const char *buf, size_t count) \
> -{ \
> -	return store_pwm_freq_reg(dev, buf, count, offset); \
> -} \
> -static DEVICE_ATTR(pwm##offset##_freq, S_IRUGO | S_IWUSR, \
> -		  show_regs_pwm_freq_##offset, store_regs_pwm_freq_##offset);
> -
> -sysfs_pwm_freq(1);
> -sysfs_pwm_freq(2);
> -sysfs_pwm_freq(3);
> +static SENSOR_DEVICE_ATTR(pwm1_freq, S_IRUGO|S_IWUSR,
> +			  show_pwm_freq, store_pwm_freq, 0);
> +static SENSOR_DEVICE_ATTR(pwm2_freq, S_IRUGO|S_IWUSR,
> +			  show_pwm_freq, store_pwm_freq, 1);
> +static SENSOR_DEVICE_ATTR(pwm3_freq, S_IRUGO|S_IWUSR,
> +			  show_pwm_freq, store_pwm_freq, 2);
>  
>  static ssize_t
> -show_sensor_reg(struct device *dev, char *buf, int nr)
> +show_temp_type(struct device *dev, struct device_attribute *devattr,
> +	       char *buf)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	return sprintf(buf, "%ld\n", (long) data->sens[nr - 1]);
> +	return sprintf(buf, "%ld\n", (long) data->sens[nr]);
>  }
>  
>  static ssize_t
> -store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
> +store_temp_type(struct device *dev, struct device_attribute *devattr,
> +		const char *buf, size_t count)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  	u32 val, tmp;
>  
> @@ -983,20 +971,20 @@ store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
>  	case 1:		/* PII/Celeron diode */
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
>  		w83627hf_write_value(data, W83781D_REG_SCFG1,
> -				    tmp | BIT_SCFG1[nr - 1]);
> +				    tmp | BIT_SCFG1[nr]);
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG2);
>  		w83627hf_write_value(data, W83781D_REG_SCFG2,
> -				    tmp | BIT_SCFG2[nr - 1]);
> -		data->sens[nr - 1] = val;
> +				    tmp | BIT_SCFG2[nr]);
> +		data->sens[nr] = val;
>  		break;
>  	case 2:		/* 3904 */
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
>  		w83627hf_write_value(data, W83781D_REG_SCFG1,
> -				    tmp | BIT_SCFG1[nr - 1]);
> +				    tmp | BIT_SCFG1[nr]);
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG2);
>  		w83627hf_write_value(data, W83781D_REG_SCFG2,
> -				    tmp & ~BIT_SCFG2[nr - 1]);
> -		data->sens[nr - 1] = val;
> +				    tmp & ~BIT_SCFG2[nr]);
> +		data->sens[nr] = val;
>  		break;
>  	case W83781D_DEFAULT_BETA:
>  		dev_warn(dev, "Sensor type %d is deprecated, please use 4 "
> @@ -1005,8 +993,8 @@ store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
>  	case 4:		/* thermistor */
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
>  		w83627hf_write_value(data, W83781D_REG_SCFG1,
> -				    tmp & ~BIT_SCFG1[nr - 1]);
> -		data->sens[nr - 1] = val;
> +				    tmp & ~BIT_SCFG1[nr]);
> +		data->sens[nr] = val;
>  		break;
>  	default:
>  		dev_err(dev,
> @@ -1019,25 +1007,16 @@ store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
>  	return count;
>  }
>  
> -#define sysfs_sensor(offset) \
> -static ssize_t show_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -    return show_sensor_reg(dev, buf, offset); \
> -} \
> -static ssize_t \
> -store_regs_sensor_##offset (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
> -{ \
> -    return store_sensor_reg(dev, buf, count, offset); \
> -} \
> -static DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, \
> -		  show_regs_sensor_##offset, store_regs_sensor_##offset);
> +#define sysfs_temp_type(offset) \
> +static SENSOR_DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, \
> +			  show_temp_type, store_temp_type, offset - 1);
>  
> -sysfs_sensor(1);
> -sysfs_sensor(2);
> -sysfs_sensor(3);
> +sysfs_temp_type(1);
> +sysfs_temp_type(2);
> +sysfs_temp_type(3);
>  
> -static ssize_t show_name(struct device *dev, struct device_attribute
> -			 *devattr, char *buf)
> +static ssize_t
> +show_name(struct device *dev, struct device_attribute *devattr, char *buf)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  
> @@ -1119,49 +1098,44 @@ static int __init w83627hf_find(int sioaddr, unsigned short *addr,
>  	return err;
>  }
>  
> +#define VIN_UNIT_ATTRS(_X_)	\
> +	&sensor_dev_attr_in##_X_##_input.dev_attr.attr,		\
> +	&sensor_dev_attr_in##_X_##_min.dev_attr.attr,		\
> +	&sensor_dev_attr_in##_X_##_max.dev_attr.attr
> +
> +#define FAN_UNIT_ATTRS(_X_)	\
> +	&sensor_dev_attr_fan##_X_##_input.dev_attr.attr,	\
> +	&sensor_dev_attr_fan##_X_##_min.dev_attr.attr,		\
> +	&sensor_dev_attr_fan##_X_##_div.dev_attr.attr
> +
> +#define TEMP_UNIT_ATTRS(_X_)	\
> +	&sensor_dev_attr_temp##_X_##_input.dev_attr.attr,	\
> +	&sensor_dev_attr_temp##_X_##_max.dev_attr.attr,		\
> +	&sensor_dev_attr_temp##_X_##_max_hyst.dev_attr.attr,	\
> +	&sensor_dev_attr_temp##_X_##_type.dev_attr.attr
> +
>  static struct attribute *w83627hf_attributes[] = {
>  	&dev_attr_in0_input.attr,
>  	&dev_attr_in0_min.attr,
>  	&dev_attr_in0_max.attr,
> -	&dev_attr_in2_input.attr,
> -	&dev_attr_in2_min.attr,
> -	&dev_attr_in2_max.attr,
> -	&dev_attr_in3_input.attr,
> -	&dev_attr_in3_min.attr,
> -	&dev_attr_in3_max.attr,
> -	&dev_attr_in4_input.attr,
> -	&dev_attr_in4_min.attr,
> -	&dev_attr_in4_max.attr,
> -	&dev_attr_in7_input.attr,
> -	&dev_attr_in7_min.attr,
> -	&dev_attr_in7_max.attr,
> -	&dev_attr_in8_input.attr,
> -	&dev_attr_in8_min.attr,
> -	&dev_attr_in8_max.attr,
> -
> -	&dev_attr_fan1_input.attr,
> -	&dev_attr_fan1_min.attr,
> -	&dev_attr_fan1_div.attr,
> -	&dev_attr_fan2_input.attr,
> -	&dev_attr_fan2_min.attr,
> -	&dev_attr_fan2_div.attr,
> -
> -	&dev_attr_temp1_input.attr,
> -	&dev_attr_temp1_max.attr,
> -	&dev_attr_temp1_max_hyst.attr,
> -	&dev_attr_temp1_type.attr,
> -	&dev_attr_temp2_input.attr,
> -	&dev_attr_temp2_max.attr,
> -	&dev_attr_temp2_max_hyst.attr,
> -	&dev_attr_temp2_type.attr,
> +	VIN_UNIT_ATTRS(2),
> +	VIN_UNIT_ATTRS(3),
> +	VIN_UNIT_ATTRS(4),
> +	VIN_UNIT_ATTRS(7),
> +	VIN_UNIT_ATTRS(8),
> +
> +	FAN_UNIT_ATTRS(1),
> +	FAN_UNIT_ATTRS(2),
> +
> +	TEMP_UNIT_ATTRS(1),
> +	TEMP_UNIT_ATTRS(2),
>  
>  	&dev_attr_alarms.attr,
>  	&dev_attr_beep_enable.attr,
>  	&dev_attr_beep_mask.attr,
>  
> -	&dev_attr_pwm1.attr,
> -	&dev_attr_pwm2.attr,
> -
> +	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	&sensor_dev_attr_pwm2.dev_attr.attr,
>  	&dev_attr_name.attr,
>  	NULL
>  };
> @@ -1171,30 +1145,13 @@ static const struct attribute_group w83627hf_group = {
>  };
>  
>  static struct attribute *w83627hf_attributes_opt[] = {
> -	&dev_attr_in1_input.attr,
> -	&dev_attr_in1_min.attr,
> -	&dev_attr_in1_max.attr,
> -	&dev_attr_in5_input.attr,
> -	&dev_attr_in5_min.attr,
> -	&dev_attr_in5_max.attr,
> -	&dev_attr_in6_input.attr,
> -	&dev_attr_in6_min.attr,
> -	&dev_attr_in6_max.attr,
> -
> -	&dev_attr_fan3_input.attr,
> -	&dev_attr_fan3_min.attr,
> -	&dev_attr_fan3_div.attr,
> -
> -	&dev_attr_temp3_input.attr,
> -	&dev_attr_temp3_max.attr,
> -	&dev_attr_temp3_max_hyst.attr,
> -	&dev_attr_temp3_type.attr,
> -
> -	&dev_attr_pwm3.attr,
> -
> -	&dev_attr_pwm1_freq.attr,
> -	&dev_attr_pwm2_freq.attr,
> -	&dev_attr_pwm3_freq.attr,
> +	VIN_UNIT_ATTRS(1),
> +	VIN_UNIT_ATTRS(5),
> +	VIN_UNIT_ATTRS(6),
> +
> +	FAN_UNIT_ATTRS(3),
> +	TEMP_UNIT_ATTRS(3),
> +	&sensor_dev_attr_pwm3.dev_attr.attr,

Missing pwm1_freq, pwm2_freq and pwm3_freq attributes.

>  	NULL
>  };
>  
> @@ -1252,27 +1209,41 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
>  
>  	/* Register chip-specific device attributes */
>  	if (data->type = w83627hf || data->type = w83697hf)
> -		if ((err = device_create_file(dev, &dev_attr_in5_input))
> -		 || (err = device_create_file(dev, &dev_attr_in5_min))
> -		 || (err = device_create_file(dev, &dev_attr_in5_max))
> -		 || (err = device_create_file(dev, &dev_attr_in6_input))
> -		 || (err = device_create_file(dev, &dev_attr_in6_min))
> -		 || (err = device_create_file(dev, &dev_attr_in6_max))
> -		 || (err = device_create_file(dev, &dev_attr_pwm1_freq))
> -		 || (err = device_create_file(dev, &dev_attr_pwm2_freq)))
> +		if ((err = device_create_file(dev,
> +				&sensor_dev_attr_in5_input.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_in5_min.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_in5_max.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_in6_input.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_in6_min.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_in6_max.dev_attr)))

pwm1_freq and pwm2_freq attributes are no longer created.

>  			goto ERROR4;
>  
>  	if (data->type != w83697hf)
> -		if ((err = device_create_file(dev, &dev_attr_in1_input))
> -		 || (err = device_create_file(dev, &dev_attr_in1_min))
> -		 || (err = device_create_file(dev, &dev_attr_in1_max))
> -		 || (err = device_create_file(dev, &dev_attr_fan3_input))
> -		 || (err = device_create_file(dev, &dev_attr_fan3_min))
> -		 || (err = device_create_file(dev, &dev_attr_fan3_div))
> -		 || (err = device_create_file(dev, &dev_attr_temp3_input))
> -		 || (err = device_create_file(dev, &dev_attr_temp3_max))
> -		 || (err = device_create_file(dev, &dev_attr_temp3_max_hyst))
> -		 || (err = device_create_file(dev, &dev_attr_temp3_type)))
> +		if ((err = device_create_file(dev,
> +				&sensor_dev_attr_in1_input.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_in1_min.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_in1_max.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_fan3_input.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_fan3_min.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_fan3_div.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_temp3_input.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_temp3_max.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_temp3_max_hyst.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_temp3_type.dev_attr)))
>  			goto ERROR4;
>  
>  	if (data->type != w83697hf && data->vid != 0xff) {
> @@ -1286,13 +1257,17 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
>  
>  	if (data->type = w83627thf || data->type = w83637hf
>  	 || data->type = w83687thf)
> -		if ((err = device_create_file(dev, &dev_attr_pwm3)))
> +		if ((err = device_create_file(dev,
> +				&sensor_dev_attr_pwm3.dev_attr)))
>  			goto ERROR4;
>  
>  	if (data->type = w83637hf || data->type = w83687thf)
> -		if ((err = device_create_file(dev, &dev_attr_pwm1_freq))
> -		 || (err = device_create_file(dev, &dev_attr_pwm2_freq))
> -		 || (err = device_create_file(dev, &dev_attr_pwm3_freq)))
> +		if ((err = device_create_file(dev,
> +				&sensor_dev_attr_pwm1_freq.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_pwm2_freq.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_pwm3_freq.dev_attr)))
>  			goto ERROR4;
>  
>  	data->hwmon_dev = hwmon_device_register(dev);
> @@ -1588,14 +1563,14 @@ static struct w83627hf_data *w83627hf_update_device(struct device *dev)
>  			    w83627hf_read_value(data,
>  					       W83781D_REG_FAN_MIN(i));
>  		}
> -		for (i = 1; i <= 3; i++) {
> +		for (i = 0; i <= 2; i++) {
>  			u8 tmp = w83627hf_read_value(data,
>  				W836X7HF_REG_PWM(data->type, i));
>   			/* bits 0-3 are reserved  in 627THF */
>   			if (data->type = w83627thf)
>  				tmp &= 0xf0;
> -			data->pwm[i - 1] = tmp;
> -			if(i = 2 &&
> +			data->pwm[i] = tmp;
> +			if(i = 1 &&

Missing space before opening parenthesis.

>  			   (data->type = w83627hf || data->type = w83697hf))
>  				break;
>  		}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
