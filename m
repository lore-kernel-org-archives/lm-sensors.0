From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman on alpha
Message-Id: <20030724133751.755b26a7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307240222.53468.kelledin@users.sourceforge.net>
In-Reply-To: <200307240222.53468.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> i2c-velleman.c needs to pick up the HZ macro.  It does this fine 
> on x86, but it needs a little extra help on alpha.  Patch 
> attached; doesn't appear to break the x86 compile.
> 
> I don't actually have or use this device, so someone else will 
> need to test this out...I just wanted i2c to compile.

OK, I'd prefer a slightly different fix. We don't include <asm/param.h>
in any of our drivers. It seems we include <linux/slab.h> instead, so I
think we should do the same for this one. Could you try and confirm it
works for you?

The i2c-philips-par driver seems to miss it too. Were you successful
building it?

> Also, I'm seeing a lot of "cast from pointer to integer of 
> different size" warnings compiling this same driver, mostly 
> having to do with the CTRL macro.  This worries me, especially 
> on 64-bit platforms.  Should I be worried in this case?

I saw hundreds of warnings on perfectly clean code while I was compiling
on a IA-64 system recently. I don't think you should be afraid. Just
remove the -Wall flag if you want gcc to leave you alone. If there are
still warnings after that, then we will take a look at them.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
