From: ppokorny@penguincomputing.com (ppokorny@penguincomputing.com)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: Sensors driver for Xeon(Pentium 4) thermal sensor
Message-Id: <1022687939.3cf4fac3511f4@hermes.penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3CF3C3CB.1040403@penguincomputing.com>
In-Reply-To: <3CF3C3CB.1040403@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the reply...

Quoting Mark Studebaker <mds@paradyne.com>:

> Right now we claim that the adm1021 driver works for the xeon, except
> that it only has
> one sensor instead of two, and requires a force_adm1021 parameter.
> Not that we've tested it. Would you please?

I guess I can try...  I'll look at the source code as well.

> If true, I don't know if it would be better to hack adm1021 to remove
> the
> second sensor for xeons, or to keep your separate driver.
> As you have good detection (that I hope won't detect the adm1021
> series)
> it's probably better to keep it separate.
> 
> After you go through doc/developers/new_drivers you will probably have
> an updated patch. A patch against CVS would be best.

I guess I'll have to read new_drivers now...

> chips.c is in lib/

I did the development against Red Hat's bundled lm_sensors in the 7.3 kernel
(2.4.18-4)  Don't know how out of date with respect to CVS that is...

Guess I need to go setup CVS tree and do a merge...  OK.

> Philip Pokorny wrote:
> > 
> > The thermal diode on the Pentium III processors has been replaced by
> an
> > SMBus device to monitor and convert the diode to degrees C in the
> > Pentium 4 (Xeon) processors.
> > 
> > This Thermal Sensors is documented in the processor datasheet and I
> have
> > written a driver to report the temperature, high and low limits, and
> the
> > conversion rate.
> > 
> > I had to hack the i2c-i801 driver to recognize the intel 7500
> xx801CA
> > chip.  I think that fix might already be in the mainline sources.
> > 
> > I have assigned myself a "production" ID in i2c-ids.h.  If that ID
> has
> > already been assigned, please assign me a new one and I'll redo the
> > patch.  (Didn't read doc/writing-drivers until after I'd
> finished...)
> > 
> > I don't have the chips.c file that goes into 'sensors', so I haven't
> > been able to add the 'temp', 'temp_over', and 'temp_hyst' parameters
> to
> > sensors and sensors.conf.
> > 
> > Please let me know what I need to do to submit this patch to the
> > main-line lm-sensors code.
> > 
> > Thanks,
> > :v)
> > 
> > --
> > Philip Pokorny, Senior Engineer
> > Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
> > PENGUIN COMPUTING - Simplifying the Solution Process [tm]
> > www.penguincomputing.com
> >
> 
> 
