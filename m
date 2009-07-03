From: Niels <n.wassenberg@chello.nl>
Date: Fri, 03 Jul 2009 16:24:38 +0000
Subject: Re: [lm-sensors] no PWM output with pwmconfig
Message-Id: <4A4E30C6.5040802@chello.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4B9B3C.1040104@chello.nl>
In-Reply-To: <4A4B9B3C.1040104@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Niels,
>
> On Fri, 03 Jul 2009 15:54:29 +0200, Niels wrote:
>   
>> Jean Delvare wrote:
>>     
>>> Which version of lm-sensors (or pwmconfig) is this?
>>>
>>> I would like to see the full output of pwmconfig and not just the above
>>> summary.
>>>       
>> nelis@nelis-desktop:~$ sensors -v
>> sensors version 3.1.1+SVN with libsensors version 3.1.1+SVN
>>
>>
>> nelis@nelis-desktop:~$ pwmconfig
>> # pwmconfig revision 5630 (2009-01-29)
>> This program will search your sensors for pulse width modulation (pwm)
>> controls, and test each one to see if it controls a fan on
>> your motherboard. Note that many motherboards do not have pwm
>> circuitry installed, even if your sensor chip supports pwm.
>>
>> We will attempt to briefly stop each fan using the pwm controls.
>> The program will attempt to restore each fan to full speed
>> after testing. However, it is ** very important ** that you
>> physically verify that the fans have been to full speed
>> after the program has completed.
>>
>> Found the following devices:
>>    hwmon0 is acpitz
>>    hwmon1/device is k8temp
>>    hwmon2/device is f71862fg
>>
>> Found the following PWM controls:
>>    hwmon2/device/pwm1
>>    hwmon2/device/pwm2
>>    hwmon2/device/pwm3
>> There are no usable PWM outputs.
>>     
>
> Hmm, you are root, aren't you?
>
>   
nelis@nelis-desktop:/$ sudo pwmconfig
# pwmconfig revision 5630 (2009-01-29)
This program will search your sensors for pulse width modulation (pwm)
controls, and test each one to see if it controls a fan on
your motherboard. Note that many motherboards do not have pwm
circuitry installed, even if your sensor chip supports pwm.

We will attempt to briefly stop each fan using the pwm controls.
The program will attempt to restore each fan to full speed
after testing. However, it is ** very important ** that you
physically verify that the fans have been to full speed
after the program has completed.

Found the following devices:
   hwmon0 is acpitz
   hwmon1/device is k8temp
   hwmon2/device is f71862fg

Found the following PWM controls:
   hwmon2/device/pwm1
hwmon2/device/pwm1 is currently setup for automatic speed control.
In general, automatic mode is preferred over manual mode, as
it is more efficient and it reacts faster. Are you sure that
you want to setup this output for manual control? (n)
   hwmon2/device/pwm2
hwmon2/device/pwm2 is currently setup for automatic speed control.
In general, automatic mode is preferred over manual mode, as
it is more efficient and it reacts faster. Are you sure that
you want to setup this output for manual control? (n)
   hwmon2/device/pwm3
hwmon2/device/pwm3 is currently setup for automatic speed control.
In general, automatic mode is preferred over manual mode, as
it is more efficient and it reacts faster. Are you sure that
you want to setup this output for manual control? (n)
There are no usable PWM outputs.


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
>>     
>
> Note that all 3 fan controllers are in automatic mode (pwm#_enable >
> 1), which is less CPU-intensive than manual mode and usually gives
> better results. So you might now want to use pwmconfig and fancontrol
> anyway, but rather tweak the automatic mode settings by writing to the
> pwm#_auto_point# files above.
>
> I admit the current configuration is a little odd. Usually point2 has
> pwm and temperature values above point1, not below. I am not familiar
> with the Fintek F71862FG and its driver though. Hans?
>
>   
I am unable to write to the files.

nelis@nelis-desktop:/sys/class/hwmon/hwmon2/device$ sudo echo "0" > 
pwm1_enable
-bash: pwm1_enable: Permission denied

So i guess temp3 is cpu temp and temp1 is motherboard temp.
But can't change that either.

nelis@nelis-desktop:/sys/class/hwmon/hwmon2/device$ sudo echo "3" > 
pwm1_auto_channels_temp
-bash: pwm1_auto_channels_temp: Permission denied








_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
