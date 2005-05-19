From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: I have information on Winbond W83627EHF Chip
Message-Id: <mtT6K7QG.1107869314.7808650.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
In-Reply-To: <20050208060234.44864.qmail@web50702.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Ruik,

> > * One additional voltage input.
>
> Which one?
> It has 6 analog inputs as HF has too. ( I looked to PIN assigment table)

Don't know which ones you missed, but the HF has actually 9: 7 at
0x20-0x26, and 2 at 0x50-0x51 (VSB and Vbat, bank 5). The EHF
additionally has one at 0x52 (bank5), labelled vin4.

> Some pins are shared, what happen if they are used for other function?
> They will return zero? Or bogus?

For the 2.6 driver, the sysfs file should simply not be created. We can
check the Super-I/O configuration to know which functions are enabled
and which aren't. For the 2.4 driver we can't prevent the file from
being created, so care should be taken that zero values are returned and
writes to the files, if apply, are ignored, when the function is
disabled. Or maybe we won't write a driver for 2.4 at all, if there is
no request to do so.

> Also one interresting bit changed to reserved
>
> Address Register (Port x5h)
> Bit7: Read Only
>
> The logical 1 indicates the device is busy because of a Serial Bus
> transaction or another LPC bus
> transaction. With checking this bit, multiple LPC drivers can use W83627HF
> hardware monitor without
> interfering with each other or a Serial Bus driver.
> It is the user's responsibility not to have a Serial Bus and LPC bus
> operations at the same time.
> This bit is:
>
> Set: with a write to Port x5h or when a Serial Bus transaction is in
> progress.
> Reset: with a write or read from Port x6h if it is set by a write to Port
> x5h, or when the Serial Bus
> transaction is finished.

Interesting. I wonder if this is really new or simply wasn't documented
for older chips. Anyway, I don't think we can use this. For one thing,
the I2C driver wouldn't possibly access this bit. For another, we could
easily deadlock the ISA driver if either the SMBus gets stuck in the
middle of a transaction, of some random write to 0x295 sets the bit and
never clears it. If we want to really ensure that both interfaces (I2C
and ISA) are never used at the same time, we'd probably better detect
the chips as being aliases at dirver level, like is done in
sensors-detect.

But to say the truth, I simply don't plan to implement i2c support for
this chip at all. I just don't see the point when we can detect the
chip much more reliably as a Super-I/O chip, and have a much faster and
more reliable registrer access through ISA.

Side note: The ISA address is said to be aligned on 2-byte a boudary, not
8-byte as expected. I wonder if the older chips supported that too. Not
that it really matters, however.

Thanks,
--
Jean Delvare
