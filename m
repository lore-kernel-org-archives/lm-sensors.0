From: hfvogt@gmx.net (Hans-Frieder Vogt)
Date: Thu, 08 Jun 2006 20:06:15 +0000
Subject: [lm-sensors] [PATCH 2.6] cleanup of i2c-nforce2,
Message-Id: <200606082206.15425.hfvogt@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200512270102.30671.hfvogt@gmx.net>
In-Reply-To: <200512270102.30671.hfvogt@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean,

> Hans-Frieder,
>
> > attached is my latest patch against kernel 2.6.17-rc5-mm3, now only
> > containing the cleanup parts of my original patch. I hope we can get
> > these changes quickly into the kernel. They mainly delete non-funtioning
> > parts, so the patch should not have many side effects.
>
> This statement isn't totally true, as the driver is now advertising
> I2C_FUNC_SMBUS_BLOCK_DATA as being supported, while so far it didn't.
> This may cause new code paths to be taken, which have never been
> exercised and might have bugs.
>
I am pretty sure now that this function is supported by the nforce2/3/4 SMBus 
controller, so I took the opportunity to not only have the function coded in 
the driver but also advertise it. It is now well tested though, and I would 
be happy to get response from users of the new mode (success or failure, both 
is welcome).

> Overall I'm happy with your patch, the cleanups are very welcome,
>
> thanks for the update. I would have a couple objections though:
> > -/* Return -1 on error. See smbus.h for more information */
> >  static s32 nforce2_access(struct i2c_adapter * adap, u16 addr,
> >  		unsigned short flags, char read_write,
> >  		u8 command, int size, union i2c_smbus_data * data)
>
> It does indeed return -1 on error, even though the second part of the
> comment should be discarded, I agree.
>
> > @@ -174,24 +156,6 @@ static s32 nforce2_access(struct i2c_ada
> >  			protocol |= NVIDIA_SMB_PRTCL_BLOCK_DATA | pec;
> >  			break;
> >
> > -		case I2C_SMBUS_I2C_BLOCK_DATA:
> > -			len = min_t(u8, data->block[0], 32);
> > -			outb_p(command, NVIDIA_SMB_CMD);
> > -			outb_p(len, NVIDIA_SMB_BCNT);
> > -			if (read_write = I2C_SMBUS_WRITE)
> > -				for (i = 0; i < len; i++)
> > -					outb_p(data->block[i + 1], NVIDIA_SMB_DATA+i);
> > -			protocol |= NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA;
> > -			break;
>
> Are you sure this transaction type isn't supported? That's a useful one
> to access EEPROMs, and given that NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA
> exists, it would seem that the chip does support it. What makes you
> think otherwise? Isn't it simply a matter of advertising it, as for the
> SMBus block transactions?
>

I have to admit, I do not know whether NVIDIA_SMB_PRTCL_I2C_BLOCK_DATA is 
supported. However, I have only limited possibilities to check the 
functionality of the SMBus host controller, and the eeprom on my nforce4 
board did not react any more when I tried to read data via i2cdump in i2c 
block data mode. Therefore I consider this function as very experimental for 
the moment. Maybe I just tried the function on the wrong i2c chip or using 
the wrong tool.
Do you know or have other tools that may be useful in testing the capability 
of i2c bus hosts and chips?
As soon as I am able to confirm that i2c block data or other functions do 
really work I will of course add again the code (and advertise it as well).

> > @@ -291,7 +256,7 @@ static int __devinit nforce2_probe_smb (
> >  		}
> >
> >  		smbus->base = iobase & PCI_BASE_ADDRESS_IO_MASK;
> > -		smbus->size = 8;
> > +		smbus->size = 64;
> >  	}
> >  	smbus->dev = dev;
>
> Your summary didn't mention this change. It looks like a bug fix to me,
> rather than a simple cleanup. We were previously reserving only 8 I/O
> addresses while the highest offset we access is 0x24 so we should have
> been reserving at least 37 bytes. 64 sounds sane.
>
I confess, this is really a bug fix and I forgot to mention it.
I chose 64 for the I/O window size because
a) it is big enough to cover the currently addressed I/O range
b) on all nforce2/3/4 boards that I have checked the SMBus I/O addresses are 
64 apart, so it is sort of a "substantiated guess".

> Thanks,
Thanks as well for your constructive comments.

-- 
--
Hans-Frieder Vogt                 e-mail: hfvogt <at> arcor .dot. de
                                          hfvogt <at> gmx .dot. net

