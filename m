From: Dustin Byford <dustin@cumulusnetworks.com>
Date: Tue, 25 Aug 2015 05:03:29 +0000
Subject: Re: [lm-sensors] [RFC 0/1] i2c: acpi: revert setting a "stable" device name
Message-Id: <20150825050329.GC21569@cumulusnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1439581034-5972-1-git-send-email-dustin@cumulusnetworks.com>
 <20150815151302.GA10020@roeck-us.net>
 <55D1948C.6080501@linux.intel.com>
In-Reply-To: <55D1948C.6080501-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon Aug 17 11:00, Jarkko Nikula wrote:

> If I remember correctly ACPI ID should not ever change and instance id :xy
> after INTABCD:xy should also be visible and keep the order even if device is
> disabled or not plugged. But I'm not absolute sure about this.
> 
> At least on a test platform that allow disable devices will show those
> devices off-line (/sys/bus/acpi/devices/INTABCD:xy/status = 0).

I'm always surprised how hard it is to tell what *can't* happen in ACPI.
How about a conditional call to LoadTable()?  Seems like that would mess
up the :xy.  Moot point, I think you're on the right track in your RFC
patch.

		--Dustin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
