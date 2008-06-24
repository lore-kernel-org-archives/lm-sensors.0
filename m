From: Frank Myhr <fmyhr@fhmtech.com>
Date: Tue, 24 Jun 2008 12:39:10 +0000
Subject: Re: [lm-sensors] sysfs-interface: pwm [0-100] rather than [0-255] ?
Message-Id: <4860EAEE.6050900@fhmtech.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <486064B5.5070704@fhmtech.com>
In-Reply-To: <486064B5.5070704@fhmtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Thank you for your quick and detailed response.

Jean Delvare wrote:
> Hi Frank,
> 
> First of all: when you start a new discussion topic, please also start
> a new thread on the mailing list, rather than replying to an old post
> and changing the subject line. The way you did, threading looks
> horrible. See by yourself:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2008-June/thread.html#23382

Gack! <face color="#ff0000">It seems I'm still learning about my mailer.</face>
Sorry about that. (Not corrected with this post, since damage is already done.)


>> Points in favor of using range [0, 100] "% duty cycle" for pwm[1-*]:
>>
>> 1) Consistency: other hwmon sysfs attributes that correspond to
>> physical quantities (temp[1-*], fan[1-*], etc.) are in physical units.
> 
> A duty cycle expressed in % is not a physical unit.

You're correct that % is dimensionless. However, % means 1/100,
I don't know of a symbol that means 1/255. But I'll concede that this point
is at least partially redundant with point (3) below.


>> 2) Freedom from chip implementation: 0-100% duty cycle remains
>> the same regardless of whether specific chip uses 6,7,8 or whatever
>> bits to represent it.
> 
> Same is true of the 0-255 range we use at the moment.

True.


>> 3) Meaningful value: natural for user to think in terms of 0-100% duty
>> cycle, rather than "255 means 100%... 60% would be... (pulls out calculator)"
> 
> True.


>> a) Is there any possibility of changing pwm[1-*] to use range [0, 100] ?*
> 
> No there isn't. This would break compatibility when the users upgrade,
> and several applications would have to be updated (pwmconfig and
> fancontrol to start with.)

OK.


>> b) If backward compatibility with [0, 255] range must be preserved,
>> would it be acceptable to make available an additional redundant
>> attribute, named something like pwm[1-*]_duty that would have range [0, 100] ?*
>> *Note that the following attributes would also be affected:
>> pwm[1-*]_auto_point[1-*]_pwm
>> temp[1-*]_auto_point[1-*]_pwm
> 
> I see very little benefit in doing this. In fact the only benefit is
> your point 3 above. Drawbacks are many:

> bigger drivers, higher memory usage,

A couple of extra functions... is this significant?


possible confusion between both interfaces.

Yes.


>> c) Is your [dog / cat / fish / fill in the blank] less naive than I am? :-)
> 
> Well, my baby daughter didn't propose this change ;-)

Your baby daughter already thinks in binary. Congratulations :-)


> The 0-255 range for pwm values has its share of benefits. It is the
> natural range for many chips, so it saves conversions back and forth.

lm_sensors does conversions for other attributes like rpm, pwm frequency.


> Other chips almost always have a 0-2^n range which can easily be mapped
> to 0-255 with no resolution loss.
> 
> The 0-100 range, on the other hand, required conversions. Given that
> only integer values can be used in sysfs, this would decrease the
> resolution. This would be a real problem. It is frequent that only the
> smallest pwm values are usable to control a fan, so if you can't use
> all the available values, the granularity can become too important for
> smooth fan speed control to be possible.

I didn't imagine that greater than 1% precision in pwm setting would
ever be necessary. Of course the range could just as easily be [0-1000]
or some other decimal range, as is done for voltage and temperature.


> If you think that converting from 0-255 to 0-100% is too difficult for
> the users, this is something for applications to address. pwmconfig and
> fancontrol could be adjusted to understand duty cycles expressed in
> percent for example. It shouldn't be too difficult. It could bring in
> some confusion though, for people used to the 0-255 range.


> The sysfs interface itself will not change, pwm value range is 0-255.

OK.


I suppose this discussion can be summarized by stating that I prefer
to express pwm in decimal units, whereas you prefer binary. We each have
some valid reasons (well, I have ONE at least!) for our preferences. If it
were a new interface, I might try to continue to argue for my preference.
But since it's already established (by you!) I'll adjust my thinking, as
hard as that may be ;-)

Thanks again,
Frank

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
