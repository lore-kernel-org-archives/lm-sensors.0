From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Apr 2013 03:52:11 +0000
Subject: Re: [lm-sensors] IT8772E Test
Message-Id: <20130404035211.GA21201@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365042247.19144.9.camel@janus>
In-Reply-To: <1365042247.19144.9.camel@janus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 03, 2013 at 07:24:07PM -0700, James Webb wrote:
> Running a Dell XPS-8300
> sensors-detect reports:
> Found `ITE IT8772E Super IO Sensors'                        Success!
>     (address 0xa30, driver `to-be-written')
> Compiled standalone driver but either modprobe it87 or modprobe it87
> force_id=0x8721 results in:
> FATAL: Error inserting it87
> (/lib/modules/3.8.5-gentoo/kernel/drivers/hwmon/it87.ko): Device or
> resource busy
> 
> Any suggestions?
> 
Some other device has its io memory space reserved, or the io memory
space is reserved by ACPI (which is more likely). In the latter case,
you should see an acpi resource conflict message on the console
(or with dmesg).  Otherwise, 'cat /proc/ioports' should give you
an idea about the offending driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
