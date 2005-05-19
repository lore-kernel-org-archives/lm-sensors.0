From: kelledin@users.sourceforge.net (Kelledin)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <200307251717.22907.kelledin@users.sourceforge.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 25 July 2003 04:10 am, you wrote:
> > Apparently gcc-3.2.3/alpha doesn't grok the original method
> > of static initialization.  It choked on it badly until I
> > switched it.  gcc-2.95.3/x86 seems to like either way just
> > fine.
>
>     Hm... We're using Compaq RH 7.2 Alpha distribution. We've
> a choice of weird redhat gcc-2.96 and a kgcc which is a
> egcs-2.91.66. Both compiling this stuff with no errors. Where
> you have got a precompiled 3.2.3 for alpha? In my opinion it's
> better to use kgcc then compiling a kernel on alpha anyway.
> BTW, redhat guys use gcc-2.96 for the purpose...

Man, HPaq's RH 7.2 Alpha distribution is _ancient_ in tech 
timelines. ;)  RedHat basically discontinued support for the 
Alpha and passed the buck on to HPaq (causing redhat-axp users 
much distress, I might add).  HPaq's barely even making a token 
effort to maintain it.

I personally use a derivative of LinuxFromScratch 
(http://www.linuxfromscratch.org/).  IIRC Debian unstable with a 
precompiled gcc-3.x, but Debian 3.0 is still using gcc-2.95.4.

As for which compiler to use, gcc-3.2.x is pretty widely regarded 
as the best compiler for Linux 2.4 on Alpha, even while 2.95.x 
is preferred for compiling kernels on x86.  2.95.3 has a 
tendency to ICE when compiling SMP kernels on Alpha.  2.96 
is...well...just plain unofficial and dirty in a RedHat 
hacked-up fashion.  egcs is just plain old, and the kernel 
developers don't bother catering to egcs anymore.

> > Maybe the C standard has changed, or maybe gcc3 is just
> > being a fruitcake.  But as the other static structs use a
> > different form of initialization, I decided to accomodate
> > gcc3 and introduce proper consistency in one fell swoop.
>
>     Sounds amazing. ;-))

/me morphs into SuperCoder, takes flight, collides with three 
birds, and promptly trips over a skyscraper.  Ouch.

Man, I think those birds had the right-of-way, too. ;)

> > Hmmm...well, part of the tsunami_driver struct requires a
> > PCI ID table (tsunami_ids).  I'm not sure what's supposed to
> > go in that table?
> >
> > Could it be that someone tried to port the driver to the new
> > API, half-finished it, and left it for dead? 
> > lm_sensors-2.7.0 makes no mention of the tsunami_driver
> > struct or the tsunami_ids table.  Maybe that little struct
> > arrangement isn't supposed to be there?
>
>     If you mean these things
>
>       .id_table       = tsunami_ids,
>
>     then I don't who is doing that... I've attached
> "reference" version of the driver to this mail.

Cool...I'll see what I can do with that.

>     I've attached i2c-elektor.patch for proper readb/writeb
> support in newest kernel. Please incorporate it with your
> Alpha fixes.

Will do, thanks.

> > What Alpha motherboards support sensors like that, btw?
>
>     Tsunami chips are used on most low-end Alpha 21264
> systems, both from Compaq and Samsung (former Alpha Processor
> Inc.) systems. PCF8584 (elektor) chips are used on Samsung
> UP2000, UP2000+ boards and similar systems (I do not remember
> exactly) from Compaq.

Hmmm...perhaps PC164LX?  Maybe I'll try later.

Oh, Jean...as far as the gcc warnings go on i2c, I tracked them 
down and decided they're harmless.  Just some devs took the 
"void *data" provided for i2c drivers to maintain private info, 
and used the pointer itself to store a single byte.  Kind of a 
hack, but tolerable.

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"
