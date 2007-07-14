From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 14 Jul 2007 09:59:05 +0000
Subject: Re: [lm-sensors] [ patch ]  de-macro-fy w83627hf.c
Message-Id: <20070714115905.1e8c8dcc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46903707.4000300@gmail.com>
In-Reply-To: <46903707.4000300@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Tue, 10 Jul 2007 13:52:37 -0600, Jim Cromie wrote:
> Thank you Krzysztof for your review.
> 
> This 2nd rev does:
> 
> - rebases on Marks GIT tree (thought I had, sorry)
> - fixes all 80-column probs in last, plus a few others
> - adopts new fashion    int nr = to_sensor_dev_attr(devattr)->index;
> - folds many one-caller functions into the caller
> - converts remaining fn-generating macros to plain old functions
> 
> 
> WRT types and conversions in the *_FROM/TO_REG macros,
> thanks for the detailed review, tracing thru the conversions is time
> consuming, and feels error prone..
> 
> - I dropped the (long) casts in some cases,
> - and pushed them down into the macros in others
> - Im disappointed that sparse/C=1 didnt identify these things
> 
> Im reluctant to do more here (Do No Harm, leave well enough alone).
> It seems that a full review, and conversion to static inline functions
> is warranted, and probably should be done separately.
> 
> <update>
> 
> Ive now seen Jean's comments, and have manually (I hope fully) backed
> out the three 'types and conversions' fixes above, reverting to
> original form.  I have a set of interim diffs, so I *could* go back
> and reconstruct things, but I would *really* like to avoid doing so;
> its tedious and error prone.
> 
> FWIW - the patch results in a smaller object.
> 
>   14627    2464      36   17127    42e7  lx-git-hwmon/drivers/hwmon/w83627hf.ko
>   12895    2676      36   15607    3cf7  lx-git-hwmon-demacro/drivers/hwmon/w83627hf.ko

Yes, the size reduction is really nice.

> ---
> 
> Convert hwmon/w83627hf to use dynamic sysfs callbacks, replacing the
> function-generating macros.
> 
> Signed-off-by:  Jim Cromie <jim.cromie@gmail.com
> 
> 
> [jimc@groucho lx]$ diffstat diff.hwmon-w83627hf-demacro-sysfs-callbacks
>  w83627hf.c |  887 ++++++++++++++++++++++++++++++-------------------------------
>  1 file changed, 449 insertions(+), 438 deletions(-)

There still are many changes in your patch, which do not belong there.
Things like:

> -	u32 val;
> -
> -	val = simple_strtoul(buf, NULL, 10);
> +	u32 val = simple_strtoul(buf, NULL, 10);

and:

> -		data->pwm[nr - 1] = PWM_TO_REG(val) & 0xf0;
> +		data->pwm[nr-1] = PWM_TO_REG(val) & 0xf0;

and:

> -		printk(KERN_WARNING DRVNAME ": Base address not set, "
> -		       "skipping\n");
> +		printk(KERN_WARNING DRVNAME
> +		       ": Base address not set, skipping\n");

should all be reverted. Your patch will be big enough with only the
needed changes.


