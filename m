From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 11 Sep 2012 08:40:49 +0000
Subject: Re: [lm-sensors] CONFIG_THERMAL_HWMON in thermal_sys.c
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB591B720F@BGSMSX101.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
 <20120911053014.GA558@roeck-us.net>
In-Reply-To: <20120911053014.GA558@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Guenter Roeck (guenter.roeck@ericsson.com)" <guenter.roeck@ericsson.com>, "Jean Delvare (khali@linux-fr.org)" <khali@linux-fr.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "lm-sensors (lm-sensors@lm-sensors.org)" <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Guenter,

Thanks for taking the time to reply.

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Guenter Roeck
> Sent: Tuesday, September 11, 2012 11:00 AM
> To: R, Durgadoss
> Cc: Guenter Roeck (guenter.roeck@ericsson.com); Jean Delvare
> (khali@linux-fr.org); Zhang, Rui; lenb@kernel.org; lm-sensors (lm-
> sensors@lm-sensors.org); linux-acpi@vger.kernel.org
> Subject: Re: CONFIG_THERMAL_HWMON in thermal_sys.c
> 
> On Tue, Sep 11, 2012 at 05:07:29AM +0000, R, Durgadoss wrote:
> > Hi Jean/Guenter,
> >
> > In thermal_sys.c we have a CONFIG_THERMAL_HWMON.
> > If enabled, this creates sysfs nodes for thermal zones inside
> > hwmon. Do we need this functionality inside thermal_sys.c ?
> > Or is it Ok to remove this ?
> >
> > I wanted to know your opinion before submitting a patch.
> >
> Hi Durga,
> 
> question is really what would replace it. From the plumbers conference,
> I understand the idea was that drivers would have to register to both hwmon
> and the thermal subsystem. Is that going to happen ?

The thermal subsystem provides a standard sysfs interface today, and more
drivers are starting to use it. The idea is, if a thermal sensor driver wants to
participate in the platform Thermal management, (not just reporting
temperature from hardware, but taking actions based on that) it should
register with Thermal subsystem, and expose sysfs under /sys/class/thermal/
as a thermal_zone. For this registration there is already an EXPORT_SYMBOL
API, that can be used.

If the driver is a hwmon driver, and wants to participate in Thermal management,
it can
a) Expose its temperature through hwmon sysfs (as it exists today)
b) register with thermal subsystem through the provided API. (optional)

If the driver is a thermal driver (placed inside drivers/thermal/) it can directly
use the thermal subsystem APIs to expose/monitor temperature. In this case,
I don't see a need for this kind of driver to use CONFIG_HWMON.

> 
> Second question is why you want to remove it in the first place. It only

We are (kind of) re-implementing the Thermal framework to have more
robust thermal monitoring. So, thought we can make this implementation
also better.

> matters for drivers which _do_ register with both hwmon and thermal - in
> other words, none today. This case could be handled with a new thermal API,
> which would specifically exclude hwmon registration.
> 
> My concern at this point with the thermal plans is that you might end up
> duplicating a bunch of temperature sensor drivers in the thermal subsystem.
> And if drivers are to support both subsystems, you would end up duplicating
> a lot of common code in drivers which support both the thermal subsystem
> and hwmon.

I agree with both of your points. Please see below.

> 
> I personally don't think that is a good idea, and would prefer a more unified
> approach where it would be possible to register a hwmon temperature
> sensor driver
> with the thermal subsystem. Since that would be quite limited in scope, it
> might
> not be too difficult to define an API for it which should both simplify hwmon
> temperature sensor drivers and provide an interface to the thermal
> subsystem.

Yes, an API exists. The drivers in hwmon (if they want to) can register with
Thermal subsystem using thermal_zone_device_register() API.

My thought of starting this discussion was for the other set of drivers,
which are inside drivers/thermal/

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
