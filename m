From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:49:07 +0000
Subject: [lm-sensors] [PATCH] I2C: refactor message in i2c_detach_client
Message-Id: <11259567671358@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: refactor message in i2c_detach_client

We could refactor the error message 34 different i2c drivers print if
i2c_detach_client() fails in this function itself. Saves quite a few
lines of code. Documentation is updated to reflect that change.

Note that this patch should be applied after Rudolf Marek's w83792d
patches.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7bef559455fc71f66f8573cc1aafe1dd33966c1c
tree 6c342574710f730d39bf5383f81eaa9f9bb10a25
parent 1ff4e3065b41847b6fe5908b1214cb508dd49e61
author Jean Delvare <khali@linux-fr.org> Wed, 27 Jul 2005 22:14:49 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:14 -0700

 Documentation/i2c/porting-clients |    3 ++-
 Documentation/i2c/writing-clients |    4 +---
 drivers/hwmon/adm1021.c           |    4 +---
 drivers/hwmon/adm1025.c           |    5 +----
 drivers/hwmon/adm9240.c           |    5 +----
 drivers/hwmon/asb100.c            |    5 +----
 drivers/hwmon/ds1621.c            |    5 +----
 drivers/hwmon/fscher.c            |    5 +----
 drivers/hwmon/fscpos.c            |    5 +----
 drivers/hwmon/gl518sm.c           |    5 +----
 drivers/hwmon/gl520sm.c           |    5 +----
 drivers/hwmon/it87.c              |    5 +----
 drivers/hwmon/lm63.c              |    5 +----
 drivers/hwmon/lm78.c              |    5 +----
 drivers/hwmon/lm80.c              |    5 +----
 drivers/hwmon/lm83.c              |    5 +----
 drivers/hwmon/lm87.c              |    5 +----
 drivers/hwmon/lm90.c              |    5 +----
 drivers/hwmon/lm92.c              |    5 +----
 drivers/hwmon/max1619.c           |    5 +----
 drivers/hwmon/pc87360.c           |    5 +----
 drivers/hwmon/sis5595.c           |    5 +----
 drivers/hwmon/smsc47b397.c        |    5 +----
 drivers/hwmon/smsc47m1.c          |    5 +----
 drivers/hwmon/via686a.c           |    5 +----
 drivers/hwmon/w83627ehf.c         |    5 +----
 drivers/hwmon/w83627hf.c          |    5 +----
 drivers/hwmon/w83781d.c           |    5 +----
 drivers/hwmon/w83792d.c           |    5 +----
 drivers/hwmon/w83l785ts.c         |    5 +----
 drivers/i2c/chips/ds1337.c        |    5 +----
 drivers/i2c/chips/eeprom.c        |    4 +---
 drivers/i2c/chips/max6875.c       |    4 +---
 drivers/i2c/chips/pca9539.c       |    4 +---
 drivers/i2c/chips/pcf8574.c       |    5 +----
 drivers/i2c/chips/pcf8591.c       |    5 +----
 drivers/i2c/i2c-core.c            |    6 +++++-
 37 files changed, 42 insertions(+), 137 deletions(-)

diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -94,7 +94,8 @@ Technical changes:
   limited to the strictly necessary steps.
 
 * [Detach] Get rid of data, remove the call to
-  i2c_deregister_entry.
+  i2c_deregister_entry. Do not log an error message if
+  i2c_detach_client fails, as i2c-core will now do it for you.
 
 * [Update] Don't access client->data directly, use
   i2c_get_clientdata(client) instead.
diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -489,10 +489,8 @@ much simpler than the attachment code, f
     /* SENSORS ONLY END */
 
     /* Try to detach the client from i2c space */
