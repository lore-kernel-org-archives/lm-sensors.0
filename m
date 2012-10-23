From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 23 Oct 2012 15:50:25 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627hf) Add support for suspend
Message-Id: <20121023175025.6d6e46a4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On suspend some register values are lost, most notably the Value RAM
areas but also other limits. Restore them on resume. On top of that,
some fixups are needed to work around BIOS bugs, in particular when
the BIOS omits running the same initialization sequence on resume
that it does after boot. In that case we have to carry initialization
over suspend.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627hf.c |   75 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

--- linux-3.7-rc2.orig/drivers/hwmon/w83627hf.c	2012-10-23 11:36:26.491575637 +0200
+++ linux-3.7-rc2/drivers/hwmon/w83627hf.c	2012-10-23 17:42:40.211546839 +0200
@@ -5,7 +5,7 @@
  *			      Philip Edelbrock <phil@netroedge.com>,
  *			      and Mark Studebaker <mdsxyz123@yahoo.com>
  * Ported to 2.6 by Bernhard C. Schrenk <clemy@clemy.org>
- * Copyright (c) 2007  Jean Delvare <khali@linux-fr.org>
+ * Copyright (c) 2007 - 1012  Jean Delvare <khali@linux-fr.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -389,6 +389,12 @@ struct w83627hf_data {
 				 */
 	u8 vrm;
 	u8 vrm_ovt;		/* Register value, 627THF/637HF/687THF only */
+
+#ifdef CONFIG_PM
+	/* Remember extra register values over suspend/resume */
+	u8 scfg1;
+	u8 scfg2;
+#endif
 };
 
 
@@ -401,10 +407,77 @@ static void w83627hf_update_fan_div(stru
 static struct w83627hf_data *w83627hf_update_device(struct device *dev);
 static void w83627hf_init_device(struct platform_device *pdev);
 
+#ifdef CONFIG_PM
+static int w83627hf_suspend(struct device *dev)
+{
+	struct w83627hf_data *data = w83627hf_update_device(dev);
+
+	mutex_lock(&data->update_lock);
+	data->scfg1 = w83627hf_read_value(data, W83781D_REG_SCFG1);
+	data->scfg2 = w83627hf_read_value(data, W83781D_REG_SCFG2);
+	mutex_unlock(&data->update_lock);
+
+	return 0;
+}
+
+static int w83627hf_resume(struct device *dev)
+{
+	struct w83627hf_data *data = dev_get_drvdata(dev);
+	int i, num_temps = (data->type = w83697hf) ? 2 : 3;
+
+	/* Restore limits */
+	mutex_lock(&data->update_lock);
+	for (i = 0; i <= 8; i++) {
+		/* skip missing sensors */
+		if (((data->type = w83697hf) && (i = 1)) ||
+		    ((data->type != w83627hf && data->type != w83697hf)
+		    && (i = 5 || i = 6)))
+			continue;
+		w83627hf_write_value(data, W83781D_REG_IN_MAX(i),
+				     data->in_max[i]);
+		w83627hf_write_value(data, W83781D_REG_IN_MIN(i),
+				     data->in_min[i]);
+	}
+	for (i = 0; i <= 2; i++)
+		w83627hf_write_value(data, W83627HF_REG_FAN_MIN(i),
+				     data->fan_min[i]);
+	for (i = 0; i < num_temps; i++) {
+		w83627hf_write_value(data, w83627hf_reg_temp_over[i],
+				     data->temp_max[i]);
+		w83627hf_write_value(data, w83627hf_reg_temp_hyst[i],
+				     data->temp_max_hyst[i]);
+	}
+
+	/* Fixup BIOS bugs */
+	if (data->type = w83627thf || data->type = w83637hf ||
+	    data->type = w83687thf)
+		w83627hf_write_value(data, W83627THF_REG_VRM_OVT_CFG,
+				     data->vrm_ovt);
+	w83627hf_write_value(data, W83781D_REG_SCFG1, data->scfg1);
+	w83627hf_write_value(data, W83781D_REG_SCFG2, data->scfg2);
+
+	/* Force re-reading all values */
+	data->valid = 0;
+	mutex_unlock(&data->update_lock);
+
+	return 0;
+}
+
+static const struct dev_pm_ops w83627hf_dev_pm_ops = {
+	.suspend = w83627hf_suspend,
+	.resume = w83627hf_resume,
+};
+
+#define W83627HF_DEV_PM_OPS	(&w83627hf_dev_pm_ops)
+#else
+#define W83627HF_DEV_PM_OPS	NULL
+#endif /* CONFIG_PM */
+
 static struct platform_driver w83627hf_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= DRVNAME,
+		.pm	= W83627HF_DEV_PM_OPS,
 	},
 	.probe		= w83627hf_probe,
 	.remove		= __devexit_p(w83627hf_remove),


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
