From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c/kernel i2c-algo-bit.c
Message-Id: <20031115081655.4980688f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031101170944.386fd941.khali@linux-fr.org>
In-Reply-To: <20031101170944.386fd941.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> correct. cycle time is 3/2 of advertised, frequency is 2/3 of
> advertised,
> clock is not a 50/50 duty cycle.

OK, I at least understood at least this well ;)

> I'm uneasy with bit_test the default, but if you've identified the
> reason for matroxfb problems and that's the best way to fix it then
> perhaps it's best.

No, it's something different from the matroxfb issue. The problem I
suspect with i2c-matroxfb is that the driver doesn't set the bus in idle
state when loaded (scl and sda high), and this sometimes cause it to
fail if I use bit_test=1 (because the test checks for the bus being idle
before going on). I'll contact Petr Vandrovec, the author of the module,
and see with him how/if that can be changed. Am I correct thinking it
can never hurt to set the lines high, even if another master would be
controling the bus at that time? If I correctly understood how the I2C
bus is working, setting lines low is always winning over setting them
high - so if that other master wants the line low at this time, our
command won't do anything. If there is no other master, the bus will
correctly go in idle state.

The idea of making bit_test the default comes from my plans of writing a
unified i2c-parport driver. With bit_test set, I can walk through the
different modes and the good one will be detected (providing it is in
the list of known ones). Without bit_test, detection seems to be
impossible and the user will have to specify the mode (which in turn
cause a problem if there are more than one adapter present on the
system, of different types). More generally, bit_test sounds like a very
good idea to improve detection in bus drivers providing these drivers
are ensuring the bus will be idle after they initialize.

I might need to read some more code, but that's how I basically see the
things for now.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