> diff -ruNp -X dontdiff -X exclude-diffs lx-git-hwmon/drivers/hwmon/w83627hf.c lx-git-hwmon-demacro/drivers/hwmon/w83627hf.c
> --- lx-git-hwmon/drivers/hwmon/w83627hf.c	2007-07-09 12:53:16.000000000 -0600
> +++ lx-git-hwmon-demacro/drivers/hwmon/w83627hf.c	2007-07-10 13:15:22.000000000 -0600
> @@ -45,6 +45,7 @@
>  #include <linux/jiffies.h>
>  #include <linux/platform_device.h>
>  #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <linux/hwmon-vid.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> @@ -403,75 +404,79 @@ static struct platform_driver w83627hf_d
>  	.remove		= __devexit_p(w83627hf_remove),
>  };
>  
> -/* following are the sysfs callback functions */
> -#define show_in_reg(reg) \
> -static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> -{ \
> -	struct w83627hf_data *data = w83627hf_update_device(dev); \
> -	return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
> -}
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
> -}
> -store_in_reg(MIN, min)
> -store_in_reg(MAX, max)
> -
> -#define sysfs_in_offset(offset) \
> -static ssize_t \
> -show_regs_in_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -        return show_in(dev, buf, offset); \
> -} \
> -static DEVICE_ATTR(in##offset##_input, S_IRUGO, show_regs_in_##offset, NULL);
> -
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
> +static ssize_t show_in_input(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", (long) IN_FROM_REG(data->in[nr]));
> +}
> +static ssize_t show_in_min(struct device *dev,
> +			   struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", (long) IN_FROM_REG(data->in_min[nr]));
> +}
> +static ssize_t show_in_max(struct device *dev,
> +			   struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", (long) IN_FROM_REG(data->in_max[nr]));
> +}
> +
> +static ssize_t store_in_min(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = dev_get_drvdata(dev);
> +	long val = simple_strtol(buf, NULL, 10);

The original code has u32 and simple_strtoul.

> +
> +	mutex_lock(&data->update_lock);
> +	data->in_min[nr] = IN_TO_REG(val);
> +	w83627hf_write_value(data, W83781D_REG_IN_MIN(nr), data->in_min[nr]);
> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +static ssize_t store_in_max(struct device *dev,
> +			    struct device_attribute *devattr, const char *buf,
> +			    size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = dev_get_drvdata(dev);
> +	u32 val = simple_strtol(buf, NULL, 10);

The original code has simple_strtoul.

> +
> +	mutex_lock(&data->update_lock);
> +	data->in_max[nr] = IN_TO_REG(val);
> +	w83627hf_write_value(data, W83781D_REG_IN_MAX(nr),
> +			     data->in_max[nr]);

Would fit on a single line, as you did in store_in_min above.

> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +#define vin_decl(offset)	\
> +static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
> +			  show_in_input, NULL, offset);		\
> +static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
> +			  show_in_min, store_in_min, offset);	\
> +static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
> +			  show_in_max, store_in_max, offset);
> +
> +vin_decl(1);
> +vin_decl(2);
> +vin_decl(3);
> +vin_decl(4);
> +vin_decl(5);
> +vin_decl(6);
> +vin_decl(7);
> +vin_decl(8);
>  
>  /* use a different set of functions for in0 */
> -static ssize_t show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
> +static ssize_t _show_in_0(struct w83627hf_data *data, char *buf, u8 reg)
>  {
>  	long in0;
>  
> @@ -488,31 +493,33 @@ static ssize_t show_in_0(struct w83627hf
>  	return sprintf(buf,"%ld\n", in0);
>  }
>  
> -static ssize_t show_regs_in_0(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_in_0(struct device *dev,
> +			 struct device_attribute *attr, char *buf)
>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	return show_in_0(data, buf, data->in[0]);
> +	return _show_in_0(data, buf, data->in[0]);
>  }
>  
> -static ssize_t show_regs_in_min0(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_in_min0(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	return show_in_0(data, buf, data->in_min[0]);
> +	return _show_in_0(data, buf, data->in_min[0]);
>  }
>  
> -static ssize_t show_regs_in_max0(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_in_max0(struct device *dev,
> +			    struct device_attribute *attr, char *buf)
>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	return show_in_0(data, buf, data->in_max[0]);
> +	return _show_in_0(data, buf, data->in_max[0]);
>  }
>  
> -static ssize_t store_regs_in_min0(struct device *dev, struct device_attribute *attr,
> -	const char *buf, size_t count)
> +static ssize_t store_in_min0(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> -	u32 val;
> -
> -	val = simple_strtoul(buf, NULL, 10);
> +	u32 val = simple_strtoul(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
>  	
> @@ -533,13 +540,12 @@ static ssize_t store_regs_in_min0(struct
>  	return count;
>  }
>  
> -static ssize_t store_regs_in_max0(struct device *dev, struct device_attribute *attr,
> -	const char *buf, size_t count)
> +static ssize_t store_in_max0(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> -	u32 val;
> -
> -	val = simple_strtoul(buf, NULL, 10);
> +	u32 val = simple_strtoul(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -560,192 +566,195 @@ static ssize_t store_regs_in_max0(struct
>  	return count;
>  }
>  
> -static DEVICE_ATTR(in0_input, S_IRUGO, show_regs_in_0, NULL);
> +static DEVICE_ATTR(in0_input, S_IRUGO, show_in_0, NULL);
>  static DEVICE_ATTR(in0_min, S_IRUGO | S_IWUSR,
> -	show_regs_in_min0, store_regs_in_min0);
> +		   show_in_min0, store_in_min0);
>  static DEVICE_ATTR(in0_max, S_IRUGO | S_IWUSR,
> -	show_regs_in_max0, store_regs_in_max0);
> +		   show_in_max0, store_in_max0);

If you really want to rename these callbacks, I suggest show_in0_input,
show_in0_min, store_in0_min, show_in0_max and show_in0_max, to stick to
the sysfs file names. But quite frankly, I wouldn't bother renaming
them at all.

>  
> -#define show_fan_reg(reg) \
> -static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> -{ \
> -	struct w83627hf_data *data = w83627hf_update_device(dev); \
> -	return sprintf(buf,"%ld\n", \
> -		FAN_FROM_REG(data->reg[nr-1], \
> -			    (long)DIV_FROM_REG(data->fan_div[nr-1]))); \
> +static ssize_t show_fan_input(struct device *dev,
> +			      struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", FAN_FROM_REG(data->fan[nr],
> +				(long) DIV_FROM_REG(data->fan_div[nr])));
>  }
> -show_fan_reg(fan);
> -show_fan_reg(fan_min);
>  
> -static ssize_t
> -store_fan_min(struct device *dev, const char *buf, size_t count, int nr)
> +static ssize_t show_fan_min(struct device *dev,
> +			    struct device_attribute *devattr, char *buf)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", FAN_FROM_REG(data->fan_min[nr],
> +				(long) DIV_FROM_REG(data->fan_div[nr])));
> +}
> +
> +static ssize_t store_fan_min(struct device *dev,
> +			     struct device_attribute *devattr,
> +			     const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> -	u32 val;
> +	u32 val = simple_strtoul(buf, NULL, 10);
>  
> -	val = simple_strtoul(buf, NULL, 10);
> +	mutex_lock(&data->update_lock);
> +	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
> +	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr+1),
> +			    data->fan_min[nr]);
> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +#define fan_decl(offset)	\
> +static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,			\
> +			  show_fan_input, NULL, offset - 1);		\
> +static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
> +			  show_fan_min, store_fan_min, offset - 1);
> +
> +fan_decl(1);
> +fan_decl(2);
> +fan_decl(3);
> +
> +static ssize_t show_temp(struct device *dev,
> +			 struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> +		return sprintf(buf, "%ld\n",
> +			(long)LM75_TEMP_FROM_REG(data->temp_add[nr-2]));
> +	} else {	/* TEMP1 */
> +		return sprintf(buf, "%ld\n", (long) TEMP_FROM_REG(data->temp));
> +	}
> +}
> +static ssize_t show_temp_max(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> +		return sprintf(buf, "%ld\n",
> +			(long)LM75_TEMP_FROM_REG(data->temp_max_add[nr-2]));
> +	} else {	/* TEMP1 */
> +		return sprintf(buf, "%ld\n",
> +			       (long) TEMP_FROM_REG(data->temp_max));
> +	}
> +}
> +static ssize_t show_temp_max_hyst(struct device *dev,
> +				  struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> +		return sprintf(buf, "%ld\n", (long) 
> +			LM75_TEMP_FROM_REG(data->temp_max_hyst_add[nr-2]));
> +	} else {	/* TEMP1 */
> +		return sprintf(buf, "%ld\n",
> +			       (long) TEMP_FROM_REG(data->temp_max_hyst));
> +	}
> +}
> +
> +static ssize_t store_temp_max(struct device *dev,
> +			      struct device_attribute *devattr,
> +			      const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = dev_get_drvdata(dev);
> +	u32 val = simple_strtoul(buf, NULL, 10);
>  
>  	mutex_lock(&data->update_lock);
> -	data->fan_min[nr - 1] > -	    FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr - 1]));
> -	w83627hf_write_value(data, W83781D_REG_FAN_MIN(nr),
> -			    data->fan_min[nr - 1]);
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
>  
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }
>  
> -#define sysfs_fan_offset(offset) \
> -static ssize_t show_regs_fan_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_fan(dev, buf, offset); \
> -} \
> -static DEVICE_ATTR(fan##offset##_input, S_IRUGO, show_regs_fan_##offset, NULL);
> -
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
> -}
> -show_temp_reg(temp);
> -show_temp_reg(temp_max);
> -show_temp_reg(temp_max_hyst);
> -
> -#define store_temp_reg(REG, reg) \
> -static ssize_t \
> -store_temp_##reg (struct device *dev, const char *buf, size_t count, int nr) \
> -{ \
> -	struct w83627hf_data *data = dev_get_drvdata(dev); \
> -	u32 val; \
> -	 \
> -	val = simple_strtoul(buf, NULL, 10); \
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
> -}
> -store_temp_reg(OVER, max);
> -store_temp_reg(HYST, max_hyst);
> -
> -#define sysfs_temp_offset(offset) \
> -static ssize_t \
> -show_regs_temp_##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_temp(dev, buf, offset); \
> -} \
> -static DEVICE_ATTR(temp##offset##_input, S_IRUGO, show_regs_temp_##offset, NULL);
> -
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
> -
> -#define sysfs_temp_offsets(offset) \
> -sysfs_temp_offset(offset) \
> -sysfs_temp_reg_offset(max, offset) \
> -sysfs_temp_reg_offset(max_hyst, offset)
> -
> -sysfs_temp_offsets(1);
> -sysfs_temp_offsets(2);
> -sysfs_temp_offsets(3);
> +static ssize_t store_temp_max_hyst(struct device *dev,
> +				   struct device_attribute *devattr,
> +				   const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = dev_get_drvdata(dev);
> +	u32 val = simple_strtoul(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
>  
> -static ssize_t
> -show_vid_reg(struct device *dev, struct device_attribute *attr, char *buf)
> +	if (nr >= 2) {	/* TEMP2 and TEMP3 */
> +		data->temp_max_hyst_add[nr-2] = LM75_TEMP_TO_REG(val);
> +		w83627hf_write_value(data, W83781D_REG_TEMP_HYST(nr),
> +				data->temp_max_hyst_add[nr-2]);
> +	} else {	/* TEMP1 */
> +		data->temp_max_hyst = TEMP_TO_REG(val);
> +		w83627hf_write_value(data, W83781D_REG_TEMP_HYST(nr),
> +			data->temp_max_hyst);
> +	}
> +
> +	mutex_unlock(&data->update_lock);
> +	return count;
> +}
> +
> +#define temp_decl(offset) \
> +static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO, 		\
> +			  show_temp, NULL, offset);			\
> +static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR, 	\
> +			  show_temp_max, store_temp_max, offset);	\
> +static SENSOR_DEVICE_ATTR(temp##offset##_max_hyst, S_IRUGO | S_IWUSR,	\
> +			  show_temp_max_hyst, store_temp_max_hyst, offset);
> +
> +temp_decl(1);
> +temp_decl(2);
> +temp_decl(3);
> +

