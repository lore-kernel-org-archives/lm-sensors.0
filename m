From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:28 +0000
Subject: [lm-sensors] [PATCH] I2C: Separate non-i2c hwmon drivers from
Message-Id: <11259567662119@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567663617@kroah.com>
In-Reply-To: <11259567663617@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Separate non-i2c hwmon drivers from i2c-core (8/9)

Kill all uses of i2c_is_isa_adapter except for the hybrid drivers (it87,
lm78, w83781d). The i2c-isa adapter not being registered with the i2c
core anymore, drivers don't have to fear being erroneously attached to
it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 02ff982c6911de1484e13a1d765d7bd31a0f8fee
tree 94e8c388df0de6561da7f10840f4e87dead18724
parent 5071860aba7fc69279ab822638ed2c2e4549f9fd
author Jean Delvare <khali@linux-fr.org> Wed, 20 Jul 2005 00:05:33 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:12 -0700

 Documentation/i2c/writing-clients |   11 +++++------
 drivers/hwmon/adm1021.c           |    9 ---------
 drivers/hwmon/asb100.c            |    8 --------
 drivers/hwmon/lm75.c              |   10 ----------
 drivers/hwmon/lm85.c              |    5 -----
 5 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -315,11 +315,10 @@ For now, you can ignore the `flags' para
     const char *type_name = "";
     int is_isa = i2c_is_isa_adapter(adapter);
 
-    if (is_isa) {
+    /* Do this only if the chip can additionally be found on the ISA bus
+       (hybrid chip). */
 
-      /* If this client can't be on the ISA bus at all, we can stop now
-         (call `goto ERROR0'). But for kicks, we will assume it is all
-         right. */
+    if (is_isa) {
 
       /* Discard immediately if this ISA range is already used */
       if (check_region(address,FOO_EXTENT))
@@ -495,10 +494,10 @@ much simpler than the attachment code, f
       return err;
     }
 
-    /* SENSORS ONLY START */
+    /* HYBRID SENSORS CHIP ONLY START */
     if i2c_is_isa_client(client)
       release_region(client->addr,LM78_EXTENT);
-    /* SENSORS ONLY END */
+    /* HYBRID SENSORS CHIP ONLY END */
 
     kfree(client); /* Frees client data too, if allocated at the same time */
     return 0;
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -198,15 +198,6 @@ static int adm1021_detect(struct i2c_ada
 	int err = 0;
 	const char *type_name = "";
 
-	/* Make sure we aren't probing the ISA bus!! This is just a safety check
-	   at this moment; i2c_detect really won't call us. */
-#ifdef DEBUG
-	if (i2c_is_isa_adapter(adapter)) {
-		dev_dbg(&adapter->dev, "adm1021_detect called for an ISA bus adapter?!?\n");
-		return 0;
-	}
-#endif
-
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		goto error0;
 
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -714,14 +714,6 @@ static int asb100_detect(struct i2c_adap
 	struct i2c_client *new_client;
 	struct asb100_data *data;
 
-	/* asb100 is SMBus only */
-	if (i2c_is_isa_adapter(adapter)) {
-		pr_debug("asb100.o: detect failed, "
-				"cannot attach to legacy adapter!\n");
-		err = -ENODEV;
-		goto ERROR0;
-	}
-
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA)) {
 		pr_debug("asb100.o: detect failed, "
 				"smbus byte data not supported!\n");
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -121,16 +121,6 @@ static int lm75_detect(struct i2c_adapte
 	int err = 0;
 	const char *name = "";
 
-	/* Make sure we aren't probing the ISA bus!! This is just a safety check
-	   at this moment; i2c_detect really won't call us. */
-#ifdef DEBUG
-	if (i2c_is_isa_adapter(adapter)) {
-		dev_dbg(&adapter->dev,
-			"lm75_detect called for an ISA bus adapter?!?\n");
-		goto exit;
-	}
-#endif
-
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
 				     I2C_FUNC_SMBUS_WORD_DATA))
 		goto exit;
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -1033,11 +1033,6 @@ int lm85_detect(struct i2c_adapter *adap
 	int err = 0;
 	const char *type_name = "";
 
-	if (i2c_is_isa_adapter(adapter)) {
-		/* This chip has no ISA interface */
-		goto ERROR0 ;
-	};
-
 	if (!i2c_check_functionality(adapter,
 					I2C_FUNC_SMBUS_BYTE_DATA)) {
 		/* We need to be able to do byte I/O */

