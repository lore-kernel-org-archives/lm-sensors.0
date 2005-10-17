From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 23:08:16 +0000
Subject: [lm-sensors] [PATCH 10/14] hwmon: kzalloc conversion
Message-Id: <20051017230832.6ef5a1b4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Deepak Saxena <dsaxena@plexity.net>
Content-Disposition: inline; filename=kzalloc-02-hwmon.patch

Use kzalloc instead of kmalloc+memset in all hardware monitoring
drivers.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

---
 drivers/hwmon/adm1021.c    |    3 +--
 drivers/hwmon/adm1025.c    |    3 +--
 drivers/hwmon/adm1026.c    |    4 +---
 drivers/hwmon/adm1031.c    |    3 +--
 drivers/hwmon/asb100.c     |   11 ++++-------
 drivers/hwmon/atxp1.c      |    3 +--
 drivers/hwmon/ds1621.c     |    3 +--
 drivers/hwmon/fscher.c     |    3 +--
 drivers/hwmon/fscpos.c     |    3 +--
 drivers/hwmon/gl518sm.c    |    3 +--
 drivers/hwmon/gl520sm.c    |    3 +--
 drivers/hwmon/it87.c       |    3 +--
 drivers/hwmon/lm63.c       |    3 +--
 drivers/hwmon/lm75.c       |    3 +--
 drivers/hwmon/lm77.c       |    3 +--
 drivers/hwmon/lm78.c       |    3 +--
 drivers/hwmon/lm80.c       |    3 +--
 drivers/hwmon/lm83.c       |    3 +--
 drivers/hwmon/lm85.c       |    3 +--
 drivers/hwmon/lm87.c       |    3 +--
 drivers/hwmon/lm90.c       |    3 +--
 drivers/hwmon/lm92.c       |    3 +--
 drivers/hwmon/max1619.c    |    3 +--
 drivers/hwmon/pc87360.c    |    3 +--
 drivers/hwmon/sis5595.c    |    3 +--
 drivers/hwmon/smsc47b397.c |    3 +--
 drivers/hwmon/smsc47m1.c   |    3 +--
 drivers/hwmon/via686a.c    |    3 +--
 drivers/hwmon/w83627ehf.c  |    3 +--
 drivers/hwmon/w83627hf.c   |    3 +--
 drivers/hwmon/w83781d.c    |   10 +++-------
 drivers/hwmon/w83792d.c    |    6 ++----
 drivers/hwmon/w83l785ts.c  |    4 +---
 33 files changed, 39 insertions(+), 80 deletions(-)

--- linux-2.6.14-rc4.orig/drivers/hwmon/adm1021.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/adm1021.c	2005-10-13 22:05:06.000000000 +0200
@@ -204,11 +204,10 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access adm1021_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct adm1021_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto error0;
 	}
-	memset(data, 0, sizeof(struct adm1021_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/adm1025.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/adm1025.c	2005-10-13 22:05:06.000000000 +0200
@@ -331,11 +331,10 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct adm1025_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct adm1025_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct adm1025_data));
 
 	/* The common I2C client data is placed right before the
 	   ADM1025-specific data. */
--- linux-2.6.14-rc4.orig/drivers/hwmon/adm1026.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/adm1026.c	2005-10-13 22:05:06.000000000 +0200
@@ -1470,13 +1470,11 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access adm1026_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct adm1026_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct adm1026_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
 
-	memset(data, 0, sizeof(struct adm1026_data));
-
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
--- linux-2.6.14-rc4.orig/drivers/hwmon/adm1031.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/adm1031.c	2005-10-13 22:05:06.000000000 +0200
@@ -740,11 +740,10 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct adm1031_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct adm1031_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct adm1031_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/asb100.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/asb100.c	2005-10-13 22:05:06.000000000 +0200
@@ -629,19 +629,17 @@
 	int i, id, err;
 	struct asb100_data *data = i2c_get_clientdata(new_client);
 
