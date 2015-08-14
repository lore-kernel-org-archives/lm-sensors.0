From: Dustin Byford <dustin@cumulusnetworks.com>
Date: Fri, 14 Aug 2015 19:37:13 +0000
Subject: [lm-sensors] [RFC 0/1] i2c: acpi: revert setting a "stable" device name
Message-Id: <1439581034-5972-1-git-send-email-dustin@cumulusnetworks.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

70762ab from 11/2014 (i2c: Use stable dev_name for ACPI enumerated I2C
slaves) modified the sysfs-visible dev_name() for ACPI enumerated I2C
devices.  With that change, /sys/bus/i2c/devices/i2c-0-004a, for
example, became /sys/bus/i2c/devices/i2c-PNPXXXX:xx

That causes problems for userspace code such as 'sensors' which does
this:

lib/sysfs.c:665:
if ((!subsys || !strcmp(subsys, "i2c")) &&
    sscanf(dev_name, "%hd-%x", &entry.chip.bus.nr,
           &entry.chip.addr) = 2) {
...

Therefore, in theory, sensors that were previously visible by running
'sensors' no longer show up.  On the other hand, there are probably few,
if any, cases of this because ACPI enumerated I2C hwmon devices are not
common.

I'm not defending the 'sensors' code, I'm sure there are better ways to
discover a hwmon I2C device from userspace.  But, I'm also not sure
70762ab achieved its stated goal in a meaningful way.  Won't
"i2c-<acpi_dev_name>" also vary with ACPI scan order, BIOS settings,
firmware upgrades, etc...?

Hence the RFC patch.  To submit a change like this I would need to
consider the fallout for ALSA SoC.  The other option is to see what can
be done in 'sensors' to include the ACPI enumerated hwmon devices.

Any opinions on which way to go?

   --Dustin

Dustin Byford (1):
  i2c: acpi: revert setting a "stable" device name

 drivers/i2c/i2c-core.c | 7 -------
 1 file changed, 7 deletions(-)

-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
