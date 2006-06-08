From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 08 Jun 2006 21:19:29 +0000
Subject: [lm-sensors] [PATCH 2.6] cleanup of i2c-nforce2,
Message-Id: <20060608231929.d44b0347.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200512270102.30671.hfvogt@gmx.net>
In-Reply-To: <200512270102.30671.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans-Frieder,

> > This statement isn't totally true, as the driver is now advertising
> > I2C_FUNC_SMBUS_BLOCK_DATA as being supported, while so far it didn't.
> > This may cause new code paths to be taken, which have never been
> > exercised and might have bugs.
>
> I am pretty sure now that this function is supported by the nforce2/3/4 SMBus 
> controller, so I took the opportunity to not only have the function coded in 
> the driver but also advertise it. It is now well tested though, and I would 
> be happy to get response from users of the new mode (success or failure, both 
> is welcome).

I guess you meant _not_ well tested?

I doubt you'll find many testers, as the SMBus block transactions are
rarely used. You need very specific devices to make use of them.

> > > -		case I2C_SMBUS_I2C_BLOCK_DATA:
> > > -			len = min_t(u8, data->block[0], 32);
> > > -			outb_p(command, NVIDIA_SMB_CMD);
> > > -			outb_p(len, NVIDIA_SMB_BCNT);
> > > -			if (read_write = I2C_SMBUS_WRITE)
> > > -				for (i = 0; i < len; i++)
> > > -					outb_p(data->block[i + 1], NVIDIA_SMB_DATA+i);
> > > -			protocol |= NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA;
> > > -			break;
> >
> > Are you sure this transaction type isn't supported? That's a useful one
> > to access EEPROMs, and given that NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA
> > exists, it would seem that the chip does support it. What makes you
> > think otherwise? Isn't it simply a matter of advertising it, as for the
> > SMBus block transactions?
> 
> I have to admit, I do not know whether NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA is 
> supported. However, I have only limited possibilities to check the 
> functionality of the SMBus host controller, and the eeprom on my nforce4 
> board did not react any more when I tried to read data via i2cdump in i2c 
> block data mode. Therefore I consider this function as very experimental for 
> the moment. Maybe I just tried the function on the wrong i2c chip or using 
> the wrong tool.

Be very careful with SPD EEPROMs, they are sometimes writable, and
corrupting them will make your memory module unusable as soon as you
reboot :(

Do you have any datasheet for the nforce2/3/4 chips?

> Do you know or have other tools that may be useful in testing the capability 
> of i2c bus hosts and chips?

i2cdetect can be used to test quick command and receive byte. i2cdump
can be used to test send byte, receive byte, read byte, read word and
i2c block read.

> As soon as I am able to confirm that i2c block data or other functions do 
> really work I will of course add again the code (and advertise it as well).

I'd prefer that we don't rip the code out if we will reintroduce it
shortly afterwards. Better test everything now, and come up with a
single patch doing the right thing.

I have a spare nforce2 board here, I can build a test system from it
and help you with the tests. However, it will have to wait for the next
week-end so that I have the time to assemble the system.

> > Your summary didn't mention this change. It looks like a bug fix to me,
> > rather than a simple cleanup. We were previously reserving only 8 I/O
> > addresses while the highest offset we access is 0x24 so we should have
> > been reserving at least 37 bytes. 64 sounds sane.
> >
> I confess, this is really a bug fix and I forgot to mention it.
> I chose 64 for the I/O window size because
> a) it is big enough to cover the currently addressed I/O range
> b) on all nforce2/3/4 boards that I have checked the SMBus I/O addresses are 
> 64 apart, so it is sort of a "substantiated guess".

A very reasonable guess, considering that for the nforce3/4 the I/O
addresses are in standard PCI BARs and they are indeed 64-byte large.
And I think the PCI I/O ranges have to be powers of two anyway. Let's go
with 64.

Thanks,
-- 
Jean Delvare

