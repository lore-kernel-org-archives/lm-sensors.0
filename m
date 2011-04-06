From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Apr 2011 15:58:13 +0000
Subject: [lm-sensors] [PATCH] hwmon: Use helper functions to set and get
Message-Id: <20110406175813.415fa480@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use helper functions to set and get driver data. This is more elegant.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/hwmon/adcxx.c       |   16 ++++++++--------
 drivers/hwmon/ibmaem.c      |   10 +++++-----
 drivers/hwmon/k10temp.c     |    6 +++---
 drivers/hwmon/k8temp.c      |    8 ++++----
 drivers/hwmon/lm70.c        |   10 +++++-----
 drivers/hwmon/ultra45_env.c |    4 ++--
 6 files changed, 27 insertions(+), 27 deletions(-)

--- linux-2.6.39-rc1.orig/drivers/hwmon/adcxx.c	2010-08-02 00:11:14.000000000 +0200
+++ linux-2.6.39-rc1/drivers/hwmon/adcxx.c	2011-04-06 17:41:30.000000000 +0200
@@ -62,7 +62,7 @@ static ssize_t adcxx_read(struct device
 {
 	struct spi_device *spi = to_spi_device(dev);
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct adcxx *adc = dev_get_drvdata(&spi->dev);
+	struct adcxx *adc = spi_get_drvdata(spi);
 	u8 tx_buf[2];
 	u8 rx_buf[2];
 	int status;
@@ -105,7 +105,7 @@ static ssize_t adcxx_show_max(struct dev
 		struct device_attribute *devattr, char *buf)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	struct adcxx *adc = dev_get_drvdata(&spi->dev);
+	struct adcxx *adc = spi_get_drvdata(spi);
 	u32 reference;
 
 	if (mutex_lock_interruptible(&adc->lock))
@@ -122,7 +122,7 @@ static ssize_t adcxx_set_max(struct devi
 	struct device_attribute *devattr, const char *buf, size_t count)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	struct adcxx *adc = dev_get_drvdata(&spi->dev);
+	struct adcxx *adc = spi_get_drvdata(spi);
 	unsigned long value;
 
 	if (strict_strtoul(buf, 10, &value))
@@ -142,7 +142,7 @@ static ssize_t adcxx_show_name(struct de
 			      *devattr, char *buf)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	struct adcxx *adc = dev_get_drvdata(&spi->dev);
+	struct adcxx *adc = spi_get_drvdata(spi);
 
 	return sprintf(buf, "adcxx%ds\n", adc->channels);
 }
@@ -182,7 +182,7 @@ static int __devinit adcxx_probe(struct
 
 	mutex_lock(&adc->lock);
 
-	dev_set_drvdata(&spi->dev, adc);
+	spi_set_drvdata(spi, adc);
 
 	for (i = 0; i < 3 + adc->channels; i++) {
 		status = device_create_file(&spi->dev, &ad_input[i].dev_attr);
@@ -206,7 +206,7 @@ out_err:
 	for (i--; i >= 0; i--)
 		device_remove_file(&spi->dev, &ad_input[i].dev_attr);
 
-	dev_set_drvdata(&spi->dev, NULL);
+	spi_set_drvdata(spi, NULL);
 	mutex_unlock(&adc->lock);
 	kfree(adc);
 	return status;
@@ -214,7 +214,7 @@ out_err:
 
 static int __devexit adcxx_remove(struct spi_device *spi)
 {
-	struct adcxx *adc = dev_get_drvdata(&spi->dev);
+	struct adcxx *adc = spi_get_drvdata(spi);
 	int i;
 
 	mutex_lock(&adc->lock);
@@ -222,7 +222,7 @@ static int __devexit adcxx_remove(struct
 	for (i = 0; i < 3 + adc->channels; i++)
 		device_remove_file(&spi->dev, &ad_input[i].dev_attr);
 
-	dev_set_drvdata(&spi->dev, NULL);
+	spi_set_drvdata(spi, NULL);
 	mutex_unlock(&adc->lock);
 	kfree(adc);
 
--- linux-2.6.39-rc1.orig/drivers/hwmon/ibmaem.c	2011-03-15 22:52:51.000000000 +0100
+++ linux-2.6.39-rc1/drivers/hwmon/ibmaem.c	2011-04-06 17:45:26.000000000 +0200
@@ -523,7 +523,7 @@ static void aem_delete(struct aem_data *
 	aem_remove_sensors(data);
 	hwmon_device_unregister(data->hwmon_dev);
 	ipmi_destroy_user(data->ipmi.user);
-	dev_set_drvdata(&data->pdev->dev, NULL);
+	platform_set_drvdata(data->pdev, NULL);
 	platform_device_unregister(data->pdev);
 	aem_idr_put(data->id);
 	kfree(data);
@@ -594,7 +594,7 @@ static int aem_init_aem1_inst(struct aem
 	if (res)
 		goto ipmi_err;
 
-	dev_set_drvdata(&data->pdev->dev, data);
+	platform_set_drvdata(data->pdev, data);
 
 	/* Set up IPMI interface */
 	if (aem_init_ipmi_data(&data->ipmi, probe->interface,
@@ -630,7 +630,7 @@ sensor_err:
 hwmon_reg_err:
 	ipmi_destroy_user(data->ipmi.user);
 ipmi_err:
-	dev_set_drvdata(&data->pdev->dev, NULL);
+	platform_set_drvdata(data->pdev, NULL);
 	platform_device_unregister(data->pdev);
 dev_err:
 	aem_idr_put(data->id);
@@ -727,7 +727,7 @@ static int aem_init_aem2_inst(struct aem
 	if (res)
 		goto ipmi_err;
 
-	dev_set_drvdata(&data->pdev->dev, data);
+	platform_set_drvdata(data->pdev, data);
 
 	/* Set up IPMI interface */
 	if (aem_init_ipmi_data(&data->ipmi, probe->interface,
@@ -763,7 +763,7 @@ sensor_err:
 hwmon_reg_err:
 	ipmi_destroy_user(data->ipmi.user);
 ipmi_err:
-	dev_set_drvdata(&data->pdev->dev, NULL);
+	platform_set_drvdata(data->pdev, NULL);
 	platform_device_unregister(data->pdev);
 dev_err:
 	aem_idr_put(data->id);
--- linux-2.6.39-rc1.orig/drivers/hwmon/k10temp.c	2011-04-06 16:34:01.000000000 +0200
+++ linux-2.6.39-rc1/drivers/hwmon/k10temp.c	2011-04-06 17:42:06.000000000 +0200
@@ -173,7 +173,7 @@ static int __devinit k10temp_probe(struc
 		err = PTR_ERR(hwmon_dev);
 		goto exit_remove;
 	}
-	dev_set_drvdata(&pdev->dev, hwmon_dev);
+	pci_set_drvdata(pdev, hwmon_dev);
 
 	if (unreliable && force)
 		dev_warn(&pdev->dev,
@@ -194,7 +194,7 @@ exit:
 
 static void __devexit k10temp_remove(struct pci_dev *pdev)
 {
-	hwmon_device_unregister(dev_get_drvdata(&pdev->dev));
+	hwmon_device_unregister(pci_get_drvdata(pdev));
 	device_remove_file(&pdev->dev, &dev_attr_name);
 	device_remove_file(&pdev->dev, &dev_attr_temp1_input);
 	device_remove_file(&pdev->dev, &dev_attr_temp1_max);
@@ -202,7 +202,7 @@ static void __devexit k10temp_remove(str
 			   &sensor_dev_attr_temp1_crit.dev_attr);
 	device_remove_file(&pdev->dev,
 			   &sensor_dev_attr_temp1_crit_hyst.dev_attr);
-	dev_set_drvdata(&pdev->dev, NULL);
+	pci_set_drvdata(pdev, NULL);
 }
 
 static const struct pci_device_id k10temp_id_table[] = {
--- linux-2.6.39-rc1.orig/drivers/hwmon/k8temp.c	2011-03-15 19:45:32.000000000 +0100
+++ linux-2.6.39-rc1/drivers/hwmon/k8temp.c	2011-04-06 17:41:18.000000000 +0200
@@ -252,7 +252,7 @@ static int __devinit k8temp_probe(struct
 
 	data->name = "k8temp";
 	mutex_init(&data->update_lock);
-	dev_set_drvdata(&pdev->dev, data);
+	pci_set_drvdata(pdev, data);
 
 	/* Register sysfs hooks */
 	err = device_create_file(&pdev->dev,
@@ -307,7 +307,7 @@ exit_remove:
 			   &sensor_dev_attr_temp4_input.dev_attr);
 	device_remove_file(&pdev->dev, &dev_attr_name);
 exit_free:
-	dev_set_drvdata(&pdev->dev, NULL);
+	pci_set_drvdata(pdev, NULL);
 	kfree(data);
 exit:
 	return err;
@@ -315,7 +315,7 @@ exit:
 
 static void __devexit k8temp_remove(struct pci_dev *pdev)
 {
-	struct k8temp_data *data = dev_get_drvdata(&pdev->dev);
+	struct k8temp_data *data = pci_get_drvdata(pdev);
 
 	hwmon_device_unregister(data->hwmon_dev);
 	device_remove_file(&pdev->dev,
@@ -327,7 +327,7 @@ static void __devexit k8temp_remove(stru
 	device_remove_file(&pdev->dev,
 			   &sensor_dev_attr_temp4_input.dev_attr);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	dev_set_drvdata(&pdev->dev, NULL);
+	pci_set_drvdata(pdev, NULL);
 	kfree(data);
 }
 
--- linux-2.6.39-rc1.orig/drivers/hwmon/lm70.c	2011-03-15 22:52:51.000000000 +0100
+++ linux-2.6.39-rc1/drivers/hwmon/lm70.c	2011-04-06 17:40:17.000000000 +0200
@@ -58,7 +58,7 @@ static ssize_t lm70_sense_temp(struct de
 	int status, val = 0;
 	u8 rxbuf[2];
 	s16 raw=0;
-	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
+	struct lm70 *p_lm70 = spi_get_drvdata(spi);
 
 	if (mutex_lock_interruptible(&p_lm70->lock))
 		return -ERESTARTSYS;
@@ -163,7 +163,7 @@ static int __devinit lm70_probe(struct s
 		status = PTR_ERR(p_lm70->hwmon_dev);
 		goto out_dev_reg_failed;
 	}
-	dev_set_drvdata(&spi->dev, p_lm70);
+	spi_set_drvdata(spi, p_lm70);
 
 	if ((status = device_create_file(&spi->dev, &dev_attr_temp1_input))
 	 || (status = device_create_file(&spi->dev, &dev_attr_name))) {
@@ -177,19 +177,19 @@ out_dev_create_file_failed:
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
 	hwmon_device_unregister(p_lm70->hwmon_dev);
 out_dev_reg_failed:
-	dev_set_drvdata(&spi->dev, NULL);
+	spi_set_drvdata(spi, NULL);
 	kfree(p_lm70);
 	return status;
 }
 
 static int __devexit lm70_remove(struct spi_device *spi)
 {
-	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
+	struct lm70 *p_lm70 = spi_get_drvdata(spi);
 
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
 	device_remove_file(&spi->dev, &dev_attr_name);
 	hwmon_device_unregister(p_lm70->hwmon_dev);
-	dev_set_drvdata(&spi->dev, NULL);
+	spi_set_drvdata(spi, NULL);
 	kfree(p_lm70);
 
 	return 0;
--- linux-2.6.39-rc1.orig/drivers/hwmon/ultra45_env.c	2011-03-30 10:57:20.000000000 +0200
+++ linux-2.6.39-rc1/drivers/hwmon/ultra45_env.c	2011-04-06 17:43:15.000000000 +0200
@@ -258,7 +258,7 @@ static int __devinit env_probe(struct pl
 		goto out_sysfs_remove_group;
 	}
 
-	dev_set_drvdata(&op->dev, p);
+	platform_set_drvdata(op, p);
 	err = 0;
 
 out:
@@ -277,7 +277,7 @@ out_free:
 
 static int __devexit env_remove(struct platform_device *op)
 {
-	struct env *p = dev_get_drvdata(&op->dev);
+	struct env *p = platform_get_drvdata(op);
 
 	if (p) {
 		sysfs_remove_group(&op->dev.kobj, &env_group);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
