From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: i2c-savage4.c
Message-Id: <3FC6B717.B4B7ABE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031127193859.700d449f.khali@linux-fr.org>
In-Reply-To: <20031127193859.700d449f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm not going to go through all 13 revisions in CVS to see if this
happened
or if it was me. As you can see I checked the driver in for you
originally. 
Here's the log if you would like to do your own research.
If you would like attribution please send a patch.

> cvs log i2c-savage4.c

RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-savage4.c,v
Working file: i2c-savage4.c
head: 1.13
branch:
locks: strict
access list:
symbolic names:
	V2-8-1: 1.13
	V2-8-0: 1.11
	i2c-2-8-km2: 1.9
	POST-2-8-I2C: 1.8
	LAST-PRE-2-8-I2C: 1.7
	LAST-PRE-2-4-KERNEL: 1.7
	V2-7-0: 1.7
	V2-6-5: 1.5
	V2-6-4: 1.5
keyword substitution: kv
total revisions: 13;	selected revisions: 13
description:
----------------------------
revision 1.13
date: 2003/09/22 04:55:10;  author: mmh;  state: Exp;  lines: +15 -27
(mmh) Use readl/writel for portable access to PCI memory
----------------------------
revision 1.12
date: 2003/07/28 09:57:11;  author: khali;  state: Exp;  lines: +1 -0
(Khali) Fix includes for compilation on Alpha.
        Patch by Kelledin.
----------------------------
revision 1.11
date: 2003/07/03 01:30:13;  author: mds;  state: Exp;  lines: +18 -3
(mds) don't use pci_module_init() for video i2c drivers so we don't
      conflict with video drivers
----------------------------
revision 1.10
date: 2003/06/07 19:53:21;  author: mds;  state: Exp;  lines: +12 -5
(mds) populate pci_device_id tables so the module will load. untested.
----------------------------
revision 1.9
date: 2003/01/21 20:01:27;  author: kmalkki;  state: Exp;  lines: +2 -3
(Ky?sti) Cleanups

   Copy sysctl enums to chip drivers from sensors.h for now,
   as seen in drivers included in 2.5 tree. File no longer included
   from kernel side.

   Apply i2c-proc change in CVS tagged -km2.

   Partial clean and sort of includes everywhere.

   Add i2c-dev.h, as a partial copy from i2c.
   Add to sensors.h from i2c-proc.h to compile things.
   Remove i2c-isa.h.

   Reflect header file changes to lib/ and prog/.
----------------------------
revision 1.8
date: 2003/01/17 01:19:52;  author: kmalkki;  state: Exp;  lines: +47
-202
(Ky?sti) some cleanups for 2.4+

   Module refcounting using .owner, removing of inc/dec_use.
   These require (yet unreleased) i2c 2.8.0+.

   Named initializers everywhere. Unified namespace.

   Cleanup for 2.5, remove EXPORT_NO_SYMBOLS, declare everything
   static. Apply initcalls.

   PCI device registration changes for busses started, replicating
   from i2c-amd*. While everything does compile, nothing really
   works. Well, maybe i2c-amd* ported back from 2.5 tree.

   After updating your work directory, run
    > cvs diff -u -r LAST-PRE-2-8-I2C > lm-2.8-patches-1

   BEWARE: I have not even insmoded any of these yet.

   To compile, you need i2c from cvs too.
   For 2.4 kernel :
    > cvs co -r lk2-4 i2c

   For 2.5 kernel :
    > cvs co i2c
----------------------------
revision 1.7
date: 2002/11/24 05:45:28;  author: mds;  state: Exp;  lines: +1 -1
(mds) change algo-bit timeout from a number to a HZ
----------------------------
revision 1.6
date: 2002/11/18 21:06:16;  author: mds;  state: Exp;  lines: +0 -4
(mds) remove #ifndef ID, require i2c-2.7.0
----------------------------
revision 1.5
date: 2002/07/07 15:45:14;  author: mds;  state: Exp;  lines: +9 -4
(mds) flush PCI posted writes on algo-bit PCI drivers.
      Also check return code on ioremap_nocache().
----------------------------
revision 1.4
date: 2002/04/20 18:22:27;  author: mds;  state: Exp;  lines: +8 -7
(mds) give it its own driver ID
----------------------------
revision 1.3
date: 2002/04/02 01:54:05;  author: mds;  state: Exp;  lines: +88 -86
(mds) voodoo3 -> savage4 global replace
----------------------------
revision 1.2
date: 2002/04/02 01:47:58;  author: mds;  state: Exp;  lines: +6 -2
(mds) compile fixes
----------------------------
revision 1.1
date: 2002/04/02 01:07:27;  author: mds;  state: Exp;
(mds) 1st cut at Savage 4 driver from
      Alexander Wold <awold@bigfoot.com>
======================================
Jean Delvare wrote:
> 
> > Was there a reason why Alex's name isn't mentioned?  If we used any
> > of his code, we should of course give him credit.
> 
> Can't tell why. Looks like it was not added in the first place. I'll
> correct that. Alexander, which address do you want in (if any)? I have
> one at broadpark.no and one at bigfoot.com, don't know which one you
> want us to use.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
