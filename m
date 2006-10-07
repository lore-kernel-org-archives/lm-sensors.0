From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 07 Oct 2006 20:02:36 +0000
Subject: [lm-sensors] [PATCH] it87: Remove the SMBus interface support
Message-Id: <20061007220236.11e36eab.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Remove the SMBus interface support from the it87 hardware monitoring
driver. This interface was useless as the LPC ISA-like interface is
always available, is faster, and is more reliable. This cuts the driver
size by some 20%.

This change is also required to later convert the it87 driver to a
platform driver, so that we can get rid of i2c-isa in a near future.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/feature-removal-schedule.txt |    9 -
 Documentation/hwmon/it87                   |   15 ++
 drivers/hwmon/it87.c                       |  202 +++++++---------------------
 include/linux/i2c-id.h                     |    1 -
 4 files changed, 64 insertions(+), 163 deletions(-)

--- linux-2.6.19-rc1.orig/Documentation/hwmon/it87	2006-10-07 10:17:06.000000000 +0200
+++ linux-2.6.19-rc1/Documentation/hwmon/it87	2006-10-07 10:37:03.000000000 +0200
@@ -9,8 +9,7 @@
                http://www.ite.com.tw/
   * IT8712F
     Prefix: 'it8712'
-    Addresses scanned: I2C 0x2d
-                       from Super I/O config space (8 I/O ports)
+    Addresses scanned: from Super I/O config space (8 I/O ports)
     Datasheet: Publicly available at the ITE website
                http://www.ite.com.tw/
   * IT8716F
@@ -53,6 +52,18 @@
   misconfigured by BIOS - PWM values would be inverted. This option tries
   to fix this. Please contact your BIOS manufacturer and ask him for fix.
 
+
+Hardware Interfaces
+-------------------
+
+All the chips suported by this driver are LPC Super-I/O chips, accessed
+through the LPC bus (ISA-like I/O ports). The IT8712F additionally has an
+SMBus interface to the hardware monitoring functions. This driver no
+longer supports this interface though, as it is slower and less reliable
+than the ISA access, and was only available on a small number of
+motherboard models.
+
+
 Description
 -----------
 
--- linux-2.6.19-rc1.orig/drivers/hwmon/it87.c	2006-10-07 10:17:06.000000000 +0200
+++ linux-2.6.19-rc1/drivers/hwmon/it87.c	2006-10-07 20:13:05.000000000 +0200
@@ -3,7 +3,7 @@
              monitoring.
 
     Supports: IT8705F  Super I/O chip w/LPC interface
-              IT8712F  Super I/O chip w/LPC interface & SMBus
+              IT8712F  Super I/O chip w/LPC interface
               IT8716F  Super I/O chip w/LPC interface
               IT8718F  Super I/O chip w/LPC interface
               Sis950   A clone of the IT8705F
@@ -41,12 +41,8 @@
 #include <asm/io.h>
 
 
-/* Addresses to scan */
-static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 static unsigned short isa_address;
-
-/* Insmod parameters */
-I2C_CLIENT_INSMOD_4(it87, it8712, it8716, it8718);
+enum chips { it87, it8712, it8716, it8718 };
 
 #define	REG	0x2e	/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
@@ -162,8 +158,6 @@
 #define IT87_REG_TEMP_HIGH(nr) (0x40 + (nr) * 2)
 #define IT87_REG_TEMP_LOW(nr)  (0x41 + (nr) * 2)
 
-#define IT87_REG_I2C_ADDR      0x48
-
 #define IT87_REG_VIN_ENABLE    0x50
 #define IT87_REG_TEMP_ENABLE   0x51
 
@@ -242,33 +236,22 @@
 };
 
 
-static int it87_attach_adapter(struct i2c_adapter *adapter);
-static int it87_isa_attach_adapter(struct i2c_adapter *adapter);
-static int it87_detect(struct i2c_adapter *adapter, int address, int kind);
+static int it87_detect(struct i2c_adapter *adapter);
 static int it87_detach_client(struct i2c_client *client);
 
 static int it87_read_value(struct i2c_client *client, u8 reg);
-static int it87_write_value(struct i2c_client *client, u8 reg, u8 value);
+static void it87_write_value(struct i2c_client *client, u8 reg, u8 value);
 static struct it87_data *it87_update_device(struct device *dev);
 static int it87_check_pwm(struct i2c_client *client);
 static void it87_init_client(struct i2c_client *client, struct it87_data *data);
 
 
-static struct i2c_driver it87_driver = {
-	.driver = {
-		.name	= "it87",
-	},
-	.id		= I2C_DRIVERID_IT87,
-	.attach_adapter	= it87_attach_adapter,
-	.detach_client	= it87_detach_client,
-};
-
 static struct i2c_driver it87_isa_driver = {
 	.driver = {
 		.owner	= THIS_MODULE,
 		.name	= "it87-isa",
 	},
-	.attach_adapter	= it87_isa_attach_adapter,
+	.attach_adapter	= it87_detect,
 	.detach_client	= it87_detach_client,
 };
 
@@ -850,22 +833,6 @@
 	.attrs = it87_attributes_opt,
 };
 
