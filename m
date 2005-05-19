From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: bus scan removal
Message-Id: <Pine.LNX.4.53.0312211214380.23656@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031221100543.28eaf2ff.khali@linux-fr.org>
In-Reply-To: <20031221100543.28eaf2ff.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 21 Dec 2003, Jean Delvare wrote:

> In the process of merging our i2c CVS repository changes into the Linux
> 2.4 kernel, I saw that, back in January 2003, you removed bus scanning
> from two drivers (i2c-algo-bit and i2c-algo-pcf). What was your reason
> for doing so? Is it because it was unused, or because i2cdetect can be
> used instead, or both, or any other reason I didn't think of?

1. If wanted in kernel code, have a single scanner in i2c-core instead.
I2C address space is not that flat and some addresses have special
meanings for 10-bit addressing, high-speed, routing/multiplexing. A
simple scan 0x00-0x7f only gives you half the picture.

2. A simple SMBus Quick command may have effect, the most simple i2c
chip is a relay acting on the R/W bit of the address. Some chip at
0x69 (?) locked the bus in the early days (-99), and I think it
was solved using write, not read address in the bus scan.

3. The ThinkPad issue, corruption on bus scan. While it is a bug on
the EEPROM fw, you well know that somehow this type of issue needs to be
handled. The fewer places to fix the better. The sensors-detect prog has
24RF08 fix, how about adding that in i2cdetect too?

4. The in-module bus scan only outputs to log, the format may not be
uniform cross algorithms. There is i2cdetect.


> I took a look at the i2c drivers present in both Linux 2.4 and 2.6, and
> it turns out that there are other drivers still having a bus scanning
> parameter (i2c-algo-ite.c and i2c-algo-sibyte.c in 2.4, i2c-algo-ite.c
> and i2c-ibm_iic.c in 2.6). As I will be submitting a patch to remove bus
> scanning from "our" drivers (i2c-algo-bit and i2c-algo-pcf), I'm
> wondering if I should do the same for these extra drivers as well.

Pretty much everything gets copy-pasted from i2c-algo-bit and
i2c-algo-pcf without much thought, the algorithm interface could be
better so this wouldn't happen. I vote for removal of bus scan in all
algorithm sources.

> BTW, does i2cdetect work on non-i386 architectures?

Its pretty straight-forward. If it doesn't work, problem is more likely
in i2c-dev.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
