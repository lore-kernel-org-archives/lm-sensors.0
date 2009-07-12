From: "Tobias Hain" <tobias.hain@gmx.de>
Date: Sun, 12 Jul 2009 17:20:41 +0000
Subject: Re: [lm-sensors] [PATCH 2.6.31-rc2] hwmon: add support for
Message-Id: <AC9A52749C094C22B21FD352B34183F6@delline>
List-Id: <lm-sensors.vger.kernel.org>
References: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
In-Reply-To: <73511e6c0907090641v506ba4a2pa9a1e93a69dd2fd1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,

Jean Delvare wrote:

> lu zhihe wrote:
>
>> +static unsigned long chipset_ids[] = {
>> +	PCI_DEVICE_ID_INTEL_82965GM,
>> +	PCI_DEVICE_ID_INTEL_82965GME,
>> +	0
>> +};
>
> I am also curious what these PCI devices are. We do not want to have
> driver conflicts, so it might make more sense to add hardware
> monitoring functionality to an existing driver than writing a brand new
> driver.

He is talking to the Host Bridge Device 0 (D0:F0) of the Mobile Intel 965
Express Chipset. This includes the following intel chipsets:
PM965/GM965/GL960/GME965/GLE960. Basically the Santa Rosa chipset
northbridges.

This northbridges does have two temperature sensors according to the intel
spec (316273.pdf). He's reading one of the sensors and displaying its
temperature. I've tested the coded on my GM965 and it reports meaningful
values. I also put the northbridge under load (shared graphics) and its
temperature rises.

I see that other chipsets although southbridges also have their own  driver
e.g. SENSORS_VIA686A. To me it makes perfectly sense to put a hwmon driver
for intel MCH here and nowhere else. Even if other parts of the kernel touch
the same device, their functions should be orthogonal. If you look at the
VIA686A again: You wouldn't remove the driver from here just because the ATA
component of the same device is used by the libata drivers.

The intel Montevina (Centrino 2) platform comprised of GM45/GL40/GS45/PM45
also features the same registers and likely works with this driver (once
hardware support is extended to device id 0x2E10h, 2E20h, 2E30h, 2E40h,
2E90h).

All those are intel MCH (memory controller hub) north bridges. Some feature
a graphics engine - some not (such as PM965/PM45). I can't tell yet whether
for all those devices the sensors deliver meaningful values, but they
feature the same registers and documentation. However the hwmon module
shouldn't be called gm965temp in this case. I suggest something more general
like "imhc" to express "intel memory controller hub" and the documentation
to this module should refine for which chipsets support has been added and
tested.

Intel desktop Series 3 and 4 also feature similar temperature measurement
facilities. Slightly different registers (see TSTTP), but given that they
also report meaningful values those could be added to this driver in future.

Regards,
7oby


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
