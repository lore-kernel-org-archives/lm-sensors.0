From: Yijing Wang <wangyijing@huawei.com>
Date: Wed, 20 Nov 2013 09:28:23 +0000
Subject: [lm-sensors] [PATCH 1/4] ACPI/hwmon: Fix acpi_bus_get_device() return value check
Message-Id: <1384939706-6292-2-git-send-email-wangyijing@huawei.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since acpi_bus_get_device() returns plain int and not acpi_status,
ACPI_FAILURE() should not be used for checking its return value.  Fix
that.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Cc: lm-sensors@lm-sensors.org
---
 drivers/hwmon/acpi_power_meter.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 8d40da3..6a34f7f 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -602,9 +602,8 @@ static int read_domain_devices(struct acpi_power_meter_resource *resource)
 
 		/* Create a symlink to domain objects */
 		resource->domain_devices[i] = NULL;
-		status = acpi_bus_get_device(element->reference.handle,
-					     &resource->domain_devices[i]);
-		if (ACPI_FAILURE(status))
+		if (acpi_bus_get_device(element->reference.handle,
+					&resource->domain_devices[i]))
 			continue;
 
 		obj = resource->domain_devices[i];
-- 
1.7.1



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
