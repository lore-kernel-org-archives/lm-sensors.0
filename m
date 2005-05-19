From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: a7v8x-x lm_sensors config
Message-Id: <20030611191751.064a8f0e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> it87                    7144   0 (unused)
> i2c-proc                6512   0 [it87]
> i2c-isa                 1164   0 (unused)
> i2c-core               14992   0 [it87 i2c-proc i2c-isa]

OK, the sensors chip is loacted on the ISA bus. That's what I wanted to
know.

I had a quite long chat today with someone that has the same
motherboard, and it seems that there's a second bus/chipset couple on
this model. You should try to load (in order) i2c-viapro and eeprom, and
you should see a number of eeproms matching the number of memory chips
on the machine. Didn't sensors-detect tell you about this? Or maybe you
just don't care about memory eeproms (and I can't blame you for that
;)).

> Note:  Previously I said loading it87 temp_type=0x31 and changing
> temp1 to be CPU and temp2 to be Motherboard yielded close agreement
> between sensors and bios/setup.  I now believe this to be incorrect. 
> When running cpuburn or setiathome the cpu runs a bit hot and does
> agree with bios/setup at about 40 degrees C, when the cpu is idling
> sensors reports 8 degrees C while bios/setup reports about 30 degrees
> C.  More experimentation is required on my part.

There are many cases where the same chip will require different temp
formulae depending on the motherboard. We do our best to track down all
possible formulae, but we don't own all the hardware existing on the
planet, so there'll always be ones missing. If you can find a formula
that works for you and we are not aware about, please let us know.

> Thank you and the other folks for maintaining lm-sensors.

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
