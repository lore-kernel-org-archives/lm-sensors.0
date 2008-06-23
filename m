From: Rene Herman <rene.herman@keyaccess.nl>
Date: Mon, 23 Jun 2008 15:06:14 +0000
Subject: [lm-sensors] [PATCH 2.6.26-rc] ACPI Thermal Zone driver breaks
Message-Id: <485FBBE6.9000104@keyaccess.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, Zhang Rui <rui.zhang@intel.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, Jean Delvare <khali@linux-fr.org>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Linux Kernel <linux-kernel@vger.kernel.org>

Hi Linus.

2.6.26-rc gained a hwmon interface to the ACPI Thermal Zone driver
which unfortunately breaks lm-sensors 2 userspace and renders all
other (subsequent) hwmon sensors inoperable also.
 
Many systems, current slackware and derivative systems among them,
are using lm-sensors 2 and would be affected. A new lm-sensors
2.10.7 release is needed to fix this from the user side.

There's disagreement on how bad the problem is, what it should be
called and what correct levels of respect and gratitude are.
Thread at:

http://lkml.org/lkml/2008/6/21/173

Admittedly, with lm-sensors 2.10.7 around the corner now, there's
opportunity to not care all that deeply but I want to make sure
that everyone is aware of this as it is definitely going to be
reported and most importantly -- losing sensors can be a vital
mistake under some circumstances. Fortunately, it's not silent
breakage.

A previous patch just made the support optional:

http://lkml.org/lkml/2008/6/22/83

which also works but is not-nicer still.

Off to my shrubbery now...

Rene.

From 303b6d3f407def5aa15bedc1bc7ff3f090025fe5 Mon Sep 17 00:00:00 2001
From: Rene Herman <rene.herman@gmail.com>
Date: Sun, 22 Jun 2008 23:45:04 +0200
Subject: [PATCH] thermal: link the virtual/thermal/thermal_zoneN device for hwmon

2.6.26-rc gained a hwmon interface to the ACPI Thermal Zone
driver which unfortunately breaks lm-sensors 2 userspace and
renders all other (subsequent) hwmon sensors inoperable also.

Many systems, current slackware and derivative systems among them,
are using lm-sensors 2 and would be affected. A new lm-sensors
2.10.7 release is needed to fix this from the user side.

The problem is userspace tripping over an absent "device"
link in the ACPI Thermal Zone sysfs /sys/class/hwmon/hwmonN
directory. This just adds the virtual "thermal/thermal_zoneN"
device as a device backlink which satisfies lm-sensors again.

Tested and fairly obvious; a downside is that the ACPI Thermal
Zone driver gathers multiple thermal zones into one hwmon
interface which means the device link is sensible only for
the first thermal zone. Point here is just to not trip up
existing lm-sensors 2 systems though.

Signed-off-by: Rene Herman <rene.herman@gmail.com>
CC: Hans de Goede <j.w.r.degoede@hhs.nl>
CC: Zhang Rui <rui.zhang@intel.com>
CC: Mark M. Hoffman <mhoffman@lightlink.com>
CC: Jean Delvare <khali@linux-fr.org>
CC: linux-acpi@vger.kernel.org
CC: lm-sensors@lm-sensors.org
CC: linux-kernel@vger.kernel.org
---
 drivers/thermal/thermal_sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
index 6098787..c21e03c 100644
--- a/drivers/thermal/thermal_sys.c
+++ b/drivers/thermal/thermal_sys.c
@@ -357,7 +357,7 @@ thermal_add_hwmon_sysfs(struct thermal_zone_device *tz)
 
 	INIT_LIST_HEAD(&hwmon->tz_list);
 	strlcpy(hwmon->type, tz->type, THERMAL_NAME_LENGTH);
-	hwmon->device = hwmon_device_register(NULL);
+	hwmon->device = hwmon_device_register(&tz->device);
 	if (IS_ERR(hwmon->device)) {
 		result = PTR_ERR(hwmon->device);
 		goto free_mem;
-- 
1.5.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
