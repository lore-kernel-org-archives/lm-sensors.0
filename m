From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:31:09 +0000
Subject: [lm-sensors] [patch 3/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212541.247586000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_drivers's ones.

This patch updates the hwmon drivers.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/hwmon/adm1021.c    |    6 ++++--
 drivers/hwmon/adm1025.c    |    6 ++++--
 drivers/hwmon/adm1026.c    |    6 ++++--
 drivers/hwmon/adm1031.c    |    6 ++++--
 drivers/hwmon/adm9240.c    |    6 ++++--
 drivers/hwmon/asb100.c     |    6 ++++--
 drivers/hwmon/atxp1.c      |    6 ++++--
 drivers/hwmon/ds1621.c     |    6 ++++--
 drivers/hwmon/fscher.c     |    6 ++++--
 drivers/hwmon/fscpos.c     |    6 ++++--
 drivers/hwmon/gl518sm.c    |    6 ++++--
 drivers/hwmon/gl520sm.c    |    6 ++++--
 drivers/hwmon/it87.c       |   15 ++++++++++-----
 drivers/hwmon/lm63.c       |    6 ++++--
 drivers/hwmon/lm75.c       |    6 ++++--
 drivers/hwmon/lm77.c       |    6 ++++--
 drivers/hwmon/lm78.c       |   14 +++++++++-----
 drivers/hwmon/lm80.c       |    6 ++++--
 drivers/hwmon/lm83.c       |    6 ++++--
 drivers/hwmon/lm85.c       |    6 ++++--
 drivers/hwmon/lm87.c       |    6 ++++--
 drivers/hwmon/lm90.c       |    6 ++++--
 drivers/hwmon/lm92.c       |    6 ++++--
 drivers/hwmon/max1619.c    |    6 ++++--
 drivers/hwmon/pc87360.c    |    8 +++++---
 drivers/hwmon/sis5595.c    |    9 ++++++---
 drivers/hwmon/smsc47b397.c |    9 ++++++---
 drivers/hwmon/smsc47m1.c   |    8 +++++---
 drivers/hwmon/via686a.c    |    9 ++++++---
 drivers/hwmon/w83627ehf.c  |    8 +++++---
 drivers/hwmon/w83627hf.c   |    8 +++++---
 drivers/hwmon/w83781d.c    |   14 +++++++++-----
 drivers/hwmon/w83792d.c    |    6 ++++--
 drivers/hwmon/w83l785ts.c  |    6 ++++--
 34 files changed, 162 insertions(+), 84 deletions(-)

Index: linux-2.6-mm/drivers/hwmon/w83781d.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/w83781d.c
+++ linux-2.6-mm/drivers/hwmon/w83781d.c
@@ -269,8 +269,10 @@
 static void w83781d_init_client(struct i2c_client *client);
 
 static struct i2c_driver w83781d_driver = {
-	.owner = THIS_MODULE,
-	.name = "w83781d",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "w83781d",
+	},
 	.id = I2C_DRIVERID_W83781D,
 	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = w83781d_attach_adapter,
@@ -278,8 +280,10 @@
 };
 
 static struct i2c_driver w83781d_isa_driver = {
-	.owner = THIS_MODULE,
-	.name = "w83781d-isa",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "w83781d-isa",
+	},
 	.attach_adapter = w83781d_isa_attach_adapter,
 	.detach_client = w83781d_detach_client,
 };
@@ -1012,7 +1016,7 @@
 	
 	if (is_isa)
 		if (!request_region(address, W83781D_EXTENT,
-				    w83781d_isa_driver.name)) {
+				    w83781d_isa_driver.driver.name)) {
 			dev_dbg(&adapter->dev, "Request of region "
 				"0x%x-0x%x for w83781d failed\n", address,
 				address + W83781D_EXTENT - 1);
Index: linux-2.6-mm/drivers/hwmon/lm80.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm80.c
+++ linux-2.6-mm/drivers/hwmon/lm80.c
@@ -143,8 +143,10 @@
  */
 
 static struct i2c_driver lm80_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm80",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm80",
+	},
 	.id		= I2C_DRIVERID_LM80,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm80_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/via686a.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/via686a.c
