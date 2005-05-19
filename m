From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH 2.6] was Re: RFC: 2.6 cleanups for i2c-piix4.c
Message-Id: <20040121044558.GI10681@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-12-26 19:58:34 -0500]:
> The following is very lightly tested here.  It applies
> on top of Greg's -test11 stack.  Comments?

I redid this patch to apply cleanly to your latest.  Please apply.

* * * * *

This patch fixes a "Trying to release non-existent resource" error that
occurs during rmmod when the device isn't actually present.  It includes
some other cleanups too: error paths, whitespace, magic numbers, __devinit.
This patch applies to and was tested against 2.6.1-bk6.

--- linux-2.6.1-bk6-orig/drivers/i2c/busses/i2c-piix4.c	2004-01-20 09:51:02.000000000 -0500
+++ linux-2.6.1-bk6-mmh/drivers/i2c/busses/i2c-piix4.c	2004-01-20 23:11:56.000000000 -0500
@@ -68,6 +68,9 @@
 #define SMBSLVEVT	(0xA + piix4_smba)
 #define SMBSLVDAT	(0xC + piix4_smba)
 
+/* count for request_region */
+#define SMBIOSIZE	8
+
 /* PCI Address Constants */
 #define SMBBA		0x090
 #define SMBHSTCFG	0x0D2
@@ -112,14 +115,13 @@
 
 static int piix4_transaction(void);
 
-
 static unsigned short piix4_smba = 0;
 static struct i2c_adapter piix4_adapter;
 
 /*
  * Get DMI information.
  */
-static int ibm_dmi_probe(void)
+static int __devinit ibm_dmi_probe(void)
 {
 #ifdef CONFIG_X86
 	extern int is_unsafe_smbus;
@@ -129,9 +131,9 @@
 #endif
 }
 
-static int piix4_setup(struct pci_dev *PIIX4_dev, const struct pci_device_id *id)
+static int __devinit piix4_setup(struct pci_dev *PIIX4_dev,
+				const struct pci_device_id *id)
 {
-	int error_return = 0;
 	unsigned char temp;
 
 	/* match up the function */
@@ -144,8 +146,7 @@
 		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
 			"may corrupt your serial eeprom! Refusing to load "
 			"module!\n");
-		error_return = -EPERM;
-		goto END;
+		return -EPERM;
 	}
 
 	/* Determine the address of the SMBus areas */
@@ -163,11 +164,10 @@
 		}
 	}
 
-	if (!request_region(piix4_smba, 8, "piix4-smbus")) {
+	if (!request_region(piix4_smba, SMBIOSIZE, "piix4-smbus")) {
 		dev_err(&PIIX4_dev->dev, "SMB region 0x%x already in use!\n",
 			piix4_smba);
-		error_return = -ENODEV;
-		goto END;
+		return -ENODEV;
 	}
 
 	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
@@ -214,8 +214,9 @@
 		} else {
 			dev_err(&PIIX4_dev->dev,
 				"Host SMBus controller not enabled!\n");
-			error_return = -ENODEV;
-			goto END;
+			release_region(piix4_smba, SMBIOSIZE);
+			piix4_smba = 0;
+			return -ENODEV;
 		}
 	}
 
@@ -231,8 +232,7 @@
 	dev_dbg(&PIIX4_dev->dev, "SMBREV = 0x%X\n", temp);
 	dev_dbg(&PIIX4_dev->dev, "SMBA = 0x%X\n", piix4_smba);
 
-END:
-	return error_return;
+	return 0;
 }
 
 /* Another internally used function */
@@ -465,7 +465,8 @@
 	{ 0, }
 };
 
-static int __devinit piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit piix4_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
 {
 	int retval;
 
@@ -479,17 +480,24 @@
 	snprintf(piix4_adapter.name, I2C_NAME_SIZE,
 		"SMBus PIIX4 adapter at %04x", piix4_smba);
 
-	retval = i2c_add_adapter(&piix4_adapter);
+	if ((retval = i2c_add_adapter(&piix4_adapter))) {
+		dev_err(&dev->dev, "Couldn't register adapter!\n");
+		release_region(piix4_smba, SMBIOSIZE);
+		piix4_smba = 0;
+	}
 
 	return retval;
 }
 
 static void __devexit piix4_remove(struct pci_dev *dev)
 {
-	i2c_del_adapter(&piix4_adapter);
+	if (piix4_smba) {
+		i2c_del_adapter(&piix4_adapter);
+		release_region(piix4_smba, SMBIOSIZE);
+		piix4_smba = 0;
+	}
 }
 
-
 static struct pci_driver piix4_driver = {
 	.name		= "piix4-smbus",
 	.id_table	= piix4_ids,
@@ -502,15 +510,13 @@
 	return pci_module_init(&piix4_driver);
 }
 
-
 static void __exit i2c_piix4_exit(void)
 {
 	pci_unregister_driver(&piix4_driver);
-	release_region(piix4_smba, 8);
 }
 
-MODULE_AUTHOR
-    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and "
+		"Philip Edelbrock <phil@netroedge.com>");
 MODULE_DESCRIPTION("PIIX4 SMBus driver");
 MODULE_LICENSE("GPL");
 
