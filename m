From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 25 Jun 2008 07:22:10 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.25.4] f71882.c driver,
Message-Id: <4861F222.7000209@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200806110520.m5B5KDgO018954@localhost>
In-Reply-To: <200806110520.m5B5KDgO018954@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark van Doesburg wrote:
> Hi,
> 
> I've finally added some missing features to the driver.

Good work, thanks!

> There are still
> some things unimplemented, such as:
> 
> 	1. Changing the fan target reached timeout.
> 	2. Something to set FAN?_RATE_SEL.  
> 	3. FAN?_STOP_DUTY
> 	4. FAN?_JUMP_HIGH_EN and FAN?_JUMP_LOW_EN 
> 
> Mostly because I don't need them, and there is no default name for
> these features.
> 

Yes, I saw all those when reviewing the datasheet too, and I agree its best to 
just not export them.

> I did add one entry to set/reset the interpolation mode of the auto_point
> follower, to make the pwm control act as a P-regulator. Simply because
> I like it, it prevents rapid speedups and slowdowns of the fan.
> 

Ok.

> Since the auto_point follower is able to track only one temperature at
> a time, I gave a preference to the lowest numbered one. Maybe returning
> an error would be better if the user tries to set an impossible value ?
> 

Yes, please just return -EINVAL on an impossible value.

I've taken a quick peek at it, and all in all it looks good, except for the 
stuffing of pwm and point together in one integer that isn't necessary, I 
believe it would be the best to instead use struct sensor_device_attribute_2 
instead of struct sensor_device_attribute for the f71882fg_fan_attr array, as 
that allows specifying both an index and a nr per attr, so instead of:

static struct sensor_device_attribute f71882fg_fan_attr[] {
   	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
...
	SENSOR_ATTR(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,
		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
		AUTO_POINT(0,0)),


You would write:

static struct sensor_device_attribute f71882fg_fan_attr[] {
	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
...
	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,
		show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
		0, 0),


And then instead of:

static ssize_t store_pwm_auto_point_temp(struct device *dev,
	struct device_attribute *devattr,
	const char *buf, size_t count)
{
	int point, pwm;
	struct f71882fg_data *data = f71882fg_update_device(dev);
	int nr = to_sensor_dev_attr(devattr)->index;
	int val = simple_strtoul(buf, NULL, 10);

	pwm=AUTO_POINT_PWM(nr);
	point=AUTO_POINT_POINT(nr);
...

You would write:

static ssize_t store_pwm_auto_point_temp(struct device *dev,
	struct device_attribute *devattr,
	const char *buf, size_t count)
{
	struct f71882fg_data *data = f71882fg_update_device(dev);
	int pwm = to_sensor_dev_attr_2(devattr)->index;
	int point = to_sensor_dev_attr_2(devattr)->nr;
	int val = simple_strtoul(buf, NULL, 10);
...


If you could make a new patch with this changed (and returning -EINVAL for 
trying to bind a auto pwm to more then one temp), I'll do a full review and run 
a few tests on my f71882fg test system. I think it would be best if you could 
split this new patch in 2 parts:
1) Convert the current f71882.c from "struct sensor_device_attribute" ->
    "struct sensor_device_attribute_2" without any functional changes
2) Your patch adding pwm support (thanks!!) on top of this

I would like to see it this way for easier review.

Thanks & Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
