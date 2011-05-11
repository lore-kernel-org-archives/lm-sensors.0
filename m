From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 May 2011 12:39:12 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <20110511143912.796c37ca@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter, Ira,

On Tue, 10 May 2011 19:26:47 -0700, Guenter Roeck wrote:
> On Tue, May 10, 2011 at 04:38:44PM -0400, Ira W. Snyder wrote:
> > I've been maintaining my own port of the ina209 driver. Now that the
> > "in*_lcrit" interfaces are added to the sysfs-interface, we only have
> > two disagreements:
> > 
> > 1) shunt voltage is reported in uV instead of mV
> > 
> > This avoids losing half of the precision supported by the chip. This
> > makes a big difference for my application: I need it. IMHO, the
> > sysfs-interface was short sighted.

I'm fairly certain I already explained months ago, but...

The sysfs interface was originally designed in 2005. Back then, the
lowest monitored system voltage was 3.3V, with memory voltage at 1.8V
(DDR2) and CPU core voltage in the 1.0-1.5V. Most monitoring chips were
using ADCs with a resolution of 16 mV. Using 1 mV as the base unit
seemed totally reasonable. As a matter of fact, we now see ADCs with
resolution 12 mV or 8 mV, and our 1 mV unit is still totally fine.

Your problem is that you are not monitoring a voltage. You are
monitoring a current, so requirements are totally different. And it's
not always possible to anticipate future requirements. Current
measurement was totally out of the scope of hardware monitoring
initially... And I would claim it still is, BTW. Probably the IIO
subsystem would be better suited at the need.

> > We'll see more chips in the future
> > that are sensitive enough to report in uV.
>
> mV seems to be pretty accurate for voltage measurements.
> The shunt voltage is really just a reflection of the voltage across
> the current shunt resistor and reflects a current, not a voltage.
> 
> Sure, chips can sense voltages in the uV range, but that is typically 
> not used for voltage but for current measurements. With a 0.001 Ohm
> shunt resistor, 1uV translates to 1mA. Reporting that "voltage" in mA
> makes, in my opinion, more sense than reporting it in uV and expecting
> a common library to perform a translation of a reported voltage into mA.
> 
> Having said that, Jean has a support ticket open to implement such a conversion:
> 	http://www.lm-sensors.org/ticket/2258
> If he ever gets to it, I suspect we will have to address the uV issue,
> since mV are definitely insufficient for reporting shunt resistor voltages.

Yes, I remember we discussed this lately, and I didn't have the time to
work on this so far, sorry.

I have nothing against extending the sysfs interface to support uV
voltages. But this must be done in a way which doesn't break current
installations. Arbitrarily reporting in uV instead of the standard mV
isn't an option, neither for the ina209 driver alone, nor for all
drivers.

One way to do it would be to invent a brand new set of attributes for
uV voltages. For example volt[0-*]_input, etc. This is straightforward
and won't break anything, and would be transparent for applications,
however this would incur a lot of redundancy in the sysfs interface
definition document and in libsensors. If done smartly, this may be
bearable. The user constraints would be: you need the latest version of
libsensors for ina219 support, otherwise the attributes in question
aren't visible at all.

Another way would be to create a dedicated attribute for hwmon drivers
to advertise whether they are reporting voltages in uV or mV. For
example, file "unit_in" would contain -6 when the chip reports voltages
in uV, -3 if the chip reports voltages in mV (which would be the
default for backwards compatibility.) This would require very little
work in the sysfs-interface document and in libsensors, and would be
transparent to applications. The user constraints would be: you need
the latest version of libsensors for ina219 support, otherwise the
attributes in question are improperly scaled. Whether this is better or
worse than the constraints of the first option can be discussed... It
has the problem that the incorrectness is silent, but the advantage
that it can be corrected in sensors.conf if known (with, again, the
problem that a future update of libsensors will require a fix of
sensors.conf.)

I don't have a strong opinion. I don't think the INA219 chip is popular
enough that the second option is problematic. But if we go that route,
we should implement the libsensors side immediately so that it starts
propagating to the user base.

Note, the second option would also have the benefit that we can switch
to nV or V or kV at any time if we need to support strange hardware
monitoring devices. I don't expect it, but I didn't expect that we'd
need uV either, so...

If we go for the second option, I presume we would do the same for
current and power. Just in case...

> > I'm sure this is why the power* sysfs-interface is exported in uW
> > (microwatt). Eventually, devices will be sensitive enough to provide
> > data with this very fine sensitivity.
>
> I don't know for sure, but I suspect it is simply because mV * mA = uW.

Yes, I think that was the reasoning behind it. And also a simple "play
it safe" decision, because the feature was new and we didn't really
know what to expect from devices (contrary to voltages in 2005 as we
had 7 years of experience behind us.)

But you know, maybe someday someone will need nW and yell at us because
we didn't anticipate it ;)

> > 2) current calculation is not handled on-chip, it is handled by
> > libsensors
> > 
> > This was done to sidestep the "configuration register" setup which is
> > needed for the chip. The value of this register must be computed using
> > the datasheet and your specific sense resistor value in your specific
> > circuit. By computing current in userspace using the sense voltage, we
> > sidestep the issue completely.
>
> The chips provide current as
> 	Current Register = Shunt Register * Calibration Register / 4096
> 
> so the question for me would be why it would be necessary report the raw value
> of the shunt resistor voltage in the first place and not just stick with in0
> (in mV) and curr1 (in mA). If you want to report the "raw" value, you could
> report it in mA as suggested above (ie assume a 0.001 Ohm shunt resistor).
> 
> Part of the problem here is how to provide configuration data.
> The overall expectation for chip configuration is that it should be handled
> in the BIOS, ie before Linux starts. For applications where this is
> not the case, would be to define platform data to provide the necessary
> information. Another alternative would be to use OF (see the ads1015 driver
> for an example). Using sysfs attributes for this purpose is not a good idea.

+1

> Jean had some reservations about assuming a 0.001 Ohm shunt resistor. See 
> 	http://article.gmane.org/gmane.linux.documentation/2744/
> Providing platform data to configure the chips would definitely be
> a better option. 

Well well... If it makes everyone's life easier, I would be happy to
(let you) document the 0.001 Ohm rule in D/h/sysfs-interface and
possibly sensors.conf.5.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
