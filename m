From: Jingoo Han <jg1.han@samsung.com>
Date: Thu, 28 Nov 2013 02:17:09 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (fam15h_power) use DEFINE_PCI_DEVICE_TABLE macro
Message-Id: <001701ceebdf$f0f70d00$d2e52700$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This macro is used to create a struct pci_device_id array.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/fam15h_power.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/fam15h_power.c b/drivers/hwmon/fam15h_power.c
index dff8410..dd0006c 100644
--- a/drivers/hwmon/fam15h_power.c
+++ b/drivers/hwmon/fam15h_power.c
@@ -132,7 +132,7 @@ static bool fam15h_power_is_internal_node0(struct pci_dev *f4)
  * counter saturations resulting in bogus power readings.
  * We correct this value ourselves to cope with older BIOSes.
  */
-static const struct pci_device_id affected_device[] = {
+static DEFINE_PCI_DEVICE_TABLE(affected_device) = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_15H_NB_F4) },
 	{ 0 }
 };
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
