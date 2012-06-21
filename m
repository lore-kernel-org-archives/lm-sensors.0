From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 21 Jun 2012 13:56:53 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (acpi_power_meter) Fix unintentional integer overflow
Message-Id: <1340287015-14008-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Expression with two integer variables is calculated as integer before it is
converted to u64. This may result in an integer overflow. Fix by declaring
the constant as ULL.

This patch addresses Coverity #200596: Unintentional integer overflow.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/acpi_power_meter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 9a0821f1..c8ac1c6 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -434,7 +434,7 @@ static ssize_t show_val(struct device *dev,
 		if (resource->trip[attr->index - 7] < 0)
 			return sprintf(buf, "unknown\n");
 
-		val = resource->trip[attr->index - 7] * 1000;
+		val = resource->trip[attr->index - 7] * 1000ULL;
 		break;
 	default:
 		BUG();
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
