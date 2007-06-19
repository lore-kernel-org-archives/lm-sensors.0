From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 19 Jun 2007 11:21:59 +0000
Subject: Re: [lm-sensors] [PATCH for review] Add temperature-tracking mode
Message-Id: <20070619132159.056a1fa8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1182008300609@dmwebmail.belize.chezphil.org>
In-Reply-To: <1182008300609@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Sat, 16 Jun 2007 16:38:20 +0100, Phil Endecott wrote:
> This is a *first attempt* at a patch for the f71805f driver to add support for its
> temperature-tracking mode.  This compiles and I have some evidence that it works, but
> it has not been thoroughly tested.
> 
> Issues that I would like to resolve before submitting a final version include the
> following.  Some help will be needed.
> 
> - My hardware only has PWM control on pwm1, so I can only test that channel.  If
> someone with different hardware could please volunteer to help test, that would be
> great.

Unfortunately, I won't be able to help you with this, as my board also
has only pwm1 wired. But I still tested your patch on my board, that's
better than nothing. Verdict: it appears to work just fine :)

> - I plan to include documentation fixes in the final version.
> 
> - To clarify some of the Fintek documentation, there are indeed three fan/temp register
> pairs and it interpolates two other points between them.  The naming scheme of 1-5-9
> rather than 1-2-3 (or perhaps 1-3-5) is inexplicable.  Currently I have mapped their 1 to
> auto_point0, 5 to auto_point1 and 9 to auto_point2; however, it seems that (as Jean
> observed) this is not the expected order i.e. their 1 (my auto_point0) is for the highest
> temperature pair.  So I think that I will reverse this ordering in the final version.

Correct, my own experimental results confirm this.

> - I have not yet implemented the 'channels' files.  I plan to add these with read-only
> contents.

Not strictly necessary - at your option.

> I await your comments.

Here you go:

> Signed-off-by: Phil Endecott <spam_from_hwmon_patch_1@chezphil.org>
> 
> --- f71805f.c.orig	2007-06-16 00:10:54.000000000 +0100
> +++ f71805f.c	2007-06-16 16:17:43.000000000 +0100
> @@ -10,6 +10,8 @@
>   * The F71872F/FG is almost the same, with two more voltages monitored,
>   * and 6 VID inputs.
>   *
> + * Datasheets are available from the Fintek website.
> + *

Please instead update Documentation/hwmon/f71805f. The datasheets were
not available for download at the time I wrote the driver.

>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License as published by
>   * the Free Software Foundation; either version 2 of the License, or
> @@ -126,6 +128,9 @@
>  #define F71805F_REG_TEMP_HIGH(nr)	(0x54 + 2 * (nr))
>  #define F71805F_REG_TEMP_HYST(nr)	(0x55 + 2 * (nr))
>  #define F71805F_REG_TEMP_MODE		0x01
> +/* pwm/fan pwmnr from 0 to 2, auto point apnr from 0 to 2 */
> +#define F71805F_REG_PWM_AUTO_POINT_TEMP(pwmnr,apnr) (0xA0 + 0x10 * (pwmnr) + (apnr))
> +#define F71805F_REG_PWM_AUTO_POINT_FAN(pwmnr,apnr)  (0xA4 + 0x10 * (pwmnr) + 2 * (apnr))

Line length is limited to 80 columns, as per Documentation/CodingStyle.

