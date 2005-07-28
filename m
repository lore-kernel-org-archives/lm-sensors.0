From: gregkh@suse.de (gregkh@suse.de)
Date: Thu, 28 Jul 2005 08:28:04 +0000
Subject: [lm-sensors] patch i2c-refactor-message.patch added to gregkh-2.6
Message-Id: <1Dy1rb-4QY-00@press.kroah.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: I2C: refactor message in i2c_detach_client

to my gregkh-2.6 tree.  Its filename is

     i2c-refactor-message.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from khali@linux-fr.org are

i2c/i2c-max6875-documentation-update.patch
i2c/i2c-max6875-simplify.patch
i2c/i2c-hwmon-class-01.patch
i2c/i2c-hwmon-class-02.patch
i2c/i2c-hwmon-class-03.patch
i2c/i2c-missing-space.patch
i2c/i2c-nforce2-cleanup.patch
i2c/i2c-hwmon-split-01.patch
i2c/i2c-hwmon-split-02.patch
i2c/i2c-hwmon-split-03.patch
i2c/i2c-hwmon-split-04.patch
i2c/i2c-hwmon-split-05.patch
i2c/i2c-hwmon-split-06.patch
i2c/i2c-hwmon-split-07.patch
i2c/i2c-hwmon-split-08.patch
i2c/i2c-hwmon-split-09.patch
i2c/i2c-max6875-cleanup.patch
i2c/i2c-max6875-documentation-cleanup.patch
i2c/i2c-max6875-kobj_to_i2c_client.patch
i2c/i2c-24rf08-corruption-prevention.patch
i2c/i2c-missing-newlines.patch
i2c/i2c-refactor-message.patch
i2c/i2c-use-time_after.patch


From khali@linux-fr.org Wed Jul 27 13:18:13 2005
Date: Wed, 27 Jul 2005 22:14:49 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: Rudolf Marek <r.marek@sh.cvut.cz>, LM Sensors
 <lm-sensors@lm-sensors.org>
Subject: I2C: refactor message in i2c_detach_client
Message-Id: <20050727221449.0488c7b6.khali@linux-fr.org>

We could refactor the error message 34 different i2c drivers print if
i2c_detach_client() fails in this function itself. Saves quite a few
lines of code. Documentation is updated to reflect that change.

Note that this patch should be applied after Rudolf Marek's w83792d
patches.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
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

--- gregkh-2.6.orig/drivers/hwmon/adm1021.c	2005-07-27 23:25:26.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/adm1021.c	2005-07-27 23:25:37.000000000 -0700
@@ -328,10 +328,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/adm1025.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/adm1025.c	2005-07-27 23:25:37.000000000 -0700
@@ -517,11 +517,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/adm9240.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/adm9240.c	2005-07-27 23:25:37.000000000 -0700
@@ -645,11 +645,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-				"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/asb100.c	2005-07-27 23:25:26.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/asb100.c	2005-07-27 23:25:37.000000000 -0700
@@ -867,11 +867,8 @@
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
--- gregkh-2.6.orig/drivers/hwmon/ds1621.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/ds1621.c	2005-07-27 23:25:37.000000000 -0700
@@ -282,11 +282,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 
--- gregkh-2.6.orig/drivers/hwmon/fscher.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/fscher.c	2005-07-27 23:25:37.000000000 -0700
@@ -383,11 +383,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/fscpos.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/fscpos.c	2005-07-27 23:25:54.000000000 -0700
@@ -549,11 +549,8 @@
 
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
--- gregkh-2.6.orig/drivers/hwmon/gl518sm.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/gl518sm.c	2005-07-27 23:25:37.000000000 -0700
@@ -492,11 +492,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/gl520sm.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/gl520sm.c	2005-07-27 23:25:37.000000000 -0700
@@ -654,11 +654,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/it87.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/it87.c	2005-07-27 23:25:37.000000000 -0700
@@ -945,11 +945,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-			"Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	if(i2c_is_isa_client(client))
 		release_region(client->addr, IT87_EXTENT);
--- gregkh-2.6.orig/drivers/hwmon/lm63.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm63.c	2005-07-27 23:25:37.000000000 -0700
@@ -520,11 +520,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/lm78.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm78.c	2005-07-27 23:25:37.000000000 -0700
@@ -686,11 +686,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		    "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	if(i2c_is_isa_client(client))
 		release_region(client->addr, LM78_EXTENT);
