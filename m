From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 10 May 2015 16:01:25 +0000
Subject: Re: [lm-sensors] Additional PWM driver support for w83792d
Message-Id: <554F80D5.60005@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
In-Reply-To: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/10/2015 06:42 AM, vt8231@hiddenengine.co.uk wrote:
[ ... ]
>>>
>>> Last note: registers 0xA3-0xA6 have extra configuration bits "Sync
>>> T1/2/3". Maybe the driver should handle them but I am not sure how. It
>>> could be that the extra outputs should only be exposed to user-space if
>>> these bits are 0 (stand alone.) Guenter, any idea/opinion on this?
>>>
>>
>> Hi Jean,
>>
>> Good point.
>>
>> How about using pwm[4567]_enable ? If I understand correctly, the possible
>> modes would be manual or sync(x). In this case we could have 1 (manual),
>> 2 (sync with fan1), 3 (sync with fan2), and 4 (sync with fan3), with the
>> caveat that the sync settings only make sense if the matching pwmX_enable
>> is set to thermal cruise mode.
>>
>> Does this make sense ?
>
> I don't think you have that level of control over PWM 4-7.  From what I can see
> in the datasheet (section 8.21 of the W83792G manual), you only have Thermal and
> Smart FAN modes for PWM 1 - 3.  This is why the existing driver does a limit
> check when setting the mode so that it only allows PWM[1-3] to be controlled.
>
> If I am reading the datasheet correctly, you have a simple enable/disable for PWM7
> (aka FAN7 Enable) and PWM6 (aka FAN6) in register 0x4B (Bank 0) "Pin Control
> Register", see section 8.13.  Likewise, you have a simple enable/disable for
> PWM5 (aka FAN_OUT5) and PWM4 (aka FAN_OUT4) via bits 6 and 5 of register 0x1A
> (CR1A_GPIO Enable).  FAN_OUT4 shares with GPIOA0 and FAN_OUT5 shares with GPIOA2.
>
> I would be nervous of changing these in Linux, however.  These relate to the HW
> configuration of the board so I would expect the BIOS to set these up correctly
> to ensure that the HW monitoring was correct from power-on.  My preference would
> be to *read* these values and only offer the /hwmonX/device/pwm[4-7] virtual
> files if the registers had *already* been set to enable this mode.  I don't like
> the idea that you could accidentally turn a GPIO input into a PWM output if you
> misconfigured the pwm[4-7]_enable signals (which you could do when probing, for
> example).
>
> My preference is *not* to provide pwm[4-7]_enable controls but just check the
> existing chip config and make pwm[4-7] and pwm[4-7]_mode available if (and only
> if) the chip has already been configured to enable them.
>

Roger,

Jean specifically suggested adding support for 'registers 0xA3-0xA6 have extra
configuration bits "Sync T1/2/3"'. I suggested to support those through pwmX_enable,
nothing else. You are right, you don't want to change the configuration bits
you referred to. But that is not what I suggested.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
