From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: ASUS ASB1009(Bach)--Bravo!! Bravo!!
Message-Id: <1040523782.10137.30.camel@linux.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I hate replying to myself, BUT

I got the latest snapshot.  ASB100 loaded on insmod w83781d without a
force_as99127f.  The readings are really good, including fan2--first
time ever.

Thank You.  I do not know who changed what, but good job.

Being the picky type, I need to tweak the temp calculations, but they
are very close, except temp3 which is the memory chip.  It stays static
at 45.1 F, so I know it is wrong.  When I make progress, I will post.

Thanks again to the authors.



On Thu, 2002-12-19 at 00:09, Ed Harrison wrote:
> On Wed, 2002-12-18 at 23:20, Mark M. Hoffman wrote: 
> > * Ed Harrison <ed.tman@verizon.net> [2002-12-18 19:45:01 -0500]:
> > > I have an ASUS A7V333 which definitely has the ASB100 chip (on $2d:
> > > $581, $4f), not to be confused with as99127f or the w83781d,
> > > although some functionalities are the same.  Your NEW AND REQUESTED CHIP
> > > DRIVERS - STATUS states that the asb100(bach) is recognized as an
> > > as99127f.  The as99127f and the asb100(bach) have different ID's and
> > > behave differently because using w83781d force_as99127f is not working 
> > 
> > Yes, we recognize the ASB100 (with different ID) but treat it like
> > a as99127f.  This is working since 2.6.5; what version are you using?
> 
> Latest CVS 2.7.0.  I tried a hack from the archives at line 1282 of 2067
> to change a long string beginning if (init & .......... to just
> if(init).  Either way doesn't make a difference.  Now runnig with driver
> from original w83781d.c.  Before 2.7.0 this would not have been true. 
> The hack was necessary for the driver with force option to even load. 
> Without force it loaded with really crazy numbers, several readings
> remained at O.
> 
> I just left all the drivers loaded and ran mbmon and xmbmon=craziness;
> HOWEVER, I ran gkrellm and all of a sudden the numbers look great. 
> gkrellm has no corrections nor offsets in the configuration, although
> they are recommended in the archives for temp calcs.  I had not taken
> the time to set them until sensors -f was happy.  It still is not.
> 
> vcore 1 is within range but shows (ALARM)
> +12V temp3 and fan3 (0 rpm) all show (beep)
> 
> 
> > <cut>
> > 
> > > fan2 rpm = CMOS rpm, which I do not get with xmbmon, nor have ever
> > > gotten from sensors.
> > 
> > Did you try FAQ 4.1.1?
> > http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/fan-divisors
> > 
> 
> Yep.  Nothing I tried gives me a reading for fan2.
> 
> > > If I modprobe the i2c and lm_sensors modules, mbmon and xmbmon start
> > > giving me crazy numbers (for example CPU 5.1 F, up from 90.5 a few
> > > moments before), as does sensors.
> > > 
> > > The only way to restore sensible numbers again is to reboot.  How Come?
> > 
> > Looks like mbmon touches the hardware directly... that's equivalent to
> > loading two drivers for the same hardware at once.  No suprise if they
> > get in eachother's way.  You could try to "rmmod" our modules including
> > i2c before you run mbmon... but even then I can't vouch for whatever state
> > in which that program leaves the hardware.  Any error in lm sensors that
> > you notice after running mbmon is out of our hands.
> If I run i2c and lm sensors first, both sensors and mdmon give bad
> numbers.
> 
> REBOOT. 
> 
> If I run mbmon first, I get reasonable numbers until I quit it and
> modprobe all your modules.(After more tests, i2c drivers -dev -core
> -proc -viapro DO NOT cause the problem.  Only after w83781d
> force_as..... do the numbers go nuts.  Let them run a while.  rmmod all
> of them and start mbmon=crazy numbers mentioned before.  I think it is
> touching ASB100 as if it were an as99127f that does the job on the
> registers.
> 
> 
> 
> > > I was going to try to hack w83781d.c into something useable, but alas I
> > > am too dumb.  I offer what I know about this chip in hopes one of you
> > > can do it, maybe as a force_asb100=0,0x2d option to w83781d.
> > 
> > <cut, as99127f vs asb100>
> > > Temp sensor 4: $17 on ASB100 [AMD diode only it seems]
> > 
> > Yes, another a7v333 user mentioned this previously.  I thought he might
> > eventually submit a patch?
> 
> Help me learn how to work on it and I will try.  I had a couple courses
> in C program writing several years ago, but w83781d.c looks like Greek to me.
> > 
> >   In the meantime, let's try to get everything
> > else working for you.  To start with, make sure you have at least the
> > 2.6.5 i2c & sensors packages.
> > 
> > Regards,
-- 
Ed Harrison <ed.tman@verizon.net>
