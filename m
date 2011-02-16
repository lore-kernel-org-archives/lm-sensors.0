From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 16 Feb 2011 18:30:23 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: twl4030: Hwmon Driver for
Message-Id: <20110216183023.GA15254@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1297861017-10057-1-git-send-email-j-keerthy@ti.com>
 <20110216160948.GB14199@ericsson.com>
 <AANLkTimEUA0ifx=FoNL1ACqFveG0pHEJ4fpcFMAQxvxB@mail.gmail.com>
In-Reply-To: <AANLkTimEUA0ifx=FoNL1ACqFveG0pHEJ4fpcFMAQxvxB@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "sameo@linux.intel.com" <sameo@linux.intel.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, Feb 16, 2011 at 12:59:52PM -0500, J, KEERTHY wrote:
> Hello Guenter,
> 
> On Wed, Feb 16, 2011 at 9:39 PM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Wed, Feb 16, 2011 at 07:56:57AM -0500, Keerthy wrote:
> >> This driver exposes the sysfs nodes of the TWL4030 MADC module.
> >> All the channel values are expressed in terms of mV. Channel 13
> >> and channel 14 are reserved. There are channels which represent
> >> temperature and current. Even they output raw voltage in mV.
> >>
> > Why ?
> 
> The conversion to current and temperature in case of MADC depends
> on a register in the battery module. Hence battery driver can expose the
> converted value. So providing the raw voltage here.

Not a good reason.

You could create an API to let you retrieve the register values.
You could read the respective registers directly.
You could provide the register values in platform data.
If there will always be just one instance of the driver, you could provide
the register values via module parameters.
You could present the raw temperature/current values and correct it
with sensors3.conf.

Either case, I don't think it is a good idea to present known temperatures
or currents as voltage.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
