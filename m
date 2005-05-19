From: dsaxena@plexity.net (Deepak Saxena)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH 2.6] Add support for Intel IXP42x GPIO-based I2C
Message-Id: <20040215190509.GA13612@plexity.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040213235906.GA5551@plexity.net>
In-Reply-To: <20040213235906.GA5551@plexity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Feb 14 2004, at 09:28, Jean Delvare was caught saying:
> > The following patch against Linus' BK tree adds a driver for using
> > GPIO pins on Intel's IXP42x ARM SOCs for an I2C interface.  
> > 
> > Tnx,
> > ~Deepak
> 
> See my comments inline.
> 
> > +/*
> > + * drivers/i2c/i2c-adap-ixp425.c
> 
> Doesn't match the actual filename and module name advertised above.

Will fix

> > +
> > +#include <linux/config.h>
> 
> Please insert the usual 3 lines debug stuff here (see other bus drivers).

Will fix.

> > +#include <linux/i2c-id.h>
> 
> You do not need to include this, i2c.h includes it for you.
> 

Will fix.

> > +}
> > +
> 
> Where are these gpio_line_* functions defined? and the IXP425_GPIO_*
> constants?

<include/asm-arm/arch-ixp425/hardware.h> which is 
included by the file <include/asm-arm/hardware.h>. These definitions
need to be in a location that is shared by various IXP425-specific
drivers.

> > (...)
> > +MODULE_DESCRIPTION("GPIO-based I2C adapter for IXP425 systems");
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Deepak Saxena<dsaxena@plexity.net>");
> 
> Missing space between name and address.

Will fix.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
