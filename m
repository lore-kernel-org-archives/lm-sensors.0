From: Mark van Doesburg <mark.vandoesburg@hetnet.nl>
Date: Tue, 07 Oct 2008 18:36:17 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] f71882.c driver,
Message-Id: <200810071836.m97IaHon030300@localhost>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_48ebac21.clOe3IH4xtec8Tc9ik4uDV09id9PxxciOXQdtjnmXm72HpsM"
List-Id: <lm-sensors.vger.kernel.org>
References: <200806110520.m5B5KDgO018954@localhost>
In-Reply-To: <200806110520.m5B5KDgO018954@localhost>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--=_48ebac21.clOe3IH4xtec8Tc9ik4uDV09id9PxxciOXQdtjnmXm72HpsM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Hans,

I've fixed the patch, and used scripts/Lindent to fix the style
issues. I've also removed a few assignments in conditions.

regards,

Mark.


Hans de Goede <j.w.r.degoede@hhs.nl> wrote:

	Mark van Doesburg wrote:
	> Hello Hans,
	> 
	> I'm sorry for the previous mail, I got the parameters for ATTR_2 reversed.
	> So here are the patches again, and now it works.
	> 
	> Regards,
	> 
	> Mark.
	> 

	Hi Mark,

	Sorry for taking so long, it has been a month since you submitted this patch :(

	Anyways I've done a very detailed review, and you will need to fix some things 
	before your patch can be applied. You can do so in another incremental patch, 
	or redo the second patch of your set, whichever you prefer.

	Here are the results of my review, I've been taking quick notes while digging 
	through the code, so some things may be written down a bit short, if you don't 
	understand please ask me to clarify!

	MUST FIX
	--------
	* pwm#_point1_temp_hyst should be an absolute value (the temp value when the
	   switch back to a lower speed zone is made), not a delta
	* All pwm#_point#_temp's have a hyst, so report it for all, as its shared only
	   make it writable for point1
	* there are only 4 temp points per pwm but in f71882fg_update_device() 5 get
	   read.
	* in store_pwm_enable when disabling pwm not only set pwm to 255 but also make
	   sure its not in automatic mode.
	* forcing pwm and rpm *comments* are reversed in store_pwm_enable()
	* in all store_foo functions update the copy of registers in your data struct
	   when you write these registers, and do this before unlocking the data struct
	   lock, otherwise a read done quickly after a write could return the old value.
	   Or worse a write done quickly after another write on a register shared
	   between multiple pwm's could undo the changes done to that reg for the other
	   pwm!!
	* in all store_foo functions take the lock earlier, before reading any
	   register copies from the data struct, otherwise 2 writes running concurrently
	   could result in bogus data being written when they use a shared register
	* in all store_foo functions clamp the return value from simple_strtol to the
	   allowable range to avoid writing bogus values like for example storing a pwm
	   setting of 355 (max is 255, so clamp this to 255). Do this campling using
	   the SENSORS_LIMIT macro, for more on this see the "sysfs attribute writes
	   interpretation" chapter at the end of Documentation/hwmon/sysfs-interface


	SHOULD FIX
	----------
	* fix many code style issues, the linux kernel code style mandates that you
	   always put a space between an operation and its operands so do not write:
	   "a+b" but write "a + b", there is a script called check-patch in the kernel
	   tree which you can run on your patch which should detect most code style
	   issues. Note that this script will complain about the use of simple_strtoul,
	   ignore this, the script is right that recently a better solution has become
	   available, but as all hwmon drivers currently use simple_strtoul, please
	   keep using that for consistency.
	* pwm_type is read but not used.
	* in show_pwm_auto_point_temp_hyst() :
	   * drop the default case in the switch statement, nr never is anything
	     but 0 - 3, and if it would be anything different returning -EINVAL
	     would be much more appropriate

	Once I receive a new patch from you fixing all above MUST FIX items, I'll 
	forward it to Andrew Morton for 2.6.27 inclusion (assuming you are quicker then 
	me in fixing your patch).

	Thans & Regards,

	Hans



	> 
	> --- /tmp/linux-2.6.25.4/drivers/hwmon/f71882fg.c	2008-05-15 17:00:12.000000000 +0200
	> +++ attr2	2008-06-30 22:57:54.000000000 +0200
	> @@ -194,79 +194,79 @@
	>  	__ATTR( name, S_IRUGO, show_name, NULL ),
	>  };
	>  
	> -static struct sensor_device_attribute f71882fg_in_temp_attr[] =
	> +static struct sensor_device_attribute_2 f71882fg_in_temp_attr[] =
	>  {
	> -	SENSOR_ATTR(in0_input, S_IRUGO, show_in, NULL, 0),
	> -	SENSOR_ATTR(in1_input, S_IRUGO, show_in, NULL, 1),
	> -	SENSOR_ATTR(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max, 1),
	> -	SENSOR_ATTR(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep, 1),
	> -	SENSOR_ATTR(in1_alarm, S_IRUGO, show_in_alarm, NULL, 1),
	> -	SENSOR_ATTR(in2_input, S_IRUGO, show_in, NULL, 2),
	> -	SENSOR_ATTR(in3_input, S_IRUGO, show_in, NULL, 3),
	> -	SENSOR_ATTR(in4_input, S_IRUGO, show_in, NULL, 4),
	> -	SENSOR_ATTR(in5_input, S_IRUGO, show_in, NULL, 5),
	> -	SENSOR_ATTR(in6_input, S_IRUGO, show_in, NULL, 6),
	> -	SENSOR_ATTR(in7_input, S_IRUGO, show_in, NULL, 7),
	> -	SENSOR_ATTR(in8_input, S_IRUGO, show_in, NULL, 8),
	> -	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0),
	> -	SENSOR_ATTR(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
	> -		store_temp_max, 0),
	> -	SENSOR_ATTR(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
	> -		store_temp_max_hyst, 0),
	> -	SENSOR_ATTR(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
	> -		store_temp_crit, 0),
	> -	SENSOR_ATTR(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0),
	> -	SENSOR_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0),
	> -	SENSOR_ATTR(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
	> -		store_temp_beep, 0),
	> -	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0),
	> -	SENSOR_ATTR(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0),
	> -	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1),
	> -	SENSOR_ATTR(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
	> -		store_temp_max, 1),
	> -	SENSOR_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
	> -		store_temp_max_hyst, 1),
	> -	SENSOR_ATTR(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
	> -		store_temp_crit, 1),
	> -	SENSOR_ATTR(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 1),
	> -	SENSOR_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1),
	> -	SENSOR_ATTR(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
	> -		store_temp_beep, 1),
	> -	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 1),
	> -	SENSOR_ATTR(temp2_fault, S_IRUGO, show_temp_fault, NULL, 1),
	> -	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2),
	> -	SENSOR_ATTR(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
	> -		store_temp_max, 2),
	> -	SENSOR_ATTR(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
	> -		store_temp_max_hyst, 2),
	> -	SENSOR_ATTR(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
	> -		store_temp_crit, 2),
	> -	SENSOR_ATTR(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 2),
	> -	SENSOR_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2),
	> -	SENSOR_ATTR(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
	> -		store_temp_beep, 2),
	> -	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 2),
	> -	SENSOR_ATTR(temp3_fault, S_IRUGO, show_temp_fault, NULL, 2)
	> +	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
	> +	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
	> +	SENSOR_ATTR_2(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max, 0, 1),
	> +	SENSOR_ATTR_2(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep, 0, 1),
	> +	SENSOR_ATTR_2(in1_alarm, S_IRUGO, show_in_alarm, NULL, 0, 1),
	> +	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
	> +	SENSOR_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 0, 3),
	> +	SENSOR_ATTR_2(in4_input, S_IRUGO, show_in, NULL, 0, 4),
	> +	SENSOR_ATTR_2(in5_input, S_IRUGO, show_in, NULL, 0, 5),
	> +	SENSOR_ATTR_2(in6_input, S_IRUGO, show_in, NULL, 0, 6),
	> +	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 0, 7),
	> +	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 0, 8),
	> +	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
	> +	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
	> +		store_temp_max, 0, 0),
	> +	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
	> +		store_temp_max_hyst, 0, 0),
	> +	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
	> +		store_temp_crit, 0, 0),
	> +	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0, 0),
	> +	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 0),
	> +	SENSOR_ATTR_2(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
	> +		store_temp_beep, 0, 0),
	> +	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 0),
	> +	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 0),
	> +	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1),
	> +	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
	> +		store_temp_max, 0, 1),
	> +	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
	> +		store_temp_max_hyst, 0, 1),
	> +	SENSOR_ATTR_2(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
	> +		store_temp_crit, 0, 1),
	> +	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0, 1),
	> +	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 1),
	> +	SENSOR_ATTR_2(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
	> +		store_temp_beep, 0, 1),
	> +	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
	> +	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
	> +	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2),
	> +	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
	> +		store_temp_max, 0, 2),
	> +	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
	> +		store_temp_max_hyst, 0, 2),
	> +	SENSOR_ATTR_2(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
	> +		store_temp_crit, 0, 2),
	> +	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0, 2),
	> +	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 2),
	> +	SENSOR_ATTR_2(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
	> +		store_temp_beep, 0, 2),
	> +	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
	> +	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2)
	>  };
	>  
	> -static struct sensor_device_attribute f71882fg_fan_attr[] =
	> +static struct sensor_device_attribute_2 f71882fg_fan_attr[] =
	>  {
	> -	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
	> -	SENSOR_ATTR(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	> -		store_fan_beep, 0),
	> -	SENSOR_ATTR(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0),
	> -	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
	> -	SENSOR_ATTR(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	> -		store_fan_beep, 1),
	> -	SENSOR_ATTR(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 1),
	> -	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
	> -	SENSOR_ATTR(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	> -		store_fan_beep, 2),
	> -	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 2),
	> -	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
	> -	SENSOR_ATTR(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	> -		store_fan_beep, 3),
	> -	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 3)
	> +	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
	> +	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	> +		store_fan_beep, 0, 0),
	> +	SENSOR_ATTR_2(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 0),
	> +	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
	> +	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	> +		store_fan_beep, 0, 1),
	> +	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
	> +	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
	> +	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	> +		store_fan_beep, 0, 2),
	> +	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
	> +	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
	> +	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	> +		store_fan_beep, 0, 3),
	> +	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3)
	>  };
	>  
	>  
	> @@ -423,7 +423,7 @@
	>  	char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  	int speed = fan_from_reg(data->fan[nr]);
	>  
	>  	if (speed == FAN_MIN_DETECT)
	> @@ -436,7 +436,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	if (data->fan_beep & (1 << nr))
	>  		return sprintf(buf, "1\n");
	> @@ -448,7 +448,7 @@
	>  	*devattr, const char *buf, size_t count)
	>  {
	>  	struct f71882fg_data *data = dev_get_drvdata(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  	int val = simple_strtoul(buf, NULL, 10);
	>  
	>  	mutex_lock(&data->update_lock);
	> @@ -467,7 +467,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	if (data->fan_status & (1 << nr))
	>  		return sprintf(buf, "1\n");
	> @@ -479,7 +479,7 @@
	>  	char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	return sprintf(buf, "%d\n", data->in[nr] * 8);
	>  }
	> @@ -513,7 +513,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	if (data->in_beep & (1 << nr))
	>  		return sprintf(buf, "1\n");
	> @@ -525,7 +525,7 @@
	>  	*devattr, const char *buf, size_t count)
	>  {
	>  	struct f71882fg_data *data = dev_get_drvdata(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  	int val = simple_strtoul(buf, NULL, 10);
	>  
	>  	mutex_lock(&data->update_lock);
	> @@ -544,7 +544,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	if (data->in_status & (1 << nr))
	>  		return sprintf(buf, "1\n");
	> @@ -556,7 +556,7 @@
	>  	char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	return sprintf(buf, "%d\n", data->temp[nr] * 1000);
	>  }
	> @@ -565,7 +565,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	return sprintf(buf, "%d\n", data->temp_high[nr] * 1000);
	>  }
	> @@ -574,7 +574,7 @@
	>  	*devattr, const char *buf, size_t count)
	>  {
	>  	struct f71882fg_data *data = dev_get_drvdata(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  	int val = simple_strtoul(buf, NULL, 10) / 1000;
	>  
	>  	if (val > 255)
	> @@ -592,7 +592,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	return sprintf(buf, "%d\n",
	>  		(data->temp_high[nr] - data->temp_hyst[nr]) * 1000);
	> @@ -602,7 +602,7 @@
	>  	*devattr, const char *buf, size_t count)
	>  {
	>  	struct f71882fg_data *data = dev_get_drvdata(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  	int val = simple_strtoul(buf, NULL, 10) / 1000;
	>  	ssize_t ret = count;
	>  
	> @@ -642,7 +642,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	return sprintf(buf, "%d\n", data->temp_ovt[nr] * 1000);
	>  }
	> @@ -651,7 +651,7 @@
	>  	*devattr, const char *buf, size_t count)
	>  {
	>  	struct f71882fg_data *data = dev_get_drvdata(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  	int val = simple_strtoul(buf, NULL, 10) / 1000;
	>  
	>  	if (val > 255)
	> @@ -669,7 +669,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	return sprintf(buf, "%d\n",
	>  		(data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000);
	> @@ -679,7 +679,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	return sprintf(buf, "%d\n", data->temp_type[nr]);
	>  }
	> @@ -688,7 +688,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	if (data->temp_beep & (1 << (nr + 1)))
	>  		return sprintf(buf, "1\n");
	> @@ -700,7 +700,7 @@
	>  	*devattr, const char *buf, size_t count)
	>  {
	>  	struct f71882fg_data *data = dev_get_drvdata(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  	int val = simple_strtoul(buf, NULL, 10);
	>  
	>  	mutex_lock(&data->update_lock);
	> @@ -719,7 +719,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	if (data->temp_status & (1 << (nr + 1)))
	>  		return sprintf(buf, "1\n");
	> @@ -731,7 +731,7 @@
	>  	*devattr, char *buf)
	>  {
	>  	struct f71882fg_data *data = f71882fg_update_device(dev);
	> -	int nr = to_sensor_dev_attr(devattr)->index;
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	>  
	>  	if (data->temp_diode_open & (1 << (nr + 1)))
	>  		return sprintf(buf, "1\n");
	> 
	> 
	> 
	> --- attr2	2008-06-30 22:57:54.000000000 +0200
	> +++ f71882fg.c	2008-06-30 22:54:22.000000000 +0200
	> @@ -57,6 +57,8 @@
	>  #define F71882FG_REG_IN1_HIGH		0x32
	>  
	>  #define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
	> +#define F71882FG_REG_FAN_TARGET(nr)	(0xA2 + (16 * (nr)))
	> +#define F71882FG_REG_FAN_FULL_SPEED(nr)	(0xA4 + (16 * (nr)))
	>  #define F71882FG_REG_FAN_STATUS		0x92
	>  #define F71882FG_REG_FAN_BEEP		0x93
	>  
	> @@ -70,6 +72,18 @@
	>  #define F71882FG_REG_TEMP_TYPE		0x6B
	>  #define F71882FG_REG_TEMP_DIODE_OPEN	0x6F
	>  
	> +
	> +#define F71882FG_REG_PWM(nr)            (0xA3 + (16 * (nr)))
	> +#define F71882FG_REG_PWM_TYPE		0x94
	> +#define F71882FG_REG_PWM_ENABLE         0x96
	> +
	> +#define F71882FG_REG_FAN_HYST0		0x98
	> +#define F71882FG_REG_FAN_HYST1		0x99
	> +
	> +#define F71882FG_REG_POINT_PWM(pwm,point)	(0xAA + point + (16 * (pwm)))
	> +#define F71882FG_REG_POINT_TEMP(pwm,point)	(0xA6 + point + (16 * (pwm)))
	> +#define F71882FG_REG_POINT_MAPPING(nr)		(0xAF + 16*(nr))
	> +
	>  #define	F71882FG_REG_START		0x01
	>  
	>  #define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
	> @@ -78,6 +92,12 @@
	>  module_param(force_id, ushort, 0);
	>  MODULE_PARM_DESC(force_id, "Override the detected device ID");
	>  
	> +static int fan_mode[4]={0, 0, 0, 0};
	> +module_param_array(fan_mode, int, NULL, 0);
	> +MODULE_PARM_DESC(fan_mode, 
	> +	"List of fan modes (for four fans) (0=don't change, 1=pwm, 2=rpm");
	> +
	> +
	>  static struct platform_device *f71882fg_pdev = NULL;
	>  
	>  /* Super-I/O Function prototypes */
	> @@ -88,6 +108,7 @@
	>  static inline void superio_exit(int base);
	>  
	>  static inline u16 fan_from_reg ( u16 reg );
	> +static inline u16 fan_to_reg ( u16 reg );
	>  
	>  struct f71882fg_data {
	>  	unsigned short addr;
	> @@ -104,6 +125,8 @@
	>  	u8	in_status;
	>  	u8	in_beep;
	>  	u16	fan[4];
	> +	u16	fan_target[4];
	> +	u16	fan_full_speed[4];
	>  	u8	fan_status;
	>  	u8	fan_beep;
	>  	u8	temp[3];
	> @@ -114,11 +137,19 @@
	>  	u8	temp_status;
	>  	u8	temp_beep;
	>  	u8	temp_diode_open;
	> +	u8	pwm[4];
	> +	u8	pwm_enable;
	> +	u8	pwm_type;
	> +	u8	pwm_auto_point_hyst[2];
	> +	u8	pwm_auto_point_mapping[4];
	> +	u8	pwm_auto_point_pwm[4][5];
	> +	u8	pwm_auto_point_temp[4][4];
	>  };
	>  
	>  static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg);
	>  static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg);
	>  static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val);
	> +static void f71882fg_write16(struct f71882fg_data *data, u8 reg, u16 val);
	>  
	>  /* Sysfs in*/
	>  static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
	> @@ -136,6 +167,10 @@
	>  /* Sysfs Fan */
	>  static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
	>  	char *buf);
	> +static ssize_t show_fan_full_speed(struct device *dev, 
	> +	struct device_attribute *devattr, char *buf);
	> +static ssize_t store_fan_full_speed(struct device *dev, 
	> +	struct device_attribute *devattr, const char *buf, size_t count);
	>  static ssize_t show_fan_beep(struct device *dev, struct device_attribute
	>  	*devattr, char *buf);
	>  static ssize_t store_fan_beep(struct device *dev, struct device_attribute
	> @@ -173,6 +208,36 @@
	>  static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
	>  	char *buf);
	>  
	> +/* PWM and Auto point control */
	> +static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
	> +	char *buf);
	> +static ssize_t store_pwm(struct device *dev, struct device_attribute
	> +	*devattr, const char *buf, size_t count);
	> +static ssize_t show_pwm_enable(struct device *dev, 
	> +	struct device_attribute *devattr, char *buf);
	> +static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
	> +	*devattr, const char *buf, size_t count);
	> +static ssize_t show_pwm_interpolate(struct device *dev, 
	> +	struct device_attribute *devattr, char *buf);
	> +static ssize_t store_pwm_interpolate(struct device *dev, 
	> +	struct device_attribute *devattr, const char *buf, size_t count);
	> +static ssize_t show_pwm_auto_point_channel(struct device *dev, 
	> +	struct device_attribute *devattr, char *buf);
	> +static ssize_t store_pwm_auto_point_channel(struct device *dev, 
	> +	struct device_attribute *devattr, const char *buf, size_t count);
	> +static ssize_t show_pwm_auto_point_temp_hyst(struct device *dev, 
	> +	struct device_attribute *devattr, char *buf);
	> +static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev, 
	> +	struct device_attribute *devattr, const char *buf, size_t count);
	> +static ssize_t show_pwm_auto_point_pwm(struct device *dev, 
	> +	struct device_attribute *devattr, char *buf);
	> +static ssize_t store_pwm_auto_point_pwm(struct device *dev, 
	> +	struct device_attribute *devattr, const char *buf, size_t count);
	> +static ssize_t show_pwm_auto_point_temp(struct device *dev, 
	> +	struct device_attribute *devattr, char *buf);
	> +static ssize_t store_pwm_auto_point_temp(struct device *dev, 
	> +	struct device_attribute *devattr, const char *buf, size_t count);
	> +
	>  static int __devinit f71882fg_probe(struct platform_device * pdev);
	>  static int __devexit f71882fg_remove(struct platform_device *pdev);
	>  static int __init f71882fg_init(void);
	> @@ -252,21 +317,181 @@
	>  static struct sensor_device_attribute_2 f71882fg_fan_attr[] =
	>  {
	>  	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
	> +	SENSOR_ATTR_2(fan1_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed, 
	> +		store_fan_full_speed, 0, 0),
	>  	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	>  		store_fan_beep, 0, 0),
	>  	SENSOR_ATTR_2(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 0),
	>  	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
	> +	SENSOR_ATTR_2(fan2_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed, 
	> +		store_fan_full_speed, 0, 1),
	>  	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	>  		store_fan_beep, 0, 1),
	>  	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
	>  	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
	> +	SENSOR_ATTR_2(fan3_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed, 
	> +		store_fan_full_speed, 0, 2),
	>  	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	>  		store_fan_beep, 0, 2),
	>  	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
	>  	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
	> +	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR, show_fan_full_speed, 
	> +		store_fan_full_speed, 0, 3),
	>  	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
	>  		store_fan_beep, 0, 3),
	> -	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3)
	> +	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
	> +
	> +	SENSOR_ATTR_2(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 0),
	> +	SENSOR_ATTR_2(pwm1_enable, S_IRUGO|S_IWUSR, show_pwm_enable, 
	> +		store_pwm_enable, 0, 0),
	> +	SENSOR_ATTR_2(pwm1_interpolate, S_IRUGO|S_IWUSR, 
	> +		show_pwm_interpolate, store_pwm_interpolate, 0, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point1_temp_hyst, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst, 
	> +		0, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 0, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		0, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point2_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		1, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point3_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		2, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point4_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		3, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point5_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		4, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point1_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		0, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point2_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		1, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point3_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		2, 0),
	> +	SENSOR_ATTR_2(pwm1_auto_point4_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		3, 0),
	> +
	> +	SENSOR_ATTR_2(pwm2, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 1),
	> +	SENSOR_ATTR_2(pwm2_enable, S_IRUGO|S_IWUSR, show_pwm_enable, 
	> +		store_pwm_enable, 0, 1),
	> +	SENSOR_ATTR_2(pwm2_interpolate, S_IRUGO|S_IWUSR, 
	> +		show_pwm_interpolate, store_pwm_interpolate, 0, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point1_temp_hyst, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst, 
	> +		0, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 0, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		0, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point2_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		1, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point3_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		2, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point4_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		3, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point5_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		4, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point1_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		0, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point2_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		1, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point3_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		2, 1),
	> +	SENSOR_ATTR_2(pwm2_auto_point4_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		3, 1),
	> +
	> +	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
	> +	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable, 
	> +		store_pwm_enable, 0, 2),
	> +	SENSOR_ATTR_2(pwm3_interpolate, S_IRUGO|S_IWUSR, 
	> +		show_pwm_interpolate, store_pwm_interpolate, 0, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point1_temp_hyst, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst, 
	> +		0, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 0, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		0, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		1, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point3_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		2, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point4_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		3, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point5_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		4, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point1_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		0, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point2_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		1, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point3_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		2, 2),
	> +	SENSOR_ATTR_2(pwm3_auto_point4_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		3, 2),
	> +
	> +	SENSOR_ATTR_2(pwm4, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 3),
	> +	SENSOR_ATTR_2(pwm4_enable, S_IRUGO|S_IWUSR, show_pwm_enable, 
	> +		store_pwm_enable, 0, 3),
	> +	SENSOR_ATTR_2(pwm4_interpolate, S_IRUGO|S_IWUSR, 
	> +		show_pwm_interpolate, store_pwm_interpolate, 0, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point1_temp_hyst, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp_hyst, store_pwm_auto_point_temp_hyst, 
	> +		0, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_channels_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_channel, store_pwm_auto_point_channel, 0, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point1_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		0, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point2_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		1, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point3_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		2, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point4_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		3, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point5_pwm, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm, 
	> +		4, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point1_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		0, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point2_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		1, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point3_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		2, 3),
	> +	SENSOR_ATTR_2(pwm4_auto_point4_temp, S_IRUGO|S_IWUSR, 
	> +		show_pwm_auto_point_temp, store_pwm_auto_point_temp, 
	> +		3, 3)
	>  };
	>  
	>  
	> @@ -310,6 +535,11 @@
	>  	return reg ? (1500000 / reg) : 0;
	>  }
	>  
	> +static inline u16 fan_to_reg(u16 fan)
	> +{
	> +	return fan ? (1500000/fan) : 0;
	> +}
	> +
	>  static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg)
	>  {
	>  	u8 val;
	> @@ -338,6 +568,15 @@
	>  	outb(val, data->addr + DATA_REG_OFFSET);
	>  }
	>  
	> +static void f71882fg_write16(struct f71882fg_data *data, u8 reg, u16 val)
	> +{
	> +	outb(reg++, data->addr + ADDR_REG_OFFSET);
	> +	outb(val>>8, data->addr + DATA_REG_OFFSET);
	> +	outb(reg, data->addr + ADDR_REG_OFFSET);
	> +	outb(val&255, data->addr + DATA_REG_OFFSET);
	> +}
	> +
	> +
	>  static struct f71882fg_data *f71882fg_update_device(struct device * dev)
	>  {
	>  	struct f71882fg_data *data = dev_get_drvdata(dev);
	> @@ -399,9 +638,37 @@
	>  
	>  		data->fan_status = f71882fg_read8(data,
	>  						F71882FG_REG_FAN_STATUS);
	> -		for (nr = 0; nr < 4; nr++)
	> +		data->pwm_type = f71882fg_read8(data,
	> +						F71882FG_REG_PWM_TYPE);
	> +		data->pwm_enable = f71882fg_read8(data,
	> +						F71882FG_REG_PWM_ENABLE);
	> +		data->pwm_auto_point_hyst[0] = f71882fg_read8(data,
	> +						F71882FG_REG_FAN_HYST0);
	> +		data->pwm_auto_point_hyst[1] = f71882fg_read8(data,
	> +						F71882FG_REG_FAN_HYST1);
	> +		for (nr = 0; nr < 4; nr++) {
	> +			int point;
	>  			data->fan[nr] = f71882fg_read16(data,
	> -						F71882FG_REG_FAN(nr));
	> +				F71882FG_REG_FAN(nr));
	> +			data->fan_target[nr] = f71882fg_read16(data,
	> +				F71882FG_REG_FAN_TARGET(nr));
	> +			data->fan_full_speed[nr] = f71882fg_read16(data,
	> +				F71882FG_REG_FAN_FULL_SPEED(nr));
	> +			data->pwm[nr] = f71882fg_read8(data,
	> +				F71882FG_REG_PWM(nr));
	> +			data->pwm_auto_point_mapping[nr] = f71882fg_read8(data,
	> +				F71882FG_REG_POINT_MAPPING(nr));
	> +			for(point=0;point<5;point++) {
	> +				data->pwm_auto_point_pwm[nr][point]=
	> +					f71882fg_read8(data,
	> +						F71882FG_REG_POINT_PWM(nr,
	> +							point));
	> +				data->pwm_auto_point_temp[nr][point]=
	> +					f71882fg_read8(data,
	> +						F71882FG_REG_POINT_TEMP(nr,
	> +							point));
	> +			}
	> +                }
	>  
	>  		data->in_status = f71882fg_read8(data,
	>  						F71882FG_REG_IN_STATUS);
	> @@ -432,6 +699,34 @@
	>  	return sprintf(buf, "%d\n", speed);
	>  }
	>  
	> +static ssize_t show_fan_full_speed(struct device *dev, 
	> +	struct device_attribute *devattr, char *buf)
	> +{
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +	int speed = fan_from_reg(data->fan_full_speed[nr]);
	> +	return sprintf(buf, "%d\n", speed);
	> +}
	> +
	> +static ssize_t store_fan_full_speed(struct device *dev, 
	> +	struct device_attribute *devattr, const char *buf, size_t count)
	> +{
	> +	struct f71882fg_data *data = dev_get_drvdata(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +	int val = simple_strtoul(buf, NULL, 10);
	> +
	> +	mutex_lock(&data->update_lock);
	> +	if(data->pwm_enable&(1<<(2*nr)))
	> +		count=-EINVAL;
	> +	else
	> +		f71882fg_write16(data, F71882FG_REG_FAN_FULL_SPEED(nr), 
	> +			fan_to_reg(val));
	> +	mutex_unlock(&data->update_lock);
	> +
	> +	return count;
	> +}
	> +
	> +
	>  static ssize_t show_fan_beep(struct device *dev, struct device_attribute
	>  	*devattr, char *buf)
	>  {
	> @@ -739,6 +1034,276 @@
	>  		return sprintf(buf, "0\n");
	>  }
	>  
	> +static ssize_t show_pwm(struct device *dev, struct device_attribute *devattr,
	> +	char *buf)
	> +{
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int val, nr = to_sensor_dev_attr_2(devattr)->index;
	> +	if(data->pwm_enable&(1<<(2*nr)))
	> +		// PWM mode
	> +		val=data->pwm[nr];
	> +	else
	> +		// RPM mode
	> +		val=255*fan_from_reg(data->fan_target[nr])
	> +			/fan_from_reg(data->fan_full_speed[nr]);
	> +	return sprintf(buf, "%d\n", val);
	> +}
	> +
	> +static ssize_t store_pwm(struct device *dev, struct device_attribute *devattr, 
	> +	const char *buf, size_t count)
	> +{
	> +	// struct f71882fg_data *data = dev_get_drvdata(dev);
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +	int val = simple_strtoul(buf, NULL, 10);
	> +
	> +	mutex_lock(&data->update_lock);
	> +	if(data->pwm_enable&(1<<(2*nr)))
	> +		// PWM mode
	> +		f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
	> +	else {
	> +		// RPM mode
	> +		int target=val*fan_from_reg(data->fan_full_speed[nr])/255;
	> +		f71882fg_write16(data, F71882FG_REG_FAN_TARGET(nr), 
	> +			fan_to_reg(target));
	> +	}
	> +	mutex_unlock(&data->update_lock);
	> +
	> +	return count;
	> +}
	> +
	> +static ssize_t show_pwm_enable(struct device *dev, 
	> +	struct device_attribute *devattr,
	> +	char *buf)
	> +{
	> +	int result;
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +
	> +	if(2&(data->pwm_enable>>(2*nr)))
	> +		result=1;
	> +	else
	> +		result=2;
	> +
	> +	return sprintf(buf, "%d\n", result);
	> +}
	> +
	> +static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
	> +	*devattr, const char *buf, size_t count)
	> +{
	> +	struct f71882fg_data *data = dev_get_drvdata(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +	int val = simple_strtoul(buf, NULL, 10);
	> +	if(val<0 || val>2)
	> +		return -EINVAL;
	> +
	> +	mutex_lock(&data->update_lock);
	> +	switch(val) {
	> +	case 1: data->pwm_enable|=2<<(2*nr); break;	// Manual
	> +	case 2: data->pwm_enable&=~(2<<(2*nr)); break;	// Temperature ctrl
	> +	}
	> +	switch(fan_mode[nr]) {
	> +	case 1: data->pwm_enable|=1<<(2*nr); break;	// RPM mode
	> +	case 2: data->pwm_enable&=~(1<<(2*nr)); break;	// Duty cycle mode
	> +	}
	> +	f71882fg_write8(data, F71882FG_REG_PWM_ENABLE, data->pwm_enable);
	> +	mutex_unlock(&data->update_lock);
	> +	if(!val)
	> +		store_pwm(dev,devattr,"255",4);
	> +
	> +	return count;
	> +}
	> +
	> +static ssize_t show_pwm_auto_point_pwm(struct device *dev, 
	> +	struct device_attribute *devattr,
	> +	char *buf)
	> +{
	> +	int result;
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int pwm = to_sensor_dev_attr_2(devattr)->index;
	> +	int point = to_sensor_dev_attr_2(devattr)->nr;
	> +
	> +	if(data->pwm_enable&(1<<(2*pwm))) {
	> +		// PWM mode
	> +		result=data->pwm_auto_point_pwm[pwm][point];
	> +	} else {
	> +		// RPM mode
	> +		result=32*255/(32+data->pwm_auto_point_pwm[pwm][point]);
	> +	}
	> +
	> +	return sprintf(buf, "%d\n", result);
	> +}
	> +
	> +static ssize_t store_pwm_auto_point_pwm(struct device *dev, 
	> +	struct device_attribute *devattr, 
	> +	const char *buf, size_t count)
	> +{
	> +	// struct f71882fg_data *data = dev_get_drvdata(dev);
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int pwm = to_sensor_dev_attr_2(devattr)->index;
	> +	int point = to_sensor_dev_attr_2(devattr)->nr;
	> +	int val = simple_strtoul(buf, NULL, 10);
	> +
	> +	mutex_lock(&data->update_lock);
	> +	if(data->pwm_enable&(1<<(2*pwm))) {
	> +		// PWM mode
	> +		f71882fg_write8(data, F71882FG_REG_POINT_PWM(pwm,point), val);
	> +	} else {
	> +		// RPM mode
	> +		if(val<29)	// Prevent negative numbers
	> +			val=255;
	> +		else
	> +			val=(255-val)*32/val;
	> +		f71882fg_write8(data, F71882FG_REG_POINT_PWM(pwm,point),val);
	> +	}
	> +	mutex_unlock(&data->update_lock);
	> +
	> +	return count;
	> +}
	> +
	> +static ssize_t show_pwm_auto_point_temp_hyst(struct device *dev, 
	> +	struct device_attribute *devattr,
	> +	char *buf)
	> +{
	> +	int result;
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +
	> +	switch(nr) {
	> +	case 0: result=data->pwm_auto_point_hyst[0]&15; break;
	> +	case 1: result=data->pwm_auto_point_hyst[0]>>4; break;
	> +	case 2: result=data->pwm_auto_point_hyst[1]&15; break;
	> +	case 3: result=data->pwm_auto_point_hyst[1]>>4; break;
	> +	default: result=-1;
	> +	}
	> +
	> +	return sprintf(buf, "%d\n", result);
	> +}
	> +
	> +static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev, 
	> +	struct device_attribute *devattr, 
	> +	const char *buf, size_t count)
	> +{
	> +	// struct f71882fg_data *data = dev_get_drvdata(dev);
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +	int val = simple_strtoul(buf, NULL, 10);
	> +	val&=15;
	> +	switch(nr) {
	> +	case 0: val=(data->pwm_auto_point_hyst[0]&0xf0)|val; break;
	> +	case 1: val=(data->pwm_auto_point_hyst[0]&0x0f)|(val<<4); break;
	> +	case 2: val=(data->pwm_auto_point_hyst[1]&0xf0)|val; break;
	> +	case 3: val=(data->pwm_auto_point_hyst[1]&0x0f)|(val<<4); break;
	> +	}
	> +
	> +	mutex_lock(&data->update_lock);
	> +	if(nr==0 || nr==1)
	> +		f71882fg_write8(data, F71882FG_REG_FAN_HYST0, val); 
	> +	else
	> +		f71882fg_write8(data, F71882FG_REG_FAN_HYST1, val); 
	> +	mutex_unlock(&data->update_lock);
	> +
	> +	return count;
	> +}
	> +
	> +static ssize_t show_pwm_interpolate(struct device *dev, 
	> +	struct device_attribute *devattr,
	> +	char *buf)
	> +{
	> +	int result;
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +
	> +	result=1&(data->pwm_auto_point_mapping[nr]>>4);
	> +
	> +	return sprintf(buf, "%d\n", result);
	> +}
	> +
	> +static ssize_t store_pwm_interpolate(struct device *dev, 
	> +	struct device_attribute *devattr, 
	> +	const char *buf, size_t count)
	> +{
	> +	// struct f71882fg_data *data = dev_get_drvdata(dev);
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +	int val = simple_strtoul(buf, NULL, 10);
	> +	if(val)
	> +		val=data->pwm_auto_point_mapping[nr]|(1<<4);
	> +	else
	> +		val=data->pwm_auto_point_mapping[nr]&(~(1<<4));
	> +	mutex_lock(&data->update_lock);
	> +	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val); 
	> +	mutex_unlock(&data->update_lock);
	> +
	> +	return count;
	> +}
	> +static ssize_t show_pwm_auto_point_channel(struct device *dev, 
	> +	struct device_attribute *devattr,
	> +	char *buf)
	> +{
	> +	int result;
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +
	> +	result=1<<(data->pwm_auto_point_mapping[nr]&3);
	> +	result>>=1;
	> +
	> +	return sprintf(buf, "%d\n", result);
	> +}
	> +
	> +static ssize_t store_pwm_auto_point_channel(struct device *dev, 
	> +	struct device_attribute *devattr, 
	> +	const char *buf, size_t count)
	> +{
	> +	// struct f71882fg_data *data = dev_get_drvdata(dev);
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int nr = to_sensor_dev_attr_2(devattr)->index;
	> +	int val = simple_strtoul(buf, NULL, 10);
	> +	switch(val) {
	> +	case 1: val=1; break;
	> +	case 2: val=2; break;
	> +	case 4: val=3; break;
	> +	default: return -EINVAL;
	> +	}
	> +	val|=data->pwm_auto_point_mapping[nr]&0xfc;
	> +	mutex_lock(&data->update_lock);
	> +	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val); 
	> +	mutex_unlock(&data->update_lock);
	> +
	> +	return count;
	> +}
	> +
	> +static ssize_t show_pwm_auto_point_temp(struct device *dev, 
	> +	struct device_attribute *devattr,
	> +	char *buf)
	> +{
	> +	int result;
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int pwm = to_sensor_dev_attr_2(devattr)->index;
	> +	int point = to_sensor_dev_attr_2(devattr)->nr;
	> +
	> +	result=data->pwm_auto_point_temp[pwm][point];
	> +	return sprintf(buf, "%d\n", result);
	> +}
	> +
	> +static ssize_t store_pwm_auto_point_temp(struct device *dev, 
	> +	struct device_attribute *devattr, 
	> +	const char *buf, size_t count)
	> +{
	> +	// struct f71882fg_data *data = dev_get_drvdata(dev);
	> +	struct f71882fg_data *data = f71882fg_update_device(dev);
	> +	int pwm = to_sensor_dev_attr_2(devattr)->index;
	> +	int point = to_sensor_dev_attr_2(devattr)->nr;
	> +	int val = simple_strtoul(buf, NULL, 10);
	> +
	> +	mutex_lock(&data->update_lock);
	> +	f71882fg_write8(data, F71882FG_REG_POINT_TEMP(pwm,point), val);
	> +	mutex_unlock(&data->update_lock);
	> +
	> +	return count;
	> +}
	> +
	> +
	>  static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
	>  	char *buf)
	>  {
	> 
	> 

--=_48ebac21.clOe3IH4xtec8Tc9ik4uDV09id9PxxciOXQdtjnmXm72HpsM
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="f71882fg_fixed.patch"

--- attr2	2008-06-30 22:57:54.000000000 +0200
+++ f71882fg.c	2008-10-07 20:31:26.000000000 +0200
@@ -27,11 +27,11 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #define DRVNAME "f71882fg"
 
-#define SIO_F71882FG_LD_HWM	0x04	/* Hardware monitor logical device*/
+#define SIO_F71882FG_LD_HWM	0x04	/* Hardware monitor logical device */
 #define SIO_UNLOCK_KEY		0x87	/* Key to enable Super-I/O */
 #define SIO_LOCK_KEY		0xAA	/* Key to diasble Super-I/O */
 
@@ -57,6 +57,8 @@
 #define F71882FG_REG_IN1_HIGH		0x32
 
 #define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
+#define F71882FG_REG_FAN_TARGET(nr)	(0xA2 + (16 * (nr)))
+#define F71882FG_REG_FAN_FULL_SPEED(nr)	(0xA4 + (16 * (nr)))
 #define F71882FG_REG_FAN_STATUS		0x92
 #define F71882FG_REG_FAN_BEEP		0x93
 
@@ -70,15 +72,31 @@
 #define F71882FG_REG_TEMP_TYPE		0x6B
 #define F71882FG_REG_TEMP_DIODE_OPEN	0x6F
 
+#define F71882FG_REG_PWM(nr)            (0xA3 + (16 * (nr)))
+#define F71882FG_REG_PWM_TYPE		0x94
+#define F71882FG_REG_PWM_ENABLE         0x96
+
+#define F71882FG_REG_FAN_HYST0		0x98
+#define F71882FG_REG_FAN_HYST1		0x99
+
+#define F71882FG_REG_POINT_PWM(pwm, point)	(0xAA + point + (16 * (pwm)))
+#define F71882FG_REG_POINT_TEMP(pwm, point)	(0xA6 + point + (16 * (pwm)))
+#define F71882FG_REG_POINT_MAPPING(nr)		(0xAF + 16*(nr))
+
 #define	F71882FG_REG_START		0x01
 
-#define FAN_MIN_DETECT			366 /* Lowest detectable fanspeed */
+#define FAN_MIN_DETECT			366	/* Lowest detectable fanspeed */
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-static struct platform_device *f71882fg_pdev = NULL;
+static int fan_mode[4] = { 0, 0, 0, 0 };
+module_param_array(fan_mode, int, NULL, 0);
+MODULE_PARM_DESC(fan_mode, "List of fan modes (for four fans) "
+		 "(0=don't change, 1=pwm, 2=rpm");
+
+static struct platform_device *f71882fg_pdev;
 
 /* Super-I/O Function prototypes */
 static inline int superio_inb(int base, int reg);
@@ -87,93 +105,149 @@
 static inline void superio_select(int base, int ld);
 static inline void superio_exit(int base);
 
-static inline u16 fan_from_reg ( u16 reg );
+static inline u16 fan_from_reg(u16 reg);
+static inline u16 fan_to_reg(u16 reg);
 
 struct f71882fg_data {
 	unsigned short addr;
 	struct device *hwmon_dev;
 
 	struct mutex update_lock;
-	char valid;			/* !=0 if following fields are valid */
+	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	unsigned long last_limits;	/* In jiffies */
 
 	/* Register Values */
-	u8	in[9];
-	u8	in1_max;
-	u8	in_status;
-	u8	in_beep;
-	u16	fan[4];
-	u8	fan_status;
-	u8	fan_beep;
-	u8	temp[3];
-	u8	temp_ovt[3];
-	u8	temp_high[3];
-	u8	temp_hyst[3];
-	u8	temp_type[3];
-	u8	temp_status;
-	u8	temp_beep;
-	u8	temp_diode_open;
+	u8 in[9];
+	u8 in1_max;
+	u8 in_status;
+	u8 in_beep;
+	u16 fan[4];
+	u16 fan_target[4];
+	u16 fan_full_speed[4];
+	u8 fan_status;
+	u8 fan_beep;
+	u8 temp[3];
+	u8 temp_ovt[3];
+	u8 temp_high[3];
+	u8 temp_hyst[3];
+	u8 temp_type[3];
+	u8 temp_status;
+	u8 temp_beep;
+	u8 temp_diode_open;
+	u8 pwm[4];
+	u8 pwm_enable;
+	u8 pwm_auto_point_hyst[2];
+	u8 pwm_auto_point_mapping[4];
+	u8 pwm_auto_point_pwm[4][5];
+	u8 pwm_auto_point_temp[4][4];
 };
 
 static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg);
 static u16 f71882fg_read16(struct f71882fg_data *data, u8 reg);
 static void f71882fg_write8(struct f71882fg_data *data, u8 reg, u8 val);
