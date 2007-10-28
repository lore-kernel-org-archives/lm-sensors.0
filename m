From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2007 21:16:08 +0000
Subject: Re: [lm-sensors] PATCH: add support for lm_sensors 3.0.0 to gkrellm
Message-Id: <20071028221608.4d87fc9d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <472463E8.8060109@hhs.nl>
In-Reply-To: <472463E8.8060109@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Oct 2007 15:23:23 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > name->path can't actually be NULL. BTW, I wonder why you need
> > name->path at all. This is meant for libsensors internal use,
> > applications shouldn't care about it. Also note that the path is not
> > guaranteed to be consistent across reboots.
> 
> gkrellm used todo all reading of sysfs files (and other type of info like ibm 
> acpi) itself, it has an interface for this where the read_method for a sensors 
> "driver" (for example direct /sysfs access, libsensors, hddtemp deamon, ...) 
> gets passed 1 string and 2 ints.  The above and below code is a way of 
> shoehorning libsensors chip_name struct into one string and one int (the second 
> int is used for the feature number).

OK, but now with the new libsensors, there's really no reason why
gkrellm would want to read from sysfs directly. So why not simply drop
this possibility to make the code more simple?

> (...)
> > Unfortunately not: for SPI, the bus number can require 16 bits. It's
> > due to the weird way spi-core uses to number buses dynamically, it
> > should really be addressed someday, but at the moment it isn't.
> > 
> 
> UGH, how often does this happen? Note that currently gkrellm will simply skip 
> sensors for which the bus number > 8 bits. I've noticed that the pointers 
> returned by: sensors_get_detected_chips are constant between calls to 
> sensors_init() and sensors_cleanup(), so I could change the shoehorning to put 
> a pointer to the chipname in hex format into the string (on 64 bit it won't fit 
> into an int) but that feels really really dirty!

It happens each time an SPI bus is numbered dynamically (i.e. isn't
considered one of "main" SPI buses of the system.) Typically this
happens when doing SPI over parallel port. But at the moment, the only
SPI hardware monitoring device we support is the LM70, and I'm not sure
how used it is... probably not much.

So it's not a big problem IMHO, especially as whoever is using the SPI
bus for hardware monitoring purposes most probably isn't running
gkrellm. If I were you I wouldn't bother, your time can probably be
used better for other tasks. Whoever really cares would better fix the
SPI bus numbering algorithm in the kernel anyway.

> (...)
> > rc3 is released now, so you could proceed. However you'll need special
> > permissions to edit the Download page. So I can either grant you these
> > permissions if you want, or I can add the link for you if you prefer.
> 
> Either way is fine with me, but I'll probably be doing more patches as time 
> permits and I would like to put those on the wiki too, so I guess having 
> editing rights is the easiest in the end.

You are now a wiki admin, so you can edit read-only pages. Handle with
care ;)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
