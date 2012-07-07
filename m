From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 07 Jul 2012 21:02:16 +0000
Subject: [lm-sensors] [PATCH 0/4] PM / hwmon: Convert platform hwmon drivers to PM handling based on struct d
Message-Id: <201207072302.16491.rjw@sisk.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, Alistair John Strachan <alistair@devzero.co.uk>, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene.kim@samsung.com>

Hi all,

As per

http://marc.info/?l=linux-kernel&m3996733422413&w=4

the following patches convert the platform TPM drivers to the PM handling
based on struct dev_pm_ops:

[1/4] abituguru: Use struct dev_pm_ops for power management.
[2/4] abituguru3: Use struct dev_pm_ops for power management.
[3/4] gpio-fan: Use struct dev_pm_ops for power management.
[4/4] exynos4_tmu: Use struct dev_pm_ops for power management.

Thanks,
Rafael


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
