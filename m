From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 11 May 2011 02:26:47 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <20110511022647.GC3781@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 10, 2011 at 04:38:44PM -0400, Ira W. Snyder wrote:
> On Tue, May 10, 2011 at 07:03:08PM +0200, Jean Delvare wrote:
> > Hi Martin,
> > 
> > On Tue, 10 May 2011 10:46:07 -0400, Martin Hicks wrote:
> > > This is a new driver for the INA219 current and power monitor.  This
> > > device does require manual configuration via sysfs files in order to
> > > provide the current and power information.  By default it does provide
> > > voltage information for the monitored bus.
> > > 
> > > Signed-off-by: Martin Hicks <mort@bork.org>
> > 
> > Ira Snyder (Cc'd) once submitted a driver for the INA209. It never got
> > reviewed due to lack of time and difficulties to make the driver fit in
> > the standard hwmon interface, but maybe you two can work together if
> > the parts are compatible enough.
> > 
> 
> Hi Jean, Martin,
> 
Hi all,

turns out Paul submitted a driver for INA209 as well, which pretty much
just exported register values via sysfs:

	http://www.mail-archive.com/i2c@lm-sensors.org/msg00342.html

> I took a quick look at the driver, and they seem fairly compatible. I
> did not look at the datasheet.
> 
Looking through the datasheets, the INA209 has some 22 registers,
while the INA219 only has 6 registers. Register numbers are different too.
That doesn't look very compatible to me. Am I missing something ?

> I've been maintaining my own port of the ina209 driver. Now that the
> "in*_lcrit" interfaces are added to the sysfs-interface, we only have
> two disagreements:
> 
> 1) shunt voltage is reported in uV instead of mV
> 
> This avoids losing half of the precision supported by the chip. This
> makes a big difference for my application: I need it. IMHO, the
> sysfs-interface was short sighted. We'll see more chips in the future
> that are sensitive enough to report in uV.
> 
mV seems to be pretty accurate for voltage measurements.
The shunt voltage is really just a reflection of the voltage across
the current shunt resistor and reflects a current, not a voltage.

Sure, chips can sense voltages in the uV range, but that is typically 
not used for voltage but for current measurements. With a 0.001 Ohm
shunt resistor, 1uV translates to 1mA. Reporting that "voltage" in mA
makes, in my opinion, more sense than reporting it in uV and expecting
a common library to perform a translation of a reported voltage into mA.

Having said that, Jean has a support ticket open to implement such a conversion:
	http://www.lm-sensors.org/ticket/2258
If he ever gets to it, I suspect we will have to address the uV issue,
since mV are definitely insufficient for reporting shunt resistor voltages.

> I'm sure this is why the power* sysfs-interface is exported in uW
> (microwatt). Eventually, devices will be sensitive enough to provide
> data with this very fine sensitivity.
> 
I don't know for sure, but I suspect it is simply because mV * mA = uW.

> 2) current calculation is not handled on-chip, it is handled by
> libsensors
> 
> This was done to sidestep the "configuration register" setup which is
> needed for the chip. The value of this register must be computed using
> the datasheet and your specific sense resistor value in your specific
> circuit. By computing current in userspace using the sense voltage, we
> sidestep the issue completely.
> 
The chips provide current as
	Current Register = Shunt Register * Calibration Register / 4096

so the question for me would be why it would be necessary report the raw value
of the shunt resistor voltage in the first place and not just stick with in0
(in mV) and curr1 (in mA). If you want to report the "raw" value, you could
report it in mA as suggested above (ie assume a 0.001 Ohm shunt resistor).

Part of the problem here is how to provide configuration data.
The overall expectation for chip configuration is that it should be handled
in the BIOS, ie before Linux starts. For applications where this is
not the case, would be to define platform data to provide the necessary
information. Another alternative would be to use OF (see the ads1015 driver
for an example). Using sysfs attributes for this purpose is not a good idea.

Jean had some reservations about assuming a 0.001 Ohm shunt resistor. See 
	http://article.gmane.org/gmane.linux.documentation/2744/
Providing platform data to configure the chips would definitely be
a better option. 

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
