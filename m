From: David Brownell <david-b@pacbell.net>
Date: Thu, 27 Sep 2007 20:37:09 +0000
Subject: Re: [lm-sensors] [patch 2.6.23-rc8 1/3] lm75: cleanups (no
Message-Id: <20070927203709.7063D239914@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925051533.38DF9239408@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
In-Reply-To: <20070925051533.38DF9239408@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Minor cleanup and reorg of the lm75 code.
> > 
> >  - Kconfig provides a larger list of lm75-compatible chips, which
> >    should help people avoid writing Yet Another LM75 Driver.
> > 
> >  - A top comment now says what the driver does (!) ... as in, just
> >    what kind of sensor is this??
> > 
> >  - Section comments now delineate the various sections of the driver:
> >    hwmon attributes, driver binding, register access, module glue.
> >    One driver binding function moved out of the attribute section,
> >    as did the driver struct itself.
> > 
> >  - Minor tweaks to legacy probe logic:  correct a comment, and
> >    remove a pointless variable.
>
> That variable and the seemingly useless construct around it were there
> for the day we would add more "kinds" to the driver. Each kind has its
> own prefix and possibly its own behavior, and can be either detected or
> forced using a module parameter. Your change removes this possibility.

Only for legacy style drivers.  It's there in full force for
driver-model conformant systems.  And I don't much like the
idea of paying for such stuff with an ever-increasing data
footprint, which is how the I2C_CLIENT_INSMOD_*() macros do
such stuff.

... Although this doesn't try to use the oneshot mode supported
by various TI parts, which saves power by not using continuous
conversion.  That's well suited to cases where the overtemperature
output is used neither as an IRQ nor as a fan control.


> Admittedly, we did not use it for years, but I find it strange that you
> decide to clean this up at the exact same moment you add support for
> more variants of the chip with additional features (12-bit resolution,
> etc.) which precisely could lead us to add new kinds.

See above.  Note also that systems trying to use overtemperature
interrupts can't work very well with legacy driver binding either.
New-style driver binding provides enough system configuration hooks
to use either directly connected IRQs, or shared SMBALERT# signals
(with TI parts).


> >  - Remove assignment of driver.id = I2C_DRIVERID_LM75.  Such values
> >    are unused and pointless.
>
> True, but then you have to remove its definition from
> include/linux/i2c-id.h as well, otherwise potential out-of-tree users
> won't have a chance to notice the change.

Done.


> > @@ -30,14 +30,19 @@
> >  #include "lm75.h"
> >  
> >  
> > -/* Addresses to scan */
> > +/*
> > + * This driver handles the LM75 and compatible digital temperature sensors.
> > + * Compatibles include at least the DS75, DS1775, LM75, MCP980x, STDS75,
>
> I am glad to learn that the LM75 is compatible with itself ;)

Yes, it does suck when radical chip revisions don't get new
part numbering.  ;)


> > + * TCN75, TMP100, TMP101, TMP75, TMP175, and TMP275.
> > + */
> > +
> > +/* Addresses scanned by legacy style driver binding */
> >  static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
> >  					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
> >  
> > -/* Insmod parameters */
> > +/* Insmod parameters (only for legacy style driver binding) */
>
> Strictly speaking, this comment and similar ones belong to the next
> patch, as there's no other binding style in this driver for now.

Nonetheless, it's strictly correct.  :)


> > +	/* OK. For now, we presume we have a valid address. We create the
> > +	   client structure, even though there may be no sensor present.
> >  	   But it allows us to access lm75_{read,write}_value. */
>
> Can you please fix this last comment as well? We don't use
> lm75_{read,write}_value at this point but
> i2c_smbus_read_{byte,word}_data.

Done.


> >  	/* Fill in the remaining client fields and put it into the global list */
> > -	strlcpy(new_client->name, name, I2C_NAME_SIZE);
> >  	data->valid = 0;
>
> This one can go away, as data has been kzalloc'ed.

It does go away -- in the next patch.


> >  /* All registers are word-sized, except for the configuration register.
> >     LM75 uses a high-byte first convention, which is exactly opposite to
> >     the usual practice. */
>
> This comment could be fixed as well: high-byte first _is_ the usual
> practice, even though the SMBus specification says low-byte first.

Done; I also removed its duplicate sibling.


Updated patch to follow.

- Dave


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
