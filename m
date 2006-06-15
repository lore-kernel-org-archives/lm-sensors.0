From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 15 Jun 2006 08:03:42 +0000
Subject: [lm-sensors] [PATCH 2.6] cleanup of i2c-nforce2,
Message-Id: <20060615100342.95ab80d7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200512270102.30671.hfvogt@gmx.net>
In-Reply-To: <200512270102.30671.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Hans,

> > I don't have a chip which actually uses SMBus block transactions, so I
> > used an SPD EEPROM to test SMBus block read, carefully choosing the
> > offset so that the first byte would be a valid length. It seemed to
> > work well, except for length = 32, where I get a timeout, and the bus
> > is dead until next reboot. You may want to investigate on your end. At
> > any rate it would be convenient to have a way to reset the bus in this
> > case, so that a failed transaction doesn't kill the bus.
> 
> very valuable results! I only tried a length of 32 so far (also on SPD EEPROMs 
> of two boards) and wondered, why it always failed!
> There is also a strange thing in general with the length2: The ACPI 
> documentation (I have checked in ACPIspec-2-0a.pdf and ACPIspec-2-0b.pdf) 
> only allows 5 bits for the block count in the SMB_BCNT register. This is a 
> bit contradictory to the explicitely mentioned maximum length of 32 bytes for 
> a block transfer. Do you know how a length of 32 is coded in this? With 0?

This matches my observation that the higher 3 bits of the length byte
are ignored. Given that 0 is an invalid block length and 32 is valid,
it would be possible to actually code 32 as 0. I don't think it is
particularly clever, as it adds to confusion and will also require
additional code in several places, but we'll have to do with it as
this is in the ACPI specification.

Attached is a suggested patch for the i2c-nforce2 driver, applying on
top of your own cleanup patch. Other drivers (i2c-amd8111 and the not
yet merged i2c-acpi-ec) would need something similar. That being said,
I doubt this will fix the hangs I was observing, as they seem to be
caused by the hardware itself and not the i2c-nforce2 driver.

> > Maybe you can check if they do anything special for 32-byte long SMBus
> > block reads.
> 
> I have not found anything so far, but I continue searching and trying. What 
> they do is that they mask the output from the block count register with 0x1f 
> to only use the allowed bits.

This is what my patch does, actually.

>                                Does that mean they only use transfers with 31 
> bytes maximum?

The SMBus specification allows 32, and the ACPI specification mentions
a 32 byte buffer (SMB_DATA[i], i=0-31) so this would be odd. But maybe
this is a flaw in the nVidia implementation.

> > > I have to admit, I do not know whether NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA is
> > > supported. However, I have only limited possibilities to check the
> > > functionality of the SMBus host controller, and the eeprom on my nforce4
> > > board did not react any more when I tried to read data via i2cdump in i2c
> > > block data mode. Therefore I consider this function as very experimental
> > > for the moment. Maybe I just tried the function on the wrong i2c chip or
> > > using the wrong tool.
> >
> > I did some testing on my end (with an nforce2 chip) and it didn't work
> > either. I had to change the driver code to force the read length to 32
> > because that's the way we implement it in Linux, but even then I still
> > can't get anything but a timeout (status register value 0x19.) Forcing
> > the length to 16 instead didn't help. As we don't even know what the
> > status bits mean, there's not much more to try at this point.
> >
> > Of course that could work better on newer chips, I only tested on
> > nforce2.
> 
> I can only confirm your findings. However, the value 0x19 means "SMBus Host 
> unsupported protocol". Pretty clear, isn't it?

Ah, great, you just made me realize that the meaning of these status
bits were described in the ACPI specification. Thanks ;)

Indeed this is quite clear. If you didn't have more success with a more
recent chip, we really can wipe out that part of the code, including
the definition of NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA itself. It's not even
in the ACPI specification, even though i2c-amd8111 has it.

> > My own tests suggest that your original patch is the right thing to do
> > (i.e. keep SMBus block transactions and drop I2C block transactions)
> > although I'm a bit worried by the problem I observed for 32-byte long
> > SMBus block reads. It might not be a problem in practice though.
> 
> I am happy that you agree with my approach, and I will concentrate now on the 
> 32-byte long block read problem.

Good. I'll do some more tests next week-end as well, before I
disassemble my test system. Now that I have the help of the ACPI
specification, I might get a bit further, who knows. Do you have the
possibility to test the block write transactions? I don't.

I am worried that, if the 32-byte long block read hang is indeed a
hardware problem, we can't safely implement the feature in the driver.
We could intercept block writes and reject the ones which would hang the
controller, but we can't intercept reads, as the length is provided by
the slave chip and the hardware gets it before we do. So, unless we can
find a way to restore the host controller to a working state after the
problem occured, we better don't implement the block read functionality
in the driver :(

Thanks,
-- 
Jean Delvare

