From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: [PATCH] 2.5 support for i2c-i801.c and i2c-piix4.c
Message-Id: <20030311234449.GA19259@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

Here's a patch against the latest cvs tree that adds proper pci id
support and probing for the i2c-i801.c and i2c-piix4.c drivers.  I've
tested it here on different machines, and it seems to work well.  I also
cleaned up a few preinitiaized variables and made some functions static
that needed to be.

Feel free to commit this if you want.

On a related note, does anyone mind if I submit these drivers (along
with the needed build files) for incluson in the 2.5 kernel tree?  Same
thing goes for my driver model patches I sent out the other day.

As it seems that the listed kernel maintainers for i2c aren't doing
anything anymore, the responsible person for getting kernel changes into
the mainline seems a bit hard to find right now :)

thanks,

greg k-h



Index: kernel/busses/i2c-i801.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-i801.c,v
retrieving revision 1.30
diff -a -u -r1.30 i2c-i801.c
--- kernel/busses/i2c-i801.c	23 Jan 2003 23:24:05 -0000	1.30
+++ kernel/busses/i2c-i801.c	12 Mar 2003 00:51:51 -0000
@@ -132,46 +132,25 @@
 
 
 
-static unsigned short i801_smba = 0;
-static struct pci_dev *I801_dev = NULL;
-static int isich4 = 0;
+static unsigned short i801_smba;
+static struct pci_dev *I801_dev;
+static int isich4;
 
 /* Detect whether a I801 can be found, and initialize it, where necessary.
    Note the differences between kernels with the old PCI BIOS interface and
    newer kernels with the real PCI interface. In compat.h some things are
    defined to make the transition easier. */
-int i801_setup(void)
+static int i801_setup(struct pci_dev *dev)
 {
 	int error_return = 0;
 	int *num = supported;
 	unsigned char temp;
 
-	/* First check whether we can access PCI at all */
-	if (pci_present() = 0) {
-		printk(KERN_WARNING "i2c-i801.o: Error: No PCI-bus found!\n");
-		error_return = -ENODEV;
-		goto END;
-	}
-
-	/* Look for each chip */
 	/* Note: we keep on searching until we have found 'function 3' */
-	I801_dev = NULL;
-	do {
-		if((I801_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
-					      *num, I801_dev))) {
-			if(PCI_FUNC(I801_dev->devfn) != 3)
-				continue;
-			break;
-		}
-		num++;
-	} while (*num != 0);
+	if(PCI_FUNC(dev->devfn) != 3)
+		return -ENODEV;
 
-	if (I801_dev = NULL) {
-		printk
-		    (KERN_WARNING "i2c-i801.o: Error: Can't detect I801, function 3!\n");
-		error_return = -ENODEV;
-		goto END;
-	}
+	I801_dev = dev;
 	isich4 = *num = PCI_DEVICE_ID_INTEL_82801DB_SMBUS;
 
 /* Determine the address of the SMBus areas */
@@ -659,13 +638,43 @@
 
 
 static struct pci_device_id i801_ids[] __devinitdata = {
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801AA_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801AB_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801BA_2,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801CA_SMBUS,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82801DB_SMBUS,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
 	{ 0, }
 };
 
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 
-	if (i801_setup()) {
+	if (i801_setup(dev)) {
 		printk
 		    (KERN_WARNING "i2c-i801.o: I801 not detected, module not inserted.\n");
 		return -ENODEV;

Index: kernel/busses/i2c-piix4.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/busses/i2c-piix4.c,v
retrieving revision 1.53
diff -a -u -r1.53 i2c-piix4.c
--- kernel/busses/i2c-piix4.c	23 Jan 2003 23:24:05 -0000	1.53
+++ kernel/busses/i2c-piix4.c	12 Mar 2003 00:51:51 -0000
@@ -51,18 +49,6 @@
 	const char *name;
 };
 
-/* Note: We assume all devices are identical
-         to the Intel PIIX4; we only mention it during detection.   */
-
-static struct sd supported[] = {
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, 3, "PIIX4"},
-	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4, 0, "OSB4"},
-	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5, 0, "CSB5"},
-	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3, 3, "440MX"},
-	{PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3, 0, "Victory66"},
-	{0, 0, 0, NULL}
-};
-
 /* PIIX4 SMBus address offsets */
 #define SMBHSTSTS (0 + piix4_smba)
 #define SMBHSLVSTS (1 + piix4_smba)
