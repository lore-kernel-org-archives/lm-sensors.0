From: David Brownell <david-b@pacbell.net>
Date: Wed, 03 Oct 2007 19:23:31 +0000
Subject: Re: [lm-sensors] [patch lm-sensors 2.10.4] i2cdetect mislabels PEC
Message-Id: <20071003192332.53BBC2393FA@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070917205024.0A35D230DBC@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Rename I2C_FUNC_SMBUS_HWPEC_CALC as I2C_FUNC_SMBUS_PEC, and list that
> > functionality as always available through the software implementation.
> > Update documentation accordingly (and list similar requirements).
> > 
> > The way it's currently packaged doesn't present the capability in a
> > useful way.  Basically, it's always available -- except when the I2C
> > stack is running on SMBus hardware without PEC support in hardware.
>
> Actually, except when the driver does not support it (drivers could lack
> PEC support while the hardware can do it.)

Fair enough, although that's not very distinguishable from the
case of no hardware support.  Feel free to update that part of
the patch comment appropriately.

> >  
> >  ioctl(file,I2C_TENBIT,long select)
> >    Selects ten bit addresses if select not equals 0, selects normal 7 bit
> > -  addresses if select equals 0. Default 0.
> > +  addresses if select equals 0. Default 0.  This request is only valid
> > +  if the adapter has I2C_FUNC_10BIT_ADDR.
> >  
> >  ioctl(file,I2C_PEC,long select)
> >    Selects SMBus PEC (packet error checking) generation and verification
> >    if select not equals 0, disables if select equals 0. Default 0.
> > -  Used only for SMBus transactions.
> > +  Used only for SMBus transactions; only valid if the adapter has
> > +  I2C_FUNC_SMBUS_PEC.
>
> Not correct. PEC being optional, chip drivers (or i2c-dev users) can
> declare themselves PEC-compliant and let the adapter driver decide
> whether it can actually do PEC or not. This is the right way to do it.
> So a better wording would be "only has an effect if..."

Depends on what you mean by "valid"; from my perspective,
it's not valid without efficacy.  That happens to be part
of the first definition in my handy dictionary.
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
