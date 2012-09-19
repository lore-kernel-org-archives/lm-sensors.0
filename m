From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 19 Sep 2012 18:50:19 +0000
Subject: Re: [lm-sensors] i8k: non-standard fan control
Message-Id: <20120919205019.7d3544f0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50596069.9030904@0x01b.net>
In-Reply-To: <50596069.9030904@0x01b.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 19 Sep 2012 11:17:07 -0600, Matthew Monaco wrote:
> On 09/19/2012 05:49 AM, Jean Delvare wrote:
> > The standard fan speed control interface is through the pwm* sysfs
> > attributes. However this interface wasn't designed for discrete speed
> > values like the i8k driver offers, so while you can map the 3 discrete
> > values to arbitrary PWM duty cycles (0%, 50% and 100%) it's somewhat
> > confusing.
> > 
> > Still, I tried to add support for this over a year ago already:
> > 
> > Subject: [lm-sensors] [PATCH 2/2] Add hwmon-style fan speed control
> > http://marc.info/?l=lm-sensors&m0270896704113&w=2
> > 
> > But I did not receive any feedback so it didn't go upstream. Note that
> > my limited experience with Dell laptops suggests that at least some
> > models don't behave like the driver claims, changing the fan speed
> > setting in the user's back. That's another reason why the patch didn't
> > go upstream. The problem also exists with the current driver but my
> > patch would make it even more visible, as the pwm* interface is
> > standardized.
> > 
> > Feel tree to play with my patch, but I'm not sure we really want to
> > push it upstream.
> 
> Yes, my hardware (Vostro 3400) will adjust my fan speed on it's own, but the
> i8kmon daemon just sets it back in its next polling period. Is this a
> deal-breaker for lm_sensors?

Yeah, sort of. The pwm interface isn't supposed to depend on a daemon
to do the right thing. And repeatedly overwriting what the BIOS sets
seems just plain wrong to start with. If the fan speed control is in
automatic mode then it should be reported that way to user-space
(pwm1_enable = 2.) But I don't think there's a way to know this is the
case, even less to switch to manual mode?

> The tcl-based i8kmon daemon uses way more resources
> than I think is reasonable, it's typically in the top 2 or 3 processes on my
> machine for CPU time; the mem usage also seems a little high.

Writing a system daemon in tcl doesn't strike me as the idea of the year ;)

> I started writing something more efficient for my own use and noticed it was
> quite a bit more efficient to read /proc/i8k and parse the temperature, for
> example, than issue an ioctl. Let alone ioctls for all of the values. I wonder
> if adding entries for each setting under /sys/modules/i8k would be accepted.

The /proc/i8k interface is definitely bad, and this is the reason why
I tried to add a proper hwmon interface to the driver. But we can only
do that for attributes which actually fit in the standard hwmon sysfs
interface.

> Your mapping make sense to me. Except I'm not sure why you have 128 as
> I8K_FAN_LOW in the getter and 192 in the setter.

192 is (128 + 255) / 2. The idea is to set the closest value available
based on what the user requested:

       0 =>   0 (fan stopped)
  1..192 => 128 (low fan speed)
193..255 => 255 (full speed)

This is somewhat arbitrary of course, but should follow the principle
of least surprise.

> (Also, write perms for
> user(/group) would be nice for the attribute).

We never do that for any hwmon driver. Letting every user change the
hardware monitoring and/or fan speed control settings would be an
obvious safety weakness.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
