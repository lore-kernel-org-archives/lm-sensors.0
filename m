From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Fri, 18 Dec 2009 16:36:16 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: add INA209 driver
Message-Id: <20091218163616.GA20523@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090820214925.GC16733@ovro.caltech.edu>
In-Reply-To: <20090820214925.GC16733@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Dec 18, 2009 at 09:37:51AM +0100, Jean Delvare wrote:
> Hi Ira,
> 
> On Wed, 16 Dec 2009 12:55:12 -0800, Ira W. Snyder wrote:
> > On Thu, Aug 20, 2009 at 02:49:25PM -0700, Ira W. Snyder wrote:
> > > Add Linux support for the TI / Burr-Brown INA209 voltage / current / power
> > > monitor I2C interface.
> > 
> > Can someone please take a look at this and see if it OK for mainline, or
> > if there are other changes that would be required. I'd like to stop
> > maintaining it out of tree. I'm just checking to make sure that this
> > patch didn't get forgotten, since I haven't gotten any feedback at all.
> 
> I think I tried reviewing your code a couple times in the past. The
> problem is that your driver doesn't quite fit in the hwmon subsystem,
> so I just don't know what to do with it.
> 
> Your driver is not using the standard unit for in0, it is reporting a
> fake power1 just to let user-space compute it by itself, the unit used
> for curr1 looks suspicious as well. No other driver dared do the same.
> The whole "needs calibration factors" thing is pretty uncommon. Either
> the hwmon subsystem and/or libsensors need to be extended to support
> that kind of thing, or your driver simply doesn't belong there. Maybe
> the upcoming industrial I/O subsystem would be more appropriate, I
> don't know.
> 
> In the absence of a maintainer for the hwmon subsystem, it's pretty
> hard to get that kind of different hardware support merged. It would
> require decisions that it seems nobody wants to take, whatever the
> reason. So I fear you're pretty much stuck for now, sorry.
> 

No problem, I can live with maintaining it out of tree for now. I'd
appreciate if you'd read over my rationale for doing things this way,
though.

1) using uV instead of mV for inX_input readings

The chip is more sensitive than mV, and I found during testing that it
made a big difference to report the values in uV instead. It made the
current calculations much more accurate.

This also follows the "rule of thumb" in Documentation/sysfs-interface,
the "in[0-*]_input" section. It says "drivers should report the voltage
values at the pins of the chip", and "values must be scaled by the
application" (AKA libsensors). Also see the second paragraph of the same
document: "since the values of these resistors can change from
motherboard to motherboard, the conversions cannot be hardcoded into the
driver and have to be done in userspace".

I'd guess that the choice of mV was just used because that is the best
any known chip could do at the time hwmon was invented. Now we've found
a more accurate chip. Rather than change every hwmon driver and the
userspace ABI (a big no-no), I used libsensors to do it.

2) the calibration register / power + current readings

This is a hardware detail. To get the chip to calculate current and
power for you, you must program it correctly for your circuit, using the
actual value of the sense resistor. In the interests of getting the
driver merged, I removed it and used libsensors to calculate current and
power instead. This is just the I=V/R formula (Ohm's law). The
calibration register is not used by the driver anymore (and doesn't show
up in /sys).

I reported the "voltage at the pins of the chip" and used my knowledge
of the circuit (the sense resistor value) to have libsensors handle the
conversion. At least from my point of view, this is the same rule of
thumb mentioned above.

Likewise for power, I used the P=I*V equation to get power. Libsensors
already has the current from the above equation, so just multiply by
voltage.

The chip's documentation explains how the calibration register value is
used internally to calculate current and power using the voltage
reading. I just moved the calculation to userspace to make the driver
fit the hwmon interface better.

Thanks for reading,
Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