--- gregkh-2.6.orig/drivers/hwmon/lm80.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm80.c	2005-07-27 23:25:37.000000000 -0700
@@ -510,11 +510,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/lm83.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm83.c	2005-07-27 23:25:37.000000000 -0700
@@ -363,11 +363,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		    "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/lm87.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm87.c	2005-07-27 23:25:37.000000000 -0700
@@ -734,11 +734,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/lm90.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm90.c	2005-07-27 23:25:37.000000000 -0700
@@ -562,11 +562,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/lm92.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/lm92.c	2005-07-27 23:25:37.000000000 -0700
@@ -399,11 +399,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/max1619.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/max1619.c	2005-07-27 23:25:37.000000000 -0700
@@ -322,11 +322,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/hwmon/pc87360.c	2005-07-27 23:25:19.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/pc87360.c	2005-07-27 23:25:37.000000000 -0700
@@ -984,11 +984,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((i = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((i = i2c_detach_client(client)))
 		return i;
-	}
 
 	for (i = 0; i < 3; i++) {
 		if (data->address[i]) {
--- gregkh-2.6.orig/drivers/hwmon/sis5595.c	2005-07-27 23:25:19.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/sis5595.c	2005-07-27 23:25:37.000000000 -0700
@@ -618,11 +618,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		    "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, SIS5595_EXTENT);
 
--- gregkh-2.6.orig/drivers/hwmon/smsc47b397.c	2005-07-27 23:25:19.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/smsc47b397.c	2005-07-27 23:25:37.000000000 -0700
@@ -214,11 +214,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, SMSC_EXTENT);
 	kfree(data);
--- gregkh-2.6.orig/drivers/hwmon/smsc47m1.c	2005-07-27 23:25:19.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/smsc47m1.c	2005-07-27 23:25:37.000000000 -0700
@@ -497,11 +497,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, SMSC_EXTENT);
 	kfree(data);
--- gregkh-2.6.orig/drivers/hwmon/via686a.c	2005-07-27 23:25:19.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/via686a.c	2005-07-27 23:25:37.000000000 -0700
@@ -700,11 +700,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		"Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, VIA686A_EXTENT);
 	kfree(data);
--- gregkh-2.6.orig/drivers/hwmon/w83627ehf.c	2005-07-27 23:25:19.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/w83627ehf.c	2005-07-27 23:25:37.000000000 -0700
@@ -771,11 +771,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 	release_region(client->addr, REGION_LENGTH);
 	kfree(data);
 
--- gregkh-2.6.orig/drivers/hwmon/w83627hf.c	2005-07-27 23:25:19.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/w83627hf.c	2005-07-27 23:25:37.000000000 -0700
@@ -1157,11 +1157,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev,
-		       "Client deregistration failed, client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	release_region(client->addr, WINB_EXTENT);
 	kfree(data);
--- gregkh-2.6.orig/drivers/hwmon/w83781d.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/w83781d.c	2005-07-27 23:25:37.000000000 -0700
@@ -1299,11 +1299,8 @@
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
--- gregkh-2.6.orig/drivers/hwmon/w83792d.c	2005-07-27 23:25:32.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/w83792d.c	2005-07-27 23:25:37.000000000 -0700
@@ -1396,11 +1396,8 @@
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
--- gregkh-2.6.orig/drivers/hwmon/w83l785ts.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/hwmon/w83l785ts.c	2005-07-27 23:25:37.000000000 -0700
@@ -267,11 +267,8 @@
 
 	hwmon_device_unregister(data->class_dev);
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed, "
-			"client not detached.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(data);
 	return 0;
--- gregkh-2.6.orig/drivers/i2c/chips/ds1337.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/ds1337.c	2005-07-27 23:25:37.000000000 -0700
@@ -353,11 +353,8 @@
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
--- gregkh-2.6.orig/drivers/i2c/chips/eeprom.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/eeprom.c	2005-07-27 23:25:37.000000000 -0700
@@ -230,10 +230,8 @@
 	int err;
 
 	err = i2c_detach_client(client);
-	if (err) {
-		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");
+	if (err)
 		return err;
-	}
 
 	kfree(i2c_get_clientdata(client));
 
--- gregkh-2.6.orig/drivers/i2c/chips/max6875.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/max6875.c	2005-07-27 23:25:37.000000000 -0700
@@ -239,10 +239,8 @@
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
--- gregkh-2.6.orig/drivers/i2c/chips/pca9539.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/pca9539.c	2005-07-27 23:25:37.000000000 -0700
@@ -163,10 +163,8 @@
 {
 	int err;
 
-	if ((err = i2c_detach_client(client))) {
-		dev_err(&client->dev, "Client deregistration failed.\n");
+	if ((err = i2c_detach_client(client)))
 		return err;
-	}
 
 	kfree(i2c_get_clientdata(client));
 	return 0;
--- gregkh-2.6.orig/drivers/i2c/chips/pcf8574.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/pcf8574.c	2005-07-27 23:25:37.000000000 -0700
@@ -185,11 +185,8 @@
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
--- gregkh-2.6.orig/drivers/i2c/chips/pcf8591.c	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/drivers/i2c/chips/pcf8591.c	2005-07-27 23:25:37.000000000 -0700
@@ -240,11 +240,8 @@
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
--- gregkh-2.6.orig/drivers/i2c/i2c-core.c	2005-07-27 23:25:16.000000000 -0700
+++ gregkh-2.6/drivers/i2c/i2c-core.c	2005-07-27 23:25:37.000000000 -0700
@@ -449,8 +449,12 @@
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
--- gregkh-2.6.orig/Documentation/i2c/porting-clients	2005-07-27 23:25:21.000000000 -0700
+++ gregkh-2.6/Documentation/i2c/porting-clients	2005-07-27 23:25:37.000000000 -0700
@@ -94,7 +94,8 @@
   limited to the strictly necessary steps.
 
 * [Detach] Get rid of data, remove the call to
-  i2c_deregister_entry.
+  i2c_deregister_entry. Do not log an error message if
+  i2c_detach_client fails, as i2c-core will now do it for you.
 
 * [Update] Don't access client->data directly, use
   i2c_get_clientdata(client) instead.
--- gregkh-2.6.orig/Documentation/i2c/writing-clients	2005-07-27 23:25:26.000000000 -0700
+++ gregkh-2.6/Documentation/i2c/writing-clients	2005-07-27 23:25:37.000000000 -0700
@@ -489,10 +489,8 @@
     /* SENSORS ONLY END */
 
     /* Try to detach the client from i2c space */
-    if ((err = i2c_detach_client(client))) {
-      printk("foo.o: Client deregistration failed, client not detached.\n");
+    if ((err = i2c_detach_client(client)))
       return err;
-    }
 
     /* HYBRID SENSORS CHIP ONLY START */
     if i2c_is_isa_client(client)
