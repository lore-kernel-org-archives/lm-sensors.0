From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:21 +0000
Subject: [lm-sensors] [PATCH 40/95] hwmon: (i5k_amb) Convert to use devm_ functions
Message-Id: <1339773856-3443-41-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Darrick J. Wong <djwong@us.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/i5k_amb.c |   45 +++++++++++++--------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
index a18882c..32ed0d1 100644
--- a/drivers/hwmon/i5k_amb.c
+++ b/drivers/hwmon/i5k_amb.c
@@ -276,7 +276,8 @@ static int __devinit i5k_amb_hwmon_init(struct platform_device *pdev)
 		num_ambs += hweight16(data->amb_present[i] & 0x7fff);
 
 	/* Set up sysfs stuff */
-	data->attrs = kzalloc(sizeof(*data->attrs) * num_ambs * KNOBS_PER_AMB,
+	data->attrs = devm_kzalloc(&pdev->dev,
+				sizeof(*data->attrs) * num_ambs * KNOBS_PER_AMB,
 				GFP_KERNEL);
 	if (!data->attrs)
 		return -ENOMEM;
@@ -403,7 +404,6 @@ exit_remove:
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	for (i = 0; i < data->num_attrs; i++)
 		device_remove_file(&pdev->dev, &data->attrs[i].s_attr.dev_attr);
-	kfree(data->attrs);
 
 	return res;
 }
@@ -511,7 +511,7 @@ static int __devinit i5k_amb_probe(struct platform_device *pdev)
 	struct resource *reso;
 	int i, res;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -525,44 +525,30 @@ static int __devinit i5k_amb_probe(struct platform_device *pdev)
 	} while (chipset_ids[i].err);
 
 	if (res)
-		goto err;
+		return res;
 
 	/* Copy the DIMM presence map for the first two channels */
 	res = i5k_channel_probe(&data->amb_present[0], chipset_ids[i].fbd0);
 	if (res)
-		goto err;
+		return res;
 
 	/* Copy the DIMM presence map for the optional second two channels */
 	i5k_channel_probe(&data->amb_present[2], chipset_ids[i].fbd0 + 1);
 
 	/* Set up resource regions */
-	reso = request_mem_region(data->amb_base, data->amb_len, DRVNAME);
-	if (!reso) {
-		res = -EBUSY;
-		goto err;
-	}
+	reso = devm_request_mem_region(&pdev->dev, data->amb_base,
+				       data->amb_len, DRVNAME);
+	if (!reso)
+		return -EBUSY;
 
-	data->amb_mmio = ioremap_nocache(data->amb_base, data->amb_len);
-	if (!data->amb_mmio) {
-		res = -EBUSY;
-		goto err_map_failed;
-	}
+	data->amb_mmio = devm_ioremap_nocache(&pdev->dev, data->amb_base,
+					      data->amb_len);
+	if (!data->amb_mmio)
+		return -EBUSY;
 
 	platform_set_drvdata(pdev, data);
 
 	res = i5k_amb_hwmon_init(pdev);
-	if (res)
-		goto err_init_failed;
-
-	return res;
-
-err_init_failed:
-	iounmap(data->amb_mmio);
-	platform_set_drvdata(pdev, NULL);
-err_map_failed:
-	release_mem_region(data->amb_base, data->amb_len);
-err:
-	kfree(data);
 	return res;
 }
 
@@ -575,11 +561,6 @@ static int __devexit i5k_amb_remove(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	for (i = 0; i < data->num_attrs; i++)
 		device_remove_file(&pdev->dev, &data->attrs[i].s_attr.dev_attr);
-	kfree(data->attrs);
-	iounmap(data->amb_mmio);
-	release_mem_region(data->amb_base, data->amb_len);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
