From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <10476033262095@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10476033263399@kroah.com>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1114, 2003/03/13 16:39:40-08:00, greg@kroah.com

i2c: add driver model support to i2c adapter drivers


 drivers/i2c/busses/i2c-ali15x3.c |    6 ++++--
 drivers/i2c/busses/i2c-amd756.c  |    3 +++
 drivers/i2c/busses/i2c-amd8111.c |    5 ++++-
 drivers/i2c/busses/i2c-i801.c    |    5 ++++-
 drivers/i2c/busses/i2c-piix4.c   |    3 +++
 drivers/i2c/i2c-core.c           |   13 +++++++++++++
 include/linux/i2c.h              |    2 ++
 7 files changed, 33 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 13 16:56:52 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 13 16:56:52 2003
@@ -531,10 +531,12 @@
 		return -ENODEV;
 	}
 
+	/* set up the driverfs linkage to our parent device */
+	ali15x3_adapter.dev.parent = &dev->dev;
+
 	sprintf(ali15x3_adapter.name, "SMBus ALI15X3 adapter at %04x",
 		ali15x3_smba);
-	i2c_add_adapter(&ali15x3_adapter);
-	return 0;
+	return i2c_add_adapter(&ali15x3_adapter);
 }
 
 static void __devexit ali15x3_remove(struct pci_dev *dev)
diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Thu Mar 13 16:56:52 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Thu Mar 13 16:56:52 2003
@@ -375,6 +375,9 @@
 	printk(KERN_DEBUG DRV_NAME ": AMD756_smba = 0x%X\n", amd756_ioport);
 #endif
 
+	/* set up the driverfs linkage to our parent device */
+	amd756_adapter.dev.parent = &pdev->dev;
+
 	sprintf(amd756_adapter.name,
 		"SMBus AMD75x adapter at %04x", amd756_ioport);
 
diff -Nru a/drivers/i2c/busses/i2c-amd8111.c b/drivers/i2c/busses/i2c-amd8111.c
--- a/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 13 16:56:52 2003
+++ b/drivers/i2c/busses/i2c-amd8111.c	Thu Mar 13 16:56:52 2003
@@ -363,6 +363,9 @@
 	smbus->adapter.algo = &smbus_algorithm;
 	smbus->adapter.algo_data = smbus;
 
+	/* set up the driverfs linkage to our parent device */
+	smbus->adapter.dev.parent = &dev->dev;
+
 	error = i2c_add_adapter(&smbus->adapter);
 	if (error)
 		goto out_release_region;
@@ -389,7 +392,7 @@
 }
 
 static struct pci_driver amd8111_driver = {
-	.name		= "amd8111 smbus 2.0",
+	.name		= "amd8111 smbus",
 	.id_table	= amd8111_ids,
 	.probe		= amd8111_probe,
 	.remove		= __devexit_p(amd8111_remove),
diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Thu Mar 13 16:56:52 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Thu Mar 13 16:56:52 2003
@@ -672,9 +672,12 @@
 		return -ENODEV;
 	}
 
+	/* set up the driverfs linkage to our parent device */
+	i801_adapter.dev.parent = &dev->dev;
+
 	sprintf(i801_adapter.name, "SMBus I801 adapter at %04x",
 		i801_smba);
-	i2c_add_adapter(&i801_adapter);
+	return i2c_add_adapter(&i801_adapter);
 }
 
 static void __devexit i801_remove(struct pci_dev *dev)
diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Thu Mar 13 16:56:52 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Thu Mar 13 16:56:52 2003
@@ -473,6 +473,9 @@
 	if (retval)
 		return retval;
 
+	/* set up the driverfs linkage to our parent device */
+	piix4_adapter.dev.parent = &dev->dev;
+
 	sprintf(piix4_adapter.name, "SMBus PIIX4 adapter at %04x",
 		piix4_smba);
 
diff -Nru a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
--- a/drivers/i2c/i2c-core.c	Thu Mar 13 16:56:52 2003
+++ b/drivers/i2c/i2c-core.c	Thu Mar 13 16:56:52 2003
@@ -87,6 +87,16 @@
 	init_MUTEX(&adap->bus);
 	init_MUTEX(&adap->list);
 
+	/* Add the adapter to the driver core.
+	 * If the parent pointer is not set up,
+	 * we add this adapter to the legacy bus.
+	 */
+	if (adap->dev.parent = NULL)
+		adap->dev.parent = &legacy_bus;
+	sprintf(adap->dev.bus_id, "i2c-%d", i);
+	strcpy(adap->dev.name, "i2c controller");
+	device_register(&adap->dev);
+
 	/* inform drivers of new adapters */
 	for (j=0;j<I2C_DRIVER_MAX;j++)
 		if (drivers[j]!=NULL && 
@@ -153,6 +163,9 @@
 	}
 
 	i2cproc_remove(i);
+
+	/* clean up the sysfs representation */
+	device_unregister(&adap->dev);
 
 	adapters[i] = NULL;
 
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Thu Mar 13 16:56:52 2003
+++ b/include/linux/i2c.h	Thu Mar 13 16:56:52 2003
@@ -231,12 +231,14 @@
 
 	int timeout;
 	int retries;
+	struct device dev;	/* the adapter device */
 
 #ifdef CONFIG_PROC_FS 
 	/* No need to set this when you initialize the adapter          */
 	int inode;
 #endif /* def CONFIG_PROC_FS */
 };
+#define to_i2c_adapter(d) container_of(d, struct i2c_adapter, dev)
 
 /*flags for the driver struct: */
 #define I2C_DF_NOTIFY	0x01		/* notify on bus (de/a)ttaches 	*/
