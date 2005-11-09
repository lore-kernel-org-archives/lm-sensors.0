From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 09 Nov 2005 13:03:40 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <XpvH0KKX.1131537027.6043510.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Roger,

On 2005-11-07, Roger Lucas wrote:
> Attached is revision 3 of the VT8231 driver.  There are a LOT of changes
> to implement your suggestions.  Some of these break compatibility with
> older vt8231 driver releases as follows:

I'll not review that code as you have posted r4 since, but I still would
like to answer the various points you make.

> tempX sequence
> Temperatures are now measured temp0,temp1,temp2,etc.  This causes the
> "sensors" user-space program to fail with errors as it expects the older
> temperature numbering sequence.

No. As per Documentation/hwmon/sysfs-interface, temperature numbering
starts at 1. You can't use temp0.

I would usually object to renumbering because it breaks comptibility with
the 2.4 driver and libsensors, but it starts being obvious that we will
have to break compatibility anyway, and the 2.4 driver (and
libsensors/sensors) will need a significant rework, so it's probably no
more a problem.

> tempX scaling
> Given that we have no idea what the temperature curves for a device are,
> the driver now returns the 10-bit value directly from the register.
> Older versions of the driver multiplied the register value by 2.5 (reason
> unknown as it DEFINITELY didn't scale it to degrees Centigrade, Fahrenheit
> or Kelvin).  Older temperature scaling calculations are now completely
> wrong.

We know how temperature scaling works, see the BIOS porting guide
document and sensors.conf.eg. This chip is quite different from other
ones and needs additional conputations.

temp3 is a bit special, it is diode-based. The conversion which is
currently done in userspace should be moved into the driver, so that the
exported value is a temperature rather than a random register value.
Other temps are thermistor based, a part of the conversion has to be
moved into the driver so that we export the voltage value at the chip
pin. The thermistor bridge computation (voltag -> temperature) belongs
to userspace because different thermistors can be used on different
motherboards. The same is done for the PC87366 temp4-6 already.

> inX scaling
> The driver now scales the measurement to mV.  Inputs such as the 3.3v
> internal reference are now completely correct.  Inputs such as IN0-IN5
> which report an external pin now return the value at the pin.
> SENSORS.CONF still has to scale these to compensate for external divider
> chains (if, for example, the 12v rail is being measured).

Correct, that's exactly what we want.

> tempX/inX presence
> The driver only generates measurements for inputs that are genuinely
> measured (according to the CONFIG register).

This sounds good to me. If anyone later complains that he/she needs to be
able to change the configuration, we'll see at that time. The BIOS
should configure it properly for us, so I would consider it a BIOS bug,
but...

> This causes the "sensors" program to fail as it expects to see all the
> tempX and inX sources available, even if you add "ignore xxx" to the
> sensors.conf file.  IMHO this is a bug in the "sensors" program, as
> "ignore xxx" should cause it to fully ignore that parameter, not still
> generate warnings if the parameter doesn't exist.

Not sure if it is a bug or a design issue. I never took the time to
investigate this. If you have some time, please do. In the meantime, we
usually drop the printed complaint in sensors for all inputs which may
not exist in 2.6 drivers. It's kind of a hack (we could miss real
errors), but works.

> PWM controls
> The VT8231 doesn't have any PWM controls.  All the code that was in the
> driver was erroneous and has been removed (I suspect it was legacy from
> some other driver used as the base for an earlier port).

Ugh. True, I don't see anything related to PWM in the VT8231 datasheet.
Mark, can you please comment on this? Undocumented registers which
worked for you? Or dead code inherited from the vt1211 or via686a
drivers? Let's clean up whatever can be.

> If the newer vt8231 driver is accepted into the kernel tree, would you
> like me to go through v2.9.2 of lm_sensors and try to see what can be
> done to resolve the compatibilities issues with this newer vt8231
> driver?

Yes, this would be very very welcome. I never feel confident when I have
to do that myself for drivers I can't test. If you can test the
changes, that's different, we can (and will have to) cleanup the 2.4
vt8231 driver.

Thanks,
--
Jean Delvare
