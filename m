From: greg@kroah.com (Greg KH)
Date: Fri, 10 Feb 2006 08:07:56 +0000
Subject: [lm-sensors] A patch for w83791d for 2.6 kernel
Message-Id: <20060210080756.GA10700@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80602091334m2319cb42j5e2710bdc1d8f1ff@mail.gmail.com>
In-Reply-To: <5bfe43f80602091334m2319cb42j5e2710bdc1d8f1ff@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Feb 09, 2006 at 01:34:42PM -0800, Charles Spirakis wrote:
> All --
> 
> Below is a patch to add w83791d support into the 2.6 kernel. This
> patch was created off of the 2.6.15.3 base, but it should apply
> cleanly on many earlier kernels (been tried on 2.6.14.3 and 2.6.15.1).
> 
> I've tried this on the system I have available here and it appears to work.
> 
> Thanks!
> 
> -- charles
> 
> 
> diff -urpN linux-2.6.15.3/Documentation/hwmon/w83791d
> linux-2.6.15.3-w83791d/Documentation/hwmon/w83791d
> --- linux-2.6.15.3/Documentation/hwmon/w83791d  1969-12-31
> 16:00:00.000000000 -0800

It looks like your email client wrapped the lines of the patch, and ate
all of the tabs for breakfast and spit them back out as spaces :(

Care to fix up your mailer problems and try again?


> +static inline u8 DIV_TO_REG(long val)
> +{
> +       int i;
> +       val = SENSORS_LIMIT(val, 1, 128) >> 1;
> +       for (i = 0; i < 6; i++) {
> +               if (val = 0)
> +                       break;
> +               val >>= 1;
> +       }
> +       return ((u8) i);

return is not a function, and doesn't need the ().

> +}
> +
> +struct w83791d_data {
> +       struct i2c_client client;
> +       struct class_device *class_dev;
> +       struct semaphore lock;

Perhaps a mutex instead?

> +static ssize_t
> +store_fan_cruise(struct device *dev, struct device_attribute *attr,
> +                    const char *buf, size_t count)
> +{
> +       struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
> +       int nr = sensor_attr->index - 1;
> +       struct i2c_client *client = to_i2c_client(dev);
> +       struct w83791d_data *data = i2c_get_clientdata(client);
> +       u32 val;
> +       u8 target_mask;
> +
> +       val = simple_strtoul(buf, NULL, 10);
> +       down(&data->update_lock);
> +       if (W83791D_FAN_SPEED_CRUISE = data->pwmenable[nr]) {
> +               data->fan_cruise[nr] = SENSORS_LIMIT(val, 0, 255);
> +               w83791d_write_value(client, W83791D_REG_TTARG[nr],
> +                                   data->fan_cruise[nr]);
> +       }
> +       else {

Put the else on the same line as the }, so it would look like:
	} else {

thanks,

greg k-h

