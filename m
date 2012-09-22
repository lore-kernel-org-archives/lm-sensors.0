From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 22 Sep 2012 12:51:55 +0000
Subject: Re: [lm-sensors] i8k: non-standard fan control
Message-Id: <20120922145155.5761a30a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <50596069.9030904@0x01b.net>
In-Reply-To: <50596069.9030904@0x01b.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 19 Sep 2012 19:31:06 -0600, Matthew Monaco wrote:
> On 09/19/2012 12:50 PM, Jean Delvare wrote:
> > On Wed, 19 Sep 2012 11:17:07 -0600, Matthew Monaco wrote:
> >> Yes, my hardware (Vostro 3400) will adjust my fan speed on it's own, but the
> >> i8kmon daemon just sets it back in its next polling period. Is this a
> >> deal-breaker for lm_sensors?
> > 
> > Yeah, sort of. The pwm interface isn't supposed to depend on a daemon
> > to do the right thing. And repeatedly overwriting what the BIOS sets
> > seems just plain wrong to start with. If the fan speed control is in
> > automatic mode then it should be reported that way to user-space
> > (pwm1_enable = 2.) But I don't think there's a way to know this is the
> > case, even less to switch to manual mode?
> 
> Ah, I finally found the hwmon/sysfs-interface doc. I'm sorry that I missed it in
> there the first time. I think hardcoding pwm[1,2]_enable to 2 makes sense, but
> unfortunately fancontrol doesn't like that.

Of course it doesn't, fancontrol only makes sense with manual fan speed
control.

> Is there any chance at standardizing "3" as hybrid mode where fancontrol will
> know it may set pwm but should update it every polling period?

I don't want to standardize a mode which I don't think makes any sense
in the first place.

Plus, from fancontrol's perspective, it wouldn't make a difference, as
it is already updating the pwm setting every polling period.

> >> (Also, write perms for
> >> user(/group) would be nice for the attribute).
> > 
> > We never do that for any hwmon driver. Letting every user change the
> > hardware monitoring and/or fan speed control settings would be an
> > obvious safety weakness.
> 
> I didn't say OTH =)

Well if you mean root being able to write the value, then my patch does
exactly this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
