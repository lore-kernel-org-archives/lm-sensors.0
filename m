From: "Thomas, Sujith" <sujith.thomas@intel.com>
Date: Tue, 05 Feb 2008 10:26:19 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <05B550FD4BD2014E841D83547B626008029899FE@bgsmsx411.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net> <1202031072.3042.54.camel@acpi-sony.sh.intel.com> <20080203164410.GL20687@jupiter.solarsys.private> <20080203175006.GB9159@khazad-dum.debian.net>
In-Reply-To: <20080203175006.GB9159@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Len Brown <lenb@kernel.org>



> -----Original Message-----
> From: Henrique de Moraes Holschuh [mailto:hmh@hmh.eng.br]
> Sent: Sunday, February 03, 2008 11:20 PM
> To: Mark M. Hoffman
> Cc: Zhang, Rui; linux-acpi@vger.kernel.org; lm-sensors@lm-sensors.org;
> Jean Delvare; Len Brown; Thomas, Sujith
> Subject: Re: The new thermal management sysfs class, and hwmon
> 
> On Sun, 03 Feb 2008, Mark M. Hoffman wrote:
> > * Zhang Rui <rui.zhang@intel.com> [2008-02-03 17:31:12 +0800]:
> > > On Sun, 2008-02-03 at 10:26 +0800, Henrique de Moraes Holschuh
wrote:
> > > > And the two sysfs ABIs are incompatible.  The ACPI one uses
> > > > low-precision units, (temperature in 10^0 degrees Celcius),
while
> > > > the hwmon ABI uses medium precision units (10^-3 degrees
Celcius),
> > > > for example.  There is also no tachometer feedback for fans,
etc.
> >
> > > Yes, currently ACPI is the only user of the thermal sysfs I/F. We
can
> > > add new sys I/F if someone really need it.
> 
> I would really appreciate if the thermal zone ABI used a subset of the
> hwmon
> ABI.  There is absolutely no reason to have one return data in 10^-3 C
> while
> the other returns data in 10^0 C, for example.  IMO, if both ABIs need
> thermal readings, both should use the same attribute, defined in the
same
> way.  The same goes for other attributes in the two interfaces that
share
> a
> common concept.
1)Hwmon interface have other sensors for voltage and current measurement
as well in addition to thermal sensors. Though this interface is generic
from a "monitoring" perspective, it lacks some hierarchy representation.
For eg. it lacks folder structure to store the list of devices
associated with a thermal sensor. This hierarchy information is very
much required by application to make an intelligent decision. 
2) It is missing interfaces for passive device control.(CPU- T
states,LCD,Memory controller, etc..)
3) The solution should work on any ACPI based system or any other
thermal model for that matter which follows the basic concept. (The
model being : There are devices associated with sensors and if we
"control" the device, the temperature of the sensor will come down).
4)What I have understood is that Hwmon supports only Smbus and I2C based
sensors. It doesn't have support for EC based sensors at this point of
time.
5)If I am not wrong, Hwmon lacks support for programming AUX trip points
and trigger events based on that.

These were all the facts which lead us to take a different route than
hwmon.
> 
> > > > IMHO, we can probably do better than two incompatible sysfs ABIs
for
> > > > what ammounts to the same functionality for many userspace
> > > > applications (i.e.  thermal monitor apps, and fan control and
> > > > monitoring apps).  And it would be really neat if the new
thermal
> > > > management stuff could just plug into the already available
> > > > temperature sensors and fan controllers that follow the hwmon
sysfs
> > > > ABI.
> >
> > > Yes, we do want to use the hwmon sysfs ABI at the beginning.
> > > But there are several gaps that making us turn to a new thermal
sysfs
> > > class. And the biggest one is that hwmon does NOT support ACPI
passive
> > > cooling devices like processor, video, etc. intel menlow platform
even
> > > has a ACPI memory controller device which can be throttled by
changing
> > > the bandwidth. These are quite different from the hwmon's
fan-based
> > > thermal management, right?
> >
> > The hwmon class ABI is more about exposing the functionality that is
> > available on various devices than it is about accomplishing some
> > specific task like "thermal management".  That said...
> 
> But a lot of chips *can* do thermal management, and there is an ABI
for it
> on hwmon (but it is not easy to use, I started messing with lm85 to do
so
> and dropped the ball because the in-chip ABI was not so easy to map to
the
> hwmon ABI and I got sidetracked).
> 
> We could reshape that ABI into something that could be useful for all
> monitoring chips AND for both ACPI active and passive cooling control.
> 
> > I don't see why the hwmon class ABI couldn't be extended to
accomodate
> > CPU throttling, etc.  But I also don't see that it hurts anything to
put
> > these controls somewhere else in sysfs.
> 
> Agreed.  However, *duplicating* what is already in hwmon elsewhere is
not
> fun.  Please reconsider.  I'd like to see passive cooling (heck, the
> entire
> ACPI v3.0 thermal model, if needed) added to hwmon, that will enhance
> hwmon
> to be even more generic, and we all benefit from that.
> 
> > I *do* think that any driver which reports temperature, etc. should
> > expose those measurements through the hwmon class - even if they're
> > exposed somewhere else as well.
> 
> While I *do* think if we have to expose them twice, we are doing
something
> wrong :-)
IMO the scope of hwmon is to monitor/report out temperature, voltage ,
current etc of the devices/platform . But the scope of these patches is
purely thermal management for a generic thermal model. As a first step
we have made it work for ACPI thermal model. 
The only duplication which I can see of is in the "reporting of
temperature", which is quite reasonable for a thermal management module
to have.

:-Sujith
> 
> --
>   "One disk to rule them all, One disk to find them. One disk to bring
>   them all and in the darkness grind them. In the Land of Redmond
>   where the shadows lie." -- The Silicon Valley Tarot
>   Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
