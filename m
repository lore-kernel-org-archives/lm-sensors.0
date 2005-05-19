From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: i2c/kernel i2c-algo-bit.c
Message-Id: <Pine.LNX.4.53.0311161950340.7421@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031101170944.386fd941.khali@linux-fr.org>
In-Reply-To: <20031101170944.386fd941.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


As noted before, bit-banging puts some limitations on the type of
devices the bus may have. My (unverified) comments in the order of TODO.

1. Even if both SCL and SDA lines are temporarily high, another master
may have issued Start sequence and the bus is considered Busy until a Stop
sequence is issued. Detecting these sequences requires (minimal)
external hardware, a status changed flag, or fast (<1us) sampling of
SCL and SDA lines. It will work most of the time, but messages from
other hosts on the same bus may get corrupted. For a multi-master
configuration, choose a hardware based i2c approach instead.

2. SMBus has 50 usec of SCL (hi) to detect a free bus. Pretty easy if
the GPIO can trigger on edge or has status change flag.

3. If the adapter hardware cannot read SCL line status, client devices
that may hold SCL low must not be used. This is crucial, otherwise
system looses sync of data and acknowledge bits (missing SCL pulse).
Even Stop may fail (SCL still low). Once released SCL, client will hold
SDA low to signal acknowledge. Master cannot signal Start. Get the
point already?

4. SDA arbitration. Strictly a multi-master issue. Pointless unless we
implement (1) or (2) above. I think i2c-algo-biths implements this as
part of being always so paranoid.


I did put some thought on the various timing issues while writing
i2c-algo-biths. I thought that one could create a queue of i2c bus
changes (ie. timed mem/io operations) and empty this queue within an
"approriate" timer interrupt. Kind of a RISC machine that ticks forwards
a predetermined program if no error flag is set.

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>  +358 50 462 8786