+static void f71882fg_write16(struct f71882fg_data *data, u8 reg, u16 val);
 
 /* Sysfs in*/
 static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
-	char *buf);
-static ssize_t show_in_max(struct device *dev, struct device_attribute
-	*devattr, char *buf);
-static ssize_t store_in_max(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count);
-static ssize_t show_in_beep(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+		       char *buf);
+static ssize_t show_in_max(struct device *dev,
+			   struct device_attribute *devattr, char *buf);
+static ssize_t store_in_max(struct device *dev,
+			    struct device_attribute *devattr, const char *buf,
+			    size_t count);
+static ssize_t show_in_beep(struct device *dev,
+			    struct device_attribute *devattr, char *buf);
 static ssize_t store_in_beep(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count);
+			     *devattr, const char *buf, size_t count);
 static ssize_t show_in_alarm(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			     *devattr, char *buf);
 /* Sysfs Fan */
-static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
-	char *buf);
+static ssize_t show_fan(struct device *dev,
+			struct device_attribute *devattr, char *buf);
+static ssize_t show_fan_full_speed(struct device *dev,
+				   struct device_attribute *devattr, char *buf);
+static ssize_t store_fan_full_speed(struct device *dev,
+				    struct device_attribute *devattr,
+				    const char *buf, size_t count);
 static ssize_t show_fan_beep(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			     *devattr, char *buf);
 static ssize_t store_fan_beep(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count);
