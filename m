From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 07 Oct 2008 19:02:47 +0000
Subject: [lm-sensors] [PATCH 5/6] hwmon: (w83781d) Stop abusing struct
Message-Id: <20081007210247.305cee33@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Upcoming changes to the I2C part of the w83781d driver will cause ISA
devices to no longer have a struct i2c_client at hand. So, we must
stop (ab)using it now.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/hwmon/w83781d.c |   63 +++++++++++++++++++----------------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

--- linux-2.6.27-rc9.orig/drivers/hwmon/w83781d.c	2008-10-07 11:16:41.000000000 +0200
+++ linux-2.6.27-rc9/drivers/hwmon/w83781d.c	2008-10-07 11:28:43.000000000 +0200
@@ -4,7 +4,7 @@
     Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,
                                Philip Edelbrock <phil@netroedge.com>,
                                and Mark Studebaker <mdsxyz123@yahoo.com>
-    Copyright (c) 2007         Jean Delvare <khali@linux-fr.org>
+    Copyright (c) 2007 - 2008  Jean Delvare <khali@linux-fr.org>
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -198,22 +198,16 @@ DIV_TO_REG(long val, enum chips type)
 	return i;
 }
 
-/* There are some complications in a module like this. First off, W83781D chips
-   may be both present on the SMBus and the ISA bus, and we have to handle
-   those cases separately at some places. Second, there might be several
-   W83781D chips available (well, actually, that is probably never done; but
-   it is a clean illustration of how to handle a case like that). Finally,
-   a specific chip may be attached to *both* ISA and SMBus, and we would
-   not like to detect it double. */
-
-/* For ISA chips, we abuse the i2c_client addr and name fields. We also use
-   the driver field to differentiate between I2C and ISA chips. */
 struct w83781d_data {
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
@@ -1625,7 +1619,7 @@ static ssize_t
 show_name(struct device *dev, struct device_attribute *devattr, char *buf)
 {
 	struct w83781d_data *data = dev_get_drvdata(dev);
-	return sprintf(buf, "%s\n", data->client.name);
+	return sprintf(buf, "%s\n", data->name);
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
@@ -1671,7 +1665,6 @@ static int w83781d_alias_detect(struct i
 static int
 w83781d_read_value_isa(struct w83781d_data *data, u16 reg)
 {
-	struct i2c_client *client = &data->client;
 	int word_sized, res;
 
 	word_sized = (((reg & 0xff00) = 0x100)
@@ -1681,23 +1674,23 @@ w83781d_read_value_isa(struct w83781d_da
 		|| ((reg & 0x00ff) = 0x55));
 	if (reg & 0xff00) {
 		outb_p(W83781D_REG_BANK,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
+		       data->isa_addr + W83781D_ADDR_REG_OFFSET);
 		outb_p(reg >> 8,
-		       client->addr + W83781D_DATA_REG_OFFSET);
+		       data->isa_addr + W83781D_DATA_REG_OFFSET);
 	}
-	outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
-	res = inb_p(client->addr + W83781D_DATA_REG_OFFSET);
+	outb_p(reg & 0xff, data->isa_addr + W83781D_ADDR_REG_OFFSET);
+	res = inb_p(data->isa_addr + W83781D_DATA_REG_OFFSET);
 	if (word_sized) {
 		outb_p((reg & 0xff) + 1,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
+		       data->isa_addr + W83781D_ADDR_REG_OFFSET);
 		res -		    (res << 8) + inb_p(client->addr +
+		    (res << 8) + inb_p(data->isa_addr +
 				       W83781D_DATA_REG_OFFSET);
 	}
 	if (reg & 0xff00) {
 		outb_p(W83781D_REG_BANK,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+		       data->isa_addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, data->isa_addr + W83781D_DATA_REG_OFFSET);
 	}
 	return res;
 }
@@ -1705,7 +1698,6 @@ w83781d_read_value_isa(struct w83781d_da
 static void
 w83781d_write_value_isa(struct w83781d_data *data, u16 reg, u16 value)
 {
-	struct i2c_client *client = &data->client;
 	int word_sized;
 
 	word_sized = (((reg & 0xff00) = 0x100)
@@ -1714,22 +1706,22 @@ w83781d_write_value_isa(struct w83781d_d
 		|| ((reg & 0x00ff) = 0x55));
 	if (reg & 0xff00) {
 		outb_p(W83781D_REG_BANK,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
+		       data->isa_addr + W83781D_ADDR_REG_OFFSET);
 		outb_p(reg >> 8,
-		       client->addr + W83781D_DATA_REG_OFFSET);
+		       data->isa_addr + W83781D_DATA_REG_OFFSET);
 	}
-	outb_p(reg & 0xff, client->addr + W83781D_ADDR_REG_OFFSET);
+	outb_p(reg & 0xff, data->isa_addr + W83781D_ADDR_REG_OFFSET);
 	if (word_sized) {
 		outb_p(value >> 8,
-		       client->addr + W83781D_DATA_REG_OFFSET);
+		       data->isa_addr + W83781D_DATA_REG_OFFSET);
 		outb_p((reg & 0xff) + 1,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
+		       data->isa_addr + W83781D_ADDR_REG_OFFSET);
 	}
-	outb_p(value & 0xff, client->addr + W83781D_DATA_REG_OFFSET);
+	outb_p(value & 0xff, data->isa_addr + W83781D_DATA_REG_OFFSET);
 	if (reg & 0xff00) {
 		outb_p(W83781D_REG_BANK,
-		       client->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(0, client->addr + W83781D_DATA_REG_OFFSET);
+		       data->isa_addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, data->isa_addr + W83781D_DATA_REG_OFFSET);
 	}
 }
 
@@ -1774,7 +1766,6 @@ w83781d_isa_probe(struct platform_device
 	int err, reg;
 	struct w83781d_data *data;
 	struct resource *res;
-	const char *name;
 
 	/* Reserve the ISA region */
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
@@ -1790,21 +1781,19 @@ w83781d_isa_probe(struct platform_device
 		goto exit_release_region;
 	}
 	mutex_init(&data->lock);
-	data->client.addr = res->start;
-	i2c_set_clientdata(&data->client, data);
+	data->isa_addr = res->start;
 	platform_set_drvdata(pdev, data);
 
 	reg = w83781d_read_value(data, W83781D_REG_WCHIPID);
 	switch (reg) {
 	case 0x30:
 		data->type = w83782d;
-		name = "w83782d";
+		data->name = "w83782d";
 		break;
 	default:
 		data->type = w83781d;
-		name = "w83781d";
+		data->name = "w83781d";
 	}
-	strlcpy(data->client.name, name, I2C_NAME_SIZE);
 
 	/* Initialize the W83781D chip */
 	w83781d_init_device(&pdev->dev);
@@ -1846,7 +1835,7 @@ w83781d_isa_remove(struct platform_devic
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group);
 	sysfs_remove_group(&pdev->dev.kobj, &w83781d_group_opt);
 	device_remove_file(&pdev->dev, &dev_attr_name);
-	release_region(data->client.addr + W83781D_ADDR_REG_OFFSET, 2);
+	release_region(data->isa_addr + W83781D_ADDR_REG_OFFSET, 2);
 	kfree(data);
 
 	return 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
