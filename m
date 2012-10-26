From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Oct 2012 07:46:23 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (w83627ehf) Add support for suspend
Message-Id: <20121026094623.329f0764@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On suspend some register values are lost, most notably the Value RAM
areas but also other limits and settings. Restore them on resume.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Changes since v1:
 * Force initial bank selection at resume. Thanks Guenter :)

I also updated the driver at:
  http://khali.linux-fr.org/devel/misc/w83627ehf/

 drivers/hwmon/w83627ehf.c |   95 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

--- linux-3.7-rc2.orig/drivers/hwmon/w83627ehf.c	2012-10-26 09:34:04.028295469 +0200
+++ linux-3.7-rc2/drivers/hwmon/w83627ehf.c	2012-10-26 09:40:28.102773093 +0200
@@ -1,7 +1,7 @@
 /*
  *  w83627ehf - Driver for the hardware monitoring functionality of
  *		the Winbond W83627EHF Super-I/O chip
- *  Copyright (C) 2005-2011  Jean Delvare <khali@linux-fr.org>
+ *  Copyright (C) 2005-2012  Jean Delvare <khali@linux-fr.org>
  *  Copyright (C) 2006  Yuan Mu (Winbond),
  *			Rudolf Marek <r.marek@assembler.cz>
  *			David Hubbard <david.c.hubbard@gmail.com>
@@ -502,6 +502,13 @@ struct w83627ehf_data {
 	u16 have_temp_offset;
 	u8 in6_skip:1;
 	u8 temp3_val_only:1;
+
+#ifdef CONFIG_PM
+	/* Remember extra register values over suspend/resume */
+	u8 vbat;
+	u8 fandiv1;
+	u8 fandiv2;
+#endif
 };
 
 struct w83627ehf_sio_data {
@@ -2608,10 +2615,96 @@ static int __devexit w83627ehf_remove(st
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int w83627ehf_suspend(struct device *dev)
+{
+	struct w83627ehf_data *data = w83627ehf_update_device(dev);
+	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+
+	mutex_lock(&data->update_lock);
+	data->vbat = w83627ehf_read_value(data, W83627EHF_REG_VBAT);
+	if (sio_data->kind = nct6775) {
+		data->fandiv1 = w83627ehf_read_value(data, NCT6775_REG_FANDIV1);
+		data->fandiv2 = w83627ehf_read_value(data, NCT6775_REG_FANDIV2);
+	}
+	mutex_unlock(&data->update_lock);
+
+	return 0;
+}
+
+static int w83627ehf_resume(struct device *dev)
+{
+	struct w83627ehf_data *data = dev_get_drvdata(dev);
+	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	int i;
+
+	mutex_lock(&data->update_lock);
+	data->bank = 0xff;		/* Force initial bank selection */
+
+	/* Restore limits */
+	for (i = 0; i < data->in_num; i++) {
+		if ((i = 6) && data->in6_skip)
+			continue;
+
+		w83627ehf_write_value(data, W83627EHF_REG_IN_MIN(i),
+				      data->in_min[i]);
+		w83627ehf_write_value(data, W83627EHF_REG_IN_MAX(i),
+				      data->in_max[i]);
+	}
+
+	for (i = 0; i < 5; i++) {
+		if (!(data->has_fan_min & (1 << i)))
+			continue;
+
+		w83627ehf_write_value(data, data->REG_FAN_MIN[i],
+				      data->fan_min[i]);
+	}
+
+	for (i = 0; i < NUM_REG_TEMP; i++) {
+		if (!(data->have_temp & (1 << i)))
+			continue;
+
+		if (data->reg_temp_over[i])
+			w83627ehf_write_temp(data, data->reg_temp_over[i],
+					     data->temp_max[i]);
+		if (data->reg_temp_hyst[i])
+			w83627ehf_write_temp(data, data->reg_temp_hyst[i],
+					     data->temp_max_hyst[i]);
+		if (data->have_temp_offset & (1 << i))
+			w83627ehf_write_value(data,
+					      W83627EHF_REG_TEMP_OFFSET[i],
+					      data->temp_offset[i]);
+	}
+
+	/* Restore other settings */
+	w83627ehf_write_value(data, W83627EHF_REG_VBAT, data->vbat);
+	if (sio_data->kind = nct6775) {
+		w83627ehf_write_value(data, NCT6775_REG_FANDIV1, data->fandiv1);
+		w83627ehf_write_value(data, NCT6775_REG_FANDIV2, data->fandiv2);
+	}
+
+	/* Force re-reading all values */
+	data->valid = 0;
+	mutex_unlock(&data->update_lock);
+
+	return 0;
+}
+
+static const struct dev_pm_ops w83627ehf_dev_pm_ops = {
+	.suspend = w83627ehf_suspend,
+	.resume = w83627ehf_resume,
+};
+
+#define W83627EHF_DEV_PM_OPS	(&w83627ehf_dev_pm_ops)
+#else
+#define W83627EHF_DEV_PM_OPS	NULL
+#endif /* CONFIG_PM */
+
 static struct platform_driver w83627ehf_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= DRVNAME,
+		.pm	= W83627EHF_DEV_PM_OPS,
 	},
 	.probe		= w83627ehf_probe,
 	.remove		= __devexit_p(w83627ehf_remove),


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
