From: Rene Herman <rene.herman@keyaccess.nl>
Date: Sun, 22 Jun 2008 00:47:24 +0000
Subject: [lm-sensors] LMSENSORS: 2.6.26-rc,
Message-Id: <485DA11C.7050906@keyaccess.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

Good day.

On 2.6.26-rc and perhaps earlier, when I enable the ACPI Thermal Zone 
support (CONFIG_ACPI_THERMAL) I see in dmesg:

ACPI: LNXTHERM:01 is registered as thermal_zone0
ACPI: Thermal Zone [THRM] (56 C)

My /sys/class/hwmon/hwmon0 (a W83782D chip) becomes hwmon1, there's a 
new /sys/class/hwmon/hwmon0 and "sensors -s" craps out with:

# sensors -s
Can't access procfs/sysfs file
Kernel interface access error
For 2.6 kernels, make sure you have mounted sysfs and libsensors
was compiled with sysfs support!

# sensors --version
sensors version 2.10.6 with libsensors version 2.10.6

This is the slackware 12.1 (recent) standard version. What's wrong?

In case it's useful, my /etc/sensors.conf is at:

http://members.home.nl/rene.herman/sensors.conf

Rene.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
