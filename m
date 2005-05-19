From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Installation report/Feedback
Message-Id: <20031214152426.2c5eafe8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207183312.GA855@GreenHouse.dorchain.net>
In-Reply-To: <20031207183312.GA855@GreenHouse.dorchain.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> IMHO it could be stressed a bit more that all three (running kernel,
> kernel source and lm_sensor) should be the same to avoid trouble. I
> somehowhad a different source than the running kernel. Well, more idot
> proof thing will created more creative idiot ;-)

From i2c/QUICKSTART and lm_sensors2/QUICKSTART:

  * Make sure you have the kernel tree corresponding to your current
    kernel in /lib/modules/(uname -r)/build.
    Even if the source is there, it may not correspond to your running
    kernel. If so, you will have to recompile your kernel.

From lm_sensors2/INSTALL:

This package REQUIRES i2c-2.8.1 or later!!!

So it's already in there.

> > > - sensors-detect produced a line # no driver for Winbond W83L785TS
> > > yet, ask us for one! and so I do ;-)
> > 
> > OK, will write a driver if I can find some spare time.
> 
> Great! Thank you.

BTW, could you please provide a dump of your chip? The data sheet isn't
always clear about how things should be handled, so a sample dump would
help:

i2cdump 0 0x2e (or i2cdump 1 0x2e if it's on the second bus).

> > BTW, your chipset isn't really an AS99127F, but an ASB100. We now
> > have a separate driver for it in CVS, you should give it a try. The
> > i2c patch you used is OK, you just need to download and install
> > lm_sensors2 CVS: http://secure.netroedge.com/~lm78/download.html#cvs
> > We still need to update sensors-detect to reflect that, so don't
> > trust it when it says you should use the w83781d driver, and use
> > asb100 instead.
> 
> This seems to be already done.

Yes, this was done right before releasing 2.8.2.

> One more note on making lm_sensors more "package-friendly". You could
> add -rpath $PREFIX/lib (or -R, depending on the linker) to make sure
> that libsensors is always found by the package binaries. For testing,
> I use prefix=/usr/local/lm_sensors, so this would help me.

I'm not sure I understand what you need. Could you please provide a
patch against CVS that does what you want?

> Also a make uninstall target (of course, automatically in sync with
> make install, in the worst case via a generated file list) would IMHO
> encourage people to try things.

I agree. That might not be easy to do though, since our Makefile spreads
over many directories. I don't think I'll have the time to take care
about that. Maybe MDS will, or you can work it out yourself and submit a
patch against CVS. Idealy, patches would be needed for both i2c and
lm_sensors2 (i2c being easier, of course).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
