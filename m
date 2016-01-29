From: Sudeep Holla <sudeep.holla@arm.com>
Date: Fri, 29 Jan 2016 17:35:52 +0000
Subject: [lm-sensors] [PATCH] hwmon: (vexpress) rename vexpress hwmon implementation
Message-Id: <1454088952-24722-1-git-send-email-sudeep.holla@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Rusty Russell <rusty@rustcorp.com.au>, Liviu Dudau <liviu.dudau@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org

The vexpress hwmon implementation is currently just called vexpress.
This is a problem because it clashes with another module with the same
name in regulators.

This patch renames the vexpress hwmon implementation to vexpress-hwmon
so that there will be no clash in the module namespace.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org
Reported-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwmon/Makefile                         | 2 +-
 drivers/hwmon/{vexpress.c => vexpress-hwmon.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/hwmon/{vexpress.c => vexpress-hwmon.c} (100%)

diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 30c94df31465..cfc09711810c 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -149,7 +149,7 @@ obj-$(CONFIG_SENSORS_TMP103)	+= tmp103.o
 obj-$(CONFIG_SENSORS_TMP401)	+= tmp401.o
 obj-$(CONFIG_SENSORS_TMP421)	+= tmp421.o
 obj-$(CONFIG_SENSORS_TWL4030_MADC)+= twl4030-madc-hwmon.o
-obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress.o
+obj-$(CONFIG_SENSORS_VEXPRESS)	+= vexpress-hwmon.o
 obj-$(CONFIG_SENSORS_VIA_CPUTEMP)+= via-cputemp.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
 obj-$(CONFIG_SENSORS_VT1211)	+= vt1211.o
diff --git a/drivers/hwmon/vexpress.c b/drivers/hwmon/vexpress-hwmon.c
similarity index 100%
rename from drivers/hwmon/vexpress.c
rename to drivers/hwmon/vexpress-hwmon.c
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
