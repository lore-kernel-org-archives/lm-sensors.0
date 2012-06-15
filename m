From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:23:22 +0000
Subject: [lm-sensors] [PATCH 41/95] hwmon: (ibmaem) Convert to use devm_ functions
Message-Id: <1339773856-3443-42-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Cc: Darrick J. Wong <djwong@us.ibm.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/ibmaem.c |   35 ++++++++++++-----------------------
 1 file changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 37f17e0..6bc25e8 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -488,13 +488,10 @@ static void aem_delete(struct aem_data *data)
 {
 	list_del(&data->list);
 	aem_remove_sensors(data);
-	kfree(data->rs_resp);
 	hwmon_device_unregister(data->hwmon_dev);
 	ipmi_destroy_user(data->ipmi.user);
-	platform_set_drvdata(data->pdev, NULL);
 	platform_device_unregister(data->pdev);
 	ida_simple_remove(&aem_ida, data->id);
-	kfree(data);
 }
 
 /* Probe functions for AEM1 devices */
@@ -537,7 +534,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 	int i;
 	int res = -ENOMEM;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(probe->bmc_device, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return res;
 	mutex_init(&data->lock);
@@ -552,7 +549,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 	/* Create sub-device for this fw instance */
 	data->id = ida_simple_get(&aem_ida, 0, 0, GFP_KERNEL);
 	if (data->id < 0)
-		goto id_err;
+		return data->id;
 
 	data->pdev = platform_device_alloc(DRVNAME, data->id);
 	if (!data->pdev)
@@ -582,7 +579,9 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 	}
 
 	data->update = update_aem1_sensors;
-	data->rs_resp = kzalloc(sizeof(*(data->rs_resp)) + 8, GFP_KERNEL);
+	data->rs_resp = devm_kzalloc(probe->bmc_device,
+				     sizeof(*(data->rs_resp)) + 8,
+				     GFP_KERNEL);
 	if (!data->rs_resp) {
 		res = -ENOMEM;
 		goto alloc_resp_err;
@@ -591,7 +590,7 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 	/* Find sensors */
 	res = aem1_find_sensors(data);
 	if (res)
-		goto sensor_err;
+		goto alloc_resp_err;
 
 	/* Add to our list of AEM devices */
 	list_add_tail(&data->list, &driver_data.aem_devices);
@@ -601,20 +600,14 @@ static int aem_init_aem1_inst(struct aem_ipmi_data *probe, u8 module_handle)
 		 data->module_handle);
 	return 0;
 
-sensor_err:
-	kfree(data->rs_resp);
 alloc_resp_err:
 	hwmon_device_unregister(data->hwmon_dev);
 hwmon_reg_err:
 	ipmi_destroy_user(data->ipmi.user);
 ipmi_err:
-	platform_set_drvdata(data->pdev, NULL);
 	platform_device_unregister(data->pdev);
 dev_err:
 	ida_simple_remove(&aem_ida, data->id);
-id_err:
-	kfree(data);
-
 	return res;
 }
 
@@ -677,7 +670,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 	int i;
 	int res = -ENOMEM;
 
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	data = devm_kzalloc(probe->bmc_device, sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return res;
 	mutex_init(&data->lock);
@@ -692,7 +685,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 	/* Create sub-device for this fw instance */
 	data->id = ida_simple_get(&aem_ida, 0, 0, GFP_KERNEL);
 	if (data->id < 0)
-		goto id_err;
+		return data->id;
 
 	data->pdev = platform_device_alloc(DRVNAME, data->id);
 	if (!data->pdev)
@@ -722,7 +715,9 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 	}
 
 	data->update = update_aem2_sensors;
-	data->rs_resp = kzalloc(sizeof(*(data->rs_resp)) + 8, GFP_KERNEL);
+	data->rs_resp = devm_kzalloc(probe->bmc_device,
+				     sizeof(*(data->rs_resp)) + 8,
+				     GFP_KERNEL);
 	if (!data->rs_resp) {
 		res = -ENOMEM;
 		goto alloc_resp_err;
@@ -731,7 +726,7 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 	/* Find sensors */
 	res = aem2_find_sensors(data);
 	if (res)
-		goto sensor_err;
+		goto alloc_resp_err;
 
 	/* Add to our list of AEM devices */
 	list_add_tail(&data->list, &driver_data.aem_devices);
@@ -741,20 +736,14 @@ static int aem_init_aem2_inst(struct aem_ipmi_data *probe,
 		 data->module_handle);
 	return 0;
 
-sensor_err:
-	kfree(data->rs_resp);
 alloc_resp_err:
 	hwmon_device_unregister(data->hwmon_dev);
 hwmon_reg_err:
 	ipmi_destroy_user(data->ipmi.user);
 ipmi_err:
-	platform_set_drvdata(data->pdev, NULL);
 	platform_device_unregister(data->pdev);
 dev_err:
 	ida_simple_remove(&aem_ida, data->id);
-id_err:
-	kfree(data);
-
 	return res;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
