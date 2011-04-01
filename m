From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 01 Apr 2011 15:41:14 +0000
Subject: Re: [lm-sensors] Query: Omap temperature sensor driver design
Message-Id: <20110401154114.GB30343@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimsX-=1Qe8F3=gJM75_TYP9SujTFTH6uvXncWRC@mail.gmail.com>
In-Reply-To: <AANLkTimsX-=1Qe8F3=gJM75_TYP9SujTFTH6uvXncWRC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Apr 01, 2011 at 08:39:43AM -0400, J, KEERTHY wrote:
> Hello All,
> 
> I am trying to implement a driver for the OMAP temperature sensor.
> It is an on chip sensor.
> 
> The sensor is responsible for reporting the temperature. The sensor
> has configurable thresholds. The user can configure the thresholds.
> An interrupt will be generated as soon as there the temperature
> thresholds are crossed.
> 
> Two possible approaches for the driver:
> 
> 1) The entire driver resides in drivers/hwmon directory. The driver
> containing all the sysfs nodes to be exposed to the user.
> The interrupt handlers are also part of this driver. The device
> registration happens in a OMAP arch specific file residing
> in arch/arm/mach-omap2 directory.
> 
> 2) The intialization and the interrupt handling done in a
> separate driver file residing in in arch/arm/mach-omap2 or
> drivers/misc directory.
> The device registration happens in a OMAP arch specific file residing
> in arch/arm/mach-omap2 directory.
> Only the sysfs nodes will be exposed through a hwmon
> driver residing in drivers/hwmon.
> 
That really depends if it does anything else besides hw monitoring.
A hw monitoring driver can support interrupts, and trigger a poll event 
on an alarm file if it gets one. But it should only perform hw monitoring 
functionality. If that interrupt triggers other activity, a thermal subsystem
driver may be more appropriate.

Thanks,
Guenter

> Please suggest the best alternative among the two or if any new
> design for the requirements is better.
> 
> -- 
> Regards and Thanks,
> Keerthy
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
