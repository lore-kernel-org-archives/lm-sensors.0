From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 10 May 2011 20:38:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for INA219 current and power
Message-Id: <20110510203844.GB18968@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305038767-13241-1-git-send-email-mort@bork.org>
In-Reply-To: <1305038767-13241-1-git-send-email-mort@bork.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 10, 2011 at 07:03:08PM +0200, Jean Delvare wrote:
> Hi Martin,
> 
> On Tue, 10 May 2011 10:46:07 -0400, Martin Hicks wrote:
> > This is a new driver for the INA219 current and power monitor.  This
> > device does require manual configuration via sysfs files in order to
> > provide the current and power information.  By default it does provide
> > voltage information for the monitored bus.
> > 
> > Signed-off-by: Martin Hicks <mort@bork.org>
> 
> Ira Snyder (Cc'd) once submitted a driver for the INA209. It never got
> reviewed due to lack of time and difficulties to make the driver fit in
> the standard hwmon interface, but maybe you two can work together if
> the parts are compatible enough.
> 

Hi Jean, Martin,

I took a quick look at the driver, and they seem fairly compatible. I
did not look at the datasheet.

I've been maintaining my own port of the ina209 driver. Now that the
"in*_lcrit" interfaces are added to the sysfs-interface, we only have
two disagreements:

1) shunt voltage is reported in uV instead of mV

This avoids losing half of the precision supported by the chip. This
makes a big difference for my application: I need it. IMHO, the
sysfs-interface was short sighted. We'll see more chips in the future
that are sensitive enough to report in uV.

I'm sure this is why the power* sysfs-interface is exported in uW
(microwatt). Eventually, devices will be sensitive enough to provide
data with this very fine sensitivity.

2) current calculation is not handled on-chip, it is handled by
libsensors

This was done to sidestep the "configuration register" setup which is
needed for the chip. The value of this register must be computed using
the datasheet and your specific sense resistor value in your specific
circuit. By computing current in userspace using the sense voltage, we
sidestep the issue completely.

Thanks,
Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