+			      *devattr, const char *buf, size_t count);
 static ssize_t show_fan_alarm(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			      *devattr, char *buf);
 /* Sysfs Temp */
 static ssize_t show_temp(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			 *devattr, char *buf);
 static ssize_t show_temp_max(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			     *devattr, char *buf);
 static ssize_t store_temp_max(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count);
+			      *devattr, const char *buf, size_t count);
 static ssize_t show_temp_max_hyst(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+				  *devattr, char *buf);
 static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count);
+				   *devattr, const char *buf, size_t count);
 static ssize_t show_temp_crit(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			      *devattr, char *buf);
 static ssize_t store_temp_crit(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count);
+			       *devattr, const char *buf, size_t count);
 static ssize_t show_temp_crit_hyst(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+				   *devattr, char *buf);
 static ssize_t show_temp_type(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			      *devattr, char *buf);
 static ssize_t show_temp_beep(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			      *devattr, char *buf);
 static ssize_t store_temp_beep(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count);
+			       *devattr, const char *buf, size_t count);
 static ssize_t show_temp_alarm(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			       *devattr, char *buf);
 static ssize_t show_temp_fault(struct device *dev, struct device_attribute
-	*devattr, char *buf);
+			       *devattr, char *buf);
 /* Sysfs misc */
-static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
-	char *buf);
+static ssize_t show_name(struct device *dev,
+			 struct device_attribute *devattr, char *buf);
+
+/* PWM and Auto point control */
+static ssize_t show_pwm(struct device *dev,
+			struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm(struct device *dev, struct device_attribute
+			 *devattr, const char *buf, size_t count);
+static ssize_t show_pwm_enable(struct device *dev,
+			       struct device_attribute *devattr, char *buf);
+static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
+				*devattr, const char *buf, size_t count);
+static ssize_t show_pwm_interpolate(struct device *dev,
+				    struct device_attribute *devattr,
+				    char *buf);
+static ssize_t store_pwm_interpolate(struct device *dev,
+				     struct device_attribute *devattr,
+				     const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_channel(struct device *dev,
+					   struct device_attribute *devattr,
+					   char *buf);
+static ssize_t store_pwm_auto_point_channel(struct device *dev,
+					    struct device_attribute *devattr,
+					    const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_temp_hyst(struct device *dev,
+					     struct device_attribute *devattr,
+					     char *buf);
+static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev,
+					      struct device_attribute *devattr,
+					      const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_pwm(struct device *dev,
+				       struct device_attribute *devattr,
+				       char *buf);
+static ssize_t store_pwm_auto_point_pwm(struct device *dev,
+					struct device_attribute *devattr,
+					const char *buf, size_t count);
+static ssize_t show_pwm_auto_point_temp(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf);
+static ssize_t store_pwm_auto_point_temp(struct device *dev,
+					 struct device_attribute *devattr,
+					 const char *buf, size_t count);
 
-static int __devinit f71882fg_probe(struct platform_device * pdev);
+static int __devinit f71882fg_probe(struct platform_device *pdev);
 static int __devexit f71882fg_remove(struct platform_device *pdev);
 static int __init f71882fg_init(void);
 static int __init f71882fg_find(int sioaddr, unsigned short *address);
@@ -182,24 +256,24 @@
 
 static struct platform_driver f71882fg_driver = {
 	.driver = {
-		.owner	= THIS_MODULE,
-		.name	= DRVNAME,
-	},
-	.probe		= f71882fg_probe,
-	.remove		= __devexit_p(f71882fg_remove),
+		   .owner = THIS_MODULE,
+		   .name = DRVNAME,
+		   },
+	.probe = f71882fg_probe,
+	.remove = __devexit_p(f71882fg_remove),
 };
 
-static struct device_attribute f71882fg_dev_attr[] =
-{
-	__ATTR( name, S_IRUGO, show_name, NULL ),
+static struct device_attribute f71882fg_dev_attr[] = {
+	__ATTR(name, S_IRUGO, show_name, NULL),
 };
 
-static struct sensor_device_attribute_2 f71882fg_in_temp_attr[] =
-{
+static struct sensor_device_attribute_2 f71882fg_in_temp_attr[] = {
 	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
 	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
-	SENSOR_ATTR_2(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max, 0, 1),
-	SENSOR_ATTR_2(in1_beep, S_IRUGO|S_IWUSR, show_in_beep, store_in_beep, 0, 1),
+	SENSOR_ATTR_2(in1_max, S_IRUGO | S_IWUSR, show_in_max,
+		      store_in_max, 0, 1),
+	SENSOR_ATTR_2(in1_beep, S_IRUGO | S_IWUSR, show_in_beep,
+		      store_in_beep, 0, 1),
 	SENSOR_ATTR_2(in1_alarm, S_IRUGO, show_in_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
 	SENSOR_ATTR_2(in3_input, S_IRUGO, show_in, NULL, 0, 3),
@@ -209,67 +283,267 @@
 	SENSOR_ATTR_2(in7_input, S_IRUGO, show_in, NULL, 0, 7),
 	SENSOR_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 0, 8),
 	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
-	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_max,
-		store_temp_max, 0, 0),
-	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
-		store_temp_max_hyst, 0, 0),
-	SENSOR_ATTR_2(temp1_crit, S_IRUGO|S_IWUSR, show_temp_crit,
-		store_temp_crit, 0, 0),
-	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_max, S_IRUGO | S_IWUSR, show_temp_max,
+		      store_temp_max, 0, 0),
+	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO | S_IWUSR,
+		      show_temp_max_hyst,
+		      store_temp_max_hyst, 0, 0),
+	SENSOR_ATTR_2(temp1_crit, S_IRUGO | S_IWUSR, show_temp_crit,
+		      store_temp_crit, 0, 0),
+	SENSOR_ATTR_2(temp1_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
+		      0, 0),
 	SENSOR_ATTR_2(temp1_type, S_IRUGO, show_temp_type, NULL, 0, 0),
