From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Apr 2011 15:25:27 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for MAX16065/MAX16066 System
Message-Id: <20110406172527.74b6ec23@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300851783-13583-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1300851783-13583-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 4 Apr 2011 09:27:26 -0700, Guenter Roeck wrote:
> On Sun, Apr 03, 2011 at 08:39:40AM -0400, Jean Delvare wrote:
> > On Tue, 22 Mar 2011 20:43:03 -0700, Guenter Roeck wrote:
> > > +
> > > +curr1_input          Current sense input; only if current sensing is enabled
> > > +                     Displayed current assumes 0.001 Ohm current sense
> > > +                     resistor.
> > > +curr1_alarm          Overcurrent alarm
> > 
> > I'm a little worried about the "assumes 0.001 Ohm (...) resistor".
> > Resistors which are external to the chip are normally handled by
> > user-space. I understand this is a different case from scaling
> > resistor pairs for voltage inputs, but it still feels wrong to assume an
> > arbitrary resistor value in the driver. Where does the value come from,
> > BTW? I couldn't find it in the datasheet.
> > 
> I have to say the datasheet isn't really easy to read ;).
> 
> Only reason for assuming 0.001 Ohm is that makes adjustments via sensors.conf
> easier than, say, 0.005 Ohm or 0.002 Ohm.

I guessed so.

> The ADC_TO_CURR() calculation is derived from information found in the datasheet,
> which I confirmed with the current sense voltage readings on my test board.
> 
> > But I also have to admit that we do not have the needed code in place
> > yet to handle it differently. This is similar to the problems described
> > in:
> >   http://www.lm-sensors.org/ticket/2258
> > 
> > I have another possible implementation idea, I'll post about it
> > separately for public discussion.

Still on my to-do list, sorry.

> Problem is that currents are always measured as voltages, and thus depend on
> the series resistor value. I have been hitting the same problem with other
> chips supporting current measurements. See the ltc4151 and ltc4261 drivers
> for examples.

We could imagine chips with an embedded series resistor, so no external
resistor is needed. Voltage input scaling has both flavors, and I fail
to see why it wouldn't work for current monitoring.

> My solution so far is to assume a specific series resistor, and let userspace deal
> with adjustments via sensors.conf.
> 
> Another option would might be to add platform data for each of the affected chips.
> Would that make sense ? But even then I would need a default value in case there is
> no platform data.

You could make platform data mandatory for these chips, or at least for
their current monitoring feature.

> [ ... ]
> > 
> > I couldn't find in the datasheet any guarantee that the MSB and the LSB
> > belong to the same measurement, but I admit I didn't read it too
> > carefully. Is this the case?
> > 
> No, or at least I did not find it either. Turns out, however, that I can use
> 16 bit reads since the chip auto-increments the address. I'll do that instead.

I was curious about that, but not seeing any mention of it in the
datasheet (which otherwise looks quite complete) I thought it wasn't
supported.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
