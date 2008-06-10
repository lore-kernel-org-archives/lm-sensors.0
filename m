From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jun 2008 12:05:28 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (lm78) Detect alias chips
Message-Id: <20080610140528.039a5f78@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM78 and LM79 can be accessed either on the I2C bus or the ISA
bus. We must not access the same chip through both interfaces. So far
we were relying on the user passing the correct ignore parameter to
skip the registration of the I2C interface as suggested by
sensors-detect, but this is fragile: the user may load the lm78
driver without running sensors-detect, and the i2c bus numbers are
not stable across reboots and hardware changes.

So, better detect alias chips in the driver directly, and skip any
I2C chip which is obviously an alias of the ISA chip. This is done
by comparing the value of 26 selected registers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm78.c |   78 +++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 13 deletions(-)

--- linux-2.6.26-rc5.orig/drivers/hwmon/lm78.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.26-rc5/drivers/hwmon/lm78.c	2008-06-10 13:40:29.000000000 +0200
@@ -120,10 +120,7 @@ static inline int TEMP_FROM_REG(s8 val)
    LM78 chips available (well, actually, that is probably never done; but
    it is a clean illustration of how to handle a case like that). Finally,
    a specific chip may be attached to *both* ISA and SMBus, and we would
-   not like to detect it double. Fortunately, in the case of the LM78 at
-   least, a register tells us what SMBus address we are on, so that helps
-   a bit - except if there could be more than one SMBus. Groan. No solution
-   for this yet. */
+   not like to detect it double. */
 
 /* For ISA chips, we abuse the i2c_client addr and name fields. We also use
    the driver field to differentiate between I2C and ISA chips. */
@@ -457,12 +454,24 @@ static SENSOR_DEVICE_ATTR(temp1_alarm, S
 /* This function is called when:
      * lm78_driver is inserted (when this module is loaded), for each
        available adapter
-     * when a new adapter is inserted (and lm78_driver is still present) */
+     * when a new adapter is inserted (and lm78_driver is still present)
+   We block updates of the ISA device to minimize the risk of concurrent
+   access to the same LM78 chip through different interfaces. */
 static int lm78_attach_adapter(struct i2c_adapter *adapter)
 {
+	struct lm78_data *data;
+	int err;
+
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_probe(adapter, &addr_data, lm78_detect);
+
+	data = pdev ? platform_get_drvdata(pdev) : NULL;
+	if (data)
+		mutex_lock(&data->update_lock);
+	err = i2c_probe(adapter, &addr_data, lm78_detect);
+	if (data)
+		mutex_unlock(&data->update_lock);
+	return err;
 }
 
 static struct attribute *lm78_attributes[] = {
@@ -531,6 +540,40 @@ static ssize_t show_name(struct device *
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
+/* Returns 1 if the I2C chip appears to be an alias of the ISA chip */
+static int lm78_alias_detect(struct i2c_client *client, u8 chipid)
+{
+	struct lm78_data *i2c, *isa;
+	int i;
+
+	if (!pdev)	/* No ISA chip */
+		return 0;
+
+	i2c = i2c_get_clientdata(client);
+	isa = platform_get_drvdata(pdev);
+
+	if (lm78_read_value(isa, LM78_REG_I2C_ADDR) != client->addr)
+		return 0;	/* Address doesn't match */
+	if ((lm78_read_value(isa, LM78_REG_CHIPID) & 0xfe) != (chipid & 0xfe))
+		return 0;	/* Chip type doesn't match */
+
+	/* We compare all the limit registers, the config register and the
+	 * interrupt mask registers */
+	for (i = 0x2b; i <= 0x3d; i++) {
+		if (lm78_read_value(isa, i) != lm78_read_value(i2c, i))
+			return 0;
+	}
+	if (lm78_read_value(isa, LM78_REG_CONFIG) !+	    lm78_read_value(i2c, LM78_REG_CONFIG))
+		return 0;
+	for (i = 0x43; i <= 0x46; i++) {
+		if (lm78_read_value(isa, i) != lm78_read_value(i2c, i))
+			return 0;
+	}
+
+	return 1;
+}
+
 /* This function is called by i2c_probe */
 static int lm78_detect(struct i2c_adapter *adapter, int address, int kind)
 {
@@ -589,6 +632,13 @@ static int lm78_detect(struct i2c_adapte
 			err = -ENODEV;
 			goto ERROR2;
 		}
+
+		if (lm78_alias_detect(new_client, i)) {
+			dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
+				"be the same as ISA device\n", address);
+			err = -ENODEV;
+			goto ERROR2;
+		}
 	}
 
 	if (kind = lm78) {
@@ -949,14 +999,12 @@ static int __init sm_lm78_init(void)
 {
 	int res;
 
-	res = i2c_add_driver(&lm78_driver);
-	if (res)
-		goto exit;
-
+	/* We register the ISA device first, so that we can skip the
+	 * registration of an I2C interface to the same device. */
 	if (lm78_isa_found(isa_address)) {
 		res = platform_driver_register(&lm78_isa_driver);
 		if (res)
-			goto exit_unreg_i2c_driver;
+			goto exit;
 
 		/* Sets global pdev as a side effect */
 		res = lm78_isa_device_add(isa_address);
@@ -964,12 +1012,16 @@ static int __init sm_lm78_init(void)
 			goto exit_unreg_isa_driver;
 	}
 
+	res = i2c_add_driver(&lm78_driver);
+	if (res)
+		goto exit_unreg_isa_device;
+
 	return 0;
 
+ exit_unreg_isa_device:
+	platform_device_unregister(pdev);
  exit_unreg_isa_driver:
 	platform_driver_unregister(&lm78_isa_driver);
- exit_unreg_i2c_driver:
-	i2c_del_driver(&lm78_driver);
  exit:
 	return res;
 }

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
