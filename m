From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Nov 2013 04:05:46 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <5281A91A.5040404@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 11/11/2013 07:24 PM, p. stephen w wrote:
> The control provided by the NCT chip would be the BIOS control?

No, that is handled by the NCT chip internally. The BIOS just sets the values
in the chip.

> My main concern is noise and the BIOS PWM control was still too noisy.  Plus it seemed to respond to CPU load rather then temp.  The slightest load ramped up the audible level, then back down as it went to idle.  The result was a noisy computer that sounded like it was breathing.  My thinking was that I needed some kind of PWM control with greater range like I got from Asus AI 3 utility.  This meant controlling it from the OS, and that's how I got to lm-sensors and fancontrol.  It is overclocked (OC'd), but spends most of its time idling as it only runs as a web server.  The benefit of the OC is seen when running windows because then it becomes my development machine, when on the job.  When its running Linux I'm not concerned about temps.
>
No, it is the CPU temperature which can increase substantially within a few seconds.

You can select the ramp with

/sys/class/hwmon/hwmon2/device/pwm2_auto_point1_pwm:51
/sys/class/hwmon/hwmon2/device/pwm2_auto_point1_temp:20000
/sys/class/hwmon/hwmon2/device/pwm2_auto_point2_pwm:178
/sys/class/hwmon/hwmon2/device/pwm2_auto_point2_temp:70000
/sys/class/hwmon/hwmon2/device/pwm2_auto_point3_pwm:255
/sys/class/hwmon/hwmon2/device/pwm2_auto_point3_temp:75000
/sys/class/hwmon/hwmon2/device/pwm2_auto_point4_pwm:255
/sys/class/hwmon/hwmon2/device/pwm2_auto_point4_temp:75000
/sys/class/hwmon/hwmon2/device/pwm2_auto_point5_pwm:255
/sys/class/hwmon/hwmon2/device/pwm2_auto_point5_temp:75000


The above reall defines the ramp. pwmQ at 20 degrees C, then 178 at 70 degrees C
and 255 (full speed) at 75 degrees C.

In one of my systems with nct6776, the configuration looks as follows:

pwm2_auto_point1_pwm:51
pwm2_auto_point1_temp:70000
pwm2_auto_point2_pwm:102
pwm2_auto_point2_temp:79000
pwm2_auto_point3_pwm:154
pwm2_auto_point3_temp:82000
pwm2_auto_point4_pwm:255
pwm2_auto_point4_temp:85000
pwm2_auto_point5_pwm:255
pwm2_auto_point5_temp:90000

This results in a much more gradual increase. The CPU's high temperature in this case
is 85 degrees C (this is the 'high' temperature you see from coretemp), and the critical
temperature is 105 degrees C (i7-3770K).

Another example from another system (with nct6775):

pwm2_auto_point1_pwm:51
pwm2_auto_point1_temp:1000
pwm2_auto_point2_pwm:51
pwm2_auto_point2_temp:70000
pwm2_auto_point3_pwm:51
pwm2_auto_point3_temp:70000
pwm2_auto_point4_pwm:102
pwm2_auto_point4_temp:79000
pwm2_auto_point5_pwm:154
pwm2_auto_point5_temp:82000
pwm2_auto_point6_pwm:255
pwm2_auto_point6_temp:85000
pwm2_auto_point7_pwm:255
pwm2_auto_point7_temp:93000

This is with a high temp of 80 degrees C and critical temp of 98 degrees C (i7-2600).
As you can see, the increase is much more gradual in both cases.

In your case, the high temperature is 80 degrees C, so you'll want full speed at 85 degrees
or less. If you want to run your system at low noise, the second set of parameters
(which sets the max fan speed at 85 degrees C) might make sense. Obviously you'd have
to shift auto_pointX down by two as you only have five data points in your system.
You could start with something like

pwm2_auto_point1_pwm:51
pwm2_auto_point1_temp:70000
pwm2_auto_point2_pwm:102
pwm2_auto_point2_temp:79000
pwm2_auto_point3_pwm:154
pwm2_auto_point3_temp:82000
pwm2_auto_point4_pwm:255
pwm2_auto_point4_temp:85000
pwm2_auto_point5_pwm:255
pwm2_auto_point5_temp:93000

You would have to set pwm2_enable to 5 to activate automatic fan control with those settings
(after writing the above values).

> Re: temp sources being associated, I did notice what looked like an error.  Sometimes running PWMCONFIG, the file would show an assignment of fan1_input to pwm2, which is incorrect.  I would confirm the association from the pwmconfig output, and correct the file, which was fan1_input controlled by pwm1, and fan2_input controlled by pwm2.  One last item, and this is likely due to trying to use pwmconfig on the 4pin voltage controlled fan (thanks Asus), but sometimes the config file would be incomplete when assigning two sources.  Sometimes after running through the pwmcofig it would produce this:
>
>
> FCTEMPS=hwmon3/device/pwm2=hwmon1/device/temp1_input hwmon3/device/pwm1>
> OR....
> FCFANS=hwmon3/device/pwm2=hwmon3/device/fan2_input hwmon3/device/pwm1>
> What's missing is the last assignment, either temp1_input, or fan1_input.
>
That looks more like a bug in the script generating the file.

What I referred to is pwmX_temp_sel which should not be 0.

>
> I'd be happy to re-run the pwmconfig to reproduce this, if it would help.
>
No, it won't. I'll dig out other commands for you to run to give me some chip
register output.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
