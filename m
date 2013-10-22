From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 Oct 2013 12:04:25 +0000
Subject: Re: [lm-sensors] [REGRESSION?] sensors and fancontrol not seeing armada_thermal on 3.12-rc series
Message-Id: <20131022140425.10afc26c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ppqzolsu.fsf@natisbad.org>
	<20131021091739.739142e8@endymion.delvare>
	<20131021151616.GA17598@roeck-us.net>
In-Reply-To: <20131021151616.GA17598@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Arnaud Ebalard <arno@natisbad.org>, Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Jason Cooper <jason@lakedaemon.net>

Hi Guenter,

On Mon, 21 Oct 2013 08:16:16 -0700, Guenter Roeck wrote:
> I think it is more likely that the problem is related to parsing the 'subsystem'
> link. If I understand the code in lib/sysfs.c correctly, it doesn't recognize
> 'thermal' (which I think is the subsystem name, but I may be wrong) and ignores
> the device as unknown.

Yes, you are right, that's exactly what is happening here.

> Question is if we can come up with some more generic code to handle that case.
> Define SENSORS_BUS_TYPE_OTHER and treat it similar to virtual, maybe ?
> But then there can be more than one of those, so you would need some means
> for enumerating bus and chip numbers, so I don't know if that is feasible.

The whole point of identifying the subsystem is because we want to
assign a unique, stable identifier to each chip, and the naming scheme
depends on the subsystem. If we start treating all unsupported
subsystems as "other", we simply won't be able to give these devices
unique names. Developers and users are unlikely to care and report the
problem to us if libsensors shows them their "foo-other-0" device. This
is why libsensors ignores these devices: developers and users will
report about the missing device and we can add proper support to
libsensors. That way we can get the naming scheme right immediately
instead of later when this will break running configurations.

Commit b82715fdd4a5407f56853b24d387d484dd9c3b5b is simply wrong, so it
should be reverted. It assumes that there's a 1:1 mapping between
thermal zones and hwmon devices, which is not the case. See this
comment near the top of thermal_hwmon.c:

/* thermal zone devices with the same type share one hwmon device */

So associating the hwmon device with the first registered thermal zone
of its kind is arbitrary and asymmetric and makes no sense. I don't
know what the goal of that change was, but that will have to be
achieved in a different way.

Note that merging all thermal zones of one kind into a single hwmon
device is exactly what makes it possible to treat it as a virtual
device and still guarantee uniqueness of the identifier (e.g.
acpitz-virtual-0.) It has the drawback of leaving the input ordering
stability up to the kernel, but back then it was not considered an
issue.

If we now want to have one hwmon device per thermal zone, then the
kernel must provide a way for libsensors to give each of them a unique
and stable identifier. Naming scheme is relatively free.

Note that I am not necessarily in favor of such a change, as 1* it
could lead to a huge number of hwmon devices, making the output of
"sensors" harder to read, and 2* the change could break existing
configurations. So if anyone wants to change this, a really really good
reason must be provided, i.e. you will have to demonstrate that the
benefits outweigh the pain.

Hope it helps,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