>  
>  #define F71805F_REG_START		0x00
>  /* status nr from 0 to 2 */
> @@ -143,6 +148,11 @@
>   * Data structures and manipulation thereof
>   */
>  
> +struct f71805f_auto_point {
> +	u8 temp[3];
> +	u16 fan[3];
> +};
> +
>  struct f71805f_data {
>  	unsigned short addr;
>  	const char *name;
> @@ -169,6 +179,7 @@
>  	u8 temp_hyst[3];
>  	u8 temp_mode;
>  	unsigned long alarms;
> +	struct f71805f_auto_point auto_points[3];
>  };
>  
>  struct f71805f_sio_data {
> @@ -311,7 +322,7 @@
>  static struct f71805f_data *f71805f_update_device(struct device *dev)
>  {
>  	struct f71805f_data *data = dev_get_drvdata(dev);
> -	int nr;
> +	int nr, apnr;
>  
>  	mutex_lock(&data->update_lock);
>  
> @@ -341,6 +352,14 @@
>  					      F71805F_REG_TEMP_HYST(nr));
>  		}
>  		data->temp_mode = f71805f_read8(data, F71805F_REG_TEMP_MODE);
> +		for (nr = 0; nr < 3; nr++) {
> +			for (apnr = 0; apnr < 3; apnr++) {
> +				data->auto_points[nr].temp[apnr] > +					f71805f_read8(data,F71805F_REG_PWM_AUTO_POINT_TEMP(nr,apnr));

The usual coding style practice is to leave a space after the comma.
Makes the code much more readable.

> +				data->auto_points[nr].fan[apnr] > +					f71805f_read16(data,F71805F_REG_PWM_AUTO_POINT_FAN(nr,apnr));
> +			}
> +		}
>  
>  		data->last_limits = jiffies;
>  	}
> @@ -641,6 +660,7 @@
>  	return count;
>  }
>  
> +
>  static struct attribute *f71805f_attr_pwm[];
>  
>  static ssize_t set_pwm_enable(struct device *dev, struct device_attribute

Patch noise, scratch this.

> @@ -704,6 +724,68 @@
>  	return count;
>  }
>  
> +#define MK_AP_IDX(pwmnr,apnr) ((pwmnr)<<2|(apnr))
> +#define GET_PWM_NR(ap_idx)    ((ap_idx)>>2)
> +#define GET_AP_NR(ap_idx)     ((ap_idx)&3)
> +

Please just use SENSOR_DEVICE_ATTR_2 so that you don't need to combine
and decode the values.

