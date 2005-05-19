From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:41 +0000
Subject: Please analyse output
Message-Id: <20021115094844.18afa622.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <B9F99D36.445B%zdavatz@ywesee.com>
In-Reply-To: <B9F99D36.445B%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > A fan can repport its speed if it is plugged directy on the
> > motherboard(not on the power cable of a hard disk drive for exemple)
> > and it has three wires (usually black, red and yellow). The yellow
> > will be used to report the speed to the motherboard.
> So the yellow has to be plugged onto the motherboard?

You can't say that. The three wires have to be plugged onto the
motherboard. You don't have one specific wire for the motherboard and
the two other wires going somewhere else. The fan must be *designed* to
be plugged onto the motherboard.

> > Your motherboard, but maybe it is simply not wired. The other are
> > obviously for each CPU. You could check it by loading your system
> > and see if the values change. If you have the possibility to load a
> > specific CPU only, you should be able to see its temperature
> > climbing.
> I do not know yet how to do that.
Simply run some stupid command in a shell. Example: "while [ 1 ] ; do
echo some stupid string ; done". This should load one CPU only if "echo"
and "[" are shell built-ins, and they are for bash. Now, what I don't
know is how to know on which CPU the process is. Maybe ps and/or top can
say this on SMP systems, but I never had one.

> > BTW, I am thinking of one thing. Didn't you forget to run "sensors
> > -s" once before running "sensors"? It could be the reason of most of
> > the trouble.
> I just done it know and I get:
> -snip-
> VCore 1:   +1.45 V  (min =  +1.37 V, max =  +1.52 V)       ALARM
> VCore 2:   +2.78 V  (min =  +1.37 V, max =  +1.52 V)       ALARM
> +3.3V:     +2.80 V  (min =  +3.13 V, max =  +3.45 V)
> +5V:       +4.94 V  (min =  +4.72 V, max =  +5.24 V)
> +12V:     +11.25 V  (min = +10.79 V, max = +13.19 V)
> -12V:      +0.30 V  (min = -13.21 V, max = -10.90 V)
> -5V:       +1.62 V  (min =  -5.26 V, max =  -4.76 V)
> V5SB:      +4.70 V  (min =  +4.72 V, max =  +5.24 V)       ALARM
> VBat:      +3.18 V  (min =  +2.40 V, max =  +3.60 V)

Well, this is *much* better, don't you think so? At least you get VCore1
OK. I don't know about VCore2. It is indeed normal that it is different
from VCore1, so I wonder why we use the same formulae in the config
file.

One thing that would be interesting is to write down these values,
quickly go to your BIOS, watch and write down all values it gives, and
compare. It would help us figure out which values make sense and which
ones don't.

> ywesee@debian:~> sudo lsmod
> Module                  Size  Used by    Not tainted
> w83781d                19328   0  (unused)
> i2c-piix4               4196   0  (unused)
> dmi_scan                1636   0  [i2c-piix4]
> eeprom                  3552   0
> i2c-proc                6464   0  [w83781d eeprom]
> i2c-dev                 3808   0
> i2c-algo-pcf            4864   0
> i2c-algo-bit            7084   0  (unused)
> i2c-core               12992   0  [w83781d i2c-piix4 eeprom i2c-proc
> i2c-dev i2c-algo-pcf i2c-algo-bit]
Looks strange. I thought piix4 was old and not used in recent system,
but maybe it is just me.

> See Attachement. Let me know if it is of use or you need more.
It's OK, I don't need anything else for now. I'll try to have a look,
but it will take some time since I'm really busy today.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
