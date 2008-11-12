From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Nov 2008 13:25:56 +0000
Subject: Re: [lm-sensors] [PATCH] SPI lm70: Code streamlining and cleanup
Message-Id: <20081112142556.6687f8f6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1226474799.18411.21.camel@kaiwan-1>
In-Reply-To: <1226474799.18411.21.camel@kaiwan-1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Nov 2008 13:48:30 +0530, Kaiwan N Billimoria wrote:
> On Tue, 2008-11-11 at 23:59 -0800, David Brownell wrote:
> > On Tuesday 11 November 2008, Kaiwan N Billimoria wrote:
> > > +As a real (in-tree) example of this "logical SPI protocol driver"
> > > interfacing
> > > +with a "physical SPI master controller" driver, see
> > > drivers/spi/spi_lm70llp 
> > > +and it's associated documentation.
> > 
> > This patch arrived badly word wrapped.  Could you resend?
> > Attachment is OK.
> 
> Sigh. sorry..
> 
> Pl find the patch attached.

David, can we get this patch reviewed and pushed upstream quickly? So
that I can finally take Manuel's patch adding support for the TMP121.

Alternatively, I can take this patch in my hwmon tree after it has been
reviewed.

My own review, for the parts I can comment on:

> diff -uprN -X a/Documentation/dontdiff a/Documentation/hwmon/lm70 b/Documentation/hwmon/lm70
> --- a/Documentation/hwmon/lm70	2008-10-10 03:43:53.000000000 +0530
> +++ b/Documentation/hwmon/lm70	2008-11-12 12:17:21.000000000 +0530
> @@ -25,6 +25,10 @@ complement digital temperature (sent via
>  driver for interpretation. This driver makes use of the kernel's in-core
>  SPI support.
>  
> +As a real (in-tree) example of this "logical SPI protocol driver" interfacing
> +with a "physical SPI master controller" driver, see drivers/spi/spi_lm70llp 
> +and it's associated documentation.

Spelling: its.

> +
>  Thanks to
>  ---------
>  Jean Delvare <khali@linux-fr.org> for mentoring the hwmon-side driver
> diff -uprN -X a/Documentation/dontdiff a/Documentation/spi/spi-lm70llp b/Documentation/spi/spi-lm70llp
> --- a/Documentation/spi/spi-lm70llp	2008-10-10 03:43:53.000000000 +0530
> +++ b/Documentation/spi/spi-lm70llp	2008-11-12 12:13:50.000000000 +0530
> @@ -13,10 +13,19 @@ Description
>  This driver provides glue code connecting a National Semiconductor LM70 LLP
>  temperature sensor evaluation board to the kernel's SPI core subsystem.
>  
> +This is an SPI master controller driver. It can be used in conjunction with 
> +(layered under) the LM70 logical driver (an "SPI protocol driver").
>  In effect, this driver turns the parallel port interface on the eval board
>  into a SPI bus with a single device, which will be driven by the generic
>  LM70 driver (drivers/hwmon/lm70.c).
>  
> +
> +Hardware Interfacing
> +--------------------
> +The schematic for this particular board (the LM70LLP eval board) is 
> +available (on page 4) here:
> +http://www.designergraphix.com/pull/spi_lm70/LM70LLPEVALmanual.pdf
> +
>  The hardware interfacing on the LM70 LLP eval board is as follows:
>  
>     Parallel                 LM70 LLP
> @@ -67,3 +76,4 @@ Thanks to
>  o David Brownell for mentoring the SPI-side driver development.
>  o Dr.Craig Hollabaugh for the (early) "manual" bitbanging driver version.
>  o Nadir Billimoria for help interpreting the circuit schematic.
> +

Pointless change, should be reverted.

> diff -uprN -X a/Documentation/dontdiff a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
> --- a/drivers/hwmon/lm70.c	2008-10-10 03:43:53.000000000 +0530
> +++ b/drivers/hwmon/lm70.c	2008-11-12 12:18:34.000000000 +0530
> @@ -65,10 +65,9 @@ static ssize_t lm70_sense_temp(struct de
>  		"spi_write_then_read failed with status %d\n", status);
>  		goto out;
>  	}
> -	dev_dbg(dev, "rxbuf[1] : 0x%x rxbuf[0] : 0x%x\n", rxbuf[1], rxbuf[0]);
> -
> -	raw = (rxbuf[1] << 8) + rxbuf[0];
> -	dev_dbg(dev, "raw=0x%x\n", raw);
> +	raw = (rxbuf[0] << 8) + rxbuf[1];
> +	dev_dbg(dev, "rxbuf[0] : 0x%x rxbuf[1] : 0x%x raw=0x%08x\n", 

raw is a s16, it makes little sense to print 8 digits. Should be:
0x%04x.

> +		rxbuf[0], rxbuf[1], raw);
>  
>  	/*
>  	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
