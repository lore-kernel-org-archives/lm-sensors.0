From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 23 Apr 2007 14:14:28 +0000
Subject: Re: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <20070423161428.4dd1c8ca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F47B44.8010108@assembler.cz>
In-Reply-To: <45F47B44.8010108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

Sorry for the late answer,

On Thu, 29 Mar 2007 00:30:55 -0700, David Hubbard wrote:
> > I suggest adding warning messages when the base I/O isn't set and when
> > we need to forcibly enable the device, as I did in the w83627hf driver.
> > This will make support easier.
> 
> I'm not clear on which part of the w83627hf driver does this. I can't
> find the patch in the mail archives that converts w83627hf to a
> platform driver, but I think this is the section of code
> (pre-platform-driver) that you're talking about: w83627hf.c lines
> 1399-1403:
>         /* Minimize conflicts with other winbond i2c-only clients...  */
>         /* disable i2c subclients... how to disable main i2c client?? */
>         /* force i2c address to relatively uncommon address */
>         w83627hf_write_value(client, W83781D_REG_I2C_SUBADDR, 0x89);
>         w83627hf_write_value(client, W83781D_REG_I2C_ADDR, force_i2c);
> 
> Let's make the "forcibly enable the device" a separate patch.

No, what I was referring to is something completely different:

static int __init w83627ehf_find(int sioaddr, unsigned short *addr)
{
	(...)
	/* Activate logical device if needed */
	val = superio_inb(SIO_REG_ENABLE);
	if (!(val & 0x01))
		superio_outb(SIO_REG_ENABLE, val | 0x01);
	(...)
}

Here we enable the device if we found it was disabled. My experience is
that Super-I/O logical devices which aren't enabled by the BIOS are
typically not meant to be used, they aren't wired properly. So the
least we can do if we have to enable it is to log it to serve as a hint
for users if the sensors readings don't make sense. The w83627hf driver
does this.

But I do agree that this isn't related to the platform driver
conversion and should be added in a different patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
