From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <20030727102530.6666b7cc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i2c-alpha.patch just includes Oleg's i2c-elektor fixes (the 
> i2c-velleman fix has already made it to CVS).

I need Oleg's confirmation that this apply to Linux 2.4 as well as 2.6.
(An explanation of why the change is needed would be welcome too).

> lm_sensors-alpha.patch includes various one-line fixes to drivers 
> (mostly missing headers).  Most of these drivers (like i2c-i810, 
> i2c-amd8111, i2c-nforce2) are currently useless on Alpha, but 
> may one day be useful (remember the AMD Irongate northbridge?)  
> Besides, if we're going to leave them in the standard build 
> vector, we should at least have them not break the build.

I agree for all fixes but one. You include <linux/slab.h> in
i2c-savage4.c while I think <asm/param.h> should be sufficent. Do you
confirm?

> For now, i2c-tsunami build targets are commented out in 
> kernel/busses/Module.mk.  They should be re-enabled when the 
> driver works again.

I'd by far prefer a real fix... So we won't comment it out for now. We
will do so before releasing 2.8.1 if no fix has been proposed at this
time. If CVS testers don't notice it fails compiling, why would one want
it to be fixed?


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