+++ linux-2.6-mm/drivers/hwmon/via686a.c
@@ -572,8 +572,10 @@
 /* The driver. I choose to use type i2c_driver, as at is identical to both
    smbus_driver and isa_driver, and clients could be of either kind */
 static struct i2c_driver via686a_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "via686a",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "via686a",
+	},
 	.attach_adapter	= via686a_detect,
 	.detach_client	= via686a_detach_client,
 };
@@ -615,7 +617,8 @@
 	}
 
 	/* Reserve the ISA region */
-	if (!request_region(address, VIA686A_EXTENT, via686a_driver.name)) {
+	if (!request_region(address, VIA686A_EXTENT,
+			    via686a_driver.driver.name)) {
 		dev_err(&adapter->dev, "region 0x%x already in use!\n",
 			address);
 		return -ENODEV;
Index: linux-2.6-mm/drivers/hwmon/adm1021.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/adm1021.c
+++ linux-2.6-mm/drivers/hwmon/adm1021.c
@@ -126,8 +126,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1021_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "adm1021",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "adm1021",
+	},
 	.id		= I2C_DRIVERID_ADM1021,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1021_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/adm1025.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/adm1025.c
+++ linux-2.6-mm/drivers/hwmon/adm1025.c
@@ -118,8 +118,10 @@
  */
 
 static struct i2c_driver adm1025_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "adm1025",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "adm1025",
+	},
 	.id		= I2C_DRIVERID_ADM1025,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm1025_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/adm1026.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/adm1026.c
+++ linux-2.6-mm/drivers/hwmon/adm1026.c
@@ -308,8 +308,10 @@
 
 
 static struct i2c_driver adm1026_driver = {
-	.owner          = THIS_MODULE,
-	.name           = "adm1026",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "adm1026",
+	},
 	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = adm1026_attach_adapter,
 	.detach_client  = adm1026_detach_client,
Index: linux-2.6-mm/drivers/hwmon/adm1031.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/adm1031.c
+++ linux-2.6-mm/drivers/hwmon/adm1031.c
@@ -105,8 +105,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver adm1031_driver = {
-	.owner = THIS_MODULE,
-	.name = "adm1031",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "adm1031",
+	},
 	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = adm1031_attach_adapter,
 	.detach_client = adm1031_detach_client,
Index: linux-2.6-mm/drivers/hwmon/adm9240.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/adm9240.c
+++ linux-2.6-mm/drivers/hwmon/adm9240.c
@@ -137,8 +137,10 @@
 
 /* driver data */
 static struct i2c_driver adm9240_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "adm9240",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "adm9240",
+	},
 	.id		= I2C_DRIVERID_ADM9240,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= adm9240_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/asb100.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/asb100.c
+++ linux-2.6-mm/drivers/hwmon/asb100.c
@@ -217,8 +217,10 @@
 static void asb100_init_client(struct i2c_client *client);
 
 static struct i2c_driver asb100_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "asb100",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "asb100",
+	},
 	.id		= I2C_DRIVERID_ASB100,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= asb100_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/atxp1.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/atxp1.c
+++ linux-2.6-mm/drivers/hwmon/atxp1.c
@@ -50,8 +50,10 @@
 static int atxp1_detect(struct i2c_adapter *adapter, int address, int kind);
 
 static struct i2c_driver atxp1_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "atxp1",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "atxp1",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = atxp1_attach_adapter,
 	.detach_client	= atxp1_detach_client,
Index: linux-2.6-mm/drivers/hwmon/ds1621.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/ds1621.c
+++ linux-2.6-mm/drivers/hwmon/ds1621.c
@@ -89,8 +89,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver ds1621_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "ds1621",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "ds1621",
+	},
 	.id		= I2C_DRIVERID_DS1621,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= ds1621_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/fscher.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/fscher.c
+++ linux-2.6-mm/drivers/hwmon/fscher.c
@@ -118,8 +118,10 @@
  */
  
 static struct i2c_driver fscher_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "fscher",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "fscher",
