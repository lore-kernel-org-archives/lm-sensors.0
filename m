From: Matthew Monaco <matt@0x01b.net>
Date: Thu, 20 Sep 2012 01:31:06 +0000
Subject: Re: [lm-sensors] i8k: non-standard fan control
Message-Id: <505A71DA.6070201@0x01b.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50596069.9030904@0x01b.net>
In-Reply-To: <50596069.9030904@0x01b.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/19/2012 12:50 PM, Jean Delvare wrote:
> On Wed, 19 Sep 2012 11:17:07 -0600, Matthew Monaco wrote:
>> On 09/19/2012 05:49 AM, Jean Delvare wrote:
>>> The standard fan speed control interface is through the pwm* sysfs
>>> attributes. However this interface wasn't designed for discrete speed
>>> values like the i8k driver offers, so while you can map the 3 discrete
>>> values to arbitrary PWM duty cycles (0%, 50% and 100%) it's somewhat
>>> confusing.
>>>
>>> Still, I tried to add support for this over a year ago already:
>>>
>>> Subject: [lm-sensors] [PATCH 2/2] Add hwmon-style fan speed control
>>> http://marc.info/?l=lm-sensors&m0270896704113&w=2
>>>
>>> But I did not receive any feedback so it didn't go upstream. Note that
>>> my limited experience with Dell laptops suggests that at least some
>>> models don't behave like the driver claims, changing the fan speed
>>> setting in the user's back. That's another reason why the patch didn't
>>> go upstream. The problem also exists with the current driver but my
>>> patch would make it even more visible, as the pwm* interface is
>>> standardized.
>>>
>>> Feel tree to play with my patch, but I'm not sure we really want to
>>> push it upstream.
>>
>> Yes, my hardware (Vostro 3400) will adjust my fan speed on it's own, but the
>> i8kmon daemon just sets it back in its next polling period. Is this a
>> deal-breaker for lm_sensors?
> 
> Yeah, sort of. The pwm interface isn't supposed to depend on a daemon
> to do the right thing. And repeatedly overwriting what the BIOS sets
> seems just plain wrong to start with. If the fan speed control is in
> automatic mode then it should be reported that way to user-space
> (pwm1_enable = 2.) But I don't think there's a way to know this is the
> case, even less to switch to manual mode?
> 

Ah, I finally found the hwmon/sysfs-interface doc. I'm sorry that I missed it in
there the first time. I think hardcoding pwm[1,2]_enable to 2 makes sense, but
unfortunately fancontrol doesn't like that.

Is there any chance at standardizing "3" as hybrid mode where fancontrol will
know it may set pwm but should update it every polling period?

>> (Also, write perms for
>> user(/group) would be nice for the attribute).
> 
> We never do that for any hwmon driver. Letting every user change the
> hardware monitoring and/or fan speed control settings would be an
> obvious safety weakness.
> 

I didn't say OTH =)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