-	SENSOR_ATTR_2(temp1_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 0),
+	SENSOR_ATTR_2(temp1_beep, S_IRUGO | S_IWUSR, show_temp_beep,
+		      store_temp_beep, 0, 0),
 	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 0),
 	SENSOR_ATTR_2(temp1_fault, S_IRUGO, show_temp_fault, NULL, 0, 0),
 	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1),
-	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_max,
-		store_temp_max, 0, 1),
-	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
-		store_temp_max_hyst, 0, 1),
-	SENSOR_ATTR_2(temp2_crit, S_IRUGO|S_IWUSR, show_temp_crit,
-		store_temp_crit, 0, 1),
-	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_max, S_IRUGO | S_IWUSR, show_temp_max,
+		      store_temp_max, 0, 1),
+	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO | S_IWUSR,
+		      show_temp_max_hyst,
+		      store_temp_max_hyst, 0, 1),
+	SENSOR_ATTR_2(temp2_crit, S_IRUGO | S_IWUSR, show_temp_crit,
+		      store_temp_crit, 0, 1),
+	SENSOR_ATTR_2(temp2_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
+		      0, 1),
 	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 1),
-	SENSOR_ATTR_2(temp2_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 1),
+	SENSOR_ATTR_2(temp2_beep, S_IRUGO | S_IWUSR, show_temp_beep,
+		      store_temp_beep, 0, 1),
 	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(temp2_fault, S_IRUGO, show_temp_fault, NULL, 0, 1),
 	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2),
