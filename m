From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: sis 746FX + 963L, winbond w83697hf - new drivers required
Message-Id: <20030508020751.GC23199@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EB7BA60.7080404@thales.mi.uni-koeln.de>
In-Reply-To: <3EB7BA60.7080404@thales.mi.uni-koeln.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Lech Nieroda <lnieroda@MI.Uni-Koeln.DE> [2003-05-06 15:36:32 +0200]:

> I've noticed your comment in the "New Drivers" section concerning the 
> new SiS chipsets and possible test support. If you should consider 
> developing these drivers, I'd like to assist with testing them on my board.
> My efforts to get the current drivers to work have failed, I hope the 
> following info will help you:
> 
> Specs of my board:
> Model: ASRock K7S8X
> Chipset: SiS 746FX (NB) and 963L (SB)
> 	 Winbond W83697HF Super I/O controller

Interesting... I haven't seen 746 before.  963 is the important part;
could you please send me the results of "lspci -v" as well as "lspci -n"
just to be sure?  I'll then send you a patch to try.

> lm_sensors version:
> 2.7.0 with a 2.4.20 kernel (patched to i2c-2.7.0)
> 
> Output of dmesg concering the sensors:
> -- snip --
> i2c-sis5595.o version 2.7.0 (20021208)
> i2c-sis5595.o: SIS5595 bus detected and initialized
> i2c-dev.o: Registered 'SMBus SIS5595 adapter at 0137' as minor 1
> -- snap --

The 5595 is misdetected on just about all modern boards w/ SiS
chipset.  Don't load i2c-sis5595 or sis5595; you don't have that.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
