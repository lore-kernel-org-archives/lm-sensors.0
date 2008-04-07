From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Apr 2008 10:22:42 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] thermal: add hwmon sys I/F
Message-Id: <20080407122242.36aa4ddb@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1207123693.27304.6.camel@acpi-hp-zz.sh.intel.com>
	<20080407114648.46cec5c6@hyperion.delvare>
In-Reply-To: <20080407114648.46cec5c6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Hans de Goede <j.w.r.degoede@hhs.nl>, Len Brown <lenb@kernel.org>

Quoting myself...

On Mon, 7 Apr 2008 11:46:48 +0200, Jean Delvare wrote:
> One thing that worries me is the hwmon device name. It comes directly
> from the thermal zone's type ("ACPI thermal zone" in the ACPI case".)
> We have no control over that name, while libsensors makes some
> assumptions on it. For example it assumes that there is no dash in a
> hwmon device name. So far, all hwmon device names also didn't have
> spaces, nor uppercase letters, and were much shorter (ACPI thermal zone
> would be something like "acpi_tz".) I hope that applications didn't
> make too many assumptions on length or content...
> 
> I'm not sure yet if and how we want to address this problem. Maybe we
> could have a "short name" field in struct thermal_zone_device. Or
> alternatively I could add a conversion function to libsensors, that
> would convert "ACPI thermal zone" to "acpi_thermal_zone". The latter
> approach doesn't help with the length, but at least it normalizes the
> character set.

Oh, I now see that you addressed the problem in patch 3/3, so you can
forget about what I wrote above. Thank you :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
