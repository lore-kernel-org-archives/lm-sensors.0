From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Fri, 05 Dec 2008 17:50:50 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (k8temp) fix wrong sensor selection
Message-Id: <20081205175050.GC5581@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Meaning of ThermSenseCoreSel bit was inverted beginning with K8 RevF.
That means with current driver temp1/temp2 belong to core 1 and
temp3/temp4 belong to core 0 on a dual core K8 RevF/RevG CPU.

This patch ensures that temp1/temp2 always belong to core 0 and
temp3/temp4 to core 1 for all K8 revisions.

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/k8temp.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 712c208..894a929 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -49,6 +49,7 @@ struct k8temp_data {
 	/* registers values */
 	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
 	u32 temp[2][2];		/* core, place */
+	u8 swap_core_select;    /* meaning of SEL_CORE is inverted */
 };
 
 static struct k8temp_data *k8temp_update_device(struct device *dev)
@@ -118,6 +119,9 @@ static ssize_t show_temp(struct device *dev,
 	int place = attr->index;
 	struct k8temp_data *data = k8temp_update_device(dev);
 
+	if (data->swap_core_select)
+		core = core ? 0 : 1;
+
 	return sprintf(buf, "%d\n",
 		       TEMP_FROM_REG(data->temp[core][place]));
 }
@@ -162,8 +166,17 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 			err = -ENODEV;
 			goto exit;
 		}
+
 		dev_warn(&pdev->dev, "Temperature readouts might be wrong"
 			 " - check erratum #141\n");
+
+		/*
+		 * AMD NPT familys 0fh, i.e. RevF and RevG:
+		 * meaning of SEL_CORE bit is inverted
+		 */
+		if (model >= 0x40)
+			data->swap_core_select = 1;
+
 		break;
 	}
 
-- 
1.6.0.4




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
