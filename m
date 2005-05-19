From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <20041202214316.32784c1c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark & Mark,

> I've started a complete re-write of the i2c-i801 SMBus driver.  As
> compared to the old one, this one:
> 
> 1) Supports fewer transaction types... still TODO

See below for my requests ;)

> 2) Does not have any BIOS workaround nastiness.  I am hoping that
> I can leave that out and that people who need that can be directed
> to just use the old driver.

The old driver would most likely be deprecated and removed so you better
don't count on it. OTOH I think that the workarounds would best be
placed with the other PCI quirks, so I'm fine if the driver doesn't
handle that case. And my own i801 machine doesn't need it anyway ;)

> 3) Does not support PEC (not sure who uses it... can also be TODO
> if there's interest).

Very interesting question, why was PEC introduced in the first place
(generic question, not limited to i801). Proof of concept, or did we
already see a bus+chip combination using it? Would we want to use it
wherever possible, regardless of the discussable benefit and the obvious
speed penalty in most cases (non-block commands)?

> And the primary difference 4) uses interrupts instead of polling.

Sounds good :)

> Re performance: this driver does not improve CPU utilization, because
> the polling loop on the old one sleeps a lot anyway.  Elapsed time
> per transaction did improve by varying degrees, depending on the
> transaction type:
> 
> OLD:
> I2C_SMBUS_QUICK(nodev) 0.00202
> I2C_SMBUS_QUICK 0.00203
> I2C_SMBUS_BYTE 0.00203
> I2C_SMBUS_BYTE_DATA 0.00402
> I2C_SMBUS_WORD_DATA 0.00602
> 
> NEW:
> I2C_SMBUS_QUICK(nodev) 0.00108
> I2C_SMBUS_QUICK 0.00107
> I2C_SMBUS_BYTE 0.00190
> I2C_SMBUS_BYTE_DATA 0.00365
> I2C_SMBUS_WORD_DATA 0.00449

My own real-world test confirms the improvement. My test case is:

time for i in $(seq 1 100)
do
	cat /sys/bus/i2c/devices/4-0050/eeprom > /dev/null
done

(Note that I modified the eeprom driver to remove data caching, so as to
make the benchmarking easier - or possible at all.)

Old driver:
real    0m53.583s
user    0m0.052s
sys     0m0.075s

New driver:
real    0m35.986s
user    0m0.067s
sys     0m0.214s

+48% speed improvement, I'm quite impressed. Congrats Mark :)

Also note that I had music playing on the system, where every device
uses IRQ 9 (ACPI enabled) and sound still worked like a charm during the
tests.

Now it could probably be even more impressive if you would implement
I2C_FUNC_SMBUS_READ_I2C_BLOCK, which the eeprom driver can make use of
when present.

Now I would have one question for Mark Studebaker. Mark, why is it that
the the original i2c-i801 driver would not implement
I2C_FUNC_SMBUS_READ_I2C_BLOCK, while it implements all other BLOCK
functions? The code has the following message if you try:
"I2C_SMBUS_I2C_BLOCK_READ not DB!". What is it supposed to mean? I see
in doc/busses/i2c-i801 that the i801 has a special 3-byte address block
read, does it mean that it does *not* support the regular (1-byte
address) I2C block read command?

If nothing else, a more understandable error message would help :)

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