-    if ((err = i2c_detach_client(client))) {
-      printk("foo.o: Client deregistration failed, client not detached.\n");
+    if ((err = i2c_detach_client(client)))
       return err;
-    }
 
     /* HYBRID SENSORS CHIP ONLY START */
     if i2c_is_isa_client(client)
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -328,10 +328,8 @@ static int adm1021_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -517,11 +517,8 @@ static int adm1025_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -645,11 +645,8 @@ static int adm9240_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-				"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -867,11 +867,8 @@ static int asb100_detach_client(struct i
 	if (data)
 		hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "client deregistration failed; "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	/* main client */
 	if (data)
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -282,11 +282,8 @@ static int ds1621_detach_client(struct i
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -383,11 +383,8 @@ static int fscher_detach_client(struct i
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -549,11 +549,8 @@ static int fscpos_detach_client(struct i
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, client"
-							" not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 	kfree(data);
 	return 0;
 }
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -492,11 +492,8 @@ static int gl518_detach_client(struct i2
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -654,11 +654,8 @@ static int gl520_detach_client(struct i2
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -945,11 +945,8 @@ static int it87_detach_client(struct i2c
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-			"Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	if(i2c_is_isa_client(client))
 		release_region(client->addr, IT87_EXTENT);
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -520,11 +520,8 @@ static int lm63_detach_client(struct i2c
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -683,11 +683,8 @@ static int lm78_detach_client(struct i2c
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		    "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	if(i2c_is_isa_client(client))
 		release_region(client->addr, LM78_EXTENT);
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -510,11 +510,8 @@ static int lm80_detach_client(struct i2c
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -363,11 +363,8 @@ static int lm83_detach_client(struct i2c
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		    "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -734,11 +734,8 @@ static int lm87_detach_client(struct i2c
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -562,11 +562,8 @@ static int lm90_detach_client(struct i2c
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -399,11 +399,8 @@ static int lm92_detach_client(struct i2c
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -322,11 +322,8 @@ static int max1619_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -984,11 +984,8 @@ static int pc87360_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((i = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((i = i2c_detach_client(client)))
 		return i;
-	}
 
 	for (i = 0; i < 3; i++) {
 		if (data->address[i]) {
diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -618,11 +618,8 @@ static int sis5595_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		    "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, SIS5595_EXTENT);
 
diff --git a/drivers/hwmon/smsc47b397.c b/drivers/hwmon/smsc47b397.c
--- a/drivers/hwmon/smsc47b397.c
+++ b/drivers/hwmon/smsc47b397.c
@@ -214,11 +214,8 @@ static int smsc47b397_detach_client(stru
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, SMSC_EXTENT);
 	kfree(data);
diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -497,11 +497,8 @@ static int smsc47m1_detach_client(struct
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, SMSC_EXTENT);
 	kfree(data);
diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -700,11 +700,8 @@ static int via686a_detach_client(struct 
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		"Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, VIA686A_EXTENT);
 	kfree(data);
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -774,11 +774,8 @@ static int w83627ehf_detach_client(struc
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 	release_region(client->addr, REGION_LENGTH);
 	kfree(data);
 
diff --git a/drivers/hwmon/w83627hf.c b/drivers/hwmon/w83627hf.c
--- a/drivers/hwmon/w83627hf.c
+++ b/drivers/hwmon/w83627hf.c
@@ -1157,11 +1157,8 @@ static int w83627hf_detach_client(struct
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		       "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, WINB_EXTENT);
 	kfree(data);
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -1299,11 +1299,8 @@ w83781d_detach_client(struct i2c_client 
 	if (i2c_is_isa_client(client))
 		release_region(client->addr, W83781D_EXTENT);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		       "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	/* main client */
 	if (data)
diff --git a/drivers/hwmon/w83792d.c b/drivers/hwmon/w83792d.c
--- a/drivers/hwmon/w83792d.c
+++ b/drivers/hwmon/w83792d.c
@@ -1396,11 +1396,8 @@ w83792d_detach_client(struct i2c_client 
 	if (data)
 		hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-			"Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	/* main client */
 	if (data)
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -267,11 +267,8 @@ static int w83l785ts_detach_client(struc
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -353,11 +353,8 @@ static int ds1337_detach_client(struct i
 	int err;
 	struct ds1337_data *data = i2c_get_clientdata(client);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	list_del(&data->list);
 	kfree(data);
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -230,10 +230,8 @@ static int eeprom_detach_client(struct i
 	int err;
 
 	err = i2c_detach_client(client);
-	if (err) {
-		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
+	if (err)
 		return err;
-	}
 
 	kfree(i2c_get_clientdata(client));
 
diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -242,10 +242,8 @@ static int max6875_detach_client(struct 
 	int err;
 
 	err = i2c_detach_client(client);
-	if (err) {
-		dev_err(&client->dev, "i2c_detach_client() failed\n");
+	if (err)
 		return err;
-	}
 	kfree(i2c_get_clientdata(client));
 	return 0;
 }
diff --git a/drivers/i2c/chips/pca9539.c b/drivers/i2c/chips/pca9539.c
--- a/drivers/i2c/chips/pca9539.c
+++ b/drivers/i2c/chips/pca9539.c
@@ -163,10 +163,8 @@ static int pca9539_detach_client(struct 
 {
 	int err;
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(i2c_get_clientdata(client));
 	return 0;
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -185,11 +185,8 @@ static int pcf8574_detach_client(struct 
 {
 	int err;
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-			"Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(i2c_get_clientdata(client));
 	return 0;
diff --git a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c
+++ b/drivers/i2c/chips/pcf8591.c
@@ -240,11 +240,8 @@ static int pcf8591_detach_client(struct 
 {
 	int err;
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-			"Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(i2c_get_clientdata(client));
 	return 0;
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -449,8 +449,12 @@ int i2c_detach_client(struct i2c_client 
 	struct i2c_adapter *adapter = client->adapter;
 	int res = 0;
 	
-	if ((client->flags & I2C_CLIENT_ALLOW_USE) && (client->usage_count > 0))
+	if ((client->flags & I2C_CLIENT_ALLOW_USE)
+	 && (client->usage_count > 0)) {
+		dev_warn(&client->dev, "Client [%s] still busy, "
+			 "can't detach\n", client->name);
 		return -EBUSY;
+	}
 
 	if (adapter->client_unregister)  {
 		res = adapter->client_unregister(client);

