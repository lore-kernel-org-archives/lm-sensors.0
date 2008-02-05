From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 05 Feb 2008 13:57:25 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <20080205135725.GO20687@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net> <1202031072.3042.54.camel@acpi-sony.sh.intel.com> <20080203164410.GL20687@jupiter.solarsys.private> <20080203175006.GB9159@khazad-dum.debian.net> <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com>
In-Reply-To: <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Thomas, Sujith" <sujith.thomas@intel.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <lenb@kernel.org>

Hi:

(btw: Please use an email client that doesn't completely butcher the
text to which you're replying.  Thanks.)

> > > > On Sun, 2008-02-03 at 10:26 +0800, Henrique de Moraes Holschuh
> > > > wrote:
> > > > > And the two sysfs ABIs are incompatible.  The ACPI one uses
> > > > > low-precision units, (temperature in 10^0 degrees Celcius), while
> > > > > the hwmon ABI uses medium precision units (10^-3 degrees Celcius),
> > > > > for example.  There is also no tachometer feedback for fans, etc.

> > > * Zhang Rui <rui.zhang@intel.com> [2008-02-03 17:31:12 +0800]:
> > > > Yes, currently ACPI is the only user of the thermal sysfs I/F. We
> > > > can add new sys I/F if someone really need it.

* Henrique de Moraes Holschuh <hmh@hmh.eng.br>:
> > I would really appreciate if the thermal zone ABI used a subset of the
> > hwmon ABI.  There is absolutely no reason to have one return data in
> > 10^-3 C while the other returns data in 10^0 C, for example.  IMO, if
> > both ABIs need thermal readings, both should use the same attribute,
> > defined in the same way.  The same goes for other attributes in the two
> > interfaces that share a common concept.

* Thomas, Sujith <sujith.thomas@intel.com> [2008-02-05 15:44:19 +0530]:
> 1)Hwmon interface have other sensors for voltage and current measurement
> as well in addition to thermal sensors. Though this interface is generic
> from a "monitoring" perspective, it lacks some hierarchy representation.
> For eg. it lacks folder structure to store the list of devices
> associated with a thermal sensor. This hierarchy information is very
> much required by application to make an intelligent decision. 

It's not there now.  It could be added.

> 2) It is missing interfaces for passive device control.(CPU- T
> states,LCD,Memory controller, etc..)

Ditto.

> 3) The solution should work on any ACPI based system or any other
> thermal model for that matter which follows the basic concept. (The
> model being : There are devices associated with sensors and if we
> "control" the device, the temperature of the sensor will come down).

The "association" bit is difficult for most hwmon drivers.  There are
10k different mainboards, all wired differently, with no way to query
them to determine e.g. which PWM output is associated with which temp
sensor.  So, we are forced to punt the assocation to userspace.  You
won't have that problem w/ ACPI - lucky you. ;)

That still doesn't mean that this info can't or shouldn't be exposed in
hwmon when it *is* available.

> 4)What I have understood is that Hwmon supports only Smbus and I2C based
> sensors. It doesn't have support for EC based sensors at this point of
> time.

Incorrect.  We support devices with a variety of hardware interfaces in
addition to the I2C/SMBus.  Did you even look?

> 5)If I am not wrong, Hwmon lacks support for programming AUX trip points
> and trigger events based on that.

You keep saying "hwmon lacks support for"... the hwmon sysfs interface
supports exactly what the hardware can do.  If your hardware can do
something new or unique, you extend the interface to support it.  There
are numerous examples of this.

> These were all the facts which lead us to take a different route than
> hwmon.

I don't actually mind having a thermal management interface that is
outside of hwmon, if that's what you want to do.  But these "facts"
(which are the premises of your rationale) are mostly bogus.

<cut>

* Thomas, Sujith <sujith.thomas@intel.com> [2008-02-05 15:44:19 +0530]:
> IMO the scope of hwmon is to monitor/report out temperature, voltage ,
> current etc of the devices/platform . But the scope of these patches is

The scope of hwmon is to allow whatever the hardware allows.  Period.

> purely thermal management for a generic thermal model. As a first step
> we have made it work for ACPI thermal model. 
> The only duplication which I can see of is in the "reporting of
> temperature", which is quite reasonable for a thermal management module
> to have.

Well, HdMH and I apparently disagree about this.  All I really care
about is that the temp info should be available through /sys/class/hwmon.
Many people just want to check their temps, without diving into the fine
details of a "thermal management solution".

So... what class of hardware would I need to give these patches a try?
Probably it would take me less time to write a patch to add hwmon class
support to that than it did to write this message... ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