-	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_max,
-		store_temp_max, 0, 2),
-	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max_hyst,
-		store_temp_max_hyst, 0, 2),
-	SENSOR_ATTR_2(temp3_crit, S_IRUGO|S_IWUSR, show_temp_crit,
-		store_temp_crit, 0, 2),
-	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_max, S_IRUGO | S_IWUSR, show_temp_max,
+		      store_temp_max, 0, 2),
+	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO | S_IWUSR,
+		      show_temp_max_hyst,
+		      store_temp_max_hyst, 0, 2),
+	SENSOR_ATTR_2(temp3_crit, S_IRUGO | S_IWUSR, show_temp_crit,
+		      store_temp_crit, 0, 2),
+	SENSOR_ATTR_2(temp3_crit_hyst, S_IRUGO, show_temp_crit_hyst, NULL,
+		      0, 2),
 	SENSOR_ATTR_2(temp3_type, S_IRUGO, show_temp_type, NULL, 0, 2),
-	SENSOR_ATTR_2(temp3_beep, S_IRUGO|S_IWUSR, show_temp_beep,
-		store_temp_beep, 0, 2),
+	SENSOR_ATTR_2(temp3_beep, S_IRUGO | S_IWUSR, show_temp_beep,
+		      store_temp_beep, 0, 2),
 	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 2),
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 2)
 };
 
