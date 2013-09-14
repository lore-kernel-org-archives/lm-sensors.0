From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:31 +0000
Subject: [lm-sensors] [PATCH 08/12] hwmon: (acpi_power_meter) Don't crash the kernel unnecessarily
Message-Id: <1379147615-7703-9-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

acpi_power_meter crashes the kernel if it detects an unexpected event
or an internal implementation error. While the detected conditions
suggest that there is a bug in the code, the condition is not fatal.
Replace BUG() with WARN().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/acpi_power_meter.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index a9e3d01..51b045b 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -381,8 +381,10 @@ static ssize_t show_str(struct device *dev,
 		val = resource->oem_info;
 		break;
 	default:
-		BUG();
+		WARN(1, "Implementation error: unexpected attribute index %d\n",
+		     attr->index);
 		val = "";
+		break;
 	}
 
 	return sprintf(buf, "%s\n", val);
@@ -436,7 +438,9 @@ static ssize_t show_val(struct device *dev,
 		val = resource->trip[attr->index - 7] * 1000;
 		break;
 	default:
-		BUG();
+		WARN(1, "Implementation error: unexpected attribute index %d\n",
+		     attr->index);
+		break;
 	}
 
 	return sprintf(buf, "%llu\n", val);
@@ -855,7 +859,8 @@ static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
 		dev_info(&device->dev, "Capping in progress.\n");
 		break;
 	default:
-		BUG();
+		WARN(1, "Unexpected event %d\n", event);
+		break;
 	}
 	mutex_unlock(&resource->lock);
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