> +static ssize_t show_vid_reg(struct device *dev,
> +			    struct device_attribute *attr, char *buf)

Please revert, this change is not needed.

>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	return sprintf(buf, "%ld\n", (long) vid_from_reg(data->vid, data->vrm));
>  }
>  static DEVICE_ATTR(cpu0_vid, S_IRUGO, show_vid_reg, NULL);
>  
> -static ssize_t
> -show_vrm_reg(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_vrm_reg(struct device *dev,
> +			    struct device_attribute *attr, char *buf)

Same here.

>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	return sprintf(buf, "%ld\n", (long) data->vrm);
>  }
> -static ssize_t
> -store_vrm_reg(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
> +static ssize_t store_vrm_reg(struct device *dev,
> +			     struct device_attribute *attr,
> +			     const char *buf, size_t count)

And same here.

>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> -	u32 val;
> -
> -	val = simple_strtoul(buf, NULL, 10);
> +	u32 val = simple_strtoul(buf, NULL, 10);
>  	data->vrm = val;
> -
>  	return count;
>  }
>  static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm_reg, store_vrm_reg);
>  
> -static ssize_t
> -show_alarms_reg(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_alarms_reg(struct device *dev,
> +			       struct device_attribute *attr, char *buf)

And here again.

>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	return sprintf(buf, "%ld\n", (long) data->alarms);
>  }
>  static DEVICE_ATTR(alarms, S_IRUGO, show_alarms_reg, NULL);
>  
> -#define show_beep_reg(REG, reg) \
> -static ssize_t show_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	struct w83627hf_data *data = w83627hf_update_device(dev); \
> -	return sprintf(buf,"%ld\n", \
> -		      (long)BEEP_##REG##_FROM_REG(data->beep_##reg)); \
> -}
> -show_beep_reg(ENABLE, enable)
> -show_beep_reg(MASK, mask)
> -
>  #define BEEP_ENABLE			0	/* Store beep_enable */
>  #define BEEP_MASK			1	/* Store beep_mask */
>  
> -static ssize_t
> -store_beep_reg(struct device *dev, const char *buf, size_t count,
> -	       int update_mask)
> +static ssize_t store_beep_reg(struct device *dev,
> +			      const char *buf, size_t count,
> +			      int update_mask)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  	u32 val, val2;
> @@ -774,36 +783,44 @@ store_beep_reg(struct device *dev, const
>  	return count;
>  }
>  
> -#define sysfs_beep(REG, reg) \
> -static ssize_t show_regs_beep_##reg (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_beep_##reg(dev, attr, buf); \
> -} \
> -static ssize_t \
> -store_regs_beep_##reg (struct device *dev, struct device_attribute *attr, const char *buf, size_t count) \
> -{ \
> -	return store_beep_reg(dev, buf, count, BEEP_##REG); \
> -} \
> -static DEVICE_ATTR(beep_##reg, S_IRUGO | S_IWUSR, \
> -		  show_regs_beep_##reg, store_regs_beep_##reg);
> -
> -sysfs_beep(ENABLE, enable);
> -sysfs_beep(MASK, mask);
> +static ssize_t show_beep_enable(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n",
> +		      (long)BEEP_ENABLE_FROM_REG(data->beep_enable));
> +}
> +static ssize_t store_beep_enable(struct device *dev,
> +				 struct device_attribute *attr,
> +				 const char *buf, size_t count)
> +{
> +	return store_beep_reg(dev, buf, count, BEEP_ENABLE);
> +}
> +static DEVICE_ATTR(beep_enable, S_IRUGO | S_IWUSR, \
> +		   show_beep_enable, store_beep_enable);
>  
> -static ssize_t
> -show_fan_div_reg(struct device *dev, char *buf, int nr)
> +static ssize_t show_beep_mask(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	return sprintf(buf, "%ld\n",
> -		       (long) DIV_FROM_REG(data->fan_div[nr - 1]));
> +		      (long)BEEP_MASK_FROM_REG(data->beep_mask));
> +}
> +static ssize_t store_beep_mask(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	return store_beep_reg(dev, buf, count, BEEP_MASK);
>  }
> +static DEVICE_ATTR(beep_mask, S_IRUGO | S_IWUSR, \
> +		  show_beep_mask, store_beep_mask);
>  

