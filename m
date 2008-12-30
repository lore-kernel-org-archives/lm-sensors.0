From: Gabriel C <crazy@frugalware.org>
Date: Tue, 30 Dec 2008 14:01:13 +0000
Subject: Re: [lm-sensors] [RFC] Asus ATK0110 ACPI hwmon driver
Message-Id: <495A29A9.9030305@frugalware.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081229205537.GA11072@dreamland.darkstar.lan>
In-Reply-To: <20081229205537.GA11072@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Luca Tettamanti wrote:

> Hello,


Hi Luca ,

> I'm once again submitting my driver for ASUS ATK0110 sensor interface,
> re-based against kernel v2.6.28. Comments are welcome :)


Thx again :-)

> 
> Asus boards have an ACPI interface for interacting with the hwmon (fan,
> temperatures, voltages) subsystem; this driver exposes the relevant
> information via the standard sysfs interface.
> 
> There are two different ACPI interfaces:
> - an old one (based on RVLT/RFAN/RTMP)
> - a new one (GGRP/GITM)
> Both may be present but there a few cases (my board, sigh) where the
> new interface is just an empty stub; the driver defaults to the old one
> when both are present.
> The old interface has received a considerable testing, but I'm still
> awaiting confirmation from my tester that the new one is working as
> expected (hence the debug code is still enabled).
> 
> Currently all the attributes are read-only, though a (partial) control
> should be possible with a bit more work.
> 


Your patch works fine on my motherboard , here is the output when loading the driver :


....

[    7.269649] ATK0110 ATK0110:00: adding...
[    7.275802] ATK0110 ATK0110:00: board ID = P5E-VM DO
[    7.275833] ATK0110 ATK0110:00: Using old hwmon interface
[    7.276047] ATK0110 ATK0110:00: voltage: 0x6020000 Vcore Voltage [850-1600] enabled
[    7.276055] ATK0110 ATK0110:00: Sensor 0 is valid, type 0x2
[    7.276064] ATK0110 ATK0110:00: voltage: 0x6020001  +3.3 Voltage [2970-3630] enabled
[    7.276069] ATK0110 ATK0110:00: Sensor 1 is valid, type 0x2
[    7.276082] ATK0110 ATK0110:00: voltage: 0x6020002  +5 Voltage [4500-5500] enabled
[    7.276088] ATK0110 ATK0110:00: Sensor 2 is valid, type 0x2
[    7.276099] ATK0110 ATK0110:00: voltage: 0x6020003  +12 Voltage [10200-13800] enabled
[    7.276105] ATK0110 ATK0110:00: Sensor 3 is valid, type 0x2
[    7.276286] ATK0110 ATK0110:00: temperature: 0x6030000 CPU Temperature [600-950] enabled
[    7.276292] ATK0110 ATK0110:00: Sensor 4 is valid, type 0x3
[    7.276299] ATK0110 ATK0110:00: temperature: 0x6030001 MB Temperature [450-950] enabled
[    7.276303] ATK0110 ATK0110:00: Sensor 5 is valid, type 0x3
[    7.276461] ATK0110 ATK0110:00: fan: 0x6040000 CPU FAN Speed [600-7200] enabled
[    7.276466] ATK0110 ATK0110:00: Sensor 6 is valid, type 0x4
[    7.276475] ATK0110 ATK0110:00: fan: 0x6040001 CHASSIS FAN Speed [600-7200] enabled
[    7.276478] ATK0110 ATK0110:00: Sensor 7 is valid, type 0x4
[    7.276486] ATK0110 ATK0110:00: registering hwmon device
[    7.276640] ATK0110 ATK0110:00: populating sysfs directory

...

however do I need some patches against lmsensors 2.* / 3.* to make sensors display the data from the ATK driver ?

( I use your patch with latest tip/master kernel )


Regards,

Gabriel 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
