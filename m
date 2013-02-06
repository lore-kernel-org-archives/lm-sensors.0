From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Feb 2013 13:42:50 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130206144250.38b2c22d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Feb 2013 13:12:54 +0100 (CET), Dag Wieers wrote:
> On Wed, 6 Feb 2013, Jean Delvare wrote:
> 
> > The risk is relatively low, but it exists. If you want to make it as
> > low as possible, you can start with:
> >
> > # i2cget 0 0x48
> >
> > This will read the presumed internal pointer value from the chip. Write
> > down the value for future use. I'll call in $v below. Then try a single
> > register read:
> >
> > # i2cget 0 0x48 $v
> >
> > If it returns $v again, and $v is neither 0x00 nor 0xff, you better
> > leave the chip alone, and cold boot the machine (just in case.) In
> > other cases, the chip seem to behave normally and you can go with:
> >
> > # i2cdump 0 0x48 b
> 
> So here we go:
> 
> root ~ # i2cget 0 0x48
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will read from device file /dev/i2c-0, chip address 0x48, current data
> address, using read byte.
> Continue? [Y/n]
> 0x3f
> 
> root ~ # i2cget 0 0x48 0x3f
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will read from device file /dev/i2c-0, chip address 0x48, data address
> 0x3f, using read byte data.
> Continue? [Y/n]
> Error: Read failed

Not good. This can mean one of two things: either the chip has no
register 0x3f and it nacks non-existent register read attempts, or it
doesn't support SMBus read byte transactions at all. In the latter
case, I strongly suggest that you leave the chip alone. As for the
former case, there are a few thermal sensor chips which behave like,
don't have a register at 0x3f and can use slave address 0x48: DS1621
and similar, DS75, LM73.

Please try "i2cget 0 0x48" multiple times and see if it always returns
the same value.

> root ~ # i2cget 0 0x48 b
> Error: Data address invalid!
> Usage: i2cget [-f] [-y] I2CBUS CHIP-ADDRESS [DATA-ADDRESS [MODE]]
>    I2CBUS is an integer or an I2C bus name
>    ADDRESS is an integer (0x03 - 0x77)
>    MODE is one of:
>      b (read byte data, default)
>      w (read word data)
>      c (write byte/read byte)
>      Append p for SMBus PEC

The right command here was i2cdump, not i2cget. But given the results
of the previous command, it's probably a good thing that you got it
wrong. Don't do it (yet.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
