From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 28 Mar 2012 16:38:27 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (acpi_power_meter) Fix compiler warning seen in some configurations
Message-Id: <1332952708-4110-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

In some configurations, BUG() does not result in an endless loop but returns
to the caller. This results in the following compiler warning:

drivers/hwmon/acpi_power_meter.c: In function 'show_str':
drivers/hwmon/acpi_power_meter.c:380: warning: 'val' may be used uninitialized in this function

Fix the warning by setting val to an empty string after BUG().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/acpi_power_meter.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 554f046..f722cac 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -391,6 +391,7 @@ static ssize_t show_str(struct device *dev,
 		break;
 	default:
 		BUG();
+		val = "";
 	}
 
 	return sprintf(buf, "%s\n", val);
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
