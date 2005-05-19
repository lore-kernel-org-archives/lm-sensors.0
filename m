From: hcs@ics2.ics.tvnet.hu (=?iso-8859-1?Q?Csaba_Hal=E1sz?=)
Date: Thu, 19 May 2005 06:23:32 +0000
Subject: [PATCH] Add nForce support to amd756 driver
Message-Id: <000201c1ef76$95836440$0700a8c0@JESTER>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I have modified the amd756 driver to support the nVidia nForce SMBus
controller.

There is of course no technical documentation (this is an nVidia product
after all :-), so this is just guesswork.

The base address is hardwired at 0x5500, because the original code does not
work, and reverse engineering the windows software shows that they have
hardcoded it as well.

It might be a good idea to change the amdsetup member in the sd struct to be
a pointer to a device specific setup function, so that it will be easier to
add new devices later on.

I have just made up a device id, I don't know the proper way to do it.

I hope that the code still works with the true amd chips.
I have only tested it on a single computer, so I have no idea whether it
will function properly for others.

Greets,
	Csaba Halasz
	hcs@ics2.ics.tvnet.hu
	jester01@freemail.hu (use if above does not work)

diff -u -r -N lm_sensors2.orig/kernel/busses/i2c-amd756.c
lm_sensors2/kernel/busses/i2c-amd756.c
--- lm_sensors2.orig/kernel/busses/i2c-amd756.c	Sat Dec 29 01:20:47 2001
+++ lm_sensors2/kernel/busses/i2c-amd756.c	Thu Apr 25 03:23:11 2002
@@ -25,7 +25,11 @@
 */

 /*
-   Supports AMD756, AMD766, and AMD768.
+    2002-04-08: Added nForce support. (Csaba Halasz)
+*/
+
+/*
+   Supports AMD756, AMD766, AMD768 and nVidia nForce
    Note: we assume there can only be one device, with one SMBus interface.
 */

@@ -51,11 +55,31 @@
 #ifndef PCI_DEVICE_ID_AMD_766
 #define PCI_DEVICE_ID_AMD_766 0x7413
 #endif
+#ifndef PCI_DEVICE_ID_AMD_768
+#define PCI_DEVICE_ID_AMD_768 0x7443
+#endif
+#ifndef PCI_VENDOR_ID_NVIDIA
+#define PCI_VENDOR_ID_NVIDIA 0x10DE
+#endif
+#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS 0x01B4
+#endif
+
+struct sd {
+    const unsigned short vendor;
+    const unsigned short device;
+    const unsigned short function;
+    const char* name;
+    int amdsetup:1;
+};

-static int supported[] = {PCI_DEVICE_ID_AMD_756,
-                          PCI_DEVICE_ID_AMD_766,
-			  0x7443, /* AMD768 */
-                          0 };
+static struct sd supported[] = {
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_756, 3, "AMD756", 1},
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_766, 3, "AMD766", 1},
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_768, 3, "AMD768", 1},
+    {PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS, 1, "nVidia
nForce", 0},
+    {0, 0, 0}
+};

 /* AMD756 SMBus address offsets */
 #define SMB_ADDR_OFFSET        0xE0
@@ -149,7 +173,7 @@
 int amd756_setup(void)
 {
 	unsigned char temp;
-	int *num = supported;
+	struct sd *currdev;
 	struct pci_dev *AMD756_dev = NULL;

 	if (pci_present() = 0) {
@@ -157,38 +181,41 @@
 		return(-ENODEV);
 	}

-	/* Look for the AMD756, function 3 */
-	/* Note: we keep on searching until we have found 'function 3' */
-	do {
-		if((AMD756_dev = pci_find_device(PCI_VENDOR_ID_AMD,
-					      *num, AMD756_dev))) {
-			if(PCI_FUNC(AMD756_dev->devfn) != 3)
-				continue;
-			break;
+	/* Look for a supported chip */
+	for(currdev = supported; currdev->vendor; ) {
+		AMD756_dev = pci_find_device(currdev->vendor,
+						currdev->device, AMD756_dev);
+		if (AMD756_dev != NULL)	{
+			if (PCI_FUNC(AMD756_dev->devfn) = currdev->function)
+				break;
+		} else {
+		    currdev++;
 		}
-		num++;
-	} while (*num != 0);
+	}

 	if (AMD756_dev = NULL) {
 		printk
-		    ("i2c-amd756.o: Error: Can't detect AMD756, function 3!\n");
+		    ("i2c-amd756.o: Error: No AMD756 or compatible device detected!\n");
 		return(-ENODEV);
 	}
-
-
-	pci_read_config_byte(AMD756_dev, SMBGCFG, &temp);
-	if ((temp & 128) = 0) {
-		printk
-		  ("i2c-amd756.o: Error: SMBus controller I/O not enabled!\n");
+	printk(KERN_INFO "i2c-amd756.o: Found %s SMBus controller.\n",
currdev->name);
+
+	if (currdev->amdsetup)
+	{
+		pci_read_config_byte(AMD756_dev, SMBGCFG, &temp);
+		if ((temp & 128) = 0) {
+			printk("i2c-amd756.o: Error: SMBus controller I/O not enabled!\n");
+		}
 		return(-ENODEV);
-	}
-
-	/* Determine the address of the SMBus areas */
-	/* Technically it is a dword but... */
-	pci_read_config_word(AMD756_dev, SMBBA, &amd756_smba);
-	amd756_smba &= 0xff00;
-	amd756_smba += SMB_ADDR_OFFSET;

+		/* Determine the address of the SMBus areas */
+		/* Technically it is a dword but... */
+		pci_read_config_word(AMD756_dev, SMBBA, &amd756_smba);
+		amd756_smba &= 0xff00;
+		amd756_smba += SMB_ADDR_OFFSET;
+	} else {
+		amd756_smba = 0x5500;
+	}
 	if (check_region(amd756_smba, SMB_IOSIZE)) {
 		printk
 		    ("i2c-amd756.o: SMB region 0x%x already in use!\n",
diff -u -r -N lm_sensors2.orig/prog/detect/sensors-detect
lm_sensors2/prog/detect/sensors-detect
--- lm_sensors2.orig/prog/detect/sensors-detect	Tue Apr  2 04:08:56 2002
+++ lm_sensors2/prog/detect/sensors-detect	Thu Apr 25 03:23:11 2002
@@ -514,7 +514,8 @@
        devid  => 0x01b4,
        func => 1,
        procid => "nVidia nForce SMBus",
-       match => sub { $_[0] =~ /dontmatchthis/ },
+       driver => "i2c-amd756",
+       match => sub { $_[0] =~ /^SMBus AMD7X6 adapter at [0-9,a-f]{4}/ },
      } ,
      {
        vendid => 0x1166,
