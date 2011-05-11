From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 May 2011 19:17:55 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <20110511211755.43adbae0@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 May 2011 11:40:56 -0700, Guenter Roeck wrote:
> On Wed, 2011-05-11 at 12:57 -0400, Jean Delvare wrote:
> > What if we create attribute curr[1-*]_resistor, which would hold the
> > value of the resistor used? Unit to be defined (milli-Ohm?) It would
> > either be initialized to 1 milli-Ohm as you've been using so far, or
> > left uninitialized (0) and the current value would only be returned by
> > the driver after user-space sets the value (through a set statement in
> > the configuration file.) Either way, this would let the user specify
> > the resistor value, as we do with the ones used for voltage input
> > scaling.
>
> Just as good or bad as defining a calibration factor, in my opinion.

Calibration factor? You mean, the compute statement is 0.001 Ohm isn't
OK?

> Both convert uV readings to mA. If we go along that route, we might as
> well do the same for voltages etc.

Err, but we don't _need_ it for voltages, so why would we make things
needlessly complex?

> Milli-Ohm would be insufficient, since there are smaller resistors
> available. Mouser offers a sense resistor with 0.000125 Ohms, so you
> would have to use micro-Ohm.

Sure, fine with me. This will still allow values up to 4.2 kOhm on
32-bit systems, I presume this is sufficient.

> > This would solve your concern (drivers can keep exporting curr[1-*]
> > attributes for current sensors) and mind (components external to the
> > monitoring device are specified by user-space).
>
> Not really ... current sense resistors are similar to voltage divider
> resistors, and external to the chip. Assumption for voltage divider
> resistors is that the driver doesn't care and conversion is handled in
> userland. Unfortunately, that does not work for currents, since the
> driver has to make _some_ assumption how to convert uV as reported by
> the ADC to mA.

Unless we go for suboption b, i.e. the resistor value starts at 0 and
the driver doesn't report any current value until user-space has set
the value. Then the driver doesn't have to assume anything.

I agree that voltage and current cases aren't fundamentally different,
except for the fact that unscaled voltage values do exist, while every
current sensor will need a resistor.

What I would like is that we come up with a standard and documented way
to implement and use current sensors. It can be my proposal above, or
it can be your arbitrary 0.001 Ohm resistor. But I don't want to leave
the implementation up to every driver author. This is how lm-sensors 2
worked, and we definitely do NOT want anything like this ever again.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
