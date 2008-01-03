From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 03 Jan 2008 22:43:31 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (asb100) De-macro the
Message-Id: <477D6513.6060200@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Looks good,

Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>

Regards,

Hans



Jean Delvare wrote:
> Use standard dynamic sysfs callbacks instead of macro-generated
> wrappers. This makes the code more readable, and the binary smaller
> (by about 12%).
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> ---
> The previous patch was supposed to be numbered "1/3" but I hit "Send"
> too fast, sorry for the confusion.
> 
>  drivers/hwmon/asb100.c |  233 +++++++++++++++++++-----------------------------
>  1 file changed, 90 insertions(+), 143 deletions(-)
> 
> --- linux-2.6.24-rc6.orig/drivers/hwmon/asb100.c	2007-12-31 14:19:19.000000000 +0100
> +++ linux-2.6.24-rc6/drivers/hwmon/asb100.c	2007-12-31 14:20:32.000000000 +0100
> @@ -40,6 +40,7 @@
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
>  #include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <linux/hwmon-vid.h>
>  #include <linux/err.h>
>  #include <linux/init.h>
> @@ -221,8 +222,10 @@ static struct i2c_driver asb100_driver >  
>  /* 7 Voltages */
>  #define show_in_reg(reg) \
> -static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> +static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
> +		char *buf) \
>  { \
> +	int nr = to_sensor_dev_attr(attr)->index; \
>  	struct asb100_data *data = asb100_update_device(dev); \
>  	return sprintf(buf, "%d\n", IN_FROM_REG(data->reg[nr])); \
>  }
> @@ -232,9 +235,10 @@ show_in_reg(in_min)
>  show_in_reg(in_max)
>  
>  #define set_in_reg(REG, reg) \
> -static ssize_t set_in_##reg(struct device *dev, const char *buf, \
> -		size_t count, int nr) \
> +static ssize_t set_in_##reg(struct device *dev, struct device_attribute *attr, \
> +		const char *buf, size_t count) \
>  { \
> +	int nr = to_sensor_dev_attr(attr)->index; \
>  	struct i2c_client *client = to_i2c_client(dev); \
>  	struct asb100_data *data = i2c_get_clientdata(client); \
>  	unsigned long val = simple_strtoul(buf, NULL, 10); \
> @@ -251,37 +255,12 @@ set_in_reg(MIN, min)
>  set_in_reg(MAX, max)
>  
>  #define sysfs_in(offset) \
> -static ssize_t \
> -	show_in##offset (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_in(dev, buf, offset); \
> -} \
> -static DEVICE_ATTR(in##offset##_input, S_IRUGO, \
> -		show_in##offset, NULL); \
> -static ssize_t \
> -	show_in##offset##_min (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_in_min(dev, buf, offset); \
> -} \
> -static ssize_t \
> -	show_in##offset##_max (struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_in_max(dev, buf, offset); \
> -} \
> -static ssize_t set_in##offset##_min (struct device *dev, struct device_attribute *attr, \
> -		const char *buf, size_t count) \
> -{ \
> -	return set_in_min(dev, buf, count, offset); \
> -} \
> -static ssize_t set_in##offset##_max (struct device *dev, struct device_attribute *attr, \
> -		const char *buf, size_t count) \
> -{ \
> -	return set_in_max(dev, buf, count, offset); \
> -} \
> -static DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
> -		show_in##offset##_min, set_in##offset##_min); \
> -static DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, \
> -		show_in##offset##_max, set_in##offset##_max);
> +static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO, \
> +		show_in, NULL, offset); \
> +static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR, \
> +		show_in_min, set_in_min, offset); \
> +static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR, \
> +		show_in_max, set_in_max, offset)
>  
>  sysfs_in(0);
>  sysfs_in(1);
> @@ -292,29 +271,36 @@ sysfs_in(5);
>  sysfs_in(6);
>  
>  /* 3 Fans */
> -static ssize_t show_fan(struct device *dev, char *buf, int nr)
> +static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
> +		char *buf)
>  {
> +	int nr = to_sensor_dev_attr(attr)->index;
>  	struct asb100_data *data = asb100_update_device(dev);
>  	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
>  		DIV_FROM_REG(data->fan_div[nr])));
>  }
>  
> -static ssize_t show_fan_min(struct device *dev, char *buf, int nr)
> +static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
> +		char *buf)
>  {
> +	int nr = to_sensor_dev_attr(attr)->index;
>  	struct asb100_data *data = asb100_update_device(dev);
>  	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr],
>  		DIV_FROM_REG(data->fan_div[nr])));
>  }
>  
> -static ssize_t show_fan_div(struct device *dev, char *buf, int nr)
> +static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
> +		char *buf)
>  {
> +	int nr = to_sensor_dev_attr(attr)->index;
>  	struct asb100_data *data = asb100_update_device(dev);
>  	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
>  }
>  
> -static ssize_t set_fan_min(struct device *dev, const char *buf,
> -				size_t count, int nr)
> +static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
>  {
> +	int nr = to_sensor_dev_attr(attr)->index;
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct asb100_data *data = i2c_get_clientdata(client);
>  	u32 val = simple_strtoul(buf, NULL, 10);
> @@ -330,9 +316,10 @@ static ssize_t set_fan_min(struct device
>     determined in part by the fan divisor.  This follows the principle of
>     least surprise; the user doesn't expect the fan minimum to change just
>     because the divisor changed. */
> -static ssize_t set_fan_div(struct device *dev, const char *buf,
> -				size_t count, int nr)
> +static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
> +		const char *buf, size_t count)
>  {
> +	int nr = to_sensor_dev_attr(attr)->index;
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct asb100_data *data = i2c_get_clientdata(client);
>  	unsigned long min;
> @@ -375,34 +362,12 @@ static ssize_t set_fan_div(struct device
>  }
>  
>  #define sysfs_fan(offset) \
> -static ssize_t show_fan##offset(struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_fan(dev, buf, offset - 1); \
> -} \
> -static ssize_t show_fan##offset##_min(struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_fan_min(dev, buf, offset - 1); \
> -} \
> -static ssize_t show_fan##offset##_div(struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_fan_div(dev, buf, offset - 1); \
> -} \
> -static ssize_t set_fan##offset##_min(struct device *dev, struct device_attribute *attr, const char *buf, \
> -					size_t count) \
> -{ \
> -	return set_fan_min(dev, buf, count, offset - 1); \
> -} \
> -static ssize_t set_fan##offset##_div(struct device *dev, struct device_attribute *attr, const char *buf, \
> -					size_t count) \
> -{ \
> -	return set_fan_div(dev, buf, count, offset - 1); \
> -} \
> -static DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
> -		show_fan##offset, NULL); \
> -static DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
> -		show_fan##offset##_min, set_fan##offset##_min); \
> -static DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
> -		show_fan##offset##_div, set_fan##offset##_div);
> +static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO, \
> +		show_fan, NULL, offset - 1); \
> +static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR, \
> +		show_fan_min, set_fan_min, offset - 1); \
> +static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR, \
> +		show_fan_div, set_fan_div, offset - 1)
>  
>  sysfs_fan(1);
>  sysfs_fan(2);
> @@ -425,8 +390,10 @@ static int sprintf_temp_from_reg(u16 reg
>  }
>  
>  #define show_temp_reg(reg) \
> -static ssize_t show_##reg(struct device *dev, char *buf, int nr) \
> +static ssize_t show_##reg(struct device *dev, struct device_attribute *attr, \
> +		char *buf) \
>  { \
> +	int nr = to_sensor_dev_attr(attr)->index; \
>  	struct asb100_data *data = asb100_update_device(dev); \
>  	return sprintf_temp_from_reg(data->reg[nr], buf, nr); \
>  }
> @@ -436,9 +403,10 @@ show_temp_reg(temp_max);
>  show_temp_reg(temp_hyst);
>  
>  #define set_temp_reg(REG, reg) \
> -static ssize_t set_##reg(struct device *dev, const char *buf, \
> -			size_t count, int nr) \
> +static ssize_t set_##reg(struct device *dev, struct device_attribute *attr, \
> +		const char *buf, size_t count) \
>  { \
> +	int nr = to_sensor_dev_attr(attr)->index; \
>  	struct i2c_client *client = to_i2c_client(dev); \
>  	struct asb100_data *data = i2c_get_clientdata(client); \
>  	long val = simple_strtol(buf, NULL, 10); \
> @@ -462,33 +430,12 @@ set_temp_reg(MAX, temp_max);
>  set_temp_reg(HYST, temp_hyst);
>  
>  #define sysfs_temp(num) \
> -static ssize_t show_temp##num(struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_temp(dev, buf, num-1); \
> -} \
> -static DEVICE_ATTR(temp##num##_input, S_IRUGO, show_temp##num, NULL); \
> -static ssize_t show_temp_max##num(struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_temp_max(dev, buf, num-1); \
> -} \
> -static ssize_t set_temp_max##num(struct device *dev, struct device_attribute *attr, const char *buf, \
> -					size_t count) \
> -{ \
> -	return set_temp_max(dev, buf, count, num-1); \
> -} \
> -static DEVICE_ATTR(temp##num##_max, S_IRUGO | S_IWUSR, \
> -		show_temp_max##num, set_temp_max##num); \
> -static ssize_t show_temp_hyst##num(struct device *dev, struct device_attribute *attr, char *buf) \
> -{ \
> -	return show_temp_hyst(dev, buf, num-1); \
> -} \
> -static ssize_t set_temp_hyst##num(struct device *dev, struct device_attribute *attr, const char *buf, \
> -					size_t count) \
> -{ \
> -	return set_temp_hyst(dev, buf, count, num-1); \
> -} \
> -static DEVICE_ATTR(temp##num##_max_hyst, S_IRUGO | S_IWUSR, \
> -		show_temp_hyst##num, set_temp_hyst##num);
> +static SENSOR_DEVICE_ATTR(temp##num##_input, S_IRUGO, \
> +		show_temp, NULL, num - 1); \
> +static SENSOR_DEVICE_ATTR(temp##num##_max, S_IRUGO | S_IWUSR, \
> +		show_temp_max, set_temp_max, num - 1); \
> +static SENSOR_DEVICE_ATTR(temp##num##_max_hyst, S_IRUGO | S_IWUSR, \
> +		show_temp_hyst, set_temp_hyst, num - 1)
>  
>  sysfs_temp(1);
>  sysfs_temp(2);
> @@ -583,50 +530,50 @@ static DEVICE_ATTR(pwm1_enable, S_IRUGO 
>  		show_pwm_enable1, set_pwm_enable1);
>  
>  static struct attribute *asb100_attributes[] = {
> -	&dev_attr_in0_input.attr,
> -	&dev_attr_in0_min.attr,
> -	&dev_attr_in0_max.attr,
> -	&dev_attr_in1_input.attr,
> -	&dev_attr_in1_min.attr,
> -	&dev_attr_in1_max.attr,
> -	&dev_attr_in2_input.attr,
> -	&dev_attr_in2_min.attr,
> -	&dev_attr_in2_max.attr,
> -	&dev_attr_in3_input.attr,
> -	&dev_attr_in3_min.attr,
> -	&dev_attr_in3_max.attr,
> -	&dev_attr_in4_input.attr,
> -	&dev_attr_in4_min.attr,
> -	&dev_attr_in4_max.attr,
> -	&dev_attr_in5_input.attr,
> -	&dev_attr_in5_min.attr,
> -	&dev_attr_in5_max.attr,
> -	&dev_attr_in6_input.attr,
> -	&dev_attr_in6_min.attr,
> -	&dev_attr_in6_max.attr,
> -
> -	&dev_attr_fan1_input.attr,
> -	&dev_attr_fan1_min.attr,
> -	&dev_attr_fan1_div.attr,
> -	&dev_attr_fan2_input.attr,
> -	&dev_attr_fan2_min.attr,
> -	&dev_attr_fan2_div.attr,
> -	&dev_attr_fan3_input.attr,
> -	&dev_attr_fan3_min.attr,
> -	&dev_attr_fan3_div.attr,
> -
> -	&dev_attr_temp1_input.attr,
> -	&dev_attr_temp1_max.attr,
> -	&dev_attr_temp1_max_hyst.attr,
> -	&dev_attr_temp2_input.attr,
> -	&dev_attr_temp2_max.attr,
> -	&dev_attr_temp2_max_hyst.attr,
> -	&dev_attr_temp3_input.attr,
> -	&dev_attr_temp3_max.attr,
> -	&dev_attr_temp3_max_hyst.attr,
> -	&dev_attr_temp4_input.attr,
> -	&dev_attr_temp4_max.attr,
> -	&dev_attr_temp4_max_hyst.attr,
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	&sensor_dev_attr_in0_min.dev_attr.attr,
> +	&sensor_dev_attr_in0_max.dev_attr.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_min.dev_attr.attr,
> +	&sensor_dev_attr_in1_max.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_min.dev_attr.attr,
> +	&sensor_dev_attr_in2_max.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_min.dev_attr.attr,
> +	&sensor_dev_attr_in3_max.dev_attr.attr,
> +	&sensor_dev_attr_in4_input.dev_attr.attr,
> +	&sensor_dev_attr_in4_min.dev_attr.attr,
> +	&sensor_dev_attr_in4_max.dev_attr.attr,
> +	&sensor_dev_attr_in5_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_min.dev_attr.attr,
> +	&sensor_dev_attr_in5_max.dev_attr.attr,
> +	&sensor_dev_attr_in6_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_min.dev_attr.attr,
> +	&sensor_dev_attr_in6_max.dev_attr.attr,
> +
> +	&sensor_dev_attr_fan1_input.dev_attr.attr,
> +	&sensor_dev_attr_fan1_min.dev_attr.attr,
> +	&sensor_dev_attr_fan1_div.dev_attr.attr,
> +	&sensor_dev_attr_fan2_input.dev_attr.attr,
> +	&sensor_dev_attr_fan2_min.dev_attr.attr,
> +	&sensor_dev_attr_fan2_div.dev_attr.attr,
> +	&sensor_dev_attr_fan3_input.dev_attr.attr,
> +	&sensor_dev_attr_fan3_min.dev_attr.attr,
> +	&sensor_dev_attr_fan3_div.dev_attr.attr,
> +
> +	&sensor_dev_attr_temp1_input.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max.dev_attr.attr,
> +	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp2_input.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max.dev_attr.attr,
> +	&sensor_dev_attr_temp2_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp3_input.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max.dev_attr.attr,
> +	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
> +	&sensor_dev_attr_temp4_input.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max.dev_attr.attr,
> +	&sensor_dev_attr_temp4_max_hyst.dev_attr.attr,
>  
>  	&dev_attr_cpu0_vid.attr,
>  	&dev_attr_vrm.attr,
> 
> 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
