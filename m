From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 03 Apr 2014 15:46:28 +0000
Subject: Re: [lm-sensors] [PATCH] fancontrol aborts after suspend/resume
Message-Id: <20140403174628.147c7c2d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201404021253.49647.l.lunak@centrum.cz>
In-Reply-To: <201404021253.49647.l.lunak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 3 Apr 2014 16:31:15 +0200, Lubos Lunak wrote:
> On Thursday 03 of April 2014, Jean Delvare wrote:
> > That being said I have to admit that your approach, although not clean,
> > has the merit to work around the problem regardless of the BIOS or
> > hwmon chip in use. This is certainly attractive. My only worry is that
> > it _assumes_ that problem comes from an improperly handled
> > suspend/resume cycle, which may or may not be the case.

On second thought: your proposed patch wouldn't work on all chips
anyway. A number of hwmon drivers accept pre-programming the manual fan
speed control value before actually switching to manual mode. In that
case, you won't get a write failure so you won't be able to detect the
problem.

>  It doesn't assume, it handles the possibility. But it doesn't matter. If the 
> write fails because of something else, it will presumably fail the second 
> time as well.

Not necessarily. Setting manual fan control mode might be sufficient
for the second write to succeed, because they happen in a short sequence.

>  I can't see how this could realistically break any reasonable scenario. 
> Fancontrol has already set up pwm control that way during start, why 
> shouldn't it be allowed to do it again?

Because it shouldn't have to, so if it has to, that means something is
wrong, and the user should know about it.

> > It might as 
> > well be the BIOS/ACPI changing the settings at run-time,
> 
>  In that case fancontrol would abort at any time this happens.

Yes it would, before your change. After your change, no longer. This is
the problem I am underlining.

> Besides, that's 
> rather against the idea of pwm being set to manual control, isn't it?

Again, that's what I am trying to explain. If the user's view of how
the fan should be controlled differs from the BIOS/ACPI's view, it
should be reported, not ignored.

> > or another fan monitoring application running in parallel,
> 
>  s/monitoring/controlling/ Well, that's certainly an interesting scenario that 
> I expect is broken enough for nobody to be bothered enough to handle it.

Yes, I meant fan controlling application, sorry. Yes, that would be a broken
scenario, which again needs to be reported to the user. A plain error
message is better than letting fancontrol run and misbehave in ways the
user can't explain.

> > or a driver bug. In which 
> > case failing with an error is the right thing to do.
> 
>  No. If the driver has a glitch that makes the write fail from time to time, 
> it's still better if fancontrol copes with that. That is, again, if this 
> scenario is actually worth thinking about.

I was thinking of a bug where changing another setting would
accidentally overwrite the fan control mode registers. We've seen this
before.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
