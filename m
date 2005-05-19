From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <41ABC84F.4010109@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks for asking for comments.

No objections to a cleanup, or to using interrupts (#4).

Not sure what BIOS stuff you took out (#2), but I don't think it would be very clean
to have two different drivers supporting the same chips, so that doesn't sound good.

Removing block transactions and PEC (#1 and 3) isn't wise, and not just because
I did most of that code and it was a lot of work :) 
The 801 driver covers a large number of popular chips,
and has possibly the highest "market share" of all the bus drivers.
It's essentially our "reference design" for block and PEC transactions
and is the driver I've often used to test the i2c-core and i2cdump implementations for these transactions.
Just because most bus drivers don't have block and SMBUS 2.0 transactions doesn't mean
we should take it out of the 801. 

And I wouldn't give up on SMBus 2.0 yet. The W83791D sensor chip supports it;
if the W83792D does as well (awaiting datasheet from Winbond), we can enable it
in the forthcoming driver from Winbond and have end-to-end hardware error checking for
i2c transactions on a system with a 792 and a 801, should such a system appear.

mds



Mark M. Hoffman wrote:
> Hello all:
> 
> I've started a complete re-write of the i2c-i801 SMBus driver.  As
> compared to the old one, this one:
> 
> 1) Supports fewer transaction types... still TODO
> 
> 2) Does not have any BIOS workaround nastiness.  I am hoping that
> I can leave that out and that people who need that can be directed
> to just use the old driver.
> 
> 3) Does not support PEC (not sure who uses it... can also be TODO
> if there's interest).
> 
> And the primary difference 4) uses interrupts instead of polling.
> 
> I'm not exactly a stranger to interrupt-handling, having designed
> whole interrupt handling mechanisms for (non-Linux) embedded systems.
> *But*, as this is my first shot at it with a Linux driver...  I would
> appreciate a close look at those parts.  The design is similar to 
> i2c-iop3xx, except where it's different. :)
> 
> My test target / dev host shares an IRQ between sound and SMBus;
> almost all of my testing was performed with xmms blasting away.
> 
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
> 
> (Script for above: http://members.dca.net/mhoffman/sensors/temp/test.pl)
> 
> The diff is harder to read than the complete files which are attached...
> 
> Thanks and regards,
> 
