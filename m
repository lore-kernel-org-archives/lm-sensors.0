From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Aug 2011 12:56:35 +0000
Subject: [lm-sensors] [PATCH v2 1/3] hwmon: (ibmaem) Fix error paths
Message-Id: <20110820145635.1ba4c58f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (ibmaem) Fix error paths

I am under the impression that error paths in functions
aem_init_aem1_inst() and aem_init_aem2_inst() are incorrect. In
several cases, the function returns 0 on error, which I suspect is
not intended. Fix this by properly tracking error codes.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Darrick J. Wong <djwong@us.ibm.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
No change since v1.

 drivers/hwmon/ibmaem.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- linux-3.1-rc2.orig/drivers/hwmon/ibmaem.c	2011-08-18 18:57:17.000000000 +0200
+++ linux-3.1-rc2/drivers/hwmon/ibmaem.c	2011-08-18 19:16:12.000000000 +0200
@@ -602,24 +602,26 @@ static int aem_init_aem1_inst(struct aem
 	platform_set_drvdata(data->pdev, data);
 
 	/* Set up IPMI interface */
-	if (aem_init_ipmi_data(&data->ipmi, probe->interface,
-			       probe->bmc_device))
+	res = aem_init_ipmi_data(&data->ipmi, probe->interface,
+				 probe->bmc_device);
+	if (res)
 		goto ipmi_err;
 
 	/* Register with hwmon */
 	data->hwmon_dev = hwmon_device_register(&data->pdev->dev);
-
 	if (IS_ERR(data->hwmon_dev)) {
 		dev_err(&data->pdev->dev, "Unable to register hwmon "
 			"device for IPMI interface %d\n",
 			probe->interface);
+		res = PTR_ERR(data->hwmon_dev);
 		goto hwmon_reg_err;
 	}
 
 	data->update = update_aem1_sensors;
 
 	/* Find sensors */
-	if (aem1_find_sensors(data))
+	res = aem1_find_sensors(data);
+	if (res)
 		goto sensor_err;
 
 	/* Add to our list of AEM devices */
@@ -735,24 +737,26 @@ static int aem_init_aem2_inst(struct aem
 	platform_set_drvdata(data->pdev, data);
 
 	/* Set up IPMI interface */
-	if (aem_init_ipmi_data(&data->ipmi, probe->interface,
-			       probe->bmc_device))
+	res = aem_init_ipmi_data(&data->ipmi, probe->interface,
+				 probe->bmc_device);
+	if (res)
 		goto ipmi_err;
 
 	/* Register with hwmon */
 	data->hwmon_dev = hwmon_device_register(&data->pdev->dev);
-
 	if (IS_ERR(data->hwmon_dev)) {
 		dev_err(&data->pdev->dev, "Unable to register hwmon "
 			"device for IPMI interface %d\n",
 			probe->interface);
+		res = PTR_ERR(data->hwmon_dev);
 		goto hwmon_reg_err;
 	}
 
 	data->update = update_aem2_sensors;
 
 	/* Find sensors */
-	if (aem2_find_sensors(data))
+	res = aem2_find_sensors(data);
+	if (res)
 		goto sensor_err;
 
 	/* Add to our list of AEM devices */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
