From: Luca Tettamanti <kronos.it@gmail.com>
Date: Sat, 22 Jan 2011 15:07:11 +0000
Subject: [lm-sensors] [PATCH] hwmon: (asus_atk0110) Override interface
Message-Id: <1295708831-10623-1-git-send-email-kronos.it@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ASUS Sabertooth X58 has a bug in ACPI that prevents the reading of MCH
temperature when the "old" ATK0110 interface is used. Add a DMI entry
to override the detection heuristic and force the use of the "new"
interface on this board.

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
Tested-by: Joris Creyghton <jorisctn@gmail.com>
---
 drivers/hwmon/asus_atk0110.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/asus_atk0110.c b/drivers/hwmon/asus_atk0110.c
index 2d68cf3..b5e8920 100644
--- a/drivers/hwmon/asus_atk0110.c
+++ b/drivers/hwmon/asus_atk0110.c
@@ -13,6 +13,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/dmi.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acpixf.h>
@@ -22,6 +23,21 @@
 
 #define ATK_HID "ATK0110"
 
+static bool new_if;
+module_param(new_if, bool, 0);
+MODULE_PARM_DESC(new_if, "Override detection heuristic and force the use of the new ATK0110 interface");
+
+static const struct dmi_system_id __initconst atk_force_new_if[] = {
+	{
+		/* Old interface has broken MCH temp monitoring */
+		.ident = "Asus Sabertooth X58",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "SABERTOOTH X58")
+		}
+	},
+	{ }
+};
+
 /* Minimum time between readings, enforced in order to avoid
  * hogging the CPU.
  */
@@ -1302,7 +1318,9 @@ static int atk_probe_if(struct atk_data *data)
 	 * analysis of multiple DSDTs indicates that when both interfaces
 	 * are present the new one (GGRP/GITM) is not functional.
 	 */
-	if (data->rtmp_handle && data->rvlt_handle && data->rfan_handle)
+	if (new_if)
+		dev_info(dev, "Overriding interface detection\n");
+	if (data->rtmp_handle && data->rvlt_handle && data->rfan_handle && !new_if)
 		data->old_interface = true;
 	else if (data->enumerate_handle && data->read_handle &&
 			data->write_handle)
@@ -1420,6 +1438,9 @@ static int __init atk0110_init(void)
 		return -EBUSY;
 	}
 
+	if (dmi_check_system(atk_force_new_if))
+		new_if = true;
+
 	ret = acpi_bus_register_driver(&atk_driver);
 	if (ret)
 		pr_info("acpi_bus_register_driver failed: %d\n", ret);
-- 
1.7.2.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