-static struct sensor_device_attribute_2 f71882fg_fan_attr[] =
-{
+static struct sensor_device_attribute_2 f71882fg_fan_attr[] = {
 	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
-	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 0),
+	SENSOR_ATTR_2(fan1_full_speed, S_IRUGO | S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 0),
+	SENSOR_ATTR_2(fan1_beep, S_IRUGO | S_IWUSR, show_fan_beep,
+		      store_fan_beep, 0, 0),
 	SENSOR_ATTR_2(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 0),
 	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
-	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 1),
+	SENSOR_ATTR_2(fan2_full_speed, S_IRUGO | S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 1),
+	SENSOR_ATTR_2(fan2_beep, S_IRUGO | S_IWUSR, show_fan_beep,
+		      store_fan_beep, 0, 1),
 	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
-	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 2),
+	SENSOR_ATTR_2(fan3_full_speed, S_IRUGO | S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 2),
+	SENSOR_ATTR_2(fan3_beep, S_IRUGO | S_IWUSR, show_fan_beep,
+		      store_fan_beep, 0, 2),
 	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
 	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
-	SENSOR_ATTR_2(fan4_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 3),
-	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3)
+	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO | S_IWUSR,
+		      show_fan_full_speed,
+		      store_fan_full_speed, 0, 3),
+	SENSOR_ATTR_2(fan4_beep, S_IRUGO | S_IWUSR, show_fan_beep,
+		      store_fan_beep, 0, 3),
+	SENSOR_ATTR_2(fan4_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 3),
+
+	SENSOR_ATTR_2(pwm1, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0, 0),
+	SENSOR_ATTR_2(pwm1_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 0),
+	SENSOR_ATTR_2(pwm1_interpolate, S_IRUGO | S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point3_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 0),
+	SENSOR_ATTR_2(pwm1_auto_point4_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 0),
+	SENSOR_ATTR_2(pwm1_auto_point5_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point3_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 0),
+	SENSOR_ATTR_2(pwm1_auto_point4_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 0),
+	SENSOR_ATTR_2(pwm1_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 0),
+	SENSOR_ATTR_2(pwm1_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 0),
+	SENSOR_ATTR_2(pwm1_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 0),
+	SENSOR_ATTR_2(pwm1_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
+
+	SENSOR_ATTR_2(pwm2, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0, 1),
+	SENSOR_ATTR_2(pwm2_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 1),
+	SENSOR_ATTR_2(pwm2_interpolate, S_IRUGO | S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 1),
+	SENSOR_ATTR_2(pwm2_auto_channels_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 1),
+	SENSOR_ATTR_2(pwm2_auto_point4_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 1),
+	SENSOR_ATTR_2(pwm2_auto_point5_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 1),
+	SENSOR_ATTR_2(pwm2_auto_point4_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 1),
+	SENSOR_ATTR_2(pwm2_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 1),
+	SENSOR_ATTR_2(pwm2_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 1),
+	SENSOR_ATTR_2(pwm2_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 1),
+	SENSOR_ATTR_2(pwm2_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
+
+	SENSOR_ATTR_2(pwm3, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0, 2),
+	SENSOR_ATTR_2(pwm3_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 2),
+	SENSOR_ATTR_2(pwm3_interpolate, S_IRUGO | S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 2),
+	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point4_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 2),
+	SENSOR_ATTR_2(pwm3_auto_point5_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point4_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 2),
+	SENSOR_ATTR_2(pwm3_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 2),
+	SENSOR_ATTR_2(pwm3_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 2),
+	SENSOR_ATTR_2(pwm3_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 2),
+	SENSOR_ATTR_2(pwm3_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
+
+	SENSOR_ATTR_2(pwm4, S_IRUGO | S_IWUSR, show_pwm, store_pwm, 0, 3),
+	SENSOR_ATTR_2(pwm4_enable, S_IRUGO | S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 3),
+	SENSOR_ATTR_2(pwm4_interpolate, S_IRUGO | S_IWUSR,
+		      show_pwm_interpolate, store_pwm_interpolate, 0, 3),
+	SENSOR_ATTR_2(pwm4_auto_channels_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_channel,
+		      store_pwm_auto_point_channel, 0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point1_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point2_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 3),
+	SENSOR_ATTR_2(pwm4_auto_point3_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 3),
+	SENSOR_ATTR_2(pwm4_auto_point5_pwm, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 3),
+	SENSOR_ATTR_2(pwm4_auto_point1_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point2_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 3),
+	SENSOR_ATTR_2(pwm4_auto_point3_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_temp, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 3),
+	SENSOR_ATTR_2(pwm4_auto_point1_temp_hyst, S_IRUGO | S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 3),
+	SENSOR_ATTR_2(pwm4_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 3),
+	SENSOR_ATTR_2(pwm4_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 3),
+	SENSOR_ATTR_2(pwm4_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 3)
 };
 
-
 /* Super I/O functions */
 static inline int superio_inb(int base, int reg)
 {
@@ -290,11 +564,11 @@
 static inline void superio_enter(int base)
 {
 	/* according to the datasheet the key must be send twice! */
-	outb( SIO_UNLOCK_KEY, base);
-	outb( SIO_UNLOCK_KEY, base);
+	outb(SIO_UNLOCK_KEY, base);
+	outb(SIO_UNLOCK_KEY, base);
 }
 
-static inline void superio_select( int base, int ld)
+static inline void superio_select(int base, int ld)
 {
 	outb(SIO_REG_LDSEL, base);
 	outb(ld, base + 1);
@@ -310,6 +584,11 @@
 	return reg ? (1500000 / reg) : 0;
 }
 
+static inline u16 fan_to_reg(u16 fan)
+{
+	return fan ? (1500000 / fan) : 0;
+}
+
 static u8 f71882fg_read8(struct f71882fg_data *data, u8 reg)
 {
 	u8 val;
@@ -338,7 +617,15 @@
 	outb(val, data->addr + DATA_REG_OFFSET);
 }
 
-static struct f71882fg_data *f71882fg_update_device(struct device * dev)
+static void f71882fg_write16(struct f71882fg_data *data, u8 reg, u16 val)
+{
+	outb(reg++, data->addr + ADDR_REG_OFFSET);
+	outb(val >> 8, data->addr + DATA_REG_OFFSET);
+	outb(reg, data->addr + ADDR_REG_OFFSET);
+	outb(val & 255, data->addr + DATA_REG_OFFSET);
+}
+
+static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr, reg, reg2;
@@ -346,34 +633,33 @@
 	mutex_lock(&data->update_lock);
 
 	/* Update once every 60 seconds */
-	if ( time_after(jiffies, data->last_limits + 60 * HZ ) ||
-			!data->valid) {
+	if (time_after(jiffies, data->last_limits + 60 * HZ) || !data->valid) {
 		data->in1_max = f71882fg_read8(data, F71882FG_REG_IN1_HIGH);
 		data->in_beep = f71882fg_read8(data, F71882FG_REG_IN_BEEP);
 
-		/* Get High & boundary temps*/
+		/* Get High & boundary temps */
 		for (nr = 0; nr < 3; nr++) {
 			data->temp_ovt[nr] = f71882fg_read8(data,
-						F71882FG_REG_TEMP_OVT(nr));
-			data->temp_high[nr] = f71882fg_read8(data,
-						F71882FG_REG_TEMP_HIGH(nr));
+						    F71882FG_REG_TEMP_OVT(nr));
+			data->temp_high[nr] =
+			    f71882fg_read8(data, F71882FG_REG_TEMP_HIGH(nr));
 		}
 
-		/* Have to hardcode hyst*/
+		/* Have to hardcode hyst */
 		data->temp_hyst[0] = f71882fg_read8(data,
-						F71882FG_REG_TEMP_HYST1) >> 4;
+					    F71882FG_REG_TEMP_HYST1) >> 4;
 		/* Hyst temps 2 & 3 stored in same register */
 		reg = f71882fg_read8(data, F71882FG_REG_TEMP_HYST23);
 		data->temp_hyst[1] = reg & 0x0F;
 		data->temp_hyst[2] = reg >> 4;
 
 		/* Have to hardcode type, because temp1 is special */
-		reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
+		reg = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
 		reg2 = f71882fg_read8(data, F71882FG_REG_PECI);
 		if ((reg2 & 0x03) == 0x01)
-			data->temp_type[0] = 6 /* PECI */;
+			data->temp_type[0] = 6 /* PECI */ ;
 		else if ((reg2 & 0x03) == 0x02)
-			data->temp_type[0] = 5 /* AMDSI */;
+			data->temp_type[0] = 5 /* AMDSI */ ;
 		else
 			data->temp_type[0] = (reg & 0x02) ? 2 : 4;
 
@@ -390,24 +676,53 @@
 	/* Update every second */
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		data->temp_status = f71882fg_read8(data,
-						F71882FG_REG_TEMP_STATUS);
+						   F71882FG_REG_TEMP_STATUS);
 		data->temp_diode_open = f71882fg_read8(data,
-						F71882FG_REG_TEMP_DIODE_OPEN);
+					       F71882FG_REG_TEMP_DIODE_OPEN);
 		for (nr = 0; nr < 3; nr++)
 			data->temp[nr] = f71882fg_read8(data,
-						F71882FG_REG_TEMP(nr));
+							F71882FG_REG_TEMP(nr));
 
 		data->fan_status = f71882fg_read8(data,
-						F71882FG_REG_FAN_STATUS);
-		for (nr = 0; nr < 4; nr++)
+						  F71882FG_REG_FAN_STATUS);
+		data->pwm_enable = f71882fg_read8(data,
+						  F71882FG_REG_PWM_ENABLE);
+		data->pwm_auto_point_hyst[0] = f71882fg_read8(data,
+						      F71882FG_REG_FAN_HYST0);
+		data->pwm_auto_point_hyst[1] = f71882fg_read8(data,
+						      F71882FG_REG_FAN_HYST1);
+		for (nr = 0; nr < 4; nr++) {
+			int point;
 			data->fan[nr] = f71882fg_read16(data,
-						F71882FG_REG_FAN(nr));
+							F71882FG_REG_FAN(nr));
+			data->fan_target[nr] =
+			    f71882fg_read16(data, F71882FG_REG_FAN_TARGET(nr));
+			data->fan_full_speed[nr] =
+			    f71882fg_read16(data,
+					    F71882FG_REG_FAN_FULL_SPEED(nr));
+			data->pwm[nr] =
+			    f71882fg_read8(data, F71882FG_REG_PWM(nr));
+			data->pwm_auto_point_mapping[nr] =
+			    f71882fg_read8(data,
+					   F71882FG_REG_POINT_MAPPING(nr));
+			for (point = 0; point < 5; point++) {
+				data->pwm_auto_point_pwm[nr][point] =
+				    f71882fg_read8(data,
+						   F71882FG_REG_POINT_PWM
+						   (nr, point));
+			}
+			for (point = 0; point < 4; point++) {
+				data->pwm_auto_point_temp[nr][point] =
+				    f71882fg_read8(data,
+						   F71882FG_REG_POINT_TEMP
+						   (nr, point));
+			}
+		}
 
