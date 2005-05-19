From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: sensors-detect and 2.6.0-test3
Message-Id: <Pine.GSO.4.21.0308211133120.11810-100000@waterleaf.sonytel.be>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 19 Aug 2003, Greg KH wrote:
> On Sun, Aug 17, 2003 at 08:32:44PM +0200, Geert Uytterhoeven wrote:
> > I'm porting i2c-hydra (which I wrote many years ago) to 2.6.0-test3 and am
> > trying to test it. I want to probe for all i2c devices on my i2c bus, but
> > sensors-detect doesn't work because /proc/bus/i2c is not there.
> 
> sensors-detect does not work on 2.6, sorry.  You have to poke around in
> the sysfs tree by hand right now after loading the drivers by hand :)
> 
> > How do I probe for all i2c devices in 2.6.0-test3? Thanks!
> 
> I just load all of the drivers and see what happens :)

Hmm... And all I have on the i2c bus is the SPD EEPROMs on my SDRAM DIMMs.
AFAIK there's no kernel `driver' for these?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
