From: max@semandex.net (Maximilian Ott)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: Address problems with 'i2cset'
Message-Id: <200501251911.j0PJBtKW019784@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501250306.j0P36PKW029120@Stimpy.netroedge.com>
In-Reply-To: <200501250306.j0P36PKW029120@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks,

Yes, the last bit is the R/W bit and I wasn't aware that I don't need to
include that. I guess that's what the "set" in "i2cset" does :)

Will try tonight.

Thanks again,

-max
 

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org] 
> Sent: Tuesday, January 25, 2005 3:22 AM
> To: max@semandex.net; sensors@Stimpy.netroedge.com
> Subject: Re: Address problems with 'i2cset'
> 
> 
> Hi Maxililian,
> 
> > I have a I2C chip with address 0xC0 and when I try to issue:
> >
> > % i2cset 0 0xC0 0x44 0x55
> >
> > It complaints about "wrong address", or something similar 
> (sorry I don't
> > have the system available right now). Is this some safety 
> check to protect
> > the clueless (certainly qualify for that).
> 
> 0xC0 doesn't fit on 7 bits, and I2C addresses supposedly are 
> 7 bit wide
> (let alone the 10-bit addressing expansion we do not 
> currently support).
> 
> I suspect that 0xC0 isn't exactly the chip address but the 
> first byte of
> an I2C or SMBus transaction. The first byte is made of the 7 
> bits of the
> address + 1 bit for read or write, so the address of the chip would be
> 0xC0 >> 1 = 0x60.
> 
> You could try to confirm this with the following command:
> 
> % i2cdetect 0
> 
> If I am correct it will reveal a chip at address 0x60. If it does, you
> can then try:
> 
> % i2cset 0 0x60 0x44 0x55
> 
> Which should do just what you wanted to do.
> 
> --
> Jean Delvare
> 
