From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: LM sensors and 2.6 kernel...
Message-Id: <3FBEC3DF.4BEED305@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <hon77s.9lxgxu@webmail.batcom-it.net>
In-Reply-To: <hon77s.9lxgxu@webmail.batcom-it.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I've checked in a Makefile fix.
you may also be able to build by using 'make -k user' to skip the
dependency build errors.


Mark Studebaker wrote:
> 
> thanks for testing.
> In the short term you'll have to download and install i2c-CVS to get
> i2c-proc.h.
> let us know how it goes.
> We'll have to think about a long-term solution.
> 
> "R. Reucher" wrote:
> >
> > Thanks for your replies, Mark & Mark :)... but I'm stuck at compilation of
> > lm_sensors2 right now.
> >
> > Two problems, one "solved" (or worked around): first, there was a missing
> > dependency (mach_mpspec.h) which I solved by adding another Linux kernel
> > include dir "$(LINUX_HEADERS)/asm/mach-default" to the top-level Makefile.
> > This is okay for me, but I think the Makefile needs a more generic and
> > automated detection of the selected subarchitecture type... please ignore my
> > ignorance, if I'm talking about things I'm not very familiar with :). I'm new
> > to I2C and lm_sensors, but an experienced programmer myself.
> >
> > The second missing dependency is "i2c-proc.h". When I understand it correctly,
> > 2.6.0-xxx doesn't support /proc/bus/i2c any longer. Please correct me, if I'm
> > wrong, but at least I couldn't find any thing like that in the new kernel...
> > or am I doing/guessing something totally wrong here?
> >
> > votan:~/src/lm_sensors2 # make user
> > make: *** No rule to make target `linux/i2c-proc.h', needed by
> > `kernel/chips/vt1211.d'.  Stop.
> >
> > Up to this point it compiles like a charme... but I can't get around this one,
> > because there is no "i2c-proc.h" in the kernel includes.
> >
> > Hope my tests help supporting 2.6 in any way.
> >
> > Regards, Rene
> > --
> > Ren? Reucher
> > BATCOM IT Services
> >
> > Tel: +49 160 94957806
> > FAX: +49 6359 205423
> > rene.reucher@batcom-it.net
> > http://www.batcom-it.net/
> > _____________________________________
> > V-webmail - http://www.v-webmail.org/