+	},
 	.id		= I2C_DRIVERID_FSCHER,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= fscher_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/fscpos.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/fscpos.c
+++ linux-2.6-mm/drivers/hwmon/fscpos.c
@@ -100,8 +100,10 @@
  * Driver data (common to all clients)
  */
 static struct i2c_driver fscpos_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "fscpos",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "fscpos",
+	},
 	.id		= I2C_DRIVERID_FSCPOS,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= fscpos_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/gl518sm.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/gl518sm.c
+++ linux-2.6-mm/drivers/hwmon/gl518sm.c
@@ -151,8 +151,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver gl518_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "gl518sm",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "gl518sm",
+	},
 	.id		= I2C_DRIVERID_GL518,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= gl518_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/gl520sm.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/gl520sm.c
+++ linux-2.6-mm/drivers/hwmon/gl520sm.c
@@ -109,8 +109,10 @@
 
 /* Driver data */
 static struct i2c_driver gl520_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "gl520sm",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "gl520sm",
+	},
 	.id		= I2C_DRIVERID_GL520,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= gl520_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/it87.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/it87.c
+++ linux-2.6-mm/drivers/hwmon/it87.c
@@ -234,8 +234,10 @@
 
 
 static struct i2c_driver it87_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "it87",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "it87",
+	},
 	.id		= I2C_DRIVERID_IT87,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= it87_attach_adapter,
@@ -243,8 +245,10 @@
 };
 
 static struct i2c_driver it87_isa_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "it87-isa",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "it87-isa",
+	},
 	.attach_adapter	= it87_isa_attach_adapter,
 	.detach_client	= it87_detach_client,
 };
@@ -754,7 +758,8 @@
 
 	/* Reserve the ISA region */
 	if (is_isa)
-		if (!request_region(address, IT87_EXTENT, it87_isa_driver.name))
+		if (!request_region(address, IT87_EXTENT,
+				    it87_isa_driver.driver.name))
 			goto ERROR0;
 
 	/* For now, we presume we have a valid client. We create the
Index: linux-2.6-mm/drivers/hwmon/lm63.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm63.c
+++ linux-2.6-mm/drivers/hwmon/lm63.c
@@ -139,8 +139,10 @@
  */
 
 static struct i2c_driver lm63_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm63",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm63",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm63_attach_adapter,
 	.detach_client	= lm63_detach_client,
Index: linux-2.6-mm/drivers/hwmon/lm75.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm75.c
+++ linux-2.6-mm/drivers/hwmon/lm75.c
@@ -79,8 +79,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver lm75_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm75",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm75",
+	},
 	.id		= I2C_DRIVERID_LM75,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm75_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/lm77.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm77.c
+++ linux-2.6-mm/drivers/hwmon/lm77.c
@@ -74,8 +74,10 @@
 
 /* This is the driver that will be inserted */
 static struct i2c_driver lm77_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm77",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm77",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = lm77_attach_adapter,
 	.detach_client	= lm77_detach_client,
Index: linux-2.6-mm/drivers/hwmon/lm78.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm78.c
+++ linux-2.6-mm/drivers/hwmon/lm78.c
@@ -164,8 +164,10 @@
 
 
 static struct i2c_driver lm78_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm78",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm78",
+	},
 	.id		= I2C_DRIVERID_LM78,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm78_attach_adapter,
@@ -173,8 +175,10 @@
 };
 
 static struct i2c_driver lm78_isa_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm78-isa",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm78-isa",
+	},
 	.attach_adapter	= lm78_isa_attach_adapter,
 	.detach_client	= lm78_detach_client,
 };
@@ -497,7 +501,7 @@
 	/* Reserve the ISA region */
 	if (is_isa)
 		if (!request_region(address, LM78_EXTENT,
-				    lm78_isa_driver.name)) {
+				    lm78_isa_driver.driver.name)) {
 			err = -EBUSY;
 			goto ERROR0;
 		}
Index: linux-2.6-mm/drivers/hwmon/lm83.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm83.c
+++ linux-2.6-mm/drivers/hwmon/lm83.c
@@ -124,8 +124,10 @@
  */
  
 static struct i2c_driver lm83_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm83",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm83",
