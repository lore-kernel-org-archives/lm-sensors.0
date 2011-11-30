From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 30 Nov 2011 08:47:42 +0000
Subject: [lm-sensors] [patch] hwmon: (pmbus/adm1275) fix memory leak on error
Message-Id: <20111130084742.GG6268@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

We added a bunch of new validation checks after an allocation without
adding the necessary calls to kfree().  Really they should have gone
before the allocation anyway.

I've shifted the allocation closer to the place where it is first
needed.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
index 6349404..81c7c2e 100644
--- a/drivers/hwmon/pmbus/adm1275.c
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -192,10 +192,6 @@ static int adm1275_probe(struct i2c_client *client,
 				     | I2C_FUNC_SMBUS_BLOCK_DATA))
 		return -ENODEV;
 
-	data = kzalloc(sizeof(struct adm1275_data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
 	ret = i2c_smbus_read_block_data(client, PMBUS_MFR_ID, block_buffer);
 	if (ret < 0) {
 		dev_err(&client->dev, "Failed to read Manufacturer ID\n");
@@ -226,16 +222,16 @@ static int adm1275_probe(struct i2c_client *client,
 			   id->name, mid->name);
 
 	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
-	if (config < 0) {
-		ret = config;
-		goto err_mem;
-	}
+	if (config < 0)
+		return config;
 
 	device_config = i2c_smbus_read_byte_data(client, ADM1275_DEVICE_CONFIG);
-	if (device_config < 0) {
-		ret = device_config;
-		goto err_mem;
-	}
+	if (device_config < 0)
+		return device_config;
+
+	data = kzalloc(sizeof(struct adm1275_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	data->id = mid->driver_data;
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