-	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	data->lm75[0] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!(data->lm75[0])) {
 		err = -ENOMEM;
 		goto ERROR_SC_0;
 	}
-	memset(data->lm75[0], 0x00, sizeof(struct i2c_client));
 
-	data->lm75[1] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	data->lm75[1] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!(data->lm75[1])) {
 		err = -ENOMEM;
 		goto ERROR_SC_1;
 	}
-	memset(data->lm75[1], 0x00, sizeof(struct i2c_client));
 
 	id = i2c_adapter_id(adapter);
 
@@ -724,12 +722,11 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access asb100_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct asb100_data), GFP_KERNEL))) {
-		pr_debug("asb100.o: detect failed, kmalloc failed!\n");
+	if (!(data = kzalloc(sizeof(struct asb100_data), GFP_KERNEL))) {
+		pr_debug("asb100.o: detect failed, kzalloc failed!\n");
 		err = -ENOMEM;
 		goto ERROR0;
 	}
-	memset(data, 0, sizeof(struct asb100_data));
 
 	new_client = &data->client;
 	init_MUTEX(&data->lock);
--- linux-2.6.14-rc4.orig/drivers/hwmon/atxp1.c	2005-10-13 21:41:25.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/atxp1.c	2005-10-13 22:05:06.000000000 +0200
@@ -268,12 +268,11 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct atxp1_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct atxp1_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
 
-	memset(data, 0, sizeof(struct atxp1_data));
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
 
--- linux-2.6.14-rc4.orig/drivers/hwmon/ds1621.c	2005-10-13 21:41:25.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/ds1621.c	2005-10-13 22:05:06.000000000 +0200
@@ -202,11 +202,10 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access ds1621_{read,write}_value. */
-	if (!(data = kmalloc(sizeof(struct ds1621_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct ds1621_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct ds1621_data));
 	
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/fscher.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/fscher.c	2005-10-13 22:05:06.000000000 +0200
@@ -303,11 +303,10 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	 * client structure, even though we cannot fill it completely yet.
 	 * But it allows us to access i2c_smbus_read_byte_data. */
-	if (!(data = kmalloc(sizeof(struct fscher_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct fscher_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
   	}
-	memset(data, 0, sizeof(struct fscher_data));
 
 	/* The common I2C client data is placed right before the
 	 * Hermes-specific data. */
--- linux-2.6.14-rc4.orig/drivers/hwmon/fscpos.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/fscpos.c	2005-10-13 22:05:06.000000000 +0200
@@ -453,11 +453,10 @@
 	 * But it allows us to access fscpos_{read,write}_value.
 	 */
 
-	if (!(data = kmalloc(sizeof(struct fscpos_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct fscpos_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct fscpos_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/gl518sm.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/gl518sm.c	2005-10-13 22:05:06.000000000 +0200
@@ -365,11 +365,10 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access gl518_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct gl518_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct gl518_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct gl518_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/gl520sm.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/gl520sm.c	2005-10-13 22:05:06.000000000 +0200
@@ -536,11 +536,10 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access gl520_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct gl520_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct gl520_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct gl520_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/it87.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/it87.c	2005-10-13 22:05:06.000000000 +0200
@@ -761,11 +761,10 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access it87_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct it87_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct it87_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(data, 0, sizeof(struct it87_data));
 
 	new_client = &data->client;
 	if (is_isa)
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm63.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm63.c	2005-10-13 22:05:06.000000000 +0200
@@ -375,11 +375,10 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm63_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm63_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm63_data));
 
 	/* The common I2C client data is placed right before the
 	   LM63-specific data. */
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm75.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm75.c	2005-10-13 22:05:06.000000000 +0200
@@ -127,11 +127,10 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm75_{read,write}_value. */
-	if (!(data = kmalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm75_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm75_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm77.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm77.c	2005-10-13 22:05:06.000000000 +0200
@@ -226,11 +226,10 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm77_{read,write}_value. */
-	if (!(data = kmalloc(sizeof(struct lm77_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm77_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm77_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm78.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm78.c	2005-10-13 22:05:06.000000000 +0200
@@ -540,11 +540,10 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm78_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct lm78_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm78_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(data, 0, sizeof(struct lm78_data));
 
 	new_client = &data->client;
 	if (is_isa)
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm80.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm80.c	2005-10-13 22:05:06.000000000 +0200
@@ -407,11 +407,10 @@
 	/* OK. For now, we presume we have a valid client. We now create the
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm80_{read,write}_value. */
-	if (!(data = kmalloc(sizeof(struct lm80_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm80_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm80_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm83.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm83.c	2005-10-13 22:05:06.000000000 +0200
@@ -230,11 +230,10 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm83_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm83_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm83_data));
 
 	/* The common I2C client data is placed right after the
 	 * LM83-specific data. */
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm85.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm85.c	2005-10-13 22:05:06.000000000 +0200
@@ -1033,11 +1033,10 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access lm85_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct lm85_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm85_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
-	memset(data, 0, sizeof(struct lm85_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm87.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm87.c	2005-10-13 22:05:06.000000000 +0200
@@ -554,11 +554,10 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm87_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm87_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm87_data));
 
 	/* The common I2C client data is placed right before the
 	   LM87-specific data. */
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm90.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm90.c	2005-10-13 22:05:06.000000000 +0200
@@ -370,11 +370,10 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm90_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm90_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm90_data));
 
 	/* The common I2C client data is placed right before the
 	   LM90-specific data. */
--- linux-2.6.14-rc4.orig/drivers/hwmon/lm92.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/lm92.c	2005-10-13 22:05:06.000000000 +0200
@@ -300,11 +300,10 @@
 					    | I2C_FUNC_SMBUS_WORD_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct lm92_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct lm92_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct lm92_data));
 
 	/* Fill in enough client fields so that we can read from the chip,
 	   which is required for identication */
--- linux-2.6.14-rc4.orig/drivers/hwmon/max1619.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/max1619.c	2005-10-13 22:05:06.000000000 +0200
@@ -197,11 +197,10 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct max1619_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct max1619_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct max1619_data));
 
 	/* The common I2C client data is placed right before the
 	   MAX1619-specific data. */
--- linux-2.6.14-rc4.orig/drivers/hwmon/pc87360.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/pc87360.c	2005-10-13 22:05:06.000000000 +0200
@@ -754,9 +754,8 @@
 	const char *name = "pc87360";
 	int use_thermistors = 0;
 
-	if (!(data = kmalloc(sizeof(struct pc87360_data), GFP_KERNEL)))
+	if (!(data = kzalloc(sizeof(struct pc87360_data), GFP_KERNEL)))
 		return -ENOMEM;
-	memset(data, 0x00, sizeof(struct pc87360_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/sis5595.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/sis5595.c	2005-10-13 22:05:06.000000000 +0200
@@ -518,11 +518,10 @@
 			goto exit_release;
 	}
 
-	if (!(data = kmalloc(sizeof(struct sis5595_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct sis5595_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
-	memset(data, 0, sizeof(struct sis5595_data));
 
 	new_client = &data->client;
 	new_client->addr = address;
--- linux-2.6.14-rc4.orig/drivers/hwmon/smsc47b397.c	2005-10-13 21:40:18.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/smsc47b397.c	2005-10-13 22:05:06.000000000 +0200
@@ -244,11 +244,10 @@
 		return -EBUSY;
 	}
 
-	if (!(data = kmalloc(sizeof(struct smsc47b397_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct smsc47b397_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto error_release;
 	}
-	memset(data, 0x00, sizeof(struct smsc47b397_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/smsc47m1.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/smsc47m1.c	2005-10-13 22:05:06.000000000 +0200
@@ -396,11 +396,10 @@
 		return -EBUSY;
 	}
 
-	if (!(data = kmalloc(sizeof(struct smsc47m1_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct smsc47m1_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto error_release;
 	}
-	memset(data, 0x00, sizeof(struct smsc47m1_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/via686a.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/via686a.c	2005-10-13 22:05:06.000000000 +0200
@@ -621,11 +621,10 @@
 		return -ENODEV;
 	}
 
-	if (!(data = kmalloc(sizeof(struct via686a_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct via686a_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
-	memset(data, 0, sizeof(struct via686a_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/w83627ehf.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/w83627ehf.c	2005-10-13 22:05:06.000000000 +0200
@@ -681,11 +681,10 @@
 		goto exit;
 	}
 
-	if (!(data = kmalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit_release;
 	}
-	memset(data, 0, sizeof(struct w83627ehf_data));
 
 	client = &data->client;
 	i2c_set_clientdata(client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/w83627hf.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/w83627hf.c	2005-10-13 22:05:06.000000000 +0200
@@ -1045,11 +1045,10 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83627hf_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct w83627hf_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83627hf_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(data, 0, sizeof(struct w83627hf_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/w83781d.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/w83781d.c	2005-10-13 22:57:31.000000000 +0200
@@ -889,12 +889,11 @@
 	const char *client_name = "";
 	struct w83781d_data *data = i2c_get_clientdata(new_client);
 
-	data->lm75[0] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	data->lm75[0] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!(data->lm75[0])) {
 		err = -ENOMEM;
 		goto ERROR_SC_0;
 	}
-	memset(data->lm75[0], 0x00, sizeof (struct i2c_client));
 
 	id = i2c_adapter_id(adapter);
 
@@ -919,13 +918,11 @@
 	}
 
 	if (kind != w83783s) {
-
-		data->lm75[1] = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+		data->lm75[1] = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 		if (!(data->lm75[1])) {
 			err = -ENOMEM;
 			goto ERROR_SC_1;
 		}
-		memset(data->lm75[1], 0x0, sizeof(struct i2c_client));
 
 		if (force_subclients[0] = id &&
 		    force_subclients[1] = address) {
@@ -1064,11 +1061,10 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83781d_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83781d_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR1;
 	}
-	memset(data, 0, sizeof(struct w83781d_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/w83792d.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/w83792d.c	2005-10-13 22:05:06.000000000 +0200
@@ -1086,11 +1086,10 @@
 	int err;
 	struct i2c_client *sub_client;
 
-	(*sub_cli) = sub_client = kmalloc(sizeof(struct i2c_client), GFP_KERNEL);
+	(*sub_cli) = sub_client = kzalloc(sizeof(struct i2c_client), GFP_KERNEL);
 	if (!(sub_client)) {
 		return -ENOMEM;
 	}
-	memset(sub_client, 0x00, sizeof(struct i2c_client));
 	sub_client->addr = 0x48 + addr;
 	i2c_set_clientdata(sub_client, NULL);
 	sub_client->adapter = adapter;
@@ -1184,11 +1183,10 @@
 	   client structure, even though we cannot fill it completely yet.
 	   But it allows us to access w83792d_{read,write}_value. */
 
-	if (!(data = kmalloc(sizeof(struct w83792d_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83792d_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto ERROR0;
 	}
-	memset(data, 0, sizeof(struct w83792d_data));
 
 	new_client = &data->client;
 	i2c_set_clientdata(new_client, data);
--- linux-2.6.14-rc4.orig/drivers/hwmon/w83l785ts.c	2005-10-12 21:24:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/hwmon/w83l785ts.c	2005-10-13 22:05:06.000000000 +0200
@@ -156,12 +156,10 @@
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto exit;
 
-	if (!(data = kmalloc(sizeof(struct w83l785ts_data), GFP_KERNEL))) {
+	if (!(data = kzalloc(sizeof(struct w83l785ts_data), GFP_KERNEL))) {
 		err = -ENOMEM;
 		goto exit;
 	}
-	memset(data, 0, sizeof(struct w83l785ts_data));
-
 
 	/* The common I2C client data is placed right before the
 	 * W83L785TS-specific data. */

-- 
Jean Delvare
