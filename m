From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 May 2008 18:44:15 +0000
Subject: Re: [lm-sensors] [PATCH 03/10] hwmon: (lm85) Drop dead code
Message-Id: <20080501204415.08a1fb15@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412195552.421b4a28@hyperion.delvare>
In-Reply-To: <20080412195552.421b4a28@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg, hi Philip,

On Thu, 1 May 2008 11:16:03 -0700, Juerg Haefliger wrote:
> > Jean Delvare wrote:
> > > Drop a lot of useless register defines, conversion macros, data structure
> > > members and update code. All these register values were read from the
> > > device but nothing is done out of them, so this is all dead code in
> > > practice.
> >
> >  The code to use all of those registers was posted in 2004:
> >
> >  http://lists.lm-sensors.org/pipermail/lm-sensors/2004-August/008563.html
> >
> >  But was apparently not picked up because there was an objection to the size
> > of the patch?
> >
> >  The patch was streamlined to try and match the "standard" for PWM control
> > (which doesn't map to the LM85 registers very well) and reposted:
> >
> >  http://lists.lm-sensors.org/pipermail/lm-sensors/2004-September/009059.html
> >
> >  but without the additional functionality unfortunately.
> >
> >  Wouldn't the better course of action be to add the accessors for these
> > tuneables rather than remove the functionality from the driver? Of course,
> > that means that I probably need to do the work, but I don't have the time to
> > do this right now.
> >
> >  So could I ask that we *not* remove this "dead" code, but leave it in for
> > now so that when someone does get around to adding the accessor functions,
> > they won't have to submit a patch to reverse this "dead" code elimination?
> 
> The code Jean wants to remove hasn't been used for a very long time
> and who is to guarantee that it doesn't take another couple years
> until it is finally put to use? In the meantime the driver is bloated
> and slowed down due to accessing unused registers. It's not too hard
> to add that stuff back. I don't like the term 'until someone gets
> around to adding the functions'. That sound like 'never' to me or
> certainly not in the near future so I vote for ripping it out.

+1

Nobody cared about these "extra features" for 3.5 years, I have no
reason to believe that anyone will care in the next few months or
years, if ever. This visible lack of interest is the reason why I
decided to just get rid of the dead code (together with my limited time
to work on the driver, and the lack of test hardware.)

Note that I totally expected that someone would complain about me
removing this code. It's always the same story, dead or broken code can
stay in the kernel and burden the maintainers and users forever, nobody
cares, but as soon as someone proposes to clean things up, everybody
complains that it's "unfortunate".

Anyway, as Juerg wrote, it's trivial to add the code back if/when you
find the time to work on this, with the added bonus that you get more
freedom in what exactly you want to implement and how.

As an additional note, I am not convinced that we actually want to add
all these fancy features to the driver. The first reason is that they
don't look terribly useful to me. The second is that the lm85 driver is
supposed to implement support for a relatively generic type of device.
All the fancy features are model specific, so if you add them all you
end up with a very large driver, which eats memory and is hard to
maintain. If you really want to implement all these extra features then
I think that what you want is a dedicated driver (as Juerg did for the
DME1737 for example.)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
