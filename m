From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 03 Jul 2009 17:25:13 +0000
Subject: Re: [lm-sensors] no PWM output with pwmconfig
Message-Id: <4A4E3EF9.8070909@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A4B9B3C.1040104@chello.nl>
In-Reply-To: <4A4B9B3C.1040104@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On 07/03/2009 07:05 PM, Niels wrote:
> Jean Delvare wrote:
>> On Fri, 03 Jul 2009 18:24:38 +0200, Niels wrote:
>>> Jean Delvare wrote:
>>>>> There are no usable PWM outputs.
>>>> Hmm, you are root, aren't you?
>>> nelis@nelis-desktop:/$ sudo pwmconfig
>>> # pwmconfig revision 5630 (2009-01-29)
>>> This program will search your sensors for pulse width modulation (pwm)
>>> controls, and test each one to see if it controls a fan on
>>> your motherboard. Note that many motherboards do not have pwm
>>> circuitry installed, even if your sensor chip supports pwm.
>>>
>>> We will attempt to briefly stop each fan using the pwm controls.
>>> The program will attempt to restore each fan to full speed
>>> after testing. However, it is ** very important ** that you
>>> physically verify that the fans have been to full speed
>>> after the program has completed.
>>>
>>> Found the following devices:
>>> hwmon0 is acpitz
>>> hwmon1/device is k8temp
>>> hwmon2/device is f71862fg
>>>
>>> Found the following PWM controls:
>>> hwmon2/device/pwm1
>>> hwmon2/device/pwm1 is currently setup for automatic speed control.
>>> In general, automatic mode is preferred over manual mode, as
>>> it is more efficient and it reacts faster. Are you sure that
>>> you want to setup this output for manual control? (n)
>>> hwmon2/device/pwm2
>>> hwmon2/device/pwm2 is currently setup for automatic speed control.
>>> In general, automatic mode is preferred over manual mode, as
>>> it is more efficient and it reacts faster. Are you sure that
>>> you want to setup this output for manual control? (n)
>>> hwmon2/device/pwm3
>>> hwmon2/device/pwm3 is currently setup for automatic speed control.
>>> In general, automatic mode is preferred over manual mode, as
>>> it is more efficient and it reacts faster. Are you sure that
>>> you want to setup this output for manual control? (n)
>>> There are no usable PWM outputs.
>>
>> OK, I'll change pwmconfig to complain if run as non-root.
>>
>>>> (...)
>>>> Note that all 3 fan controllers are in automatic mode (pwm#_enable >
>>>> 1), which is less CPU-intensive than manual mode and usually gives
>>>> better results. So you might now want to use pwmconfig and fancontrol
>>>> anyway, but rather tweak the automatic mode settings by writing to the
>>>> pwm#_auto_point# files above.
>>>>
>>>> I admit the current configuration is a little odd. Usually point2 has
>>>> pwm and temperature values above point1, not below. I am not familiar
>>>> with the Fintek F71862FG and its driver though. Hans?
>>> I am unable to write to the files.
>>>
>>> nelis@nelis-desktop:/sys/class/hwmon/hwmon2/device$ sudo echo "0" >
>>> pwm1_enable
>>> -bash: pwm1_enable: Permission denied
>>
>> Never mix sudo and shell redirection, it doesn't work. Redirection
>> "happens first" so you try to write as non-root, and this isn't allowed.
>>
>>> So i guess temp3 is cpu temp and temp1 is motherboard temp.
>>
>> Or the other way around, it's hard to tell. Maybe looking at what the
>> BIOS displays will provide valuable hints. I certainly hope temp2 isn't
>> real...
>>
>>> But can't change that either.
>>>
>>> nelis@nelis-desktop:/sys/class/hwmon/hwmon2/device$ sudo echo "3" >
>>> pwm1_auto_channels_temp
>>> -bash: pwm1_auto_channels_temp: Permission denied
>>
>> Same problem as above. Use su instead of sudo. Or maybe sudo sh -c ...
>>
> root@nelis-desktop:/sys/class/hwmon/hwmon2/device# echo "0" > pwm1_enable
> bash: echo: write error: Invalid argument

Take a look at Documents/hwmon/f71882fg for which values are allowed,
with your chip only 1 (manual mode) and 2 (auto mode) are supported,
0 = pwm disabled (fans full speed) is not supported.

> root@nelis-desktop:/sys/class/hwmon/hwmon2/device# echo "3" >
> pwm1_auto_channels_temp
> bash: echo: write error: Invalid argument
>

The pwm#_auto_channels_temp attributes are a bitmap, you are now asking
for both temp1 and temp2 to influence pwm1, the chip cannot handle this,
you need to choose one.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
