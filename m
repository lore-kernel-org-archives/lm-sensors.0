From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 20 Aug 2011 12:58:23 +0000
Subject: [lm-sensors] [PATCH v2 3/3] hwmon: (ibmaem) Avoid repeated memory
Message-Id: <20110820145823.7c5b38a1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Preallocate a buffer for the response to sensor reads, and reuse it
for each read instead of allocating a new one each time. This should
be faster and should also avoid memory fragmentation.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Darrick J. Wong <djwong@us.ibm.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
No changes since v1 (only refresh.)

 drivers/hwmon/ibmaem.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

--- linux-3.1-rc2.orig/drivers/hwmon/ibmaem.c	2011-08-20 10:19:24.000000000 +0200
+++ linux-3.1-rc2/drivers/hwmon/ibmaem.c	2011-08-20 10:32:31.000000000 +0200
@@ -148,8 +148,9 @@ struct aem_data {
 	int			id;
 	struct aem_ipmi_data	ipmi;
 
-	/* Function to update sensors */
+	/* Function and buffer to update sensors */
 	void (*update)(struct aem_data *data);
+	struct aem_read_sensor_resp *rs_resp;
 
 	/*
 	 * AEM 1.x sensors:
@@ -388,13 +389,14 @@ static void aem_idr_put(int id)
 
 /* Sensor support functions */
 
-/* Read a sensor value */
+/* Read a sensor value; must be called with data->lock held */
 static int aem_read_sensor(struct aem_data *data, u8 elt, u8 reg,
 			   void *buf, size_t size)
 {
 	int rs_size, res;
 	struct aem_read_sensor_req rs_req;
-	struct aem_read_sensor_resp *rs_resp;
+	/* Use preallocated rx buffer */
+	struct aem_read_sensor_resp *rs_resp = data->rs_resp;
 	struct aem_ipmi_data *ipmi = &data->ipmi;
 
 	/* AEM registers are 1, 2, 4 or 8 bytes */
@@ -420,10 +422,6 @@ static int aem_read_sensor(struct aem_da
 	ipmi->tx_message.data_len = sizeof(rs_req);
 
 	rs_size = sizeof(*rs_resp) + size;
-	rs_resp = kzalloc(rs_size, GFP_KERNEL);
-	if (!rs_resp)
-		return -ENOMEM;
-
 	ipmi->rx_msg_data = rs_resp;
 	ipmi->rx_msg_len = rs_size;
 
@@ -466,7 +464,6 @@ static int aem_read_sensor(struct aem_da
 	res = 0;
 
 out:
-	kfree(rs_resp);
 	return res;
 }
 
@@ -524,6 +521,7 @@ static void aem_delete(struct aem_data *
 {
 	list_del(&data->list);
 	aem_remove_sensors(data);
+	kfree(data->rs_resp);
 	hwmon_device_unregister(data->hwmon_dev);
 	ipmi_destroy_user(data->ipmi.user);
 	platform_set_drvdata(data->pdev, NULL);
@@ -616,6 +614,11 @@ static int aem_init_aem1_inst(struct aem
 	}
 
 	data->update = update_aem1_sensors;
+	data->rs_resp = kzalloc(sizeof(*(data->rs_resp)) + 8, GFP_KERNEL);
+	if (!data->rs_resp) {
+		res = -ENOMEM;
+		goto alloc_resp_err;
+	}
 
 	/* Find sensors */
 	res = aem1_find_sensors(data);
@@ -631,6 +634,8 @@ static int aem_init_aem1_inst(struct aem
 	return 0;
 
 sensor_err:
+	kfree(data->rs_resp);
+alloc_resp_err:
 	hwmon_device_unregister(data->hwmon_dev);
 hwmon_reg_err:
 	ipmi_destroy_user(data->ipmi.user);
@@ -748,6 +753,11 @@ static int aem_init_aem2_inst(struct aem
 	}
 
 	data->update = update_aem2_sensors;
+	data->rs_resp = kzalloc(sizeof(*(data->rs_resp)) + 8, GFP_KERNEL);
+	if (!data->rs_resp) {
+		res = -ENOMEM;
+		goto alloc_resp_err;
+	}
 
 	/* Find sensors */
 	res = aem2_find_sensors(data);
@@ -763,6 +773,8 @@ static int aem_init_aem2_inst(struct aem
 	return 0;
 
 sensor_err:
+	kfree(data->rs_resp);
+alloc_resp_err:
 	hwmon_device_unregister(data->hwmon_dev);
 hwmon_reg_err:
 	ipmi_destroy_user(data->ipmi.user);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
