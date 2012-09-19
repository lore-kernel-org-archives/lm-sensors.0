From: Matthew Monaco <matt@0x01b.net>
Date: Wed, 19 Sep 2012 17:17:07 +0000
Subject: Re: [lm-sensors] i8k: non-standard fan control
Message-Id: <5059FE13.1050202@0x01b.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50596069.9030904@0x01b.net>
In-Reply-To: <50596069.9030904@0x01b.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/19/2012 05:49 AM, Jean Delvare wrote:
> Hi Matthew,
> 
> On Wed, 19 Sep 2012 00:04:25 -0600, Matthew Monaco wrote:
>> I am interested in extending the i8k module's hwmon support. This module (among
>> other things) allows the status of Dell laptop fans to be controlled. The fan
>> speed is controlled via an integer from 0 (off) to 2 (fast).
> 
> You can change the desired speed of the fans, not their status.
> 
>> Is there any way to support these semantics through hwmon? I easily added a
>> fanN_status sysfs entry through hwmon that does the right thing. However the
>> _status doesn't follow all other naming conventions that I can find.
> 
> The standard fan speed control interface is through the pwm* sysfs
> attributes. However this interface wasn't designed for discrete speed
> values like the i8k driver offers, so while you can map the 3 discrete
> values to arbitrary PWM duty cycles (0%, 50% and 100%) it's somewhat
> confusing.
> 
> Still, I tried to add support for this over a year ago already:
> 
> Subject: [lm-sensors] [PATCH 2/2] Add hwmon-style fan speed control
> http://marc.info/?l=lm-sensors&m0270896704113&w=2
> 
> But I did not receive any feedback so it didn't go upstream. Note that
> my limited experience with Dell laptops suggests that at least some
> models don't behave like the driver claims, changing the fan speed
> setting in the user's back. That's another reason why the patch didn't
> go upstream. The problem also exists with the current driver but my
> patch would make it even more visible, as the pwm* interface is
> standardized.
> 
> Feel tree to play with my patch, but I'm not sure we really want to
> push it upstream.
> 

Yes, my hardware (Vostro 3400) will adjust my fan speed on it's own, but the
i8kmon daemon just sets it back in its next polling period. Is this a
deal-breaker for lm_sensors? The tcl-based i8kmon daemon uses way more resources
than I think is reasonable, it's typically in the top 2 or 3 processes on my
machine for CPU time; the mem usage also seems a little high.

I started writing something more efficient for my own use and noticed it was
quite a bit more efficient to read /proc/i8k and parse the temperature, for
example, than issue an ioctl. Let alone ioctls for all of the values. I wonder
if adding entries for each setting under /sys/modules/i8k would be accepted.

Your mapping make sense to me. Except I'm not sure why you have 128 as
I8K_FAN_LOW in the getter and 192 in the setter. (Also, write perms for
user(/group) would be nice for the attribute).

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
