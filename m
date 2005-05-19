From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: sensors-detect and 2.6.0-test3
Message-Id: <Pine.GSO.4.21.0308172027560.12924-100000@vervain.sonytel.be>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

	Hi,

I'm porting i2c-hydra (which I wrote many years ago) to 2.6.0-test3 and am
trying to test it. I want to probe for all i2c devices on my i2c bus, but
sensors-detect doesn't work because /proc/bus/i2c is not there.

According to the FAQ I have to `modprobe i2c-proc', but I cannot find the code
for that module in the kernel tree.

How do I probe for all i2c devices in 2.6.0-test3? Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
