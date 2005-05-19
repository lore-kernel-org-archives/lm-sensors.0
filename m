From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Keywest detection
Message-Id: <1060248872.1077.63.camel@gaston>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806190950.6326aa8f.khali@linux-fr.org>
In-Reply-To: <20030806190950.6326aa8f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2003-08-07 at 00:00, Jean Delvare wrote:
> > No. They don't, they show up in /proc/device-tree (one at the root
> > of the tree, the one in the northbridge, and one lower below,
> > within the macio PCI asic)
> 
> Interesting. I would need a concrete example to figure that out
> properly. When you say "device-tree", is it the real directory name
> (never seen that in i386) or is it to be replaced by something else,
> depending on the machine?

There's a /proc/device-tree directory on PPCs that have Open Firmware
(that is not all PPCs, but all supported PowerMacs) that contains the
Open Firmware device-tree.

> It's usable by us then. If I understand you correctly, it already shows
> in 2.4, but will be different (and better) in 2.6?

Yes.

> Our script only read values, so we are unlikely to break anything.

Hrm... ok.

> > The firmware is setting that up in some "sane" way, what else would
> > you want to do?
> 
> I don't know about PPC, but in the i386 world, we want to set our own
> temperatures and fan limits. I guess it's a bit different because all
> the hardware for a given PPC system is known, so the fan speeds, normal
> temperature etc. are known and not subject to change. Anyway, drivers
> are still welcome so that you can at least read the temperatures values,
> etc...

Well... depends on what PPC, PPC arch covers a wide range of very
different kinds of machines... Anyway, regarding PowerMacs, I'd rather
avoid touching those sensors settings from code that isn't specifically
written for those machines. 

> Yes, I think it does. What made me wonder is that some comments in the
> code reveal that the code is meant to be run on PPCs. For example,
> __powerpc__ is checked twice. There also is a log entry that mentions
> PPC support support.
> 
> On the other hand, I don't know if PPC even have an I2C bus. A PPC user
> reported today that our sensors-detect script locks when it comes to ISA
> chipsets detection. So, what should I know about PPC and the ISA bus?
> 
> My primary goal here is to allow PPC users to compile lm_sensors. For
> now, they can't because at some point isadump fails to compile because
> of a header issue (I think PPC has asm/io.h instead of sys/io.h, is that
> it?) so I was wondering if we should simply disable the compilation of
> this tool on PPC, or try to fix it.

Ok, so PPCs means a lot of things ;)

The PPC arch cover a wide range of different machines, like the PowerMacs,
the PReP and CHRP machines (IBM RS6k among others), a lot of embedded
boards, the "Amigas" (APUS and Pegasos boards), etc...

Some of them are rather PC-like (that is with some similar chipsets to
what is found on x86), some aren't (PowerMacs).

The CPU itself doesn't have the inX/outX instructions, like most non
x86 CPUs, but there is till the possiblility of having an ISA bus on
some machines, in which case it's available on a southbridge on the
PCI bus. The PowerMacs don't have one though.

There are some techniques to issue IOs from userland, but those
involve using some syscalls to find the IO base address of a given
PCI bus, then mmap'ing /dev/mem to get access to this IO range, then
re-implementing the kernel IO accessors based on this. This isn't
something I recommend to do unless it cannot be avoided. (XFree is
an example of a userland app that do need that).

Ben.
