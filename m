From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 23 May 2011 20:42:47 +0000
Subject: [lm-sensors] [PATCH] hwmon: (coretemp) Add comments describing the
Message-Id: <1306184738-4933-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The coretemp driver provides a single set of device attributes for each physical
core of a HT CPU to avoid duplicate sensors. This functionality was introduced
with commit d883b9f0977269d519469da72faec6a7f72cb489.

Commit e40cc4bdfd4b89813f072f72bd9c7055814d3f0f extends this functionality to
register the HT sibling of a CPU which is taken offline, to ensure that
sensor attributes are provided if at least one HT sibling of a core is online.

Add comments into the code describing the functionality in some more detail.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Durgadoss R <durgadoss.r@intel.com>
---
I am not completely happy with the added comments nor with the description
above, so please feel free to chime in if you have an idea for a better
description.

 drivers/hwmon/coretemp.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index a00245e..9577c43 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -506,7 +506,13 @@ static int create_core_data(struct platform_data *pdata,
 	if (attr_no > MAX_CORE_DATA - 1)
 		return -ERANGE;
 
-	/* Skip if it is a HT core, Not an error */
+	/*
+	 * Provide a single set of attributes for all HT siblings of a core
+	 * to avoid duplicate sensors (the processor ID and core ID of all
+	 * HT siblings of a core is the same).
+	 * Skip if a HT sibling of this core is already online.
+	 * This is not an error.
+	 */
 	if (pdata->core_data[attr_no] != NULL)
 		return 0;
 
@@ -763,10 +769,20 @@ static void __cpuinit put_core_offline(unsigned int cpu)
 	if (pdata->core_data[indx] && pdata->core_data[indx]->cpu = cpu)
 		coretemp_remove_core(pdata, &pdev->dev, indx);
 
-	/* Online the HT version of this core, if any */
+	/*
+	 * If a core is taken offline, but a HT sibling of the same core is
+	 * still online, register the alternate sibling. This ensures that
+	 * exactly one set of attributes is provided as long as at least one
+	 * HT sibling of a core is online.
+	 */
 	for_each_sibling(i, cpu) {
 		if (i != cpu) {
 			get_core_online(i);
+			/*
+			 * Display temperature sensor data for one HT sibling
+			 * per core only, so abort the loop after one such
+			 * sibling has been found.
+			 */
 			break;
 		}
 	}
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
