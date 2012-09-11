From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 05:30:14 +0000
Subject: Re: [lm-sensors] CONFIG_THERMAL_HWMON in thermal_sys.c
Message-Id: <20120911053014.GA558@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "Guenter Roeck (guenter.roeck@ericsson.com)" <guenter.roeck@ericsson.com>, "Jean Delvare (khali@linux-fr.org)" <khali@linux-fr.org>, "Zhang, Rui" <rui.zhang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "lm-sensors (lm-sensors@lm-sensors.org)" <lm-sensors@lm-sensors.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Sep 11, 2012 at 05:07:29AM +0000, R, Durgadoss wrote:
> Hi Jean/Guenter,
> 
> In thermal_sys.c we have a CONFIG_THERMAL_HWMON.
> If enabled, this creates sysfs nodes for thermal zones inside
> hwmon. Do we need this functionality inside thermal_sys.c ?
> Or is it Ok to remove this ?
> 
> I wanted to know your opinion before submitting a patch.
> 
Hi Durga,

question is really what would replace it. From the plumbers conference,
I understand the idea was that drivers would have to register to both hwmon
and the thermal subsystem. Is that going to happen ?

Second question is why you want to remove it in the first place. It only
matters for drivers which _do_ register with both hwmon and thermal - in
other words, none today. This case could be handled with a new thermal API,
which would specifically exclude hwmon registration.

My concern at this point with the thermal plans is that you might end up
duplicating a bunch of temperature sensor drivers in the thermal subsystem.
And if drivers are to support both subsystems, you would end up duplicating
a lot of common code in drivers which support both the thermal subsystem
and hwmon.

I personally don't think that is a good idea, and would prefer a more unified
approach where it would be possible to register a hwmon temperature sensor driver
with the thermal subsystem. Since that would be quite limited in scope, it might
not be too difficult to define an API for it which should both simplify hwmon
temperature sensor drivers and provide an interface to the thermal subsystem.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
