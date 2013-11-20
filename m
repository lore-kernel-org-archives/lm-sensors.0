From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 20 Nov 2013 04:04:59 +0000
Subject: [lm-sensors] [RFC PATCH] hwmon: (coretemp) Define minimum reported temperature for some Atom CPUs
Message-Id: <1384920299-15392-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On some Atom CPUs (330, D5xx), the 'valid' bit in MSR_IA32_THERM_STATUS is 0
if the temperature is lower than a processor dependent threshold. For CPUs known
to be affected, report a more or less arbitrary minimum temperature if this is
the case. Report the same temperature if the temperature read from
MSR_IA32_THERM_STATUS is below that value, as it is known to be highly
inaccurate and typically much too low.

Cc: Mike Gilbert <mike@baymicrosystems.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Something like this ?

 drivers/hwmon/coretemp.c |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 310ce19..9862728 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -85,6 +85,7 @@ struct temp_data {
 	int temp;
 	int ttarget;
 	int tjmax;
+	int tjmin;
 	unsigned long last_updated;
 	unsigned int cpu;
 	u32 cpu_core_id;
@@ -184,6 +185,11 @@ static ssize_t show_temp(struct device *dev,
 					((eax >> 16) & 0x7f) * 1000;
 			tdata->valid = 1;
 		}
+		if (tdata->tjmin && (!tdata->valid ||
+				     tdata->temp < tdata->tjmin)) {
+			tdata->temp = tdata->tjmin;
+			tdata->valid = 1;
+		}
 		tdata->last_updated = jiffies;
 	}
 
@@ -206,23 +212,25 @@ static const struct tjmax_pci tjmax_pci_table[] __cpuinitconst = {
 struct tjmax {
 	char const *id;
 	int tjmax;
+	int tjmin;
 };
 
 static const struct tjmax tjmax_table[] = {
 	{ "CPU  230", 100000 },		/* Model 0x1c, stepping 2	*/
-	{ "CPU  330", 125000 },		/* Model 0x1c, stepping 2	*/
+	{ "CPU  330", 125000, 36000 },	/* Model 0x1c, stepping 2	*/
 };
 
 struct tjmax_model {
 	u8 model;
 	u8 mask;
 	int tjmax;
+	int tjmin;
 };
 
 #define ANY 0xff
 
 static const struct tjmax_model tjmax_model_table[] = {
-	{ 0x1c, 10, 100000 },	/* D4xx, K4xx, N4xx, D5xx, K5xx, N5xx */
+	{ 0x1c, 10, 100000, 36000 },	/* D4xx, K4xx, N4xx, D5xx, K5xx, N5xx */
 	{ 0x1c, ANY, 90000 },	/* Z5xx, N2xx, possibly others
 				 * Note: Also matches 230 and 330,
 				 * which are covered by tjmax_table
@@ -392,6 +400,25 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 	return adjust_tjmax(c, id, dev);
 }
 
+static int get_tjmin(struct cpuinfo_x86 *c, u32 id, struct device *dev)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tjmax_table); i++) {
+		if (strstr(c->x86_model_id, tjmax_table[i].id))
+			return tjmax_table[i].tjmin;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(tjmax_model_table); i++) {
+		const struct tjmax_model *tm = &tjmax_model_table[i];
+		if (c->x86_model = tm->model &&
+		    (tm->mask = ANY || c->x86_mask = tm->mask))
+			return tm->tjmin;
+	}
+
+	return 0;
+}
+
 static int create_name_attr(struct platform_data *pdata,
 				      struct device *dev)
 {
@@ -528,6 +555,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 
 	/* We can access status register. Get Critical Temperature */
 	tdata->tjmax = get_tjmax(c, cpu, &pdev->dev);
+	tdata->tjmin = get_tjmin(c, cpu, &pdev->dev);
 
 	/*
 	 * Read the still undocumented bits 8:15 of IA32_TEMPERATURE_TARGET.
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