-		data->in_status = f71882fg_read8(data,
-						F71882FG_REG_IN_STATUS);
+		data->in_status = f71882fg_read8(data, F71882FG_REG_IN_STATUS);
 		for (nr = 0; nr < 9; nr++)
 			data->in[nr] = f71882fg_read8(data,
-						F71882FG_REG_IN(nr));
+						      F71882FG_REG_IN(nr));
 
 		data->last_updated = jiffies;
 		data->valid = 1;
@@ -419,8 +734,8 @@
 }
 
 /* Sysfs Interface */
-static ssize_t show_fan(struct device *dev, struct device_attribute *devattr,
-	char *buf)
+static ssize_t show_fan(struct device *dev,
+			struct device_attribute *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -432,8 +747,38 @@
 	return sprintf(buf, "%d\n", speed);
 }
 
+static ssize_t show_fan_full_speed(struct device *dev,
+				   struct device_attribute *devattr, char *buf)
+{
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int speed = fan_from_reg(data->fan_full_speed[nr]);
+	return sprintf(buf, "%d\n", speed);
+}
+
+static ssize_t store_fan_full_speed(struct device *dev,
+				    struct device_attribute *devattr,
+				    const char *buf, size_t count)
+{
+	struct f71882fg_data *data = dev_get_drvdata(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	if (data->pwm_enable & (1 << (2 * nr)))
+		count = -EINVAL;
+	else {
+		f71882fg_write16(data, F71882FG_REG_FAN_FULL_SPEED(nr),
+				 fan_to_reg(val));
+		data->fan_full_speed[nr] = fan_to_reg(val);
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
 static ssize_t show_fan_beep(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			     *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -445,7 +790,7 @@
 }
 
 static ssize_t store_fan_beep(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+			      *devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -464,7 +809,7 @@
 }
 
 static ssize_t show_fan_alarm(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			      *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -475,8 +820,8 @@
 		return sprintf(buf, "0\n");
 }
 
-static ssize_t show_in(struct device *dev, struct device_attribute *devattr,
-	char *buf)
+static ssize_t show_in(struct device *dev,
+		       struct device_attribute *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -485,7 +830,7 @@
 }
 
 static ssize_t show_in_max(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			   *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 
@@ -493,7 +838,7 @@
 }
 
 static ssize_t store_in_max(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+			    *devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int val = simple_strtoul(buf, NULL, 10) / 8;
@@ -510,7 +855,7 @@
 }
 
 static ssize_t show_in_beep(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			    *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -522,7 +867,7 @@
 }
 
 static ssize_t store_in_beep(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+			     *devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -541,7 +886,7 @@
 }
 
 static ssize_t show_in_alarm(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			     *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -552,8 +897,8 @@
 		return sprintf(buf, "0\n");
 }
 
-static ssize_t show_temp(struct device *dev, struct device_attribute *devattr,
-	char *buf)
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -562,7 +907,7 @@
 }
 
 static ssize_t show_temp_max(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			     *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -571,7 +916,7 @@
 }
 
 static ssize_t store_temp_max(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+			      *devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -589,17 +934,17 @@
 }
 
 static ssize_t show_temp_max_hyst(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+				  *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	return sprintf(buf, "%d\n",
-		(data->temp_high[nr] - data->temp_hyst[nr]) * 1000);
+		       (data->temp_high[nr] - data->temp_hyst[nr]) * 1000);
 }
 
 static ssize_t store_temp_max_hyst(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+				   *devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -619,19 +964,19 @@
 
 	/* convert value to register contents */
 	switch (nr) {
-		case 0:
-			val = val << 4;
-			break;
-		case 1:
-			val = val | (data->temp_hyst[2] << 4);
-			break;
-		case 2:
-			val = data->temp_hyst[1] | (val << 4);
-			break;
+	case 0:
+		val = val << 4;
+		break;
+	case 1:
+		val = val | (data->temp_hyst[2] << 4);
+		break;
+	case 2:
+		val = data->temp_hyst[1] | (val << 4);
+		break;
 	}
 
 	f71882fg_write8(data, nr ? F71882FG_REG_TEMP_HYST23 :
-		F71882FG_REG_TEMP_HYST1, val);
+			F71882FG_REG_TEMP_HYST1, val);
 
 store_temp_max_hyst_exit:
 	mutex_unlock(&data->update_lock);
@@ -639,7 +984,7 @@
 }
 
 static ssize_t show_temp_crit(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			      *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -648,7 +993,7 @@
 }
 
 static ssize_t store_temp_crit(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+			       *devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -666,17 +1011,17 @@
 }
 
 static ssize_t show_temp_crit_hyst(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+				   *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
 
 	return sprintf(buf, "%d\n",
-		(data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000);
+		       (data->temp_ovt[nr] - data->temp_hyst[nr]) * 1000);
 }
 
 static ssize_t show_temp_type(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			      *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -685,7 +1030,7 @@
 }
 
 static ssize_t show_temp_beep(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			      *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -697,7 +1042,7 @@
 }
 
 static ssize_t store_temp_beep(struct device *dev, struct device_attribute
-	*devattr, const char *buf, size_t count)
+			       *devattr, const char *buf, size_t count)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -716,7 +1061,7 @@
 }
 
 static ssize_t show_temp_alarm(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			       *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -728,7 +1073,7 @@
 }
 
 static ssize_t show_temp_fault(struct device *dev, struct device_attribute
-	*devattr, char *buf)
+			       *devattr, char *buf)
 {
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
@@ -739,20 +1084,330 @@
 		return sprintf(buf, "0\n");
 }
 