@@ -148,37 +134,16 @@
    Note the differences between kernels with the old PCI BIOS interface and
    newer kernels with the real PCI interface. In compat.h some things are
    defined to make the transition easier. */
-int piix4_setup(void)
+static int piix4_setup(struct pci_dev *PIIX4_dev, const struct pci_device_id *id)
 {
 	int error_return = 0;
 	unsigned char temp;
-	struct sd *num = supported;
-	struct pci_dev *PIIX4_dev = NULL;
 
-	if (pci_present() = 0) {
-		error_return = -ENODEV;
-		goto END;
-	}
+	/* match up the function */
+	if (PCI_FUNC(PIIX4_dev->devfn) != id->driver_data)
+		return -ENODEV;
 
-	/* Look for a supported device/function */
-	do {
-		if((PIIX4_dev = pci_find_device(num->mfr, num->dev,
-					        PIIX4_dev))) {
-			if(PCI_FUNC(PIIX4_dev->devfn) != num->fn)
-				continue;
-			break;
-		}
-		PIIX4_dev = NULL;
-		num++;
-	} while (num->mfr);
-
-	if (PIIX4_dev = NULL) {
-		printk
-		  (KERN_ERR "i2c-piix4.o: Error: Can't detect PIIX4 or compatible device!\n");
-		 error_return = -ENODEV;
-		 goto END;
-	}
-	printk(KERN_INFO "i2c-piix4.o: Found %s device\n", num->name);
+	printk(KERN_INFO "i2c-piix4.o: Found %s device\n", PIIX4_dev->dev.name);
 
 #ifdef CONFIG_X86
 	if(ibm_dmi_probe()) {
@@ -269,14 +234,14 @@
 
 
 /* Internally used pause function */
-void piix4_do_pause(unsigned int amount)
+static void piix4_do_pause(unsigned int amount)
 {
 	current->state = TASK_INTERRUPTIBLE;
 	schedule_timeout(amount);
 }
 
 /* Another internally used function */
-int piix4_transaction(void)
+static int piix4_transaction(void)
 {
 	int temp;
 	int result = 0;
@@ -365,7 +330,7 @@
 }
 
 /* Return -1 on error. */
-s32 piix4_access(struct i2c_adapter * adap, u16 addr,
+static s32 piix4_access(struct i2c_adapter * adap, u16 addr,
 		 unsigned short flags, char read_write,
 		 u8 command, int size, union i2c_smbus_data * data)
 {
@@ -458,7 +423,7 @@
 }
 
 
-u32 piix4_func(struct i2c_adapter *adapter)
+static u32 piix4_func(struct i2c_adapter *adapter)
 {
 	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
 	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
@@ -482,16 +447,58 @@
 
 
 static struct pci_device_id piix4_ids[] __devinitdata = {
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82371AB_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	3
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
+		.device =	PCI_DEVICE_ID_SERVERWORKS_OSB4,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_SERVERWORKS,
+		.device =	PCI_DEVICE_ID_SERVERWORKS_CSB5,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_INTEL,
+		.device =	PCI_DEVICE_ID_INTEL_82443MX_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	3,
+	},
+	{
+		.vendor =	PCI_VENDOR_ID_EFAR,
+		.device =	PCI_DEVICE_ID_EFAR_SLC90E66_3,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+		.driver_data =	0,
+	},
 	{ 0, }
 };
 
 static int __devinit piix4_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
+	int retval;
+	
+	retval = piix4_setup(dev, id);
+	if (retval)
+		return retval;
 
 	sprintf(piix4_adapter.name, "SMBus PIIX4 adapter at %04x",
 		piix4_smba);
 
-	i2c_add_adapter(&piix4_adapter);
+	retval = i2c_add_adapter(&piix4_adapter);
+
+	return retval;
 }
 
 static void __devexit piix4_remove(struct pci_dev *dev)
