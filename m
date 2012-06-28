From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 28 Jun 2012 17:04:42 +0000
Subject: Re: [lm-sensors] Reducing fan speed for w83627ehf
Message-Id: <20120628170442.GA7283@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
In-Reply-To: <CAP3RjSfZQevwuBONgEbA0XaE_aiUik6sDdYY6ZJA+bWmZW1MQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jun 28, 2012 at 12:20:08PM -0400, Arun Raghavan wrote:
> > Can you provide the output of all pwm sysfs attributes ?
> > Something like "grep . /sys/class/hwmon/hwmonX/device/pwm*" should do it,
> > where
> > X is the hwmon index for the NCT6775F driver (probably 1 for your system).
> >
> > /sys/class/hwmon/hwmon1/device/pwm1:255
> /sys/class/hwmon/hwmon1/device/pwm1_enable:1
> /sys/class/hwmon/hwmon1/device/pwm1_max_output:255
> /sys/class/hwmon/hwmon1/device/pwm1_mode:1
> /sys/class/hwmon/hwmon1/device/pwm1_start_output:128
> /sys/class/hwmon/hwmon1/device/pwm1_step_output:3
> /sys/class/hwmon/hwmon1/device/pwm1_stop_output:128
> /sys/class/hwmon/hwmon1/device/pwm1_stop_time:1000
> /sys/class/hwmon/hwmon1/device/pwm1_target:41000
> /sys/class/hwmon/hwmon1/device/pwm1_tolerance:1000
> /sys/class/hwmon/hwmon1/device/pwm2:1
> /sys/class/hwmon/hwmon1/device/pwm2_enable:1
> /sys/class/hwmon/hwmon1/device/pwm2_max_output:255
> /sys/class/hwmon/hwmon1/device/pwm2_mode:1
> /sys/class/hwmon/hwmon1/device/pwm2_start_output:128
> /sys/class/hwmon/hwmon1/device/pwm2_step_output:4
> /sys/class/hwmon/hwmon1/device/pwm2_stop_output:128
> /sys/class/hwmon/hwmon1/device/pwm2_stop_time:1000
> /sys/class/hwmon/hwmon1/device/pwm2_target:44000
> /sys/class/hwmon/hwmon1/device/pwm2_tolerance:1000
> /sys/class/hwmon/hwmon1/device/pwm3:1
> /sys/class/hwmon/hwmon1/device/pwm3_enable:1
> /sys/class/hwmon/hwmon1/device/pwm3_max_output:255
> /sys/class/hwmon/hwmon1/device/pwm3_mode:1
> /sys/class/hwmon/hwmon1/device/pwm3_start_output:128
> /sys/class/hwmon/hwmon1/device/pwm3_step_output:3
> /sys/class/hwmon/hwmon1/device/pwm3_stop_output:128
> /sys/class/hwmon/hwmon1/device/pwm3_stop_time:1000
> /sys/class/hwmon/hwmon1/device/pwm3_target:41000
> /sys/class/hwmon/hwmon1/device/pwm3_tolerance:1000
> 
Hi Arun,

is that the default setting after system powerup, or did you modify it ?
Just wondering, since the NCT6775 is usually configured for automatic fan
control (which, in my experience, works pretty well).

Anyway, the fans are all in pwm mode, so I think Jean is right and the fan just
doesn't get slower than 1000 rpm. Which may explain why one of the fans in my
system runs at 1000 rpm, even though it turns out that its pwm value is lower
than the other fan's pwm value.

For comparison, here is the output for pwm1 on my system with NCT6775.

/sys/class/hwmon/hwmon1/device/pwm1:64
/sys/class/hwmon/hwmon1/device/pwm1_auto_point1_pwm:50
/sys/class/hwmon/hwmon1/device/pwm1_auto_point1_temp:5000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point1_temp_hyst:3000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point2_pwm:77
/sys/class/hwmon/hwmon1/device/pwm1_auto_point2_temp:89000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point2_temp_hyst:87000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point3_pwm:77
/sys/class/hwmon/hwmon1/device/pwm1_auto_point3_temp:89000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point3_temp_hyst:87000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point4_pwm:123
/sys/class/hwmon/hwmon1/device/pwm1_auto_point4_temp:98000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point4_temp_hyst:96000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point5_pwm:166
/sys/class/hwmon/hwmon1/device/pwm1_auto_point5_temp:101000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point5_temp_hyst:99000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point6_pwm:255
/sys/class/hwmon/hwmon1/device/pwm1_auto_point6_temp:104000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point6_temp_hyst:102000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point7_pwm:255
/sys/class/hwmon/hwmon1/device/pwm1_auto_point7_temp:114000
/sys/class/hwmon/hwmon1/device/pwm1_auto_point7_temp_hyst:114000
/sys/class/hwmon/hwmon1/device/pwm1_enable:5
/sys/class/hwmon/hwmon1/device/pwm1_max_output:255
/sys/class/hwmon/hwmon1/device/pwm1_mode:1
/sys/class/hwmon/hwmon1/device/pwm1_start_output:1
/sys/class/hwmon/hwmon1/device/pwm1_step_down_time:100
/sys/class/hwmon/hwmon1/device/pwm1_step_enable:1
/sys/class/hwmon/hwmon1/device/pwm1_step_output:1
/sys/class/hwmon/hwmon1/device/pwm1_step_up_time:200
/sys/class/hwmon/hwmon1/device/pwm1_stop_output:1
/sys/class/hwmon/hwmon1/device/pwm1_stop_output_enable:0
/sys/class/hwmon/hwmon1/device/pwm1_stop_time:6000
/sys/class/hwmon/hwmon1/device/pwm1_target:1000
/sys/class/hwmon/hwmon1/device/pwm1_temp_sel:8
/sys/class/hwmon/hwmon1/device/pwm1_weight_duty_step:36
/sys/class/hwmon/hwmon1/device/pwm1_weight_enable:1
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_sel:1
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step:2000
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_base:70000
/sys/class/hwmon/hwmon1/device/pwm1_weight_temp_step_tol:1000

This is with the new driver for the NCT677X chips, which supports automatic
fan control. Might be worthwhile to give it a try if you want to use
automatic fan control.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
