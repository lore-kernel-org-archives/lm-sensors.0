From: Chris Verges <kg4ysn@gmail.com>
Date: Mon, 28 Oct 2013 18:48:46 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: lm73: reset device during lm73_probe()
Message-Id: <20131028184846.GA31037@cverges-dev-lnx.sentient-energy.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
In-Reply-To: <1382976305-3625-1-git-send-email-kg4ysn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 28, 2013 at 10:35:18AM -0700, Guenter Roeck wrote:
> On Mon, Oct 28, 2013 at 09:05:05AM -0700, Chris Verges wrote:
> > The LM73 datasheet recommends resetting the sensor at power-up to
> > avoid certain VDD ramp-up problems.  The full sequence and rationale
> > is described in the LM73 datasheet, May 2009 revision, page 19,
> > section "Power Supply Ramp-Up Considerations."
> 
> common assumption is that the chip is enabled and pre-configured by
> the BIOS or ROMMON.  If so, this code is unnecessary and just adds
> 100+ ms to the system boot time for each LM73 sensor. I don't think
> that would be a good idea.
> 
> The datasheet says "... In systems where there is a large amount of
> capacitance on the VDD node, the LM73 power supply ramp-up time can
> become excessively long", which is defined as "A linear power-on-ramp
> of less than 0.7V/msec and an exponential ramp with an RC time
> constant of more than 1.25 msec is categorized as a slow power-supply
> ramp". The soft-reset is only required if this is the case.
> 
> Are there indications that this condition is actually seen on real
> hardware, and not taken care of by the BIOS/ROMMON?

Yes, I encountered this problem on an embedded system and discovered the
note in the datasheet as part of the debugging of that problem.  The
LM73 started returning random, sporadic temperature readings as a result
of VDD being ramped too slowly.  The app note's tone makes the
recommendation sound like the TI-preferred methodology of device
initialization for guaranteed behavior, and so modifying the probe()
directly seemed like a better choice than relying on the user to know to
enable this functionality via module params, platform data, or
devicetree properties.

> > +	value &= ~(3 << 0); /* always clear bits 1:0 */
> > +	value |= (1 << 6);  /* always set bit 6 */
> > +
> You are using BIT() above, making this inconsistent.

Outstanding, I'll update to use BIT().

> > +	dev_dbg(&client->dev, "%s: powering down the sensor\n",
> > +		dev_name(hwmon_dev));
> 
> Kind of redundant to use dev_err and then display the device name
> again.  Same below. Besides, I don't think the debug messages provide
> real value.

This was for me to do some debugging.  I'll remove it.

> > +	value |= LM73_CONF_PD_MASK;
> > +	err = i2c_smbus_write_byte_data(client, LM73_REG_CONF, value);
> > +	if (err < 0)
> > +		goto reset_error;
> > +
> > +	mdelay(LM73_MIN_RESET_TIME_MS);
> > +
> Datasheet says one has to wait for the conversion time, which depends
> on the configured resolution. This means that, most of the time, you
> are waiting way too long here - especially in the presumed context
> that the chip has not been initialized by the ROMMON/BIOS.

Agreed, this could be an optimization made later if someone wanted to
implement a look-up table.  The theoretical delta would be 15 msec in
11-bit mode versus 115 msec in 14-bit mode.  I'd prefer to not rely on
the device being in 11-bit mode for an initial release of the changeset,
however, as the module loading/unloading methodology could also be used
at runtime to reset a system.

> > +	/* Reset the device */
> > +	status = lm73_soft_reset(client);
> > +
> What exactly is the point of returning status ...

For me to print an error message that wasn't implemented.  Good catch.
I'll update as part of the revised patch.

Many thanks!
Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
