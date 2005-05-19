From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: bus scan removal
Message-Id: <20031221130732.067ad897.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 1. If wanted in kernel code, have a single scanner in i2c-core
> instead.

But you finally did not implement that, right?

> I2C address space is not that flat and some addresses have
> special meanings for 10-bit addressing, high-speed,
> routing/multiplexing. A simple scan 0x00-0x7f only gives you half the
> picture.

True, still both sensors-detect and i2c-detect also do a "flat" scan.

> 2. A simple SMBus Quick command may have effect, the most simple i2c
> chip is a relay acting on the R/W bit of the address. Some chip at
> 0x69 (?) locked the bus in the early days (-99), and I think it
> was solved using write, not read address in the bus scan.

I wasn't there back to these times, but we now use a quick write
command (which, as you know, doesn't really write anything). A quick
look at i2c-ibm_iic.c in Linux 2.6.0 shows that they use one-byte read
instead.

> 3. The ThinkPad issue, corruption on bus scan. While it is a bug on
> the EEPROM fw, you well know that somehow this type of issue needs to
> be handled. The fewer places to fix the better. The sensors-detect
> prog has 24RF08 fix, how about adding that in i2cdetect too?

You got a point, we forgot i2c-detect. MDS, is doubling the quickwrite
on addresses 0x54-0x57 enough?

> 4. The in-module bus scan only outputs to log, the format may not be
> uniform cross algorithms. There is i2cdetect.

Makes sense too.

> I vote for removal of bus scan in all algorithm sources.

OK, will do.

> > BTW, does i2cdetect work on non-i386 architectures?
> 
> Its pretty straight-forward. If it doesn't work, problem is more
> likely in i2c-dev.

That's not how I meant it. My point is that I think I remember Greg
saying someting about i2c-dev not being portable cross platforms. If I'm
not mistaking, i2cdetect relies on i2c-dev. What I mean is that removing
in-modules bus scanning might not be accepted if the architectures using
these modules are not able to use the new and prefered method, i.e.
i2cdetect.

I searched my mail archive for Greg's original comment, but couldn't
find it. Greg, any chance you could refresh my memory?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
