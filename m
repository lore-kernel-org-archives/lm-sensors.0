From: Zhang Rui <rui.zhang@intel.com>
Date: Sun, 03 Feb 2008 09:31:12 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <1202031072.3042.54.camel@acpi-sony.sh.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net>
In-Reply-To: <20080203022622.GA995@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Jean Delvare <khali@linux-fr.org>, Len Brown <lenb@kernel.org>, "Thomas, Sujith" <sujith.thomas@intel.com>

Hi, henrique,

On Sun, 2008-02-03 at 10:26 +0800, Henrique de Moraes Holschuh wrote:
> The new thermal managemeny sysfs class that was just merged into
> acpi-test,
> especially when dealing with temperature measurement and fan control,
> has a
> lot of common ground with the hwmon interface.
Yes, that's true.
The idea is from Len's ols paper in 2007, "Cool Hand Linux - Handheld
Thermal Extensions". The new thermal management sysfs class can be used
by handheld devices which use device throttling for thermal control and
may have no fan at all.
Please refer to
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/doc/OLS2007-cool-web/

> However, the ACPI model for thermal cooling devices (fans, etc) and
> thermal
> zones (temp sensors) as currently implemented in the sysfs class
> appears at
> first glance to be a lot more simplified than what is available
> through the
> hwmon sysfs ABI (for a lack of a better term to describe the sysfs
> attribute
> specifications).
> 
> And the two sysfs ABIs are incompatible.  The ACPI one uses
> low-precision
> units, (temperature in 10^0 degrees Celcius), while the hwmon ABI uses
> medium precision units (10^-3 degrees Celcius), for example.  There is
> also
> no tachometer feedback for fans, etc.
Yes, currently ACPI is the only user of the thermal sysfs I/F. We can
add new sys I/F if someone really need it.
> 
> IMHO, we can probably do better than two incompatible sysfs ABIs for
> what
> ammounts to the same functionality for many userspace applications
> (i.e.
> thermal monitor apps, and fan control and monitoring apps).  And it
> would be
> really neat if the new thermal management stuff could just plug into
> the
> already available temperature sensors and fan controllers that follow
> the
> hwmon sysfs ABI.
Yes, we do want to use the hwmon sysfs ABI at the beginning.
But there are several gaps that making us turn to a new thermal sysfs
class. And the biggest one is that hwmon does NOT support ACPI passive
cooling devices like processor, video, etc. intel menlow platform even
has a ACPI memory controller device which can be throttled by changing
the bandwidth. These are quite different from the hwmon's fan-based
thermal management, right?

thanks,
rui


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
