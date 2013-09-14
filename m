From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:32 +0000
Subject: [lm-sensors] [PATCH 09/12] hwmon: (acpi_power_meter) Use return value from acpi_bus_register_driver
Message-Id: <1379147615-7703-10-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

acpi_bus_register_driver() returns a valid error code. Use it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/acpi_power_meter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 51b045b..8d40da3 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -996,7 +996,7 @@ static int __init acpi_power_meter_init(void)
 
 	result = acpi_bus_register_driver(&acpi_power_meter_driver);
 	if (result < 0)
-		return -ENODEV;
+		return result;
 
 	return 0;
 }
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
