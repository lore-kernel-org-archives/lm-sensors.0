From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:11 +0000
Subject: [lm-sensors] [PATCH 90/95] hwmon: (k8temp) Convert to use devm_ functions
Message-Id: <1339773856-3443-91-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Rudolf Marek <r.marek@assembler.cz>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k8temp.c |   25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/k8temp.c b/drivers/hwmon/k8temp.c
index 35aac82..49a69c5 100644
--- a/drivers/hwmon/k8temp.c
+++ b/drivers/hwmon/k8temp.c
@@ -183,21 +183,17 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 	u8 model, stepping;
 	struct k8temp_data *data;
 
-	data = kzalloc(sizeof(struct k8temp_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto exit;
-	}
+	data = devm_kzalloc(&pdev->dev, sizeof(struct k8temp_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	model = boot_cpu_data.x86_model;
 	stepping = boot_cpu_data.x86_mask;
 
 	/* feature available since SH-C0, exclude older revisions */
-	if (((model = 4) && (stepping = 0)) ||
-	    ((model = 5) && (stepping <= 1))) {
-		err = -ENODEV;
-		goto exit_free;
-	}
+	if ((model = 4 && stepping = 0) ||
+	    (model = 5 && stepping <= 1))
+		return -ENODEV;
 
 	/*
 	 * AMD NPT family 0fh, i.e. RevF and RevG:
@@ -224,8 +220,7 @@ static int __devinit k8temp_probe(struct pci_dev *pdev,
 
 	if (scfg & (SEL_PLACE | SEL_CORE)) {
 		dev_err(&pdev->dev, "Configuration bit(s) stuck at 1!\n");
-		err = -ENODEV;
-		goto exit_free;
+		return -ENODEV;
 	}
 
 	scfg |= (SEL_PLACE | SEL_CORE);
@@ -307,10 +302,6 @@ exit_remove:
 	device_remove_file(&pdev->dev,
 			   &sensor_dev_attr_temp4_input.dev_attr);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-exit_free:
-	pci_set_drvdata(pdev, NULL);
-	kfree(data);
-exit:
 	return err;
 }
 
@@ -328,8 +319,6 @@ static void __devexit k8temp_remove(struct pci_dev *pdev)
 	device_remove_file(&pdev->dev,
 			   &sensor_dev_attr_temp4_input.dev_attr);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	pci_set_drvdata(pdev, NULL);
-	kfree(data);
 }
 
 static struct pci_driver k8temp_driver = {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
