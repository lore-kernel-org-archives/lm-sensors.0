From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 11 May 2011 23:36:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <1305156997.2163.52.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Wed, 2011-05-11 at 15:17 -0400, Jean Delvare wrote:
> On Wed, 11 May 2011 11:40:56 -0700, Guenter Roeck wrote:
> > On Wed, 2011-05-11 at 12:57 -0400, Jean Delvare wrote:
> > > What if we create attribute curr[1-*]_resistor, which would hold the
> > > value of the resistor used? Unit to be defined (milli-Ohm?) It would
> > > either be initialized to 1 milli-Ohm as you've been using so far, or
> > > left uninitialized (0) and the current value would only be returned by
> > > the driver after user-space sets the value (through a set statement in
> > > the configuration file.) Either way, this would let the user specify
> > > the resistor value, as we do with the ones used for voltage input
> > > scaling.
> >
> > Just as good or bad as defining a calibration factor, in my opinion.
> 
> Calibration factor? You mean, the compute statement is 0.001 Ohm isn't
> OK?
> 
I meant that curr1_resistor and a more generic [curr|in]1_cal_gain are
really the same to me.

Having said that, I actually do care to some degree. PMBus devices
support two registers for current calibration:

IOUT_CAL_GAIN

The IOUT_CAL_GAIN command is used to set the ratio of the voltage at the
current sense pins to the sensed current. For devices using a fixed
current sense resistor, it is typically the same value as the resistance
of the resistor.

IOUT_CAL_OFFSET

The IOUT_CAL_OFFSET is used to null out any offsets in the output
current sensing circuit. This command is most often used in conjunction
with the IOUT_CAL_GAIN command (above) to minimize the error of the
current sensing circuit.

If we make any ABI changes, we should support both calibration gain and
offset.

> > Both convert uV readings to mA. If we go along that route, we might as
> > well do the same for voltages etc.
> 
> Err, but we don't _need_ it for voltages, so why would we make things
> needlessly complex?
> 
Arguable. PMBus devices do have a register to specify the voltage gain.

> > Milli-Ohm would be insufficient, since there are smaller resistors
> > available. Mouser offers a sense resistor with 0.000125 Ohms, so you
> > would have to use micro-Ohm.
> 
> Sure, fine with me. This will still allow values up to 4.2 kOhm on
> 32-bit systems, I presume this is sufficient.
> 
> > > This would solve your concern (drivers can keep exporting curr[1-*]
> > > attributes for current sensors) and mind (components external to the
> > > monitoring device are specified by user-space).
> >
> > Not really ... current sense resistors are similar to voltage divider
> > resistors, and external to the chip. Assumption for voltage divider
> > resistors is that the driver doesn't care and conversion is handled in
> > userland. Unfortunately, that does not work for currents, since the
> > driver has to make _some_ assumption how to convert uV as reported by
> > the ADC to mA.
> 
> Unless we go for suboption b, i.e. the resistor value starts at 0 and
> the driver doesn't report any current value until user-space has set
> the value. Then the driver doesn't have to assume anything.
> 
> I agree that voltage and current cases aren't fundamentally different,
> except for the fact that unscaled voltage values do exist, while every
> current sensor will need a resistor.
> 
> What I would like is that we come up with a standard and documented way
> to implement and use current sensors. It can be my proposal above, or
> it can be your arbitrary 0.001 Ohm resistor. But I don't want to leave
> the implementation up to every driver author. This is how lm-sensors 2
> worked, and we definitely do NOT want anything like this ever again.
> 
Makes sense. I'll leave it up to you to decide which way to go.

Note that I specifically don't mind adding the ABI if you think we
should do it. After all, I do have a bunch of chips to test it with ;).

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
