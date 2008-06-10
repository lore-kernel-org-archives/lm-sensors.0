From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Jun 2008 12:06:39 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (w83781d) Detect alias chips
Message-Id: <20080610140639.34b1263e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The W83781D and W83782D can be accessed either on the I2C bus or the
ISA bus. We must not access the same chip through both interfaces. So
far we were relying on the user passing the correct ignore parameter
to skip the registration of the I2C interface as suggested by
sensors-detect, but this is fragile: the user may load the w83781d
driver without running sensors-detect, and the i2c bus numbers are
not stable across reboots and hardware changes.

So, better detect alias chips in the driver directly, and skip any
I2C chip which is obviously an alias of the ISA chip. This is done
by comparing the value of 26 selected registers.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |   79 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 66 insertions(+), 13 deletions(-)

--- linux-2.6.26-rc5.orig/drivers/hwmon/w83781d.c	2008-06-10 12:58:44.000000000 +0200
+++ linux-2.6.26-rc5/drivers/hwmon/w83781d.c	2008-06-10 13:39:57.000000000 +0200
@@ -205,10 +205,7 @@ DIV_TO_REG(long val, enum chips type)
    W83781D chips available (well, actually, that is probably never done; but
    it is a clean illustration of how to handle a case like that). Finally,
    a specific chip may be attached to *both* ISA and SMBus, and we would
-   not like to detect it double. Fortunately, in the case of the W83781D at
-   least, a register tells us what SMBus address we are on, so that helps
-   a bit - except if there could be more than one SMBus. Groan. No solution
-   for this yet. */
+   not like to detect it double. */
 
 /* For ISA chips, we abuse the i2c_client addr and name fields. We also use
    the driver field to differentiate between I2C and ISA chips. */
@@ -852,13 +849,25 @@ static DEVICE_ATTR(name, S_IRUGO, show_n
 /* This function is called when:
      * w83781d_driver is inserted (when this module is loaded), for each
        available adapter
-     * when a new adapter is inserted (and w83781d_driver is still present) */
+     * when a new adapter is inserted (and w83781d_driver is still present)
+   We block updates of the ISA device to minimize the risk of concurrent
+   access to the same W83781D chip through different interfaces. */
 static int
 w83781d_attach_adapter(struct i2c_adapter *adapter)
 {
+	struct w83781d_data *data;
+	int err;
+
 	if (!(adapter->class & I2C_CLASS_HWMON))
 		return 0;
-	return i2c_probe(adapter, &addr_data, w83781d_detect);
+
+	data = pdev ? platform_get_drvdata(pdev) : NULL;
+	if (data)
+		mutex_lock(&data->update_lock);
+	err = i2c_probe(adapter, &addr_data, w83781d_detect);
+	if (data)
+		mutex_unlock(&data->update_lock);
+	return err;
 }
 
 /* Assumes that adapter is of I2C, not ISA variety.
@@ -1028,6 +1037,40 @@ static const struct attribute_group w837
 	.attrs = w83781d_attributes_opt,
 };
 
+/* Returns 1 if the I2C chip appears to be an alias of the ISA chip */
+static int w83781d_alias_detect(struct i2c_client *client, u8 chipid)
+{
+	struct w83781d_data *i2c, *isa;
+	int i;
+
+	if (!pdev)	/* No ISA chip */
+		return 0;
+
+	i2c = i2c_get_clientdata(client);
+	isa = platform_get_drvdata(pdev);
+
+	if (w83781d_read_value(isa, W83781D_REG_I2C_ADDR) != client->addr)
+		return 0;	/* Address doesn't match */
+	if (w83781d_read_value(isa, W83781D_REG_WCHIPID) != chipid)
+		return 0;	/* Chip type doesn't match */
+
+	/* We compare all the limit registers, the config register and the
+	 * interrupt mask registers */
+	for (i = 0x2b; i <= 0x3d; i++) {
+		if (w83781d_read_value(isa, i) != w83781d_read_value(i2c, i))
+			return 0;
+	}
+	if (w83781d_read_value(isa, W83781D_REG_CONFIG) !+	    w83781d_read_value(i2c, W83781D_REG_CONFIG))
+		return 0;
+	for (i = 0x43; i <= 0x46; i++) {
+		if (w83781d_read_value(isa, i) != w83781d_read_value(i2c, i))
+			return 0;
+	}
+
+	return 1;
+}
+
 /* No clean up is done on error, it's up to the caller */
 static int
 w83781d_create_files(struct device *dev, int kind, int is_isa)
@@ -1242,6 +1285,14 @@ w83781d_detect(struct i2c_adapter *adapt
 			err = -EINVAL;
 			goto ERROR2;
 		}
+
+		if ((kind = w83781d || kind = w83782d)
+		 && w83781d_alias_detect(client, val1)) {
+			dev_dbg(&adapter->dev, "Device at 0x%02x appears to "
+				"be the same as ISA device\n", address);
+			err = -ENODEV;
+			goto ERROR2;
+		}
 	}
 
 	if (kind = w83781d) {
@@ -1904,14 +1955,12 @@ sensors_w83781d_init(void)
 {
 	int res;
 
-	res = i2c_add_driver(&w83781d_driver);
-	if (res)
-		goto exit;
-
+	/* We register the ISA device first, so that we can skip the
+	 * registration of an I2C interface to the same device. */
 	if (w83781d_isa_found(isa_address)) {
 		res = platform_driver_register(&w83781d_isa_driver);
 		if (res)
-			goto exit_unreg_i2c_driver;
+			goto exit;
 
 		/* Sets global pdev as a side effect */
 		res = w83781d_isa_device_add(isa_address);
@@ -1919,12 +1968,16 @@ sensors_w83781d_init(void)
 			goto exit_unreg_isa_driver;
 	}
 
+	res = i2c_add_driver(&w83781d_driver);
+	if (res)
+		goto exit_unreg_isa_device;
+
 	return 0;
 
+ exit_unreg_isa_device:
+	platform_device_unregister(pdev);
  exit_unreg_isa_driver:
 	platform_driver_unregister(&w83781d_isa_driver);
- exit_unreg_i2c_driver:
-	i2c_del_driver(&w83781d_driver);
  exit:
 	return res;
 }

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