> +static ssize_t show_pwm_auto_point_temp(struct device *dev, struct device_attribute *devattr,
> +				        char* buf)
> +{
> +	struct f71805f_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int pwmnr = GET_PWM_NR(attr->index);
> +	int apnr  = GET_AP_NR(attr->index);
> +
> +	return sprintf(buf, "%ld\n", temp_from_reg(data->auto_points[pwmnr].temp[apnr]));
> +}
> +
> +static ssize_t set_pwm_auto_point_temp(struct device *dev, struct device_attribute *devattr,
> +				       const char* buf, size_t count)
> +{
> +	struct f71805f_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int pwmnr = GET_PWM_NR(attr->index);
> +	int apnr  = GET_AP_NR(attr->index);
> +	unsigned long val = simple_strtoul(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	data->auto_points[pwmnr].temp[apnr] = temp_to_reg(val);
> +	f71805f_write8(data, F71805F_REG_PWM_AUTO_POINT_TEMP(pwmnr,apnr),
> +		       data->auto_points[pwmnr].temp[apnr]);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
> +static ssize_t show_pwm_auto_point_fan(struct device *dev, struct device_attribute *devattr,
> +				       char* buf)
> +{
> +	struct f71805f_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int pwmnr = GET_PWM_NR(attr->index);
> +	int apnr  = GET_AP_NR(attr->index);
> +
> +	return sprintf(buf, "%ld\n", fan_from_reg(data->auto_points[pwmnr].fan[apnr]));
> +}
> +
> +static ssize_t set_pwm_auto_point_fan(struct device *dev, struct device_attribute *devattr,
> +				      const char* buf, size_t count)
> +{
> +	struct f71805f_data *data = dev_get_drvdata(dev);
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> +	int pwmnr = GET_PWM_NR(attr->index);
> +	int apnr  = GET_AP_NR(attr->index);
> +	unsigned long val = simple_strtoul(buf, NULL, 10);
> +
> +	mutex_lock(&data->update_lock);
> +	data->auto_points[pwmnr].fan[apnr] = fan_to_reg(val);
> +	f71805f_write16(data, F71805F_REG_PWM_AUTO_POINT_FAN(pwmnr,apnr),
> +		        data->auto_points[pwmnr].fan[apnr]);
> +	mutex_unlock(&data->update_lock);
> +
> +	return count;
> +}
> +
>  static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
>  			 char *buf)
>  {
> @@ -931,6 +1013,45 @@
>  			  show_pwm_freq, set_pwm_freq, 2);
>  static SENSOR_DEVICE_ATTR(pwm3_mode, S_IRUGO, show_pwm_mode, NULL, 2);
>  
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point1_temp, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_temp, set_pwm_auto_point_temp, MK_AP_IDX(0,0));
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point1_fan, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_fan, set_pwm_auto_point_fan, MK_AP_IDX(0,0));
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point2_temp, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_temp, set_pwm_auto_point_temp, MK_AP_IDX(0,1));
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point2_fan, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_fan, set_pwm_auto_point_fan, MK_AP_IDX(0,1));
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point3_temp, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_temp, set_pwm_auto_point_temp, MK_AP_IDX(0,2));
> +static SENSOR_DEVICE_ATTR(pwm1_auto_point3_fan, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_fan, set_pwm_auto_point_fan, MK_AP_IDX(0,2));
> +
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point1_temp, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_temp, set_pwm_auto_point_temp, MK_AP_IDX(1,0));
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point1_fan, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_fan, set_pwm_auto_point_fan, MK_AP_IDX(1,0));
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point2_temp, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_temp, set_pwm_auto_point_temp, MK_AP_IDX(1,1));
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point2_fan, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_fan, set_pwm_auto_point_fan, MK_AP_IDX(1,1));
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point3_temp, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_temp, set_pwm_auto_point_temp, MK_AP_IDX(1,2));
> +static SENSOR_DEVICE_ATTR(pwm2_auto_point3_fan, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_fan, set_pwm_auto_point_fan, MK_AP_IDX(1,2));
> +
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point1_temp, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_temp, set_pwm_auto_point_temp, MK_AP_IDX(2,0));
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point1_fan, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_fan, set_pwm_auto_point_fan, MK_AP_IDX(2,0));
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point2_temp, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_temp, set_pwm_auto_point_temp, MK_AP_IDX(2,1));
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point2_fan, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_fan, set_pwm_auto_point_fan, MK_AP_IDX(2,1));
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point3_temp, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_temp, set_pwm_auto_point_temp, MK_AP_IDX(2,2));
> +static SENSOR_DEVICE_ATTR(pwm3_auto_point3_fan, S_IRUGO | S_IWUSR,
> +			  show_pwm_auto_point_fan, set_pwm_auto_point_fan, MK_AP_IDX(2,2));
> +
>  static SENSOR_DEVICE_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0);
>  static SENSOR_DEVICE_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1);
>  static SENSOR_DEVICE_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2);
> @@ -1013,6 +1134,25 @@
>  	&sensor_dev_attr_temp3_max_hyst.dev_attr.attr,
>  	&sensor_dev_attr_temp3_type.dev_attr.attr,
>  
> +	&sensor_dev_attr_pwm1_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point1_fan.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point2_fan.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm1_auto_point3_fan.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point1_fan.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point2_fan.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm2_auto_point3_fan.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point1_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point1_fan.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point2_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point2_fan.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point3_temp.dev_attr.attr,
> +	&sensor_dev_attr_pwm3_auto_point3_fan.dev_attr.attr,
> +
>  	&sensor_dev_attr_in0_alarm.dev_attr.attr,
>  	&sensor_dev_attr_in1_alarm.dev_attr.attr,
>  	&sensor_dev_attr_in2_alarm.dev_attr.attr,

I'm waiting for the next iteration of this patch, then we can push it
upstream.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
