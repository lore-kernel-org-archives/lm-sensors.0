From: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
Date: Thu, 10 Jul 2014 22:16:00 +0000
Subject: [lm-sensors] [PATCH] hwmon, fam15h_power: Remove needless pci dev id
Message-Id: <1405030560-2128-1-git-send-email-Aravind.Gopalakrishnan@amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: herrmann.der.user@googlemail.com, jdelvare@suse.de, linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>

PCI_DEVICE_ID_AMD_16H_NB_F4 can be obtained from it's
definition in pci_ids.h. So we don't have to define it
again here.

Signed-off-by: Aravind Gopalakrishnan <Aravind.Gopalakrishnan@amd.com>
---
 drivers/hwmon/fam15h_power.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index 6040121..d442000 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -31,9 +31,6 @@ MODULE_DESCRIPTION("AMD Family 15h CPU processor power monitor");
 MODULE_AUTHOR("Andreas Herrmann <herrmann.der.user@googlemail.com>");
 MODULE_LICENSE("GPL");
 
-/* Family 16h Northbridge's function 4 PCI ID */
-#define PCI_DEVICE_ID_AMD_16H_NB_F4	0x1534
-
 /* D18F3 */
 #define REG_NORTHBRIDGE_CAP		0xe8
 
-- 
1.8.1.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
