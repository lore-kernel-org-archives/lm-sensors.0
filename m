From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Sep 2006 16:23:02 +0000
Subject: [lm-sensors] issue with clearing alarms
Message-Id: <20060927182302.ccfd1d55.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450312F6.4030500@gmail.com>
In-Reply-To: <450312F6.4030500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> > > --- linux-2.6.18-rc6-mm2-sk/Documentation/hwmon/sysfs-interface	2006-09-07 16:09:40.000000000 -0600
> > > +++ doc-touches/Documentation/hwmon/sysfs-interface	2006-09-26 14:04:19.000000000 -0600
> > > @@ -23,6 +23,7 @@ voltages between 0 and +4V. Other voltag
> > >  range using external resistors. Since the values of these resistors
> > >  can change from motherboard to motherboard, the conversions cannot be
> > >  hard coded into the driver and have to be done in user space.
> > > +Therefore, all sysfs values are fixed point numbers.
> >
> > I see no cause-to-consequence relation here, so why the "therefore"?
> > What problem are you trying to address by moving this sentence around?
>
> sure, its a little white lie.  I wondered if it would draw comment.
> Its easier than explaining why the kernel doesnt allow FP.

It's easier, and irrelevant. We just don't need floating point here.

> Let me turn it around.  Why do you bother to say it at all ?

Because it's true, and relevant. This is an important design decision,
and also a difference compared to the Linux 2.4 interface. Well, 2.4
used fixed point as well, but exported the values to procfs as real
numbers, as opposed to integers as we do now.

> Motivated readers would just try it, then either google to find out
> why its disallowed (I have), or <gasp> ask on some ML.
> Besides, the whole paragraph is sufficient reason, to move the sentence,
> even if FP were allowed.

I don't follow you here. You seem to agree that there is no real
relation between the paragraph above, and the fixed point sentence, yet
you still want to move the two next to each other?

> > >  For this reason, even if we aim at a chip-independent libsensors, it will
> > >  still require a configuration file (e.g. /etc/sensors.conf) for proper
> > > @@ -35,8 +36,9 @@ access this data in a simple and consist
> > >  will have to implement conversion, labeling and hiding of inputs. For
> > >  this reason, it is still not recommended to bypass the library.
> > >  
> > > -If you are developing a userspace application please send us feedback on
> > > -this standard.
> > > +If you are developing a userspace application please send us feedback
> > > +on this standard.  Note that applications are expected to read all the
> > > +sysfs files at once, you may miss transient alarms otherwise.
> >
> > Or you could leave the "on" where it was, so that the diff doesn't look
> > bigger than it really is?
>
> emacs autowrap.  But thats not really the issue is it ?

It is. If your text editor reformats the lines as it sees fit, you
can't really work with me. But I guess you can actually reconfigure it
not to misbehave that way.

> > You are putting the things in the wrong order, I think. The
> > applications are not expected to read all the sysfs values at once, it
> > just happens to be what they all do at the moment. And nothing really
> > wrong will happen if they don't. The different behavior of transient
> > alarms is a minor annoyance, because, as I explained earlier, nobody
> > really cares about transient alarms. In fact, people may even be
> > _happy_ to miss them. So why frighten them with something we don't
> > expect to bother them at all?
>
> ignorance != apathy

Certainly, and your point is?

> And if we dont care about alarms, why bother to split them out, 1 per 
> sensor ?

My point is essentially that transient alarms don't matter. Alarms by
themselves, are somewhat more important. Their redundancy helps us
debug the drivers, and we can also use them to quickly understand
configuration issues on user systems, for example negative voltages
with their limits swapped, or the reason why the system is beeping,
etc.

More importantly, we have been providing this data to the applications
for 8 years now, so just dropping it is likely to cause some complaints
if anyone is really interested in them. I would be happy myself without
the alarm bits, and this would get around a lot of work in the next
months as well, so don't tempt me please ;)

-- 
Jean Delvare

