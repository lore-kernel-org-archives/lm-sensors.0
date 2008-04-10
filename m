From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Apr 2008 11:46:13 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <20080410134613.11b46b2d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 10 Apr 2008 05:00:22 +0800, Mini Stac wrote:
> Kernel version is 2.6.22-14
> 
> The 3.0.1 script gets further but comes up with the same result (full output
> below):
> hwmon0/device/pwm1_enable stuck to 2
> 
> I know that the fan speed can be controlled manually under Windows.
> Thanks if there is anything else to try.
> 
> 
> Found the following devices:
>    hwmon0/device is w83627dhg
> 
> Found the following PWM controls:
>    hwmon0/device/pwm1
> hwmon0/device/pwm1 is currently setup for automatic speed control.
> In general, automatic mode is preferred over manual mode, as
> it is more efficient and it reacts faster. Are you sure that
> you want to setup this output for manual control? (n) y
> 0
> 1
> hwmon0/device/pwm1_enable stuck to 2
> Manual control mode not supported, skipping hwmon0/device/pwm1.
>    hwmon0/device/pwm2
> hwmon0/device/pwm2 stuck to 0
> Manual control mode not supported, skipping hwmon0/device/pwm2.
>    hwmon0/device/pwm3
> hwmon0/device/pwm3 stuck to 0
> Manual control mode not supported, skipping hwmon0/device/pwm3.
>    hwmon0/device/pwm4
> hwmon0/device/pwm4 stuck to 0
> Manual control mode not supported, skipping hwmon0/device/pwm4.
> There are no usable PWM outputs.

Just to make sure: you're running pwmconfig as root, aren't you? Only
root can change the chip's settings.

Can you try setting the PWM output to manual mode manually?

echo 1 > /sys/class/hwmon/hwmon0/device/pwm1_enable
cat /sys/class/hwmon/hwmon0/device/pwm1_enable
echo 1 > /sys/class/hwmon/hwmon0/device/pwm2_enable
cat /sys/class/hwmon/hwmon0/device/pwm2_enable

If it works then the problem is in the pwmconfig script (or bash). If
it doesn't then the problem would be in the w83627ehf driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
