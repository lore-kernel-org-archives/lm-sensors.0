From: mathog@mendel.bio.caltech.edu (David Mathog)
Date: Thu, 19 May 2005 06:23:39 +0000
Subject: Fw: Re: Mondo: problem with as99127f-i2c-2d
Message-Id: <E17oqJG-00031L-00@mendel.bio.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

After my signature is Kelledin's response to a problem report
about mondo.  From what he says it may actually be some
sort of problem with I2C/lm_sensors instead.  Have you folks
seen this before?  This particular type of glitch seems to happen
only once very few hours - but since it shuts down the system
when it occurs, that's way too often.  Right now running a very
long logging session to see if I can catch one again.

Thanks,

David Mathog
mathog@caltech.edu
Manager, Sequence Analysis Facility, Biology Division, Caltech

------------- Forwarded message follows -------------

On Tuesday 10 September 2002 11:15 am, you wrote:
>
> I've discovered another bug, this one really problematic.  I
> set up my mondo.conf file and then after a while the system
> shut down claiming the CPU had overheated.  But I was sitting
> right there and got straight into the BIOS hardware monitor
> and it showed the temp was ok. So I changed the mondo.conf to
> just emit warnings instead of shutting down.  After an hour or
> so it claimed the fan was running too slow, but again, I was
> sitting right there, and within seconds had run sensors, which
> showed the fan speed to be ok.
>
>
> Then I looked at /var/log/messages, and it said that the temp
> when it had overheaded had been 255.40 and the fan speed
> had been 0.0.   That's obviously nonsense.  I think maybe
> what's happening here is that mondo is reading the proc files
> just as they're being updated, and so reads an invalid value.
> Is there any file locking employed?  Have you seen this
> before?

Yikes!  Now that's something I've never seen before...

As for file locking, mondo never accesses the files in /proc 
directly.  It simply calls the lm_sensors library routines, and 
these routines should take care of any syscalls, file locking, 
etc. in whatever manner they think best.

Here's an idea: run mondo-setup with the -l option, so mondo 
performs logging even if sensor states don't reach an alarm 
condition.  Let mondo run for some ten minutes, then "grep mondo 
/var/log/messages > mondo.log".  Then send the resulting 
"mondo.log" file to me, so I can see what exactly happens (the 
contents might be useful to you too).  It would also be a good 
idea to send me the mondo.conf file that mondo-setup spits out 
(before editing it manually to adjust limits).

Another idea: if possible, switch the system to using the ISA 
bus, rather than the i2c bus, for reading sensors.  ISA is 
supposed to be a bit faster, and it's possible that this board 
produces more reliable readings this way.

Yet another idea: if possible, say "screw it" to the ASUS monitor 
chip and try using the via686a driver instead.  The stuff I'm 
reading in the default sensors.conf file suggests that the 
as99127f driver might not be all that trustworthy (due to Asus 
not releasing specs like a good Linux-friendly company should).

Even if using the via686a driver solves your problem, it's 
probably a good idea to generate the mondo.log file (see above) 
so we'll have something to show the lm_sensors developers.  This 
may be a bug in lm_sensors, or just a bug in the Asus as99127f 
chip itself.  In either case, the lm_sensors team should know 
about it.

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"