+	},
 	.id		= I2C_DRIVERID_LM83,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm83_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/lm85.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm85.c
+++ linux-2.6-mm/drivers/hwmon/lm85.c
@@ -380,8 +380,10 @@
 
 
 static struct i2c_driver lm85_driver = {
-	.owner          = THIS_MODULE,
-	.name           = "lm85",
+	.driver = {
+		.owner  = THIS_MODULE,
+		.name   = "lm85",
+	},
 	.id             = I2C_DRIVERID_LM85,
 	.flags          = I2C_DF_NOTIFY,
 	.attach_adapter = lm85_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/lm87.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm87.c
+++ linux-2.6-mm/drivers/hwmon/lm87.c
@@ -161,8 +161,10 @@
  */
 
 static struct i2c_driver lm87_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm87",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm87",
+	},
 	.id		= I2C_DRIVERID_LM87,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm87_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/lm90.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm90.c
+++ linux-2.6-mm/drivers/hwmon/lm90.c
@@ -186,8 +186,10 @@
  */
 
 static struct i2c_driver lm90_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm90",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm90",
+	},
 	.id		= I2C_DRIVERID_LM90,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm90_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/lm92.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/lm92.c
+++ linux-2.6-mm/drivers/hwmon/lm92.c
@@ -410,8 +410,10 @@
  */
 
 static struct i2c_driver lm92_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "lm92",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "lm92",
+	},
 	.id		= I2C_DRIVERID_LM92,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= lm92_attach_adapter,
Index: linux-2.6-mm/drivers/hwmon/max1619.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/max1619.c
+++ linux-2.6-mm/drivers/hwmon/max1619.c
@@ -90,8 +90,10 @@
  */
 
 static struct i2c_driver max1619_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "max1619",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "max1619",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= max1619_attach_adapter,
 	.detach_client	= max1619_detach_client,
Index: linux-2.6-mm/drivers/hwmon/pc87360.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/pc87360.c
+++ linux-2.6-mm/drivers/hwmon/pc87360.c
@@ -236,8 +236,10 @@
  */
 
 static struct i2c_driver pc87360_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "pc87360",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "pc87360",
+	},
 	.attach_adapter	= pc87360_detect,
 	.detach_client	= pc87360_detach_client,
 };
@@ -798,7 +800,7 @@
 	for (i = 0; i < 3; i++) {
 		if (((data->address[i] = extra_isa[i]))
 		 && !request_region(extra_isa[i], PC87360_EXTENT,
-		 		    pc87360_driver.name)) {
+		 		    pc87360_driver.driver.name)) {
 			dev_err(&new_client->dev, "Region 0x%x-0x%x already "
 				"in use!\n", extra_isa[i],
 				extra_isa[i]+PC87360_EXTENT-1);
Index: linux-2.6-mm/drivers/hwmon/sis5595.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/sis5595.c
+++ linux-2.6-mm/drivers/hwmon/sis5595.c
@@ -198,8 +198,10 @@
 static void sis5595_init_client(struct i2c_client *client);
 
 static struct i2c_driver sis5595_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "sis5595",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "sis5595",
+	},
 	.attach_adapter	= sis5595_detect,
 	.detach_client	= sis5595_detach_client,
 };
@@ -484,7 +486,8 @@
 	if (force_addr)
 		address = force_addr & ~(SIS5595_EXTENT - 1);
 	/* Reserve the ISA region */
-	if (!request_region(address, SIS5595_EXTENT, sis5595_driver.name)) {
+	if (!request_region(address, SIS5595_EXTENT,
+			    sis5595_driver.driver.name)) {
 		err = -EBUSY;
 		goto exit;
 	}
Index: linux-2.6-mm/drivers/hwmon/smsc47b397.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/smsc47b397.c
+++ linux-2.6-mm/drivers/hwmon/smsc47b397.c
@@ -226,8 +226,10 @@
 static int smsc47b397_detect(struct i2c_adapter *adapter);
 
 static struct i2c_driver smsc47b397_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "smsc47b397",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "smsc47b397",
+	},
 	.attach_adapter	= smsc47b397_detect,
 	.detach_client	= smsc47b397_detach_client,
 };
