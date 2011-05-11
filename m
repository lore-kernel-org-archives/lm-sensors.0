From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Wed, 11 May 2011 15:41:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <20110511154158.GA32116@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 10, 2011 at 07:26:47PM -0700, Guenter Roeck wrote:
> On Tue, May 10, 2011 at 04:38:44PM -0400, Ira W. Snyder wrote:
> > On Tue, May 10, 2011 at 07:03:08PM +0200, Jean Delvare wrote:
> > > Hi Martin,
> > > 
> > > On Tue, 10 May 2011 10:46:07 -0400, Martin Hicks wrote:
> > > > This is a new driver for the INA219 current and power monitor.  This
> > > > device does require manual configuration via sysfs files in order to
> > > > provide the current and power information.  By default it does provide
> > > > voltage information for the monitored bus.
> > > > 
> > > > Signed-off-by: Martin Hicks <mort@bork.org>
> > > 
> > > Ira Snyder (Cc'd) once submitted a driver for the INA209. It never got
> > > reviewed due to lack of time and difficulties to make the driver fit in
> > > the standard hwmon interface, but maybe you two can work together if
> > > the parts are compatible enough.
> > > 
> > 
> > Hi Jean, Martin,
> > 
> Hi all,
> 
> turns out Paul submitted a driver for INA209 as well, which pretty much
> just exported register values via sysfs:
> 
> 	http://www.mail-archive.com/i2c@lm-sensors.org/msg00342.html
> 

Yep. Hopefully you've seen my INA209 driver as well, which at least
tries to be compatible with the sysfs-interface where possible. If you
need another copy, I'll be happy to post it again.

> > I took a quick look at the driver, and they seem fairly compatible. I
> > did not look at the datasheet.
> > 
> Looking through the datasheets, the INA209 has some 22 registers,
> while the INA219 only has 6 registers. Register numbers are different too.
> That doesn't look very compatible to me. Am I missing something ?
> 
> > I've been maintaining my own port of the ina209 driver. Now that the
> > "in*_lcrit" interfaces are added to the sysfs-interface, we only have
> > two disagreements:
> > 
> > 1) shunt voltage is reported in uV instead of mV
> > 
> > This avoids losing half of the precision supported by the chip. This
> > makes a big difference for my application: I need it. IMHO, the
> > sysfs-interface was short sighted. We'll see more chips in the future
> > that are sensitive enough to report in uV.
> > 
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

Yes, you are correct. I am returning the shunt resistor voltage (in uV)
in place of mA in the current value. I think you are probably right, I
don't need more resolution than mV in the true voltage monitor sysfs
files.

Also, (in reply to some email further down the thread), I understand
that the interface was designed in 2005, and that with the benefit of 7
years of experience, things might have been done differently. Perhaps I
shouldn't have said "short sighted", maybe "suboptimal interface choice
due to lack of experience" would have been better. I don't want to start
a fight. :)

> Having said that, Jean has a support ticket open to implement such a conversion:
> 	http://www.lm-sensors.org/ticket/2258
> If he ever gets to it, I suspect we will have to address the uV issue,
> since mV are definitely insufficient for reporting shunt resistor voltages.
> 
> > I'm sure this is why the power* sysfs-interface is exported in uW
> > (microwatt). Eventually, devices will be sensitive enough to provide
> > data with this very fine sensitivity.
> > 
> I don't know for sure, but I suspect it is simply because mV * mA = uW.
> 
> > 2) current calculation is not handled on-chip, it is handled by
> > libsensors
> > 
> > This was done to sidestep the "configuration register" setup which is
> > needed for the chip. The value of this register must be computed using
> > the datasheet and your specific sense resistor value in your specific
> > circuit. By computing current in userspace using the sense voltage, we
> > sidestep the issue completely.
> > 
> The chips provide current as
> 	Current Register = Shunt Register * Calibration Register / 4096
> 

There is a problem here. When you change the value of the Calibration
Register, you change the mA per bit (LSB) of the Current Register value.
I couldn't figure out how to determine the LSB of the Current Register
using the value in the Calibration Register.

Does that explanation make sense? How would you handle this situation?

FYI, here is a snippet from my sensors3.conf:

chip "ina209-i2c-0-45"
        label in0 "FPGA 2.5V SENSE"
        label in1 "FPGA 2.5V VOLTAGE"
        label power1 "FPGA 2.5V POWER"
        label curr1 "FPGA 2.5V CURRENT"

        # shunt voltage reported in uV
        compute in0 (@ / 1000), (@ * 1000)

        # 32 mOhm sense resistor
        compute power1 in1_input * curr1_input, in1_input * curr1_input
        compute curr1 (@ / 32), (@ * 32)

chip "ina209-i2c-0-4a"
        label in0 "FPGA 3.3V SENSE"
        label in1 "FPGA 3.3V VOLTAGE"
        label power1 "FPGA 3.3V POWER"
        label curr1 "FPGA 3.3V CURRENT"

        # shunt voltage reported in uV
        compute in0 (@ / 1000), (@ * 1000)

        # 220 mOhm sense resistor
        compute power1 in1_input * curr1_input, in1_input * curr1_input
        compute curr1 (@ / 220), (@ * 220)

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
> 

I am happy to configure the chip in my bootloader, before Linux starts.
Or to use OF, that is fine too.

The trouble is in the scaling of the "Current Register". As noted above,
the LSB changes depending on the value of the "Configuration Register".
I am not smart enough to figure out how to convert from "Configuration
Register value" to "LSB of Current Register".

Ira

> Jean had some reservations about assuming a 0.001 Ohm shunt resistor. See 
> 	http://article.gmane.org/gmane.linux.documentation/2744/
> Providing platform data to configure the chips would definitely be
> a better option. 
> 
> Thanks,
> Guenter
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
