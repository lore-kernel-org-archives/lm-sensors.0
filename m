From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: sensors-output.
Message-Id: <1080804874.406bc60a0c2d2@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1080645241.2518.37.camel@ronin.inmyhouse.org>
In-Reply-To: <1080645241.2518.37.camel@ronin.inmyhouse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

According to Chris Douglass:

> According to sensors-detect, I have a MAX1617 on a dual P4 SuperMicro
> board using the i801 bus driver.

That makes sense, such sensors are commonly embedded in dual-Xeon
systems.

> Here is a segment of sensors-detect showing the chips, and i2cdump
> output of each chip in order.

In the meantime I've made the tests for MAX1617 and LM84 even stricter
in sensors-detect (i.e. any failed assertion discards the chip), and
the dumps below would pass the tests. They look like real MAX1617 chips
(low limit 20 degrees C, high limit 60 degrees C, measured temperatures
19 local and 21 remote for first CPU, 20 local and 28 remote for the
second CPU).

Thanks for providing these dumps, it's interesting to know what a real
MAX1617 looks like (for example the fact that all registers after and
including 0x09 return 0xff) if we ever need more tests to distinguish
between a real MAX1617 and a misdetection.

Also it's interesting to see that MAX1617 chips are still used in modern
systems, so it's important to go on supporting them as good as
possible

> There is also an LM85 on this board, but not an LM84.

The LM85 is probably located on the motherboard (while the MAX1617s are
likely to belong the the CPUs) and has sensors for much more than just
temperature.

> Hope it helps.

Yes, it really does :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
