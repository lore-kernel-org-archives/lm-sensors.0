From: Andreas Herrmann <andreas.herrmann3@amd.com>
Date: Mon, 15 Dec 2008 23:12:13 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (k8temp) fix temperature reporting
Message-Id: <20081215231213.GC7013@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Current Temperature for K8 RevG desktop CPUs is a "normalized value"
which can be below ambient temperature.

As a consequence lots of RevG systems report temperatures like:

 sensors
 k8temp-pci-00c3
 Adapter: PCI adapter
 Core0 Temp:
              +17C
 Core0 Temp:
               +3C
 Core1 Temp:
              +21C
 Core1 Temp:
               +5C

being quite below ambient temperature.
There are even reports of negative temperature values.

This patch corrects the temperature reporting of k8temp for
RevG desktop CPUs.

Cc: Rudolf Marek <r.marek@assembler.cz>
Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/k8temp.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index ff12281..b138f79 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -49,6 +49,7 @@ struct k8temp_data {
 	u8 sensorsp;		/* sensor presence bits - SEL_CORE & SEL_PLACE */
 	u32 temp[2][2];		/* core, place */
 	u8 swap_core_select;    /* meaning of SEL_CORE is inverted */
+	u32 temp_offset;
 };
 
 static struct k8temp_data *k8temp_update_device(struct device *dev)
@@ -116,13 +117,15 @@ static ssize_t show_temp(struct device *dev,
 	    to_sensor_dev_attr_2(devattr);
 	int core = attr->nr;
 	int place = attr->index;
+	int temp;
 	struct k8temp_data *data = k8temp_update_device(dev);
 
 	if (data->swap_core_select)
 		core = core ? 0 : 1;
 
-	return sprintf(buf, "%d\n",
-		       TEMP_FROM_REG(data->temp[core][place]));
+	temp = TEMP_FROM_REG(data->temp[core][place]) + data->temp_offset;
+
+	return sprintf(buf, "%d\n", temp);
 }
 
 /* core, place */
@@ -176,6 +179,16 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 				 "wrong - check erratum #141\n");
 		}
 
+		if (((model >= 0x68) && (model != 0xc1)) &&
+		    !(model = 0x68) && !(model = 0x6c) &&
+		    !(model = 0x7c))
+			/*
+			 * RevG desktop CPUs (i.e. no socket S1G1 parts)
+			 * need additional offset, otherwise reported
+			 * temperature is below ambient temperature
+			 */
+			data->temp_offset = 21000;
+
 		break;
 	}
 
-- 
1.6.0.4




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