-/* This function is called when:
-     * it87_driver is inserted (when this module is loaded), for each
-       available adapter
-     * when a new adapter is inserted (and it87_driver is still present) */
-static int it87_attach_adapter(struct i2c_adapter *adapter)
-{
-	if (!(adapter->class & I2C_CLASS_HWMON))
-		return 0;
-	return i2c_probe(adapter, &addr_data, it87_detect);
-}
-
-static int it87_isa_attach_adapter(struct i2c_adapter *adapter)
-{
-	return it87_detect(adapter, isa_address, -1);
-}
-
 /* SuperIO detection - will change isa_address if a chip is found */
 static int __init it87_find(unsigned short *address)
 {
@@ -916,29 +883,20 @@
 }
 
 /* This function is called by i2c_probe */
-static int it87_detect(struct i2c_adapter *adapter, int address, int kind)
+static int it87_detect(struct i2c_adapter *adapter)
 {
-	int i;
 	struct i2c_client *new_client;
 	struct it87_data *data;
 	int err = 0;
-	const char *name = "";
-	int is_isa = i2c_is_isa_adapter(adapter);
+	const char *name;
 	int enable_pwm_interface;
 
-	if (!is_isa && 
-	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		goto ERROR0;
-
 	/* Reserve the ISA region */
-	if (is_isa)
-		if (!request_region(address, IT87_EXTENT,
-				    it87_isa_driver.driver.name))
-			goto ERROR0;
-
-	/* For now, we presume we have a valid client. We create the
-	   client structure, even though we cannot fill it completely yet.
-	   But it allows us to access it87_{read,write}_value. */
+	if (!request_region(isa_address, IT87_EXTENT,
+			    it87_isa_driver.driver.name)){
+		err = -EBUSY;
+		goto ERROR0;
+	}
 
 	if (!(data = kzalloc(sizeof(struct it87_data), GFP_KERNEL))) {
 		err = -ENOMEM;
@@ -946,80 +904,46 @@
 	}
 
 	new_client = &data->client;
-	if (is_isa)
-		mutex_init(&data->lock);
+	mutex_init(&data->lock);
 	i2c_set_clientdata(new_client, data);
-	new_client->addr = address;
+	new_client->addr = isa_address;
 	new_client->adapter = adapter;
-	new_client->driver = is_isa ? &it87_isa_driver : &it87_driver;
-	new_client->flags = 0;
+	new_client->driver = &it87_isa_driver;
 
 	/* Now, we do the remaining detection. */
-
-	if (kind < 0) {
-		if ((it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
-		  || (!is_isa
-		   && it87_read_value(new_client, IT87_REG_I2C_ADDR) != address)) {
-		   	err = -ENODEV;
-			goto ERROR2;
-		}
+	if ((it87_read_value(new_client, IT87_REG_CONFIG) & 0x80)
+	 || it87_read_value(new_client, IT87_REG_CHIPID) != 0x90) {
+		err = -ENODEV;
+		goto ERROR2;
 	}
 
 	/* Determine the chip type. */
-	if (kind <= 0) {
-		i = it87_read_value(new_client, IT87_REG_CHIPID);
-		if (i = 0x90) {
-			kind = it87;
-			if (is_isa) {
-				switch (chip_type) {
-				case IT8712F_DEVID:
-					kind = it8712;
-					break;
-				case IT8716F_DEVID:
-					kind = it8716;
-					break;
-				case IT8718F_DEVID:
-					kind = it8718;
-					break;
-				}
-			}
-		}
-		else {
-			if (kind = 0)
-				dev_info(&adapter->dev, 
-					"Ignoring 'force' parameter for unknown chip at "
-					"adapter %d, address 0x%02x\n",
-					i2c_adapter_id(adapter), address);
-			err = -ENODEV;
-			goto ERROR2;
-		}
-	}
-
-	if (kind = it87) {
-		name = "it87";
-	} else if (kind = it8712) {
+	switch (chip_type) {
+	case IT8712F_DEVID:
+		data->type = it8712;
 		name = "it8712";
-	} else if (kind = it8716) {
+		break;
+	case IT8716F_DEVID:
+		data->type = it8716;
 		name = "it8716";
-	} else if (kind = it8718) {
+		break;
+	case IT8718F_DEVID:
+		data->type = it8718;
 		name = "it8718";
+		break;
+	default:
+		data->type = it87;
+		name = "it87";
 	}
 
 	/* Fill in the remaining client fields and put it into the global list */
 	strlcpy(new_client->name, name, I2C_NAME_SIZE);
-	data->type = kind;
-	data->valid = 0;
 	mutex_init(&data->update_lock);
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
 		goto ERROR2;
 
-	if (!is_isa)
-		dev_info(&new_client->dev, "The I2C interface to IT87xxF "
-			 "hardware monitoring chips is deprecated. Please "
-			 "report if you still rely on it.\n");
-
 	/* Check PWM configuration */
 	enable_pwm_interface = it87_check_pwm(new_client);
 
@@ -1129,8 +1053,7 @@
 ERROR2:
 	kfree(data);
 ERROR1:
-	if (is_isa)
-		release_region(address, IT87_EXTENT);
+	release_region(isa_address, IT87_EXTENT);
 ERROR0:
 	return err;
 }
@@ -1147,50 +1070,39 @@
 	if ((err = i2c_detach_client(client)))
 		return err;
 
-	if(i2c_is_isa_client(client))
-		release_region(client->addr, IT87_EXTENT);
+	release_region(client->addr, IT87_EXTENT);
 	kfree(data);
 
 	return 0;
 }
 
-/* The SMBus locks itself, but ISA access must be locked explicitly! 
-   We don't want to lock the whole ISA bus, so we lock each client
-   separately.
+/* ISA access must be locked explicitly!
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
    would slow down the IT87 access and should not be necessary. */
 static int it87_read_value(struct i2c_client *client, u8 reg)
 {
 	struct it87_data *data = i2c_get_clientdata(client);
-
 	int res;
-	if (i2c_is_isa_client(client)) {
-		mutex_lock(&data->lock);
-		outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
-		res = inb_p(client->addr + IT87_DATA_REG_OFFSET);
-		mutex_unlock(&data->lock);
-		return res;
-	} else
-		return i2c_smbus_read_byte_data(client, reg);
+
+	mutex_lock(&data->lock);
+	outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
+	res = inb_p(client->addr + IT87_DATA_REG_OFFSET);
+	mutex_unlock(&data->lock);
+
+	return res;
 }
 
-/* The SMBus locks itself, but ISA access muse be locked explicitly! 
-   We don't want to lock the whole ISA bus, so we lock each client
-   separately.
+/* ISA access must be locked explicitly!
    We ignore the IT87 BUSY flag at this moment - it could lead to deadlocks,
    would slow down the IT87 access and should not be necessary. */
-static int it87_write_value(struct i2c_client *client, u8 reg, u8 value)
+static void it87_write_value(struct i2c_client *client, u8 reg, u8 value)
 {
 	struct it87_data *data = i2c_get_clientdata(client);
 
-	if (i2c_is_isa_client(client)) {
-		mutex_lock(&data->lock);
-		outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
-		outb_p(value, client->addr + IT87_DATA_REG_OFFSET);
-		mutex_unlock(&data->lock);
-		return 0;
-	} else
-		return i2c_smbus_write_byte_data(client, reg, value);
+	mutex_lock(&data->lock);
+	outb_p(reg, client->addr + IT87_ADDR_REG_OFFSET);
+	outb_p(value, client->addr + IT87_DATA_REG_OFFSET);
+	mutex_unlock(&data->lock);
 }
 
 /* Return 1 if and only if the PWM interface is safe to use */
@@ -1426,26 +1338,14 @@
 {
 	int res;
 
-	res = i2c_add_driver(&it87_driver);
-	if (res)
+	if ((res = it87_find(&isa_address)))
 		return res;
-
-	if (!it87_find(&isa_address)) {
-		res = i2c_isa_add_driver(&it87_isa_driver);
-		if (res) {
-			i2c_del_driver(&it87_driver);
-			return res;
-		}
-	}
-
-	return 0;
+	return i2c_isa_add_driver(&it87_isa_driver);
 }
 
 static void __exit sm_it87_exit(void)
 {
-	if (isa_address)
-		i2c_isa_del_driver(&it87_isa_driver);
-	i2c_del_driver(&it87_driver);
+	i2c_isa_del_driver(&it87_isa_driver);
 }
 
 
--- linux-2.6.19-rc1.orig/Documentation/feature-removal-schedule.txt	2006-10-06 21:27:34.000000000 +0200
+++ linux-2.6.19-rc1/Documentation/feature-removal-schedule.txt	2006-10-07 11:01:06.000000000 +0200
@@ -147,15 +147,6 @@
 
 ---------------------------
 
-What:	I2C interface of the it87 driver
-When:	January 2007
-Why:	The ISA interface is faster and should be always available. The I2C
-	probing is also known to cause trouble in at least one case (see
-	bug #5889.)
-Who:	Jean Delvare <khali at linux-fr.org>
-
----------------------------
-
 What:	Unused EXPORT_SYMBOL/EXPORT_SYMBOL_GPL exports
 	(temporary transition config option provided until then)
 	The transition config option will also be removed at the same time.
--- linux-2.6.19-rc1.orig/include/linux/i2c-id.h	2006-10-06 21:27:34.000000000 +0200
+++ linux-2.6.19-rc1/include/linux/i2c-id.h	2006-10-07 11:05:34.000000000 +0200
@@ -143,7 +143,6 @@
 #define I2C_DRIVERID_MTP008 1023
 #define I2C_DRIVERID_DS1621 1024
 #define I2C_DRIVERID_ADM1024 1025
-#define I2C_DRIVERID_IT87 1026
 #define I2C_DRIVERID_CH700X 1027 /* single driver for CH7003-7009 digital pc to tv encoders */
 #define I2C_DRIVERID_FSCPOS 1028
 #define I2C_DRIVERID_FSCSCY 1029


-- 
Jean Delvare

