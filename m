From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Jun 2012 19:06:53 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <20120628190653.GB20159@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 28, 2012 at 01:18:45PM -0400, Arun Raghavan wrote:
> Hi Guenter,
> 
> 
> 
> > is that the default setting after system powerup, or did you modify it ?
> > Just wondering, since the NCT6775 is usually configured for automatic fan
> > control (which, in my experience, works pretty well).
> >
> > Anyway, the fans are all in pwm mode, so I think Jean is right and the fan
> > just
> > doesn't get slower than 1000 rpm. Which may explain why one of the fans in
> > my
> > system runs at 1000 rpm, even though it turns out that its pwm value is
> > lower
> > than the other fan's pwm value.
> >
> 
> I modified it to manual and changed the PWM divisor to see what speeds I
> could get. I agree that Jean's diagnosis makes sense.
>  It isn't that the automatic fan control didn't work well, in fact it never
> gave me problems. This might sound weird, but I actually need the fan speed
> lower to reach a specific (lower) TDP for experimental work.
> After playing around with the heatsink and fan settings, the TDP is
> currently pretty close to what I ideally want, to within about 5W. I was
> hoping to shave off 5W more by reducing fan speed further.
> 
> >
> > For comparison, here is the output for pwm1 on my system with NCT6775.
> >
> > /sys/class/hwmon/hwmon1/device/pwm1:64
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point1_pwm:50
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point1_temp:5000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point1_temp_hyst:3000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point2_pwm:77
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point2_temp:89000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point2_temp_hyst:87000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point3_pwm:77
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point3_temp:89000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point3_temp_hyst:87000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point4_pwm:123
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point4_temp:98000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point4_temp_hyst:96000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point5_pwm:166
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point5_temp:101000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point5_temp_hyst:99000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point6_pwm:255
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point6_temp:104000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point6_temp_hyst:102000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point7_pwm:255
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point7_temp:114000
> > /sys/class/hwmon/hwmon1/device/pwm1_auto_point7_temp_hyst:114000
> > /sys/class/hwmon/hwmon1/device/pwm1_enable:5
> > /sys/class/hwmon/hwmon1/device/pwm1_max_output:255
> > /sys/class/hwmon/hwmon1/device/pwm1_mode:1
> > /sys/class/hwmon/hwmon1/device/pwm1_start_output:1
> > /sys/class/hwmon/hwmon1/device/pwm1_step_down_time:100
> > /sys/class/hwmon/hwmon1/device/pwm1_step_enable:1
> > /sys/class/hwmon/hwmon1/device/pwm1_step_output:1
> > /sys/class/hwmon/hwmon1/device/pwm1_step_up_time:200
> > /sys/class/hwmon/hwmon1/device/pwm1_stop_output:1
> > /sys/class/hwmon/hwmon1/device/pwm1_stop_output_enable:0
> > /sys/class/hwmon/hwmon1/device/pwm1_stop_time:6000
> > /sys/class/hwmon/hwmon1/device/pwm1_target:1000
> > /sys/class/hwmon/hwmon1/device/pwm1_temp_sel:8
> > /sys/class/hwmon/hwmon1/device/pwm1_weight_duty_step:36
> > /sys/class/hwmon/hwmon1/device/pwm1_weight_enable:1
> > /sys/class/hwmon/hwmon1/device/pwm1_weight_temp_sel:1
> > /sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step:2000
> > /sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_base:70000
> > /sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_tol:1000
> >
> > This is with the new driver for the NCT677X chips, which supports automatic
> > fan control. Might be worthwhile to give it a try if you want to use
> > automatic fan control.
> >
> > Thanks. I'm trying to retain control of the thermals for a study.
> Actually, could you provide some more info on how the automatic control
> works? In specific, does it try to keep *average* temperature under control
> by modulating fan speed, or can I get it to keep a constant fan speed so
> that temperature doesn't fluctuate (i.e. a plot of temperature v/s time
> would be monotonic under constant input power)? That might work for me too.

The chip has multiple modes. In "thermal cruise" mode it tries to keep a fixed
temperature by adjusting the fan speed. In "speed cruise" mode it tries to keep
the fan speed constant. In "SmartFan" mode it increases the fan speed with
increasing temperature based on the settings in the auto_point attributes.
In SmartFan mode, the auto_point settings can optionally be augmented with
the "weight" attributes. For example, if the board temperature is low but
the CPU temperature is high, the chassis fan can be made to run faster
by monitoring the CPU temperature in addition to the board temperature.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
