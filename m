From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: linux-2.6.1, ECS K7S5A / SiS735
Message-Id: <1073983802.4003b13ac0d4e@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040113004723.5892cfb2.Dexter.Filmore@gmx.de>
In-Reply-To: <20040113004723.5892cfb2.Dexter.Filmore@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I just installed lm-sensors 2.8.2 user utils to read the sis735 board
> sensors in my server, running linux-2.6.1.
> 
> first of all I got confused over what to compile or not. As of now,
> there is sis5595 as a module (since sensors-detect asks for it), then
> there is sis96x as a module since the kernel help says it supports
> the 735 chipset. i2c support is compiled in statically.

Should be supported by i2c-sis96x, yes.

> now first of all I hacked the detect script to look for sis96x since
> sis645 module doesn't exist at all.

Right, that's on my to-do list for some times already, but couldn't find
the time to fix that problem yet, sorry.

> script loads it fine, the it8705 chip, too (*and* the sis5595, bob
> knows why)

It shouldn't. And you shouldn't try to load it, as it might confuse your
bus.

> but later on after everything is loaded, namely:
> i2c_sis96x              4416  0
> it87                   21632  0
> i2c_sensor              2368  1 it87
> 
> it still tells me "no sensors found".
> 
> any ideas?

Not really, except ths sis5595-might-have-confused-your-bus mentioned
right above.

Make sure you have sysfs support enabled in your kernel and mounted
under /sys on your system. Check your dmesg for possible hints, and
have a loot at what /sys/bus/i2c contains.

You could also unload it87 and run i2cdetect on your sis735 bus, to make
sure you see your it87 chip there (I expect you to see it if
sensors-detect suggested it). If you can see the chip, run i2cdump on
it and we'll try to understand why the it87 drivers did not like it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
