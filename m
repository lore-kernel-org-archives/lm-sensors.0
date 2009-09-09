From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 09 Sep 2009 08:06:38 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon driver for ACPI 4.0 power meters
Message-Id: <20090909080637.GA28353@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200908202049.n7KKnKO7015060@imap1.linux-foundation.org> <20090820211557.GA8431@elf.ucw.cz> <20090820213755.GB10521@tux1.beaverton.ibm.com> <20090821091939.GC21167@elf.ucw.cz> <20090821184718.GD23397@tux1.beaverton.ibm.com> <20090821221705.GA2108@elf.ucw.cz> <20090822011744.GH10521@tux1.beaverton.ibm.com> <20090821140159.GB1328@ucw.cz> <20090908202410.GS10521@tux1.beaverton.ibm.com>
In-Reply-To: <20090908202410.GS10521@tux1.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi!

> diff --git a/Documentation/hwmon/acpi_power_meter b/Documentation/hwmon/acpi_power_meter
> new file mode 100644
> index 0000000..b02ddaa
> --- /dev/null
> +++ b/Documentation/hwmon/acpi_power_meter
> @@ -0,0 +1,31 @@
> +Kernel driver power_meter
> +============> +
> +This driver talks to ACPI 4.0 power meters.
> +
> +Supported systems:
> +  * Any recent system with ACPI 4.0.
> +    Prefix: 'power_meter'
> +    Datasheet: http://acpi.info/, section 10.4.
> +
> +Author: Darrick J. Wong
> +
> +Description
> +-----------
> +
> +This driver implements sensor reading support for the power meters exposed in
> +the ACPI 4.0 spec (Chapter 10.4).  These devices have a simple set of
> +features--a power meter that returns average power use over a configurable
> +interval, an optional capping mechanism, and a couple of trip points.

So where do we get the average power?

> +Special Features
> +----------------
> +
> +The power[1-*]_is_battery knob indicates if the power supply is a battery.
> +Both power[1-*]_average_{min,max} must be set before the trip
> points will work.

How do trip points work? It is not explained here.


> +config ACPI_POWER_METER
> +	tristate "ACPI 4.0 power meter"
> +	depends on HWMON
> +	default m

default M is "evil".

> +	  devices.  Say Y (or M) if you have an Intel or AMD computer with
> +	  a power meter.

WTF? Neither Intel nor AMD makes _computers_.

> +	  To compile this driver as a module, choose M here:
> +	  the module will be called power-meter.

.ko.

> +#define POWER_CAP_NAME		"power1_cap"

I did not see power cap explained.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
