From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Tue, 16 Sep 2008 05:01:19 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: TI TMP121 SPI temperature
Message-Id: <20080916050119.GA14613@roarinelk.homelinux.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Good Morning Jean,

On Mon, Sep 15, 2008 at 11:50:51PM +0200, Jean Delvare wrote:
> Hi Manuel,
> 
> Le lundi 15 septembre 2008, Manuel Lauss a ?crit?:
> > Driver for the Texas Instruments TMP121/TMP123 SPI temperature sensors.
> > The code is 99% identical to the LM70 driver;  only the formula to
> > calculate the temperature (in 1/1000 deg celsius) has been adjusted.
> > 
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> > ---
> >  drivers/hwmon/Kconfig  |   10 +++
> >  drivers/hwmon/Makefile |    1 +
> >  drivers/hwmon/tmp121.c |  168 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 179 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/hwmon/tmp121.c
> 
> Wouldn't it make more sense to just add support for the TMP121/TMP123
> chips to the lm70 driver? Duplicating code is better avoided when
> possible. Thankfully these drivers are relatively small, but still...

I can do that, sure.  New patch in the works.

 
> > --- /dev/null
> > +++ b/drivers/hwmon/tmp121.c
> > (...)
> > +	/*
> > +	 * The "raw" temperature read into rxbuf[] is a 16-bit signed 2's
> > +	 * complement value. Only the MSB 13 bits (1 sign + 12 temperature
> > +	 * bits) are meaningful; the LSB 3 bits are to be discarded.
> > +	 * Each bit represents 0.0625 degrees Celsius.
> > +	 */
> > +	val = (raw * 625) / 80;
> 
> This does not actually discard the 3 LSB. In order to do that, you
> would need to write the following:
> 
> 	val = (raw / 8) * 625 / 10;

Don't drink and code... (the lower 3 bits read back as zero, so I used the
cheap equation).

Thank you!
	Manuel Lauss

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
