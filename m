From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Jul 2009 08:49:22 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
Message-Id: <20090713104922.3294795f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
In-Reply-To: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Tobias,

On Sun, 12 Jul 2009 22:43:12 +0200, Tobias Hain wrote:
> Hello Jean,
> 
> > So while I wouldn't want to hide the hardware monitoring support
> > of the VIA 686 in another driver, I would be totally fine with adding
> > temperature reporting to whatever driver is already handling the Intel
> > 965. At this point I still believe this is the way to go.
> 
> intel-agp.c contains the device ids for all intel host bridges. None of the
> symbols (= device ids) intel-agp.c used has been exported to
> include/linux/pci_ids.h and I guess there's a reason for this.

I don't quite follow you... what would that reason be?

> intel-agp.c has 2432 LOC and only deals with AGP/GART table management. I
> don't think anybody would be amused to see other code in there.

Well, the driver posted by Lu was rather small, and most of it is for
device management, not functionality. Adding temperature reading to
another driver would probably fit in 250 lines.

> I don't see
> other infrastructure in place (e.g. dispatchers) to management access from
> multiple modules.

Just because something isn't there doesn't mean we don't want to
implement it. Maybe nobody had the need so far.

> Do you have a successful example where temperature reading and evaluating is
> done in an unrelated kernel module? To have a look at how they did it.

A quick grep reveals these drivers:

drivers/input/touchscreen/ads7846.c
drivers/platform/x86/eeepc-laptop.c
drivers/platform/x86/thinkpad_acpi.c
drivers/thermal/thermal_sys.c

But there may be other drivers which do export temperature readings
without registering a proper hwmon class device.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
