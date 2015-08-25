From: Dustin Byford <dustin@cumulusnetworks.com>
Date: Tue, 25 Aug 2015 05:03:06 +0000
Subject: Re: [lm-sensors] [RFC] i2c: Revert back to old device naming for ACPI enumerated I2C slaves
Message-Id: <20150825050306.GB21569@cumulusnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440413522-7855-1-git-send-email-jarkko.nikula@linux.intel.com>
In-Reply-To: <1440413522-7855-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org

On Mon Aug 24 13:52, Jarkko Nikula wrote:

> I don't know how common ACPI enumerated I2C hwmon devices are but I guess
> they exists since Dustin notices this issue and wrote "With that change,
> /sys/bus/i2c/devices/i2c-0-004a, for example, became
> /sys/bus/i2c/devices/i2c-PNPXXXX:xx".

I wouldn't take my particular use case as evidence they are common, or
even they really exist.  I got here because I loaded a hwmon driver
using the _DSD/PRP0001 mechanism in ACPI.  In that case, those devices
have never worked with 'sensors'  Therefore, in that context, this
change is just fixing a bug.

I can't say much about other apps writing against the current sysfs
names.  18 months seems like a long time.

		--Dustin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
