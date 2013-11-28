From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 02:18:28 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (i5k_amb) use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <001801ceebe0$2070ad20$61520760$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/i5k_amb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index 6c0080a..0d33f72 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -495,7 +495,7 @@ static struct {
 };
 
 #ifdef MODULE
-static struct pci_device_id i5k_amb_ids[] = {
+static DEFINE_PCI_DEVICE_TABLE(i5k_amb_ids) = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5000_ERR) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_5400_ERR) },
 	{ 0, }
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
