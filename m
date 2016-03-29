From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Mar 2016 20:01:26 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: adc128d818: Implement operation mode 1
Message-Id: <20160329200126.GB27318@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1459278219-5573-1-git-send-email-mail@alexanderkoch.net>
 <1459278219-5573-3-git-send-email-mail@alexanderkoch.net>
In-Reply-To: <1459278219-5573-3-git-send-email-mail@alexanderkoch.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Koch <mail@alexanderkoch.net>
Cc: Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Michael Hornung <mhornung.linux@gmail.com>

On Tue, Mar 29, 2016 at 09:03:39PM +0200, Alexander Koch wrote:
> Implement chip operation mode 1 (see datasheet sec. 8.4.1) which offers an
> additional analog input signal on channel 7 but no temperature reading.
> 
> Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
> Michael Hornung <mhornung.linux@gmail.com>
> ---
>  drivers/hwmon/adc128d818.c | 48 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/adc128d818.c b/drivers/hwmon/adc128d818.c
> index 7505d4e..d29ba36 100644
> --- a/drivers/hwmon/adc128d818.c
> +++ b/drivers/hwmon/adc128d818.c
> @@ -298,6 +298,13 @@ static SENSOR_DEVICE_ATTR_2(in6_min, S_IWUSR | S_IRUGO,
>  static SENSOR_DEVICE_ATTR_2(in6_max, S_IWUSR | S_IRUGO,
>  			    adc128_show_in, adc128_set_in, 6, 2);
>  
> +static SENSOR_DEVICE_ATTR_2(in7_input, S_IRUGO,
> +			    adc128_show_in, NULL, 7, 0);
> +static SENSOR_DEVICE_ATTR_2(in7_min, S_IWUSR | S_IRUGO,
> +			    adc128_show_in, adc128_set_in, 7, 1);
> +static SENSOR_DEVICE_ATTR_2(in7_max, S_IWUSR | S_IRUGO,
> +			    adc128_show_in, adc128_set_in, 7, 2);
> +
>  static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, adc128_show_temp, NULL, 0);
>  static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
>  			  adc128_show_temp, adc128_set_temp, 1);
> @@ -311,6 +318,7 @@ static SENSOR_DEVICE_ATTR(in3_alarm, S_IRUGO, adc128_show_alarm, NULL, 3);
>  static SENSOR_DEVICE_ATTR(in4_alarm, S_IRUGO, adc128_show_alarm, NULL, 4);
>  static SENSOR_DEVICE_ATTR(in5_alarm, S_IRUGO, adc128_show_alarm, NULL, 5);
>  static SENSOR_DEVICE_ATTR(in6_alarm, S_IRUGO, adc128_show_alarm, NULL, 6);
> +static SENSOR_DEVICE_ATTR(in7_alarm, S_IRUGO, adc128_show_alarm, NULL, 7);
>  static SENSOR_DEVICE_ATTR(temp1_max_alarm, S_IRUGO, adc128_show_alarm, NULL, 7);
>  
>  static struct attribute *adc128m0_attrs[] = {
> @@ -349,6 +357,42 @@ static struct attribute *adc128m0_attrs[] = {
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(adc128m0);
> +static struct attribute *adc128m1_attrs[] = {
> +	&sensor_dev_attr_in0_min.dev_attr.attr,
> +	&sensor_dev_attr_in1_min.dev_attr.attr,
> +	&sensor_dev_attr_in2_min.dev_attr.attr,
> +	&sensor_dev_attr_in3_min.dev_attr.attr,
> +	&sensor_dev_attr_in4_min.dev_attr.attr,
> +	&sensor_dev_attr_in5_min.dev_attr.attr,
> +	&sensor_dev_attr_in6_min.dev_attr.attr,
> +	&sensor_dev_attr_in7_min.dev_attr.attr,
> +	&sensor_dev_attr_in0_max.dev_attr.attr,
> +	&sensor_dev_attr_in1_max.dev_attr.attr,
> +	&sensor_dev_attr_in2_max.dev_attr.attr,
> +	&sensor_dev_attr_in3_max.dev_attr.attr,
> +	&sensor_dev_attr_in4_max.dev_attr.attr,
> +	&sensor_dev_attr_in5_max.dev_attr.attr,
> +	&sensor_dev_attr_in6_max.dev_attr.attr,
> +	&sensor_dev_attr_in7_max.dev_attr.attr,
> +	&sensor_dev_attr_in0_input.dev_attr.attr,
> +	&sensor_dev_attr_in1_input.dev_attr.attr,
> +	&sensor_dev_attr_in2_input.dev_attr.attr,
> +	&sensor_dev_attr_in3_input.dev_attr.attr,
> +	&sensor_dev_attr_in4_input.dev_attr.attr,
> +	&sensor_dev_attr_in5_input.dev_attr.attr,
> +	&sensor_dev_attr_in6_input.dev_attr.attr,
> +	&sensor_dev_attr_in7_input.dev_attr.attr,
> +	&sensor_dev_attr_in0_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in1_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in2_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in3_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in4_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in5_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in6_alarm.dev_attr.attr,
> +	&sensor_dev_attr_in7_alarm.dev_attr.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(adc128m1);
>  
No, this is not how to do it. You have two options:

- define multiple groups, and add groups as needed. 
  For example, you would have one group for in0..in3, one for in4..in5, one
  for in6, and one for in7, plus one for temp1. This would cover all
  operational modes.

  Then use a bitmap for supported voltages in a given mode, and use that bit map
  to determine if a voltage sensor is supported or not. For temperature you can
  use a boolean, or declare that the temperature sensor is available if in7
  is not available. This way you don't always have to check the operational mode
  when updating sensor values.

- Use a single group and is_visible() to determine is a sensor is visible or
  not (in combination with the bit map suggested above). This would probably
  be the simpler solution.

Guenter

>  static int adc128_detect(struct i2c_client *client, struct i2c_board_info *info)
>  {
> @@ -456,7 +500,9 @@ static int adc128_probe(struct i2c_client *client,
>  	data->mode = 0;
>  	groups = adc128m0_groups;
>  	if (of_property_read_u8(dev->of_node, "mode", &data->mode) = 0) {
> -		if (data->mode != 0) {
> +		if (data->mode = 1) {
> +			groups = adc128m1_groups;
> +		} else if (data->mode != 0) {
>  			dev_err(dev, "unsupported operation mode %d",
>  				data->mode);
>  			err = -EINVAL;
> -- 
> 2.7.4
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
