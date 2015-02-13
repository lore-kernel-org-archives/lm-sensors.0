From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 13 Feb 2015 20:44:43 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (nct6775) Enable auxiliary fan monitoring on ASRock Z77 Pro4-M
Message-Id: <1423860283-3938-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Auxiliary fan monitoring is not enabled on ASRock Z77 Pro4-M
with BIOS version 2.00 if booted in UEFI Ultra-FastBoot mode.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 0445a52..4fcb481 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -57,6 +57,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 #include <linux/io.h>
 #include "lm75.h"
 
@@ -3199,6 +3200,26 @@ nct6775_check_fan_inputs(struct nct6775_data *data)
 		pwm6pin = false;
 	} else if (data->kind = nct6776) {
 		bool gpok = superio_inb(sioreg, 0x27) & 0x80;
+		const char *board_vendor, *board_name;
+
+		board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
+		board_name = dmi_get_system_info(DMI_BOARD_NAME);
+
+		if (board_name && board_vendor &&
+		    !strcmp(board_vendor, "ASRock")) {
+			/*
+			 * Auxiliary fan monitoring is not enabled on ASRock
+			 * Z77 Pro4-M if booted in UEFI Ultra-FastBoot mode.
+			 * Observed with BIOS version 2.00.
+			 */
+			if (!strcmp(board_name, "Z77 Pro4-M")) {
+				if ((data->sio_reg_enable & 0xe0) != 0xe0) {
+					data->sio_reg_enable |= 0xe0;
+					superio_outb(sioreg, SIO_REG_ENABLE,
+						     data->sio_reg_enable);
+				}
+			}
+		}
 
 		if (data->sio_reg_enable & 0x80)
 			fan3pin = gpok;
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