This change on beep_mask and beep_enable doesn't help at all. You are
simply expanding the macros, there's no benefit in doing this. There
would be an interest if you were using the index value to share the
callbacks between both sysfs files, but you don't. So please either
revert this change, or make use of the index to actually share some
code.

>  /* Note: we save and restore the fan minimum here, because its value is
>     determined in part by the fan divisor.  This follows the principle of
>     least surprise; the user doesn't expect the fan minimum to change just
>     because the divisor changed. */
> -static ssize_t
> -store_fan_div_reg(struct device *dev, const char *buf, size_t count, int nr)
> +static ssize_t store_fan_div_reg(struct device *dev,
> +				 const char *buf, size_t count, int nr)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  	unsigned long min;
> @@ -818,10 +835,12 @@ store_fan_div_reg(struct device *dev, co
>  
>  	data->fan_div[nr] = DIV_TO_REG(val);
>  
> -	reg = (w83627hf_read_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
> +	reg = (w83627hf_read_value(data, nr = 2 ?
> +			W83781D_REG_PIN : W83781D_REG_VID_FANDIV)
>  	       & (nr=0 ? 0xcf : 0x3f))
>  	    | ((data->fan_div[nr] & 0x03) << (nr=0 ? 4 : 6));
> -	w83627hf_write_value(data, nr=2 ? W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);
> +	w83627hf_write_value(data, nr = 2 ?
> +			W83781D_REG_PIN : W83781D_REG_VID_FANDIV, reg);

You have no reason to touch these lines.

>  
>  	reg = (w83627hf_read_value(data, W83781D_REG_VBAT)
>  	       & ~(1 << (5 + nr)))
> @@ -836,94 +855,85 @@ store_fan_div_reg(struct device *dev, co
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
> -
> -static ssize_t
> -show_pwm_reg(struct device *dev, char *buf, int nr)
> +static ssize_t show_fan_div(struct device *dev,
> +			    struct device_attribute *devattr, char *buf)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	return sprintf(buf, "%ld\n", (long) data->pwm[nr - 1]);
> +	return sprintf(buf, "%ld\n",
> +		       (long) DIV_FROM_REG(data->fan_div[nr]));
>  }
> +static ssize_t store_fan_div(struct device *dev,
> +			     struct device_attribute *devattr,
> +			     const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	return store_fan_div_reg(dev, buf, count, nr);
> +}

Your cleanup is insufficient. You should move all the code from
store_fan_div_reg directly here.

> +
> +static SENSOR_DEVICE_ATTR(fan1_div, S_IRUGO | S_IWUSR,
> +			  show_fan_div, store_fan_div, 0);
> +static SENSOR_DEVICE_ATTR(fan2_div, S_IRUGO | S_IWUSR,
> +			  show_fan_div, store_fan_div, 1);
> +static SENSOR_DEVICE_ATTR(fan3_div, S_IRUGO | S_IWUSR,
> +			  show_fan_div, store_fan_div, 2);
>  
> -static ssize_t
> -store_pwm_reg(struct device *dev, const char *buf, size_t count, int nr)
> +static ssize_t show_pwm(struct device *dev,
> +			struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	struct w83627hf_data *data = w83627hf_update_device(dev);
> +	return sprintf(buf, "%ld\n", (long) data->pwm[nr-1]);
> +}
> +static ssize_t store_pwm(struct device *dev,
> +			 struct device_attribute *devattr,
> +			 const char *buf, size_t count)
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
> +		data->pwm[nr-1] = PWM_TO_REG(val) & 0xf0;
>  		w83627hf_write_value(data,
>  				     W836X7HF_REG_PWM(data->type, nr),
> -				     data->pwm[nr - 1] |
> +				     data->pwm[nr-1] |
>  				     (w83627hf_read_value(data,
>  				     W836X7HF_REG_PWM(data->type, nr)) & 0x0f));
>  	} else {
> -		data->pwm[nr - 1] = PWM_TO_REG(val);
> +		data->pwm[nr-1] = PWM_TO_REG(val);
>  		w83627hf_write_value(data,
>  				     W836X7HF_REG_PWM(data->type, nr),
> -				     data->pwm[nr - 1]);
> +				     data->pwm[nr-1]);
>  	}
>  
>  	mutex_unlock(&data->update_lock);
>  	return count;
>  }

