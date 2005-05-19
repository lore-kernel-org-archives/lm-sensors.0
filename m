From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: "probe" module param broken for it87 in Linux 2.6.6
Message-Id: <20040512215607.609b6f0e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <hvk6zhzp6c.fsf@rasputin.ws.nextra.no>
In-Reply-To: <hvk6zhzp6c.fsf@rasputin.ws.nextra.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> There were some concerns about detecting the IT8712F since it has a
> non-standard config mode exit sequence.  Theoretically we risk putting
> another SuperIO chip in config mode.  Therefore, just in case, the
> "standard" exit command has been added to superio_exit(). This does
> not seem to matter to the IT8712F.  The code as it is has been in the
> lm_sensors package for some time.

That's what we first thought but it's not correct.

The outb(0x02, REG), outb(0x02, VAL) exit sequence is actually the
standard exit sequence per ISA PNP spec. The other exit sequence is used
by Winbond, VIA and SMSC but isn't part of the standard.

The Winbond method is harmless in any case, since it doesn't actually
write anything, so I agree it wouldn't hurt to leave it in the it87
driver.

The standard exit sequence is believed to work on Winbond chips as well,
although it may be slightly slower and/or more agressive than the
documented exit sequence.

In sensors-detect we now default to the standard (outb(0x02, REG),
outb(0x02, VAL)) exit sequence for all Super-I/O chips unless we have
successfully detected a chip for which we know an alternate exit
sequence. We have had no complaint so far, so it has to work with no
side effect.

So I'd suggest that you simply use the standard exit sequence in the
it87 driver (the second one in your current patch). A patch for the 2.4
driver would be appreciated as well.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
