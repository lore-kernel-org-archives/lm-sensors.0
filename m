From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Apr 2008 19:40:07 +0000
Subject: [lm-sensors] Temperature in generic thermal zone not updated
Message-Id: <20080409214007.4d81e43f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rui,

I am testing your generic thermal zone driver on my old Sony laptop
(Vaio PCG-GR214EP) and I have noticed that the temperature reported by
the generic thermal zone interface
(/sys/class/thermal/thermal_zone0/temp) isn't updated. The reported
value is always the same, until I read
from /proc/acpi/thermal_zone/ATF0/temperature. After that the value
in /sys/class/thermal/thermal_zone0/temp matches the one reported
in /proc/acpi/thermal_zone/ATF0/temperature, but doesn't change again
until the next access to /proc/acpi/thermal_zone/ATF0/temperature.

This is with polling disabled on the ACPI thermal zone (the default on
my system). If I set polling to 2 seconds, then reading
from /sys/class/thermal/thermal_zone0/temp shows changing values as
expected.

So it seems to me that reading
from /proc/acpi/thermal_zone/ATF0/temperature updates the temperature
value when polling is disabled, while reading
from /sys/class/thermal/thermal_zone0/temp only returns a cached value.
Is it correct? I think that the generic thermal driver should be fixed
to update the temperature values properly.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
