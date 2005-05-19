From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: Nat. Sem. PC87366 also listed under "Sensors Chip" Drivers
Message-Id: <1081846193.407ba9b13b825@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <33.454e65b3.2d85f761@aol.com>
In-Reply-To: <33.454e65b3.2d85f761@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me.]

> pulled off the cvs lmsensors2 on 4/12 at 4:15 pm but compiling fails
> at vt1211.c (says no rule to make target, required by sensors.h); i
> am going to test the drivers on a 2.4 kernel since i'm not sure how
> to fit the modules into a 2.6 kernel
> 
> is there a way to skip these failures? or is there a way to compile
> just a specific module?

First of all, lm_sensors2 CVS drivers only work with Linux 2.4, not
2.6.

Second, you need at least i2c 2.8.1 for lm_sensors CVS to work. Since
2.4 kernels come with an old i2c subsystem, you have to install
i2c-2.8.1 by yourself (unless your distribution provides a convenient
way to do that). If you don't use any non-sensor i2c device driver
(bttv etc.) you can simply get and install i2c 2.8.4 from here:
http://secure.netroedge.com/~lm78/archive/i2c-2.8.4.tar.gz

If you *do* use other i2c drivers (from the kernel or 3rd party), you
have to patch your kernel sources and possibly 3rd party drivers, see
the following page:
http://delvare.nerim.net/i2c/

Once i2c is correctly installed, including C headers, lm_sensors2 CVS
should compile correctly.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
