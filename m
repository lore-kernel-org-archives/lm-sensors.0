From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 10 May 2015 21:44:54 +0000
Subject: Re: [lm-sensors] Additional PWM driver support for w83792d
Message-Id: <554FD156.3050507@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
In-Reply-To: <003901d08a57$bc46f8a0$34d4e9e0$@hiddenengine.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 05/10/2015 10:48 AM, vt8231@hiddenengine.co.uk wrote:
>>
>> Roger,
>>
>> Jean specifically suggested adding support for 'registers 0xA3-0xA6 have extra
>> configuration bits "Sync T1/2/3"'. I suggested to support those through pwmX_enable,
>> nothing else. You are right, you don't want to change the configuration bits
>> you referred to. But that is not what I suggested.
>>
>> Thanks,
>> Guenter
>
> I apologise - I completely misread your post and hadn't realised what you and Jean
> were referring to.
>
> Is the following list of changes that was meant:
>
> 1) Only make the pwm[4-7] and pwm[4-7]_enable files present if the corresponding
>     enable flags are set in registers 0x1A and 0x4B.  There would be individual
>     checks for pwm4 + pwm4_enable, pwm5 + pwm5_enable, pwm6 + pwm6_enable and pwm7
>     + pwm7_enable.
>
Correct, plus pwm[4-7]_mode, though the code to do this check is already there.
All you need to do is to add the new attributes to w83792d_attributes_fan[].

> 2) Add new pwm_enable modes "Sync T1" (=4), "Sync T2" (=5) and "Sync T3" (=6) for
>     PWM 4-7.  I propose the new values so that they don't collide with the existing
>     pwm_enable modes for pwm[1-3].  These would not be supported for pwm[1-3] and
>     likewise the existing pwm_enable modes would not be supported for pwm[4-7]
>     (apart from the manual mode).
>
Correct. Not sure what the new values should be (4-6 or 1-3). 4-6 may be better.
Jean, what do you think ?

> 3) Refuse to allow "Sync T1" to be set unless PWM1 is in thermal cruise mode (=3)
>     and instead set "stand alone/manual mode" (=1)
>
> 4) Refuse to allow "Sync T2" to be set unless PWM2 is in thermal cruise mode (=3)
>     and instead set "stand alone/manual mode" (=1)
>
> 5) Refuse to allow "Sync T3" to be set unless PWM3 is in thermal cruise mode (=3)
>     and instead set "stand alone/manual mode" (=1)
>

Problem is that pwm[1-3]_enable can be changed _after_ pwm[4-7]_enable was
configured. I would tend to let the user just set pwm[4-7]_enable, and add
a note to the documentation describing what happens if the mantching pwmX_enable
is not set to thermal cruse mode.

Jean, any suggestion ?

Thanks,
Guenter

> 6) Clean up comments as per Jean's mail
>
> If so, I think I know what to do and should be able to make the changes and have
> a new patch available this week.  Can you point me to the correct reference code
> for the w83792d driver so that my patch applies cleanly?  My guess would be the
> V4.1-rc2 release on kernel.org?
>
> I'll be testing on Ubuntu 15.04 (which is kernel 3.19.0) but hopefully the delta
> is minimal for this driver between 3.19.0 and 4.1?
>
> Best regards,
>
> Roger
>
>
>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
