From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <41B5D866.3000807@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Mark & Mark,
> 

>>3) Does not support PEC (not sure who uses it... can also be TODO
>>if there's interest).
> 
> 
> Very interesting question, why was PEC introduced in the first place
> (generic question, not limited to i801). Proof of concept, or did we
> already see a bus+chip combination using it? Would we want to use it
> wherever possible, regardless of the discussable benefit and the obvious
> speed penalty in most cases (non-block commands)?
> 
> 

I developed the kernel PEC support with an 82801DB and an Intel 82551 NIC.
The board had an I2C bus to all the PCI slots (according to the updated PCI standard).
With I2C to PCI slots, the bus/chip combinations are obviously more flexible.
That's also why SMBus ARP makes sense (PCI hotplug).

When we get a dedicated (and stable) driver for a chip supporting PEC (83791?)
we should turn on PEC in the chip driver. This will enable HW PEC on the bus
drivers that support it, and SW PEC in the kernel i2c layer for bus drivers that don't.
Then we can get some experience on the benefits and penalties, if any.


 
> Now it could probably be even more impressive if you would implement
> I2C_FUNC_SMBUS_READ_I2C_BLOCK, which the eeprom driver can make use of
> when present.
> 
> Now I would have one question for Mark Studebaker. Mark, why is it that
> the the original i2c-i801 driver would not implement
> I2C_FUNC_SMBUS_READ_I2C_BLOCK, while it implements all other BLOCK
> functions? The code has the following message if you try:
> "I2C_SMBUS_I2C_BLOCK_READ not DB!". What is it supposed to mean? I see
> in doc/busses/i2c-i801 that the i801 has a special 3-byte address block
> read, does it mean that it does *not* support the regular (1-byte
> address) I2C block read command?
> 
> If nothing else, a more understandable error message would help :)

My reading of the DB datasheet (in 2002 and now) is that it doesn't support a
standard i2c block read. The driver functionality bitmask reflects that.
I fixed the error message (which would only print out if a driver ignored the functionality mask).

mds
