From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 03 Jul 2009 14:35:57 +0000
Subject: Re: [lm-sensors] no PWM output with pwmconfig
Message-Id: <4A4E174D.4000800@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4B9B3C.1040104@chello.nl>
In-Reply-To: <4A4B9B3C.1040104@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 07/03/2009 04:27 PM, Jean Delvare wrote:
> Hi Niels,
>

<snip>

>> nelis@nelis-desktop:~$ grep -H . /sys/class/hwmon/hwmon*/device/pwm*
>> /sys/class/hwmon/hwmon2/device/pwm1:81
>> /sys/class/hwmon/hwmon2/device/pwm1_auto_channels_temp:1
>> /sys/class/hwmon/hwmon2/device/pwm1_auto_point1_pwm:90
>> /sys/class/hwmon/hwmon2/device/pwm1_auto_point1_temp:60000
>> /sys/class/hwmon/hwmon2/device/pwm1_auto_point1_temp_hyst:56000
>> /sys/class/hwmon/hwmon2/device/pwm1_auto_point2_pwm:80
>> /sys/class/hwmon/hwmon2/device/pwm1_auto_point2_temp:35000
>> /sys/class/hwmon/hwmon2/device/pwm1_auto_point2_temp_hyst:31000
>> /sys/class/hwmon/hwmon2/device/pwm1_enable:2
>> /sys/class/hwmon/hwmon2/device/pwm1_interpolate:1
>> /sys/class/hwmon/hwmon2/device/pwm2:255
>> /sys/class/hwmon/hwmon2/device/pwm2_auto_channels_temp:2
>> /sys/class/hwmon/hwmon2/device/pwm2_auto_point1_pwm:217
>> /sys/class/hwmon/hwmon2/device/pwm2_auto_point1_temp:60000
>> /sys/class/hwmon/hwmon2/device/pwm2_auto_point1_temp_hyst:56000
>> /sys/class/hwmon/hwmon2/device/pwm2_auto_point2_pwm:128
>> /sys/class/hwmon/hwmon2/device/pwm2_auto_point2_temp:30000
>> /sys/class/hwmon/hwmon2/device/pwm2_auto_point2_temp_hyst:26000
>> /sys/class/hwmon/hwmon2/device/pwm2_enable:2
>> /sys/class/hwmon/hwmon2/device/pwm2_interpolate:1
>> /sys/class/hwmon/hwmon2/device/pwm3:155
>> /sys/class/hwmon/hwmon2/device/pwm3_auto_channels_temp:4
>> /sys/class/hwmon/hwmon2/device/pwm3_auto_point1_pwm:217
>> /sys/class/hwmon/hwmon2/device/pwm3_auto_point1_temp:60000
>> /sys/class/hwmon/hwmon2/device/pwm3_auto_point1_temp_hyst:58000
>> /sys/class/hwmon/hwmon2/device/pwm3_auto_point2_pwm:128
>> /sys/class/hwmon/hwmon2/device/pwm3_auto_point2_temp:30000
>> /sys/class/hwmon/hwmon2/device/pwm3_auto_point2_temp_hyst:28000
>> /sys/class/hwmon/hwmon2/device/pwm3_enable:2
>> /sys/class/hwmon/hwmon2/device/pwm3_interpolate:1
>
> Note that all 3 fan controllers are in automatic mode (pwm#_enable>
> 1), which is less CPU-intensive than manual mode and usually gives
> better results. So you might now want to use pwmconfig and fancontrol
> anyway, but rather tweak the automatic mode settings by writing to the
> pwm#_auto_point# files above.
>
> I admit the current configuration is a little odd. Usually point2 has
> pwm and temperature values above point1, not below. I am not familiar
> with the Fintek F71862FG and its driver though. Hans?
>

Yes, erm well the F718xx family has them in reverse order in hardware and
I kept the hardware order for sysfs files. A bit strange I must admit.

In hindsight it might have been better to reverse the order in sysfs
for consistency with other drivers.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
