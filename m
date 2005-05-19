From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <20040129222700.58c9e568.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

A few more comments and random thoughts about the gl518sm driver:

* Can you confirm that you do have a GL518SM chipset for testing and
use? Please also tell us which release it is. This is an old chip and I
am surprised that someone still uses it. I think we should only port to
Linux 2.6 drivers that people need. We better don't work for nobody, and
also don't clutter the kernel tree with useless code.

* Can you confirm that the 2.4 driver works OK for you? Just to make
sure that the code we are starting from is working.

* Your new driver counts voltages starting at 1, instead of 0. This
will break compatibility with existing code and needs to be fixed (I
will do).

* Your new driver defines two different names for the two different
releases of the chip. This breaks compatibility with libsensors, and
would better be fixed (I will do too).

* The "iteration" code increases the driver code size by one third (not
one fifth as I initially announced). One more reason to get rid of it (I
already did it, to say the truth).

* The more simple way to handle the two different releases of the chip
is probably to export 0 as the readings for in0-in2 in release 0x00. I
had first thought of no file at all, or non-readable files, but this may
be more confusing than helpful, and this will make things more complex
in libsensors. MMH reminded me that sensors.conf is there to allow
people to ignore unused inputs, so we can just do that. Minimal work,
maximum compatibility. It's simply adding a "if these read 0, just
ignore them" comment in sensors.conf and chip doc. If someone can think
of a better and cleaner way of doing it, please speak up.

I should have something for you to test within a day.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