@@ -238,7 +240,8 @@
 	struct smsc47b397_data *data;
 	int err = 0;
 
-	if (!request_region(address, SMSC_EXTENT, smsc47b397_driver.name)) {
+	if (!request_region(address, SMSC_EXTENT,
+			    smsc47b397_driver.driver.name)) {
 		dev_err(&adapter->dev, "Region 0x%x already in use!\n",
 			address);
 		return -EBUSY;
Index: linux-2.6-mm/drivers/hwmon/smsc47m1.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/smsc47m1.c
+++ linux-2.6-mm/drivers/hwmon/smsc47m1.c
@@ -126,8 +126,10 @@
 
 
 static struct i2c_driver smsc47m1_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "smsc47m1",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "smsc47m1",
+	},
 	.attach_adapter	= smsc47m1_detect,
 	.detach_client	= smsc47m1_detach_client,
 };
@@ -391,7 +393,7 @@
 	int err = 0;
 	int fan1, fan2, pwm1, pwm2;
 
-	if (!request_region(address, SMSC_EXTENT, smsc47m1_driver.name)) {
+	if (!request_region(address, SMSC_EXTENT, smsc47m1_driver.driver.name)) {
 		dev_err(&adapter->dev, "Region 0x%x already in use!\n", address);
 		return -EBUSY;
 	}
Index: linux-2.6-mm/drivers/hwmon/w83627ehf.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/w83627ehf.c
+++ linux-2.6-mm/drivers/hwmon/w83627ehf.c
@@ -676,7 +676,7 @@
 	int i, err = 0;
 
 	if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
-	                    w83627ehf_driver.name)) {
+	                    w83627ehf_driver.driver.name)) {
 		err = -EBUSY;
 		goto exit;
 	}
@@ -785,8 +785,10 @@
 }
 
 static struct i2c_driver w83627ehf_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "w83627ehf",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "w83627ehf",
+	},
 	.attach_adapter	= w83627ehf_detect,
 	.detach_client	= w83627ehf_detach_client,
 };
Index: linux-2.6-mm/drivers/hwmon/w83627hf.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/w83627hf.c
+++ linux-2.6-mm/drivers/hwmon/w83627hf.c
@@ -333,8 +333,10 @@
 static void w83627hf_init_client(struct i2c_client *client);
 
 static struct i2c_driver w83627hf_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "w83627hf",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "w83627hf",
+	},
 	.attach_adapter	= w83627hf_detect,
 	.detach_client	= w83627hf_detach_client,
 };
@@ -1006,7 +1008,7 @@
 		address = force_addr & WINB_ALIGNMENT;
 
 	if (!request_region(address + WINB_REGION_OFFSET, WINB_REGION_SIZE,
-	                    w83627hf_driver.name)) {
+	                    w83627hf_driver.driver.name)) {
 		err = -EBUSY;
 		goto ERROR0;
 	}
Index: linux-2.6-mm/drivers/hwmon/w83792d.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/w83792d.c
+++ linux-2.6-mm/drivers/hwmon/w83792d.c
@@ -316,8 +316,10 @@
 static void w83792d_init_client(struct i2c_client *client);
 
 static struct i2c_driver w83792d_driver = {
-	.owner = THIS_MODULE,
-	.name = "w83792d",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "w83792d",
+	},
 	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = w83792d_attach_adapter,
 	.detach_client = w83792d_detach_client,
Index: linux-2.6-mm/drivers/hwmon/w83l785ts.c
=================================--- linux-2.6-mm.orig/drivers/hwmon/w83l785ts.c
+++ linux-2.6-mm/drivers/hwmon/w83l785ts.c
@@ -92,8 +92,10 @@
  */
  
 static struct i2c_driver w83l785ts_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "w83l785ts",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "w83l785ts",
+	},
 	.id		= I2C_DRIVERID_W83L785TS,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= w83l785ts_attach_adapter,

--

