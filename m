From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 10 Jan 2012 22:01:39 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon (k8temp): fix checkpatch issues
Message-Id: <1326232900-326-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

resolved:
WARNING: line over 80 characters
ERROR: do not use assignment in if condition

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/k8temp.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index d985ae3..5751019 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -46,7 +46,7 @@ struct k8temp_data {
 	unsigned long last_updated;	/* in jiffies */
 
 	/* registers values */
-	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
+	u8 sensorsp;		/* sensor presence bits - SEL_CORE, SEL_PLACE */
 	u32 temp[2][2];		/* core, place */
 	u8 swap_core_select;    /* meaning of SEL_CORE is inverted */
 	u32 temp_offset;
@@ -63,7 +63,7 @@ static struct k8temp_data *k8temp_update_device(struct device *dev)
 	if (!data->valid
 	    || time_after(jiffies, data->last_updated + HZ)) {
 		pci_read_config_byte(pdev, REG_TEMP, &tmp);
-		tmp &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
+		tmp &= ~(SEL_PLACE | SEL_CORE);	/* Select sensor 0, core0 */
 		pci_write_config_byte(pdev, REG_TEMP, tmp);
 		pci_read_config_dword(pdev, REG_TEMP, &data->temp[0][0]);
 
@@ -82,7 +82,7 @@ static struct k8temp_data *k8temp_update_device(struct device *dev)
 					      &data->temp[1][0]);
 
 			if (data->sensorsp & SEL_PLACE) {
-				tmp |= SEL_PLACE;	/* Select sensor 1, core1 */
+				tmp |= SEL_PLACE; /* Select sensor 1, core1 */
 				pci_write_config_byte(pdev, REG_TEMP, tmp);
 				pci_read_config_dword(pdev, REG_TEMP,
 						      &data->temp[1][1]);
@@ -183,7 +183,8 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 	u8 model, stepping;
 	struct k8temp_data *data;
 
-	if (!(data = kzalloc(sizeof(struct k8temp_data), GFP_KERNEL))) {
+	data = kzalloc(sizeof(struct k8temp_data), GFP_KERNEL);
+	if (!data) {
 		err = -ENOMEM;
 		goto exit;
 	}
@@ -217,7 +218,7 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 		data->temp_offset = 21000;
 
 	pci_read_config_byte(pdev, REG_TEMP, &scfg);
-	scfg &= ~(SEL_PLACE | SEL_CORE);		/* Select sensor 0, core0 */
+	scfg &= ~(SEL_PLACE | SEL_CORE);	/* Select sensor 0, core0 */
 	pci_write_config_byte(pdev, REG_TEMP, scfg);
 	pci_read_config_byte(pdev, REG_TEMP, &scfg);
 
@@ -238,7 +239,7 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 		pci_write_config_byte(pdev, REG_TEMP, scfg);
 		pci_read_config_dword(pdev, REG_TEMP, &temp);
 		scfg |= SEL_CORE;	/* prepare for next selection */
-		if (!((temp >> 16) & 0xff))	/* if temp is 0 -49C is not likely */
+		if (!((temp >> 16) & 0xff)) /* if temp is 0 -49C is unlikely */
 			data->sensorsp &= ~SEL_PLACE;
 	}
 
@@ -246,7 +247,7 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 		scfg &= ~SEL_PLACE;	/* Select sensor 0, core1 */
 		pci_write_config_byte(pdev, REG_TEMP, scfg);
 		pci_read_config_dword(pdev, REG_TEMP, &temp);
-		if (!((temp >> 16) & 0xff))	/* if temp is 0 -49C is not likely */
+		if (!((temp >> 16) & 0xff)) /* if temp is 0 -49C is unlikely */
 			data->sensorsp &= ~SEL_CORE;
 	}
 
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
