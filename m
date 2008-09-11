From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 11 Sep 2008 10:13:14 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: (lm78) Stop abusing struct
Message-Id: <20080911121314.0a685b55@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Upcoming changes to the I2C part of the lm78 driver will cause ISA
devices to no longer have a struct i2c_client at hand. So, we must
stop (ab)using it now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm78.c |   38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

--- linux-2.6.27-rc6.orig/drivers/hwmon/lm78.c	2008-09-10 12:05:33.000000000 +0200
+++ linux-2.6.27-rc6/drivers/hwmon/lm78.c	2008-09-11 11:02:31.000000000 +0200
@@ -114,22 +114,16 @@ static inline int TEMP_FROM_REG(s8 val)
 
 #define DIV_FROM_REG(val) (1 << (val))
 
-/* There are some complications in a module like this. First off, LM78 chips
-   may be both present on the SMBus and the ISA bus, and we have to handle
-   those cases separately at some places. Second, there might be several
-   LM78 chips available (well, actually, that is probably never done; but
-   it is a clean illustration of how to handle a case like that). Finally,
-   a specific chip may be attached to *both* ISA and SMBus, and we would
-   not like to detect it double. */
-
-/* For ISA chips, we abuse the i2c_client addr and name fields. We also use
-   the driver field to differentiate between I2C and ISA chips. */
 struct lm78_data {
 	struct i2c_client client;
 	struct device *hwmon_dev;
 	struct mutex lock;
 	enum chips type;
 
+	/* For ISA device only */
+	const char *name;
+	int isa_addr;
+
 	struct mutex update_lock;
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
@@ -536,7 +530,7 @@ static ssize_t show_name(struct device *
 {
 	struct lm78_data *data = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%s\n", data->client.name);
+	return sprintf(buf, "%s\n", data->name);
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
@@ -707,7 +701,6 @@ static int __devinit lm78_isa_probe(stru
 	int err;
 	struct lm78_data *data;
 	struct resource *res;
-	const char *name;
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -721,18 +714,16 @@ static int __devinit lm78_isa_probe(stru
 		goto exit_release_region;
 	}
 	mutex_init(&data->lock);
-	data->client.addr = res->start;
-	i2c_set_clientdata(&data->client, data);
+	data->isa_addr = res->start;
 	platform_set_drvdata(pdev, data);
 
 	if (lm78_read_value(data, LM78_REG_CHIPID) & 0x80) {
 		data->type = lm79;
-		name = "lm79";
+		data->name = "lm79";
 	} else {
 		data->type = lm78;
-		name = "lm78";
+		data->name = "lm78";
 	}
-	strlcpy(data->client.name, name, I2C_NAME_SIZE);
 
 	/* Initialize the LM78 chip */
 	lm78_init_device(data);
@@ -763,13 +754,16 @@ static int __devinit lm78_isa_probe(stru
 static int __devexit lm78_isa_remove(struct platform_device *pdev)
 {
 	struct lm78_data *data = platform_get_drvdata(pdev);
+	struct resource *res;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &lm78_group);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	release_region(data->client.addr + LM78_ADDR_REG_OFFSET, 2);
 	kfree(data);
 
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+	release_region(res->start + LM78_ADDR_REG_OFFSET, 2);
+
 	return 0;
 }
 
@@ -785,8 +779,8 @@ static int lm78_read_value(struct lm78_d
 	if (!client->driver) { /* ISA device */
 		int res;
 		mutex_lock(&data->lock);
-		outb_p(reg, client->addr + LM78_ADDR_REG_OFFSET);
-		res = inb_p(client->addr + LM78_DATA_REG_OFFSET);
+		outb_p(reg, data->isa_addr + LM78_ADDR_REG_OFFSET);
+		res = inb_p(data->isa_addr + LM78_DATA_REG_OFFSET);
 		mutex_unlock(&data->lock);
 		return res;
 	} else
@@ -806,8 +800,8 @@ static int lm78_write_value(struct lm78_
 
 	if (!client->driver) { /* ISA device */
 		mutex_lock(&data->lock);
-		outb_p(reg, client->addr + LM78_ADDR_REG_OFFSET);
-		outb_p(value, client->addr + LM78_DATA_REG_OFFSET);
+		outb_p(reg, data->isa_addr + LM78_ADDR_REG_OFFSET);
+		outb_p(value, data->isa_addr + LM78_DATA_REG_OFFSET);
 		mutex_unlock(&data->lock);
 		return 0;
 	} else

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
