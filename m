From: hfvogt@gmx.net (Hans-Frieder Vogt)
Date: Wed, 14 Jun 2006 22:19:00 +0000
Subject: [lm-sensors] [PATCH 2.6] cleanup of i2c-nforce2,
Message-Id: <200606150019.00254.hfvogt@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200512270102.30671.hfvogt@gmx.net>
In-Reply-To: <200512270102.30671.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

thank you very much for your testing. Your results are extremely helpful for 
me!

Am Sonntag, 11. Juni 2006 13:28 schrieb Jean Delvare:
> > > This statement isn't totally true, as the driver is now advertising
> > > I2C_FUNC_SMBUS_BLOCK_DATA as being supported, while so far it didn't.
> > > This may cause new code paths to be taken, which have never been
> > > exercised and might have bugs.
> >
> > I am pretty sure now that this function is supported by the nforce2/3/4
> > SMBus controller, so I took the opportunity to not only have the function
> > coded in the driver but also advertise it. It is not well tested though,
> > and I would be happy to get response from users of the new mode (success
> > or failure, both is welcome).
>
> I don't have a chip which actually uses SMBus block transactions, so I
> used an SPD EEPROM to test SMBus block read, carefully choosing the
> offset so that the first byte would be a valid length. It seemed to
> work well, except for length = 32, where I get a timeout, and the bus
> is dead until next reboot. You may want to investigate on your end. At
> any rate it would be convenient to have a way to reset the bus in this
> case, so that a failed transaction doesn't kill the bus.

very valuable results! I only tried a length of 32 so far (also on SPD EEPROMs 
of two boards) and wondered, why it always failed!
There is also a strange thing in general with the length2: The ACPI 
documentation (I have checked in ACPIspec-2-0a.pdf and ACPIspec-2-0b.pdf) 
only allows 5 bits for the block count in the SMB_BCNT register. This is a 
bit contradictory to the explicitely mentioned maximum length of 32 bytes for 
a block transfer. Do you know how a length of 32 is coded in this? With 0?

> > > I doubt you'll find many testers, as the SMBus block transactions are
> > > rarely used. You need very specific devices to make use of them.
> >
> > at least the BIOS provides this function on nforce4 mainboards, although
> > I don't know whether they also use it :-]
>
> Do they offer the I2C block transaction variant as well?

I have found none.

>
> Maybe you can check if they do anything special for 32-byte long SMBus
> block reads.

I have not found anything so far, but I continue searching and trying. What 
they do is that they mask the output from the block count register with 0x1f 
to only use the allowed bits. Does that mean they only use transfers with 31 
bytes maximum?

> > > > -		case I2C_SMBUS_I2C_BLOCK_DATA:
> > > > -			len = min_t(u8, data->block[0], 32);
> > > > -			outb_p(command, NVIDIA_SMB_CMD);
> > > > -			outb_p(len, NVIDIA_SMB_BCNT);
> > > > -			if (read_write = I2C_SMBUS_WRITE)
> > > > -				for (i = 0; i < len; i++)
> > > > -					outb_p(data->block[i + 1], NVIDIA_SMB_DATA+i);
> > > > -			protocol |= NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA;
> > > > -			break;
> > >
> > > Are you sure this transaction type isn't supported? That's a useful one
> > > to access EEPROMs, and given that NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA
> > > exists, it would seem that the chip does support it. What makes you
> > > think otherwise? Isn't it simply a matter of advertising it, as for the
> > > SMBus block transactions?
> >
> > I have to admit, I do not know whether NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA is
> > supported. However, I have only limited possibilities to check the
> > functionality of the SMBus host controller, and the eeprom on my nforce4
> > board did not react any more when I tried to read data via i2cdump in i2c
> > block data mode. Therefore I consider this function as very experimental
> > for the moment. Maybe I just tried the function on the wrong i2c chip or
> > using the wrong tool.
>
> I did some testing on my end (with an nforce2 chip) and it didn't work
> either. I had to change the driver code to force the read length to 32
> because that's the way we implement it in Linux, but even then I still
> can't get anything but a timeout (status register value 0x19.) Forcing
> the length to 16 instead didn't help. As we don't even know what the
> status bits mean, there's not much more to try at this point.
>
> Of course that could work better on newer chips, I only tested on
> nforce2.

I can only confirm your findings. However, the value 0x19 means "SMBus Host 
unsupported protocol". Pretty clear, isn't it?

> > > > As soon as I am able to confirm that i2c block data or other
> > > > functions do really work I will of course add again the code (and
> > > > advertise it as well).
> > >
> > > I'd prefer that we don't rip the code out if we will reintroduce it
> > > shortly afterwards. Better test everything now, and come up with a
> > > single patch doing the right thing.
> >
> > OK, I will do again some testing over a limited time, and will then
> > either confirm the patch or come up with some better variant.
>
> My own tests suggest that your original patch is the right thing to do
> (i.e. keep SMBus block transactions and drop I2C block transactions)
> although I'm a bit worried by the problem I observed for 32-byte long
> SMBus block reads. It might not be a problem in practice though.

I am happy that you agree with my approach, and I will concentrate now on the 
32-byte long block read problem.

> I am waiting for the results of your own tests, then we can decide what
> we want to do.

Thanks again for your support. I will use the next weekend and will then 
summarise my findings.

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt <at> arcor .dot. de
                                          hfvogt <at> gmx .dot. net

