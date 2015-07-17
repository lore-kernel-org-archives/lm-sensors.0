From: Adam Majer <adamm@zombino.com>
Date: Fri, 17 Jul 2015 02:47:49 +0000
Subject: [lm-sensors] [PATCH] [hwmon]: (k10temp) remove duplicate pci-id define
Message-Id: <1437101269-16620-1-git-send-email-adamm@zombino.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

PCI_DEVICE_ID_AMD_15H_M60H_NB_F3 is now defined in pci_ids.h
---
 drivers/hwmon/k10temp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 1e7bdcd..9cdfde6 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -60,7 +60,6 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
  * Control]
  */
 #define F15H_M60H_REPORTED_TEMP_CTRL_OFFSET	0xd8200ca4
-#define PCI_DEVICE_ID_AMD_15H_M60H_NB_F3	0x1573
 
 static void amd_nb_smu_index_read(struct pci_dev *pdev, unsigned int devfn,
 				  int offset, u32 *val)
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
