From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Mar 2008 10:06:18 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] thermal: add hwmon sys I/F for thermal
Message-Id: <20080318110618.735572d2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1203975102.10256.82.camel@acpi-hp-zz.sh.intel.com>
	<47C3D04E.6090609@hhs.nl>
	<20080317133732.05b79f4d@hyperion.delvare>
	<47DE6A24.7040705@hhs.nl>
	<20080317144811.12b7d6cb@hyperion.delvare>
	<1205811952.3171.80.camel@acpi-hp-zz.sh.intel.com>
In-Reply-To: <1205811952.3171.80.camel@acpi-hp-zz.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>, "Thomas, Sujith" <sujith.thomas@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Hughes <hughsient@gmail.com>

On Tue, 18 Mar 2008 11:45:52 +0800, Zhang, Rui wrote:
> On Mon, 2008-03-17 at 21:48 +0800, Jean Delvare wrote:
> > Rui, Len, how did you originally envision the coexistence (or not) of
> >  different types of thermal zones?
> 
> driver/thermal/thermal.c won't change any behavior of the current
> system. It just creates a generic sys I/F, that's why we call it the
> Generic Thermal Sysfs driver. :)
> 
> We want to introduce a generic solution for thermal management, which
> usually contains a user application for policy control, a generic
> thermal sysfs driver which provides a set of platform-independent
> interfaces, native sensor drivers and device drivers for thermal
> monitoring and device throttling.
> Note that the target is the handheld devices which is not covered by
> hwmon.
> The idea comes from Len's ols paper, please refer to
> http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/doc/OLS2007-cool-web/
> 
> I don't think the generic thermal sysfs driver need to handle the
> coexistence of different types of thermal zones, because:
> If there are any, they always exist without the generic thermal driver.
> If they break something, it's broken before the generic thermal driver
> is implemented, and the generic thermal driver give it a chance to
> handle this in user space.
> Please correct me if I misunderstand your question. :)

Maybe I have not been clear, but my question was not about the generic
thermal driver itself. I understand that it's only adding an interface
to other drivers and not creating anything new. My question was about
thermal zones in general, i.e.: Do we expect systems to have more than
one thermal zone type at a given time, or not? Len seems to think we do.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
