From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 09 May 2015 15:55:00 +0000
Subject: Re: [lm-sensors] Additional PWM driver support for w83792d
Message-Id: <554E2DD4.3070701@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
In-Reply-To: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/09/2015 05:57 AM, vt8231@hiddenengine.co.uk wrote:
> Dear LM-Sensors,
>
> I have a Dell FS12-NV7 server and it has two W83792G chips on it (as well as
> an IT87).  One of the W83792G devices is connected to three fans on PWM
> outputs 3,4 and 5 respectively.
>
> I am running with Ubuntu 15.04 (Linux 3.19.0) and the W83792D driver only
> has support for PWM outputs 1,2 and 3.
>
> The patch below adds the 4 missing PWM outputs which are supported by the
> chip.  This has been tested and works as expected on my motherboard.
>
> --- linux-3.19.0/drivers/hwmon/w83792d.c        2015-02-09
> 02:54:22.000000000 +0000
> +++ linux-3.19.0-new/drivers/hwmon/w83792d.c    2015-05-08
> 21:53:06.637515282 +0100
> @@ -1075,6 +1075,10 @@
>   static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0);
>   static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
>   static SENSOR_DEVICE_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2);
> +static SENSOR_DEVICE_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3);
> +static SENSOR_DEVICE_ATTR(pwm5, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 4);
> +static SENSOR_DEVICE_ATTR(pwm6, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 5);
> +static SENSOR_DEVICE_ATTR(pwm7, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 6);
>   static SENSOR_DEVICE_ATTR(pwm1_enable, S_IWUSR | S_IRUGO,
>                          show_pwmenable, store_pwmenable, 1);
>   static SENSOR_DEVICE_ATTR(pwm2_enable, S_IWUSR | S_IRUGO,
> @@ -1270,6 +1274,10 @@
>          &sensor_dev_attr_pwm3.dev_attr.attr,
>          &sensor_dev_attr_pwm3_mode.dev_attr.attr,
>          &sensor_dev_attr_pwm3_enable.dev_attr.attr,
> +       &sensor_dev_attr_pwm4.dev_attr.attr,
> +       &sensor_dev_attr_pwm5.dev_attr.attr,
> +       &sensor_dev_attr_pwm6.dev_attr.attr,
> +       &sensor_dev_attr_pwm7.dev_attr.attr,
>          &dev_attr_alarms.attr,
>          &dev_attr_intrusion0_alarm.attr,
>          &sensor_dev_attr_tolerance1.dev_attr.attr,
>

Hi Roger,

unfortunately it is not that simple.

The chip's io pins for pwm4 .. pwm7 are, like the respective fan status
pins, multi-function pins. You'll have to add the pointers to
sensor_dev_attr_pwm[4..7] to w83792d_attributes_fan[].

Also, I think you should also add pwm[4..7]_mode since it follows the same
rules as pwm[4..7] and uses the same registers.

Last but not least, can you send the patch in a form that can be applied,
as outlined in Documentation/SubmittingPatches ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