All the changes inside this function are cosmetic and should be
reverted.

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
> -
> -static ssize_t
> -show_pwm_freq_reg(struct device *dev, char *buf, int nr)
> +static ssize_t show_pwm_freq(struct device *dev,
> +			     struct device_attribute *devattr, char *buf)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
>  	if (data->type = w83627hf)
>  		return sprintf(buf, "%ld\n",
> -			pwm_freq_from_reg_627hf(data->pwm_freq[nr - 1]));
> +			pwm_freq_from_reg_627hf(data->pwm_freq[nr-1]));
>  	else
>  		return sprintf(buf, "%ld\n",
> -			pwm_freq_from_reg(data->pwm_freq[nr - 1]));
> +			pwm_freq_from_reg(data->pwm_freq[nr-1]));
>  }
>  
> -static ssize_t
> -store_pwm_freq_reg(struct device *dev, const char *buf, size_t count, int nr)
> +static ssize_t store_pwm_freq(struct device *dev,
> +			      struct device_attribute *devattr,
> +			      const char *buf, size_t count)
>  {
> +	int nr = to_sensor_dev_attr(devattr)->index;
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
> -	static const u8 mask[]={0xF8, 0x8F};
> +	static const u8 mask[] = {0xF8, 0x8F};

Revert.

>  	u32 val;
>  
>  	val = simple_strtoul(buf, NULL, 10);
> @@ -931,49 +941,39 @@ store_pwm_freq_reg(struct device *dev, c
>  	mutex_lock(&data->update_lock);
>  
>  	if (data->type = w83627hf) {
> -		data->pwm_freq[nr - 1] = pwm_freq_to_reg_627hf(val);
> +		data->pwm_freq[nr-1] = pwm_freq_to_reg_627hf(val);
>  		w83627hf_write_value(data, W83627HF_REG_PWM_FREQ,
> -				(data->pwm_freq[nr - 1] << ((nr - 1)*4)) |
> +				(data->pwm_freq[nr-1] << ((nr-1)*4)) |
>  				(w83627hf_read_value(data,
> -				W83627HF_REG_PWM_FREQ) & mask[nr - 1]));
> +				W83627HF_REG_PWM_FREQ) & mask[nr-1]));
>  	} else {
> -		data->pwm_freq[nr - 1] = pwm_freq_to_reg(val);
> -		w83627hf_write_value(data, W83637HF_REG_PWM_FREQ[nr - 1],
> -				data->pwm_freq[nr - 1]);
> +		data->pwm_freq[nr-1] = pwm_freq_to_reg(val);
> +		w83627hf_write_value(data, W83637HF_REG_PWM_FREQ[nr-1],
> +				data->pwm_freq[nr-1]);
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
> +#define pwm_decl(offset)	\
> +static SENSOR_DEVICE_ATTR(pwm##offset, S_IRUGO | S_IWUSR,		\
> +			  show_pwm, store_pwm, offset);			\
> +static SENSOR_DEVICE_ATTR(pwm##offset##_freq, S_IRUGO | S_IWUSR,	\
> +			  show_pwm_freq, store_pwm_freq, offset);

Inside the callbacks, you always use "nr - 1", so you could pass
"offset - 1" here, and simplify the code inside the callbacks, same you
did for fan callbacks.

> +
> +pwm_decl(1);
> +pwm_decl(2);
> +pwm_decl(3);
>  
> -static ssize_t
> -show_sensor_reg(struct device *dev, char *buf, int nr)
> +static ssize_t show_sensor_reg(struct device *dev, char *buf, int nr)
>  {
>  	struct w83627hf_data *data = w83627hf_update_device(dev);
> -	return sprintf(buf, "%ld\n", (long) data->sens[nr - 1]);
> +	return sprintf(buf, "%ld\n", (long) data->sens[nr-1]);
>  }
>  
> -static ssize_t
> -store_sensor_reg(struct device *dev, const char *buf, size_t count, int nr)
> +static ssize_t store_sensor_reg(struct device *dev, const char *buf,
> +				size_t count, int nr)
>  {
>  	struct w83627hf_data *data = dev_get_drvdata(dev);
>  	u32 val, tmp;
> @@ -986,26 +986,26 @@ store_sensor_reg(struct device *dev, con
>  	case 1:		/* PII/Celeron diode */
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
>  		w83627hf_write_value(data, W83781D_REG_SCFG1,
> -				    tmp | BIT_SCFG1[nr - 1]);
> +				    tmp | BIT_SCFG1[nr-1]);
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG2);
>  		w83627hf_write_value(data, W83781D_REG_SCFG2,
> -				    tmp | BIT_SCFG2[nr - 1]);
> -		data->sens[nr - 1] = val;
> +				    tmp | BIT_SCFG2[nr-1]);
> +		data->sens[nr-1] = val;
>  		break;
>  	case 2:		/* 3904 */
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
>  		w83627hf_write_value(data, W83781D_REG_SCFG1,
> -				    tmp | BIT_SCFG1[nr - 1]);
> +				    tmp | BIT_SCFG1[nr-1]);
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG2);
>  		w83627hf_write_value(data, W83781D_REG_SCFG2,
> -				    tmp & ~BIT_SCFG2[nr - 1]);
> -		data->sens[nr - 1] = val;
> +				    tmp & ~BIT_SCFG2[nr-1]);
> +		data->sens[nr-1] = val;
>  		break;
>  	case W83781D_DEFAULT_BETA:	/* thermistor */
>  		tmp = w83627hf_read_value(data, W83781D_REG_SCFG1);
>  		w83627hf_write_value(data, W83781D_REG_SCFG1,
> -				    tmp & ~BIT_SCFG1[nr - 1]);
> -		data->sens[nr - 1] = val;
> +				    tmp & ~BIT_SCFG1[nr-1]);
> +		data->sens[nr-1] = val;
>  		break;
>  	default:
>  		dev_err(dev,

Either revert all these, of change them to just "nr" and adjust the
sysfs file declarations accordingly.

> @@ -1018,22 +1018,27 @@ store_sensor_reg(struct device *dev, con
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
> -
> -sysfs_sensor(1);
> -sysfs_sensor(2);
> -sysfs_sensor(3);
> +static ssize_t show_sensor(struct device *dev,
> +			   struct device_attribute *devattr, char *buf)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	return show_sensor_reg(dev, buf, nr);
> +}
> +static ssize_t store_sensor(struct device *dev,
> +			    struct device_attribute *devattr,
> +			    const char *buf, size_t count)
> +{
> +	int nr = to_sensor_dev_attr(devattr)->index;
> +	return store_sensor_reg(dev, buf, count, nr);
> +}

Here again, you should move all the code from store_sensor_reg directly
inside this function. You no longer need a wrapper.

> +
> +#define sensor_decl(offset) \
> +static SENSOR_DEVICE_ATTR(temp##offset##_type, S_IRUGO | S_IWUSR, \
> +			  show_sensor, store_sensor, offset);
> +
> +sensor_decl(1);
> +sensor_decl(2);
> +sensor_decl(3);

BTW, your patch would be somewhat smaller if you weren't renaming these
macros for no good reason I can see.

>  
>  static ssize_t show_name(struct device *dev, struct device_attribute
>  			 *devattr, char *buf)
> @@ -1098,14 +1103,15 @@ static int __init w83627hf_find(int sioa
>  	       superio_inb(WINB_BASE_REG + 1);
>  	*addr = val & WINB_ALIGNMENT;
>  	if (*addr = 0) {
> -		printk(KERN_WARNING DRVNAME ": Base address not set, "
> -		       "skipping\n");
> +		printk(KERN_WARNING DRVNAME
> +		       ": Base address not set, skipping\n");
>  		goto exit;
>  	}
>  
>  	val = superio_inb(WINB_ACT_REG);
>  	if (!(val & 0x01)) {
> -		printk(KERN_WARNING DRVNAME ": Enabling HWM logical device\n");
> +		printk(KERN_WARNING DRVNAME
> +		       ": Enabling HWM logical device\n");
>  		superio_outb(WINB_ACT_REG, val | 0x01);
>  	}
>  

Revert.

> @@ -1118,48 +1124,43 @@ static int __init w83627hf_find(int sioa
>  	return err;
>  }
>  
> +#define VIN_UNIT_ATTRS(X)	\
> +	&sensor_dev_attr_in##X##_input.dev_attr.attr,	    \
> +	&sensor_dev_attr_in##X##_min.dev_attr.attr,	    \
> +	&sensor_dev_attr_in##X##_max.dev_attr.attr
> +
> +#define FAN_UNIT_ATTRS(X)	\
> +	&sensor_dev_attr_fan##X##_input.dev_attr.attr,	    \
> +	&sensor_dev_attr_fan##X##_min.dev_attr.attr,	    \
> +	&sensor_dev_attr_fan##X##_div.dev_attr.attr
> +
> +#define TEMP_UNIT_ATTRS(X)	\
> +	&sensor_dev_attr_temp##X##_input.dev_attr.attr,		\
> +	&sensor_dev_attr_temp##X##_max.dev_attr.attr,		\
> +	&sensor_dev_attr_temp##X##_max_hyst.dev_attr.attr,	\
> +	&sensor_dev_attr_temp##X##_type.dev_attr.attr
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
> +
> +	VIN_UNIT_ATTRS(2),
> +	VIN_UNIT_ATTRS(3),
> +	VIN_UNIT_ATTRS(4),
> +	VIN_UNIT_ATTRS(7),
> +	VIN_UNIT_ATTRS(8),
> +	FAN_UNIT_ATTRS(1),
> +	FAN_UNIT_ATTRS(2),
> +	TEMP_UNIT_ATTRS(1),
> +	TEMP_UNIT_ATTRS(2),
>  
>  	&dev_attr_alarms.attr,
>  	&dev_attr_beep_enable.attr,
>  	&dev_attr_beep_mask.attr,
>  
> -	&dev_attr_pwm1.attr,
> -	&dev_attr_pwm2.attr,
> +	&sensor_dev_attr_pwm1.dev_attr.attr,
> +	&sensor_dev_attr_pwm2.dev_attr.attr,
>  
>  	&dev_attr_name.attr,
>  	NULL
> @@ -1170,30 +1171,17 @@ static const struct attribute_group w836
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
> +	FAN_UNIT_ATTRS(3),
> +	TEMP_UNIT_ATTRS(3),
> +
> +	&sensor_dev_attr_pwm3.dev_attr.attr,
> +
> +	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_freq.dev_attr.attr,
>  	NULL
>  };
>  
> @@ -1251,27 +1239,46 @@ static int __devinit w83627hf_probe(stru
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
> +				&sensor_dev_attr_in6_max.dev_attr))
> +		 /* tbd */

What does this comment mean?

> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_pwm1_freq.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_pwm2_freq.dev_attr)))
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
> @@ -1285,13 +1292,17 @@ static int __devinit w83627hf_probe(stru
>  
>  	if (data->type = w83627thf || data->type = w83637hf
>  	 || data->type = w83687thf)
> -		if ((err = device_create_file(dev, &dev_attr_pwm3)))
> +		if ((err = device_create_file(
> +				dev, &sensor_dev_attr_pwm3.dev_attr)))
>  			goto ERROR4;
>  
>  	if (data->type = w83637hf || data->type = w83687thf)
> -		if ((err = device_create_file(dev, &dev_attr_pwm1_freq))
> -		 || (err = device_create_file(dev, &dev_attr_pwm2_freq))
> -		 || (err = device_create_file(dev, &dev_attr_pwm3_freq)))
> +		if ((err = device_create_file(dev,
> +				&sensor_dev_attr_pwm1_freq.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_pwm1_freq.dev_attr))
> +		 || (err = device_create_file(dev,
> +				&sensor_dev_attr_pwm1_freq.dev_attr)))
>  			goto ERROR4;
>  
>  	data->class_dev = hwmon_device_register(dev);

Please provide an updated patch.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
