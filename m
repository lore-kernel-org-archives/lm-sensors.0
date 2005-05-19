From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: adm1021 + kernel 2.6.3 kills machine
Message-Id: <20040227230650.05209fac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1077918018.21481.21.camel@nomad.ad.eecg.saic.com>
In-Reply-To: <1077918018.21481.21.camel@nomad.ad.eecg.saic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> sensors-detect tells me I have and adm1021 sensor. When I try to load
> this module, my monitor turns off, and the hard drive light stays on
> until I shut down and unplug the machine from the wall for several
> seconds. Merely powering off does not help. I don't know if this is a
> bad detection or a hardware issue. I also have a W83682HF chip on the
> mobo which works fine, as well as the eeprom driver.

So this is unlikely that what sensors-detect finds is an adm1021 or
compatible chip (I guess it pretends to find a lm84 or a max1617, two
highly difficult to detect chips).

The solution would simply be not to load the adm1021 driver at all.

If you want me to take a look at what the chip could be, you can provide
the output of i2cdump for it. That said, I don't expect it to be a
hardware monitoring chip, so I probably won't be able to identify it.

> It may be of interest to note that the new radeonfb driver includes an
> i2c interface which is detected by sensors-detect and the i2c
> interface itself is detected by the radeonfb driver. If there is any
> output you would like, or investigation I can do to help, let me know.

I do have a Radeon board and gave a try to that new driver. It does
indeed give access to up to 4 i2c busses on the board. The only thing
you can see there are DDC eeproms from connected monitors. They help
radeonfb (and the X radeon driver) to detect the correct resolution and
frequencies for your monitors. We have a driver for this for 2.4 kernels
(ddcmon) but it hasn't been ported to 2.6 yet. You can also use the
eeprom driver (which is ported to 2.6) and the
proc/eeprom/decode-edid.pl script (together with the read-edid tool).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
