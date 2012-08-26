From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 26 Aug 2012 17:47:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm70: adding support for NS LM74 chip
Message-Id: <20120826174721.GA32334@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208231532.q7NFWCQZ023407@localhost.localdomain>
 <20120823181317.GA5623@roeck-us.net>
In-Reply-To: <20120823181317.GA5623@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Thu, Aug 23, 2012 at 11:13:17AM -0700, Guenter Roeck wrote:
> On Thu, Aug 23, 2012 at 05:32:12PM +0200, Christophe Leroy wrote:
> > Hello,
> > 
> Hi Christophe,
> 
Hi again,

[ ... ]

> >  
> > -	/* 3-wire link (shared SI/SO) for LM70 */
> > -	if (chip = LM70_CHIP_LM70 && !(spi->mode & SPI_3WIRE))
> > +	/* 3-wire link (shared SI/SO) for LM70 and LM74 */
> > +	if ((chip = LM70_CHIP_LM70 || chip = LM70_CHIP_LM74)
> > +			&& !(spi->mode & SPI_3WIRE))
> 
> Ok for now, but I'll have to check this. The driver does not really write
> anything to the chip, so it should be irrelevant which mode the SPI master
> controller supports (MOSI does not have to be connected). Besides, from the
> chip specification it looks like it is possible to connect the chip to a
> standard SPI interface by adding a 10k resistor between MOSI and MISO.
> 
After looking into the above, the proper change or fix is really to remove the
above check for SPI_3WIRE entirely. The driver works perfectly fine if a LM70 is
connected to a controller which does not explicitly support SPI_3WIRE; all that
needs to be done is to connect MOSI through a resistor or not at all. This is,
however, a board design decision, not a SPI master chip limitation.

With that, we don't need to explicitly add any LM74 specific code to the driver,
since the TMP121 code does the trick. All we need to do is to update the
documentation, adding a note that LM74 is supported as well, and that it can be
selected with 'tmp121'.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