-static ssize_t show_name(struct device *dev, struct device_attribute *devattr,
-	char *buf)
+static ssize_t show_pwm(struct device *dev,
+			struct device_attribute *devattr, char *buf)
 {
-	return sprintf(buf, DRVNAME "\n");
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int val, nr = to_sensor_dev_attr_2(devattr)->index;
+	if (data->pwm_enable & (1 << (2 * nr)))
+		/* PWM mode */
+		val = data->pwm[nr];
+	else
+		/* RPM mode */
+		val = 255 * fan_from_reg(data->fan_target[nr])
+		    / fan_from_reg(data->fan_full_speed[nr]);
+	return sprintf(buf, "%d\n", val);
+}
+
+static ssize_t store_pwm(struct device *dev,
+			 struct device_attribute *devattr, const char *buf,
+			 size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int val = simple_strtoul(buf, NULL, 10);
+	val = SENSORS_LIMIT(val, 0, 255);
+
+	mutex_lock(&data->update_lock);
+	if (data->pwm_enable & (1 << (2 * nr))) {
+		/* PWM mode */
+		f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
+		data->pwm[nr] = val;
+	} else {
+		/* RPM mode */
+		int target = val * fan_from_reg(data->fan_full_speed[nr]) / 255;
+		f71882fg_write16(data, F71882FG_REG_FAN_TARGET(nr),
+				 fan_to_reg(target));
+		data->fan_target[nr] = fan_to_reg(target);
+	}
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_enable(struct device *dev,
+			       struct device_attribute *devattr, char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+
+	if (2 & (data->pwm_enable >> (2 * nr)))
+		result = 1;
+	else
+		result = 2;
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_enable(struct device *dev, struct device_attribute
+				*devattr, const char *buf, size_t count)
+{
+	struct f71882fg_data *data = dev_get_drvdata(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int val = simple_strtoul(buf, NULL, 10);
+	if (val < 0 || val > 2)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	switch (val) {
+	case 0:
+	case 1:
+		data->pwm_enable |= 2 << (2 * nr);
+		break;		/* Manual */
+	case 2:
+		data->pwm_enable &= ~(2 << (2 * nr));
+		break;		/* Temperature ctrl */
+	}
+	switch (fan_mode[nr]) {
+	case 1:
+		data->pwm_enable |= 1 << (2 * nr);
+		break;		/* Duty cycle mode */
+	case 2:
+		data->pwm_enable &= ~(1 << (2 * nr));
+		break;		/* RPM mode */
+	}
+	f71882fg_write8(data, F71882FG_REG_PWM_ENABLE, data->pwm_enable);
+	mutex_unlock(&data->update_lock);
+	if (!val)
+		store_pwm(dev, devattr, "255", 4);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_pwm(struct device *dev,
+				       struct device_attribute *devattr,
+				       char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int pwm = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+
+	if (data->pwm_enable & (1 << (2 * pwm))) {
+		/* PWM mode */
+		result = data->pwm_auto_point_pwm[pwm][point];
+	} else {
+		/* RPM mode */
+		result = 32 * 255 / (32 + data->pwm_auto_point_pwm[pwm][point]);
+	}
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_auto_point_pwm(struct device *dev,
+					struct device_attribute *devattr,
+					const char *buf, size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int pwm = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+	int val = simple_strtoul(buf, NULL, 10);
+	val = SENSORS_LIMIT(val, 0, 255);
+
+	mutex_lock(&data->update_lock);
+	if (data->pwm_enable & (1 << (2 * pwm))) {
+		/* PWM mode */
+	} else {
+		/* RPM mode */
+		if (val < 29)	/* Prevent negative numbers */
+			val = 255;
+		else
+			val = (255 - val) * 32 / val;
+	}
+	f71882fg_write8(data, F71882FG_REG_POINT_PWM(pwm, point), val);
+	data->pwm_auto_point_pwm[pwm][point] = val;
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_temp_hyst(struct device *dev,
+					     struct device_attribute *devattr,
+					     char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+
+	switch (nr) {
+	case 0:
+		result = data->pwm_auto_point_hyst[0] & 15;
+		break;
+	case 1:
+		result = data->pwm_auto_point_hyst[0] >> 4;
+		break;
+	case 2:
+		result = data->pwm_auto_point_hyst[1] & 15;
+		break;
+	case 3:
+		result = data->pwm_auto_point_hyst[1] >> 4;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return sprintf(buf, "%d\n",
+		       data->pwm_auto_point_temp[nr][point] - result);
+}
+
+static ssize_t store_pwm_auto_point_temp_hyst(struct device *dev,
+					      struct device_attribute *devattr,
+					      const char *buf, size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int val = simple_strtoul(buf, NULL, 10);
+	val -= data->pwm_auto_point_temp[nr][0];
+	val = SENSORS_LIMIT(val, 0, 15);
+
+	mutex_lock(&data->update_lock);
+	switch (nr) {
+	case 0:
+		val = (data->pwm_auto_point_hyst[0] & 0xf0) | val;
+		break;
+	case 1:
+		val = (data->pwm_auto_point_hyst[0] & 0x0f) | (val << 4);
+		break;
+	case 2:
+		val = (data->pwm_auto_point_hyst[1] & 0xf0) | val;
+		break;
+	case 3:
+		val = (data->pwm_auto_point_hyst[1] & 0x0f) | (val << 4);
+		break;
+	}
+	if (nr == 0 || nr == 1)
+		f71882fg_write8(data, F71882FG_REG_FAN_HYST0, val);
+	else
+		f71882fg_write8(data, F71882FG_REG_FAN_HYST1, val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_interpolate(struct device *dev,
+				    struct device_attribute *devattr, char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+
+	result = 1 & (data->pwm_auto_point_mapping[nr] >> 4);
+
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_interpolate(struct device *dev,
+				     struct device_attribute *devattr,
+				     const char *buf, size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int val = simple_strtoul(buf, NULL, 10);
+	mutex_lock(&data->update_lock);
+	if (val)
+		val = data->pwm_auto_point_mapping[nr] | (1 << 4);
+	else
+		val = data->pwm_auto_point_mapping[nr] & (~(1 << 4));
+	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_channel(struct device *dev,
+					   struct device_attribute *devattr,
+					   char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+
+	result = 1 << (data->pwm_auto_point_mapping[nr] & 3);
+	result >>= 1;
+
+	return sprintf(buf, "%d\n", result);
 }
 
+static ssize_t store_pwm_auto_point_channel(struct device *dev,
+					    struct device_attribute *devattr,
+					    const char *buf, size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int nr = to_sensor_dev_attr_2(devattr)->index;
+	int val = simple_strtoul(buf, NULL, 10);
+	switch (val) {
+	case 1:
+		val = 1;
+		break;
+	case 2:
+		val = 2;
+		break;
+	case 4:
+		val = 3;
+		break;
+	default:
+		return -EINVAL;
+	}
+	val |= data->pwm_auto_point_mapping[nr] & 0xfc;
+	mutex_lock(&data->update_lock);
+	f71882fg_write8(data, F71882FG_REG_POINT_MAPPING(nr), val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_pwm_auto_point_temp(struct device *dev,
+					struct device_attribute *devattr,
+					char *buf)
+{
+	int result;
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int pwm = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+
+	result = data->pwm_auto_point_temp[pwm][point];
+	return sprintf(buf, "%d\n", result);
+}
+
+static ssize_t store_pwm_auto_point_temp(struct device *dev,
+					 struct device_attribute *devattr,
+					 const char *buf, size_t count)
+{
+	/* struct f71882fg_data *data = dev_get_drvdata(dev); */
+	struct f71882fg_data *data = f71882fg_update_device(dev);
+	int pwm = to_sensor_dev_attr_2(devattr)->index;
+	int point = to_sensor_dev_attr_2(devattr)->nr;
+	int val = simple_strtoul(buf, NULL, 10);
+	val = SENSORS_LIMIT(val, 0, 255);
+
+	mutex_lock(&data->update_lock);
+	f71882fg_write8(data, F71882FG_REG_POINT_TEMP(pwm, point), val);
+	mutex_unlock(&data->update_lock);
+
+	return count;
+}
+
+static ssize_t show_name(struct device *dev,
+			 struct device_attribute *devattr, char *buf)
+{
+	return sprintf(buf, DRVNAME "\n");
+}
 
-static int __devinit f71882fg_probe(struct platform_device * pdev)
+static int __devinit f71882fg_probe(struct platform_device *pdev)
 {
 	struct f71882fg_data *data;
 	int err, i;
 	u8 start_reg;
 
-	if (!(data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL)))
+	data = kzalloc(sizeof(struct f71882fg_data), GFP_KERNEL);
+	if (!data)
 		return -ENOMEM;
 
 	data->addr = platform_get_resource(pdev, IORESOURCE_IO, 0)->start;
@@ -770,7 +1425,8 @@
 	if (start_reg & 0x01) {
 		for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++) {
 			err = device_create_file(&pdev->dev,
-					&f71882fg_in_temp_attr[i].dev_attr);
+						 &f71882fg_in_temp_attr[i].
+						 dev_attr);
 			if (err)
 				goto exit_unregister_sysfs;
 		}
@@ -779,7 +1435,8 @@
 	if (start_reg & 0x02) {
 		for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++) {
 			err = device_create_file(&pdev->dev,
-					&f71882fg_fan_attr[i].dev_attr);
+						 &f71882fg_fan_attr[i].
+						 dev_attr);
 			if (err)
 				goto exit_unregister_sysfs;
 		}
@@ -799,7 +1456,7 @@
 
 	for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++)
 		device_remove_file(&pdev->dev,
-					&f71882fg_in_temp_attr[i].dev_attr);
+				   &f71882fg_in_temp_attr[i].dev_attr);
 
 	for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)
 		device_remove_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);
@@ -822,7 +1479,7 @@
 
 	for (i = 0; i < ARRAY_SIZE(f71882fg_in_temp_attr); i++)
 		device_remove_file(&pdev->dev,
-					&f71882fg_in_temp_attr[i].dev_attr);
+				   &f71882fg_in_temp_attr[i].dev_attr);
 
 	for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)
 		device_remove_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);
@@ -860,8 +1517,7 @@
 	}
 
 	*address = superio_inw(sioaddr, SIO_REG_ADDR);
-	if (*address == 0)
-	{
+	if (*address == 0) {
 		printk(KERN_WARNING DRVNAME ": Base address not set\n");
 		goto exit;
 	}
@@ -871,14 +1527,15 @@
 	start_reg = f71882fg_read8(&data, F71882FG_REG_START);
 	if (!(start_reg & 0x03)) {
 		printk(KERN_WARNING DRVNAME
-			": Hardware monitoring not activated\n");
+		       ": Hardware monitoring not activated\n");
 		goto exit;
 	}
 
 	err = 0;
-	printk(KERN_INFO DRVNAME ": Found F71882FG chip at %#x, revision %d\n",
-		(unsigned int)*address,
-		(int)superio_inb(sioaddr, SIO_REG_DEVREV));
+	printk(KERN_INFO DRVNAME
+	       ": Found F71882FG chip at %#x, revision %d\n",
+	       (unsigned int)*address, (int)superio_inb(sioaddr,
+							SIO_REG_DEVREV));
 exit:
 	superio_exit(sioaddr);
 	return err;
@@ -887,9 +1544,9 @@
 static int __init f71882fg_device_add(unsigned short address)
 {
 	struct resource res = {
-		.start	= address,
-		.end	= address + REGION_LENGTH - 1,
-		.flags	= IORESOURCE_IO,
+		.start = address,
+		.end = address + REGION_LENGTH - 1,
+		.flags = IORESOURCE_IO,
 	};
 	int err;
 
@@ -926,10 +1583,12 @@
 	if (f71882fg_find(0x2e, &address) && f71882fg_find(0x4e, &address))
 		goto exit;
 
-	if ((err = platform_driver_register(&f71882fg_driver)))
+	err = platform_driver_register(&f71882fg_driver);
+	if (err)
 		goto exit;
 
-	if ((err = f71882fg_device_add(address)))
+	err = f71882fg_device_add(address);
+	if (err)
 		goto exit_driver;
 
 	return 0;

--=_48ebac21.clOe3IH4xtec8Tc9ik4uDV09id9PxxciOXQdtjnmXm72HpsM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=_48ebac21.clOe3IH4xtec8Tc9ik4uDV09id9PxxciOXQdtjnmXm72HpsM--

