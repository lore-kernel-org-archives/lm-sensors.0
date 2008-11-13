From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Nov 2008 09:34:53 +0000
Subject: Re: [lm-sensors] [PATCH] SPI lm70: Code streamlining and cleanup
Message-Id: <20081113103453.215df73c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1226474799.18411.21.camel@kaiwan-1>
In-Reply-To: <1226474799.18411.21.camel@kaiwan-1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kaiwan,

On Thu, 13 Nov 2008 10:53:58 +0530, Kaiwan N Billimoria wrote:
> On Wed, 2008-11-12 at 14:25 +0100, Jean Delvare wrote:
> > > --- a/Documentation/spi/spi-lm70llp	2008-10-10 03:43:53.000000000 +0530
> > > +++ b/Documentation/spi/spi-lm70llp	2008-11-12 12:13:50.000000000 +0530
> > > @@ -13,10 +13,19 @@ Description
> > >  This driver provides glue code connecting a National Semiconductor LM70 LLP
> > >  temperature sensor evaluation board to the kernel's SPI core subsystem.
> > >  
> > > +This is an SPI master controller driver. It can be used in conjunction with 
> > > +(layered under) the LM70 logical driver (an "SPI protocol driver").
> > >  In effect, this driver turns the parallel port interface on the eval board
> > >  into a SPI bus with a single device, which will be driven by the generic
> > >  LM70 driver (drivers/hwmon/lm70.c).
> > >  
> > > +
> > > +Hardware Interfacing
> > > +--------------------
> > > +The schematic for this particular board (the LM70LLP eval board) is 
> > > +available (on page 4) here:
> > > +http://www.designergraphix.com/pull/spi_lm70/LM70LLPEVALmanual.pdf
> > > +
> > >  The hardware interfacing on the LM70 LLP eval board is as follows:
> > >  
> > >     Parallel                 LM70 LLP
> > > @@ -67,3 +76,4 @@ Thanks to
> > >  o David Brownell for mentoring the SPI-side driver development.
> > >  o Dr.Craig Hollabaugh for the (early) "manual" bitbanging driver version.
> > >  o Nadir Billimoria for help interpreting the circuit schematic.
> > > +
> > 
> > Pointless change, should be reverted.
> 
> Sorry I do not follow you..which part are you referring to as pointless?
> IMHO, the schematic PDF download is important for anyone trying to
> understand the 'physical' driver.

The change I was referring to is: adding a blank line at the end of the
file. I have no objection to the other ("real") changes!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
