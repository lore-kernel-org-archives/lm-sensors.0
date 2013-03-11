From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Date: Mon, 11 Mar 2013 02:21:46 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: ntc: Add DT support to NTC thermistor driver
Message-Id: <1362967787-22557-1-git-send-email-ch.naveen@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: devicetree-discuss@lists.ozlabs.org, khali@linux-fr.org, linux@roeck-us.net, dianders@chromium.org, naveenkrishna.ch@gmail.com, dg77.kim@samsung.com

This patch adds the DT support to NTC driver to parse the
platform data.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
---
 drivers/hwmon/ntc_thermistor.c |   93 ++++++++++++++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index d92b237..cfedbd3 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -26,6 +26,7 @@
 #include <linux/math64.h>
 #include <linux/platform_device.h>
 #include <linux/err.h>
+#include <linux/of.h>
 
 #include <linux/platform_data/ntc_thermistor.h>
 
@@ -37,6 +38,41 @@ struct ntc_compensation {
 	unsigned int	ohm;
 };
 
+static const struct platform_device_id ntc_thermistor_id[] = {
+	{ "ncp15wb473", TYPE_NCPXXWB473 },
+	{ "ncp18wb473", TYPE_NCPXXWB473 },
+	{ "ncp21wb473", TYPE_NCPXXWB473 },
+	{ "ncp03wb473", TYPE_NCPXXWB473 },
+	{ "ncp15wl333", TYPE_NCPXXWL333 },
+	{ },
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id ntc_match[] = {
+	{ .compatible = "ntc,ncp15wb473", .data = (void *)TYPE_NCPXXWB473 },
+	{ .compatible = "ntc,ncp18wb473", .data = (void *)TYPE_NCPXXWB473 },
+	{ .compatible = "ntc,ncp21wb473", .data = (void *)TYPE_NCPXXWB473 },
+	{ .compatible = "ntc,ncp03wb473", .data = (void *)TYPE_NCPXXWB473 },
+	{ .compatible = "ntc,ncp15wl333", .data = (void *)TYPE_NCPXXWL333 },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ntc_match);
+#endif
+
+/* Get NTC type either from device tree or platform data. */
+static enum ntc_thermistor_type thermistor_get_type
+				(struct platform_device *pdev)
+{
+	if (pdev->dev.of_node) {
+		const struct of_device_id *match;
+		match = of_match_node(of_match_ptr(ntc_match),
+						pdev->dev.of_node);
+		return (unsigned int)match->data;
+	}
+
+	return platform_get_device_id(pdev)->driver_data;
+}
+
 /*
  * A compensation table should be sorted by the values of .ohm
  * in descending order.
@@ -126,6 +162,27 @@ struct ntc_data {
 	char name[PLATFORM_NAME_SIZE];
 };
 
+#ifdef CONFIG_OF
+static void ntc_thermistor_parse_dt(struct ntc_thermistor_platform_data *pdata,
+							struct device_node *np)
+{
+	of_property_read_u32(np, "pullup-uV", &pdata->pullup_uV);
+	of_property_read_u32(np, "pullup-ohm", &pdata->pullup_ohm);
+	of_property_read_u32(np, "pulldown-ohm", &pdata->pulldown_ohm);
+	if (of_find_property(np, "connected-positive", NULL))
+		pdata->connect = NTC_CONNECTED_POSITIVE;
+	else /* status change should be possible if not always on. */
+		pdata->connect = NTC_CONNECTED_GROUND;
+}
+#else
+static void
+static void ntc_thermistor_parse_dt(struct ntc_thermistor_platform_data *pdata,
+							struct device_node *np)
+{
+	return;
+}
+#endif
+
 static inline u64 div64_u64_safe(u64 dividend, u64 divisor)
 {
 	if (divisor = 0 && dividend = 0)
@@ -313,9 +370,19 @@ static const struct attribute_group ntc_attr_group = {
 static int ntc_thermistor_probe(struct platform_device *pdev)
 {
 	struct ntc_data *data;
-	struct ntc_thermistor_platform_data *pdata = pdev->dev.platform_data;
+	struct device_node *np = pdev->dev.of_node;
+	struct ntc_thermistor_platform_data *pdata = NULL;
 	int ret = 0;
 
+	if (np) {
+		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+		if (!pdata)
+			return -ENOMEM;
+
+		ntc_thermistor_parse_dt(pdata, np);
+	} else
+		pdata = pdev->dev.platform_data;
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "No platform init data supplied.\n");
 		return -ENODEV;
@@ -353,9 +420,9 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 	data->dev = &pdev->dev;
 	data->pdev = pdev;
 	data->pdata = pdata;
-	strlcpy(data->name, pdev->id_entry->name, sizeof(data->name));
+	strncpy(data->name, dev_name(&pdev->dev), PLATFORM_NAME_SIZE);
 
-	switch (pdev->id_entry->driver_data) {
+	switch (thermistor_get_type(pdev)) {
 	case TYPE_NCPXXWB473:
 		data->comp = ncpXXwb473;
 		data->n_comp = ARRAY_SIZE(ncpXXwb473);
@@ -365,9 +432,8 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 		data->n_comp = ARRAY_SIZE(ncpXXwl333);
 		break;
 	default:
-		dev_err(&pdev->dev, "Unknown device type: %lu(%s)\n",
-				pdev->id_entry->driver_data,
-				pdev->id_entry->name);
+		dev_err(&pdev->dev, "Unknown device type: %u\n",
+				thermistor_get_type(pdev));
 		return -EINVAL;
 	}
 
@@ -386,9 +452,8 @@ static int ntc_thermistor_probe(struct platform_device *pdev)
 		goto err_after_sysfs;
 	}
 
-	dev_info(&pdev->dev, "Thermistor %s:%d (type: %s/%lu) successfully probed.\n",
-			pdev->name, pdev->id, pdev->id_entry->name,
-			pdev->id_entry->driver_data);
+	dev_info(&pdev->dev, "Thermistor successfully probed.\n");
+
 	return 0;
 err_after_sysfs:
 	sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
@@ -406,19 +471,11 @@ static int ntc_thermistor_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct platform_device_id ntc_thermistor_id[] = {
-	{ "ncp15wb473", TYPE_NCPXXWB473 },
-	{ "ncp18wb473", TYPE_NCPXXWB473 },
-	{ "ncp21wb473", TYPE_NCPXXWB473 },
-	{ "ncp03wb473", TYPE_NCPXXWB473 },
-	{ "ncp15wl333", TYPE_NCPXXWL333 },
-	{ },
-};
-
 static struct platform_driver ntc_thermistor_driver = {
 	.driver = {
 		.name = "ntc-thermistor",
 		.owner = THIS_MODULE,
+		.of_match_table = of_match_ptr(ntc_match),
 	},
 	.probe = ntc_thermistor_probe,
 	.remove = ntc_thermistor_remove,
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
