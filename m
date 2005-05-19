From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:54 +0000
Subject: [PATCH] i2c driver changes for 2.5.68
Message-Id: <10512287461640@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10512287461373@kroah.com>
References: <10512287461373@kroah.com>
In-Reply-To: <10512287461373@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1179.3.6, 2003/04/24 10:26:56-07:00, greg@kroah.com

[PATCH] i2c: fix up it87.c check_region mess.


 drivers/i2c/chips/it87.c |   38 ++++++++++++++++----------------------
 1 files changed, 16 insertions(+), 22 deletions(-)


diff -Nru a/drivers/i2c/chips/it87.c b/drivers/i2c/chips/it87.c
--- a/drivers/i2c/chips/it87.c	Thu Apr 24 16:46:54 2003
+++ b/drivers/i2c/chips/it87.c	Thu Apr 24 16:46:54 2003
@@ -224,7 +224,6 @@
    allocated. */
 struct it87_data {
 	struct semaphore lock;
-	int sysctl_id;
 	enum chips type;
 
 	struct semaphore update_lock;
@@ -533,22 +532,21 @@
 int it87_detect(struct i2c_adapter *adapter, int address, int kind)
 {
 	int i;
-	struct i2c_client *new_client;
+	struct i2c_client *new_client = NULL;
 	struct it87_data *data;
 	int err = 0;
 	const char *name = "";
 	const char *client_name = "";
 	int is_isa = i2c_is_isa_adapter(adapter);
 
-	if (!is_isa
-	    && !i2c_check_functionality(adapter,
-					I2C_FUNC_SMBUS_BYTE_DATA)) goto
-		    ERROR0;
+	if (!is_isa && 
+	    !i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto ERROR0;
 
-	if (is_isa) {
-		if (check_region(address, IT87_EXTENT))
+	/* Reserve the ISA region */
+	if (is_isa)
+		if (!request_region(address, IT87_EXTENT, name))
 			goto ERROR0;
-	}
 
 	/* Probe whether there is anything available on this address. Already
 	   done for SMBus clients */
@@ -560,11 +558,11 @@
 			   if we read 'undefined' registers. */
 			i = inb_p(address + 1);
 			if (inb_p(address + 2) != i)
-				goto ERROR0;
+				goto ERROR1;
 			if (inb_p(address + 3) != i)
-				goto ERROR0;
+				goto ERROR1;
 			if (inb_p(address + 7) != i)
-				goto ERROR0;
+				goto ERROR1;
 #undef REALLY_SLOW_IO
 
 			/* Let's just hope nothing breaks here */
@@ -585,7 +583,7 @@
 					sizeof(struct it87_data),
 					GFP_KERNEL))) {
 		err = -ENOMEM;
-		goto ERROR0;
+		goto ERROR1;
 	}
 
 	data = (struct it87_data *) (new_client + 1);
@@ -635,10 +633,6 @@
 		goto ERROR1;
 	}
 
-	/* Reserve the ISA region */
-	if (is_isa)
-		request_region(address, IT87_EXTENT, name);
-
 	/* Fill in the remaining client fields and put it into the global list */
 	strncpy(new_client->dev.name, name, DEVICE_NAME_SIZE);
 
@@ -650,7 +644,7 @@
 
 	/* Tell the I2C layer a new client has arrived */
 	if ((err = i2c_attach_client(new_client)))
-		goto ERROR2;
+		goto ERROR1;
 
 	/* register sysfs hooks */
 	device_create_file(&new_client->dev, &dev_attr_in_input0);
@@ -689,12 +683,12 @@
 	it87_init_client(new_client);
 	return 0;
 
-      ERROR2:
+ERROR1:
+	kfree(new_client);
+
 	if (is_isa)
 		release_region(address, IT87_EXTENT);
-      ERROR1:
-	kfree(new_client);
-      ERROR0:
+ERROR0:
 	return err;
 }
 

