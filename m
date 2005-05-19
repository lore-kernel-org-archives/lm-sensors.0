From: Jester01@freemail.hu (Halasz Csaba)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: [PATCH] nforce update
Message-Id: <9B4E9DA25A3DD41189B000508B5C0CEE0245D6@BOMBA>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

I have updated i2c-amd756.c to support multiple adapters.
It was necessary because the nforce has two busses.
I hope I haven't broken anything in the process.
Could somebody with an amd try it? Thanks.

There was no locking in the driver, so I assume that
calls are serialized on a higher level. Therefore
I didn't add any myself.

The base addresses for the nforce are hardcoded, I wonder
if we should extract them from the pci resources (those
are supposed to be set up by the BIOS, right?) Also, a
force parameter could be introduced should the need arise.

Comments welcome.

Greets,
	Csaba

--- i2c-amd756.c.orig	Mon Jul  8 21:38:16 2002
+++ i2c-amd756.c	Tue Jul  9 22:09:02 2002
@@ -26,11 +26,11 @@
 
 /*
     2002-04-08: Added nForce support. (Csaba Halasz)
+    2002-07-09: Added multiple adapter support (Csaba Halasz)
 */
 
 /*
    Supports AMD756, AMD766, AMD768 and nVidia nForce
-   Note: we assume there can only be one device, with one SMBus interface.
 */
 
 #include <linux/version.h>
@@ -55,35 +55,23 @@
 #define PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS 0x01B4
 #endif
 
-struct sd {
-    const unsigned short vendor;
-    const unsigned short device;
-    const unsigned short function;
-    const char* name;
-    int amdsetup:1;
-};
+/* this could be set to I2C_ADAP_MAX if necessary */
+#define AMD756_ADAP_MAX 2	
 
-static struct sd supported[] = {
-    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_756, 3, "AMD756", 1},
-    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_766, 3, "AMD766", 1},
-    {PCI_VENDOR_ID_AMD, 0x7443, 3, "AMD768", 1},
-    {PCI_VENDOR_ID_NVIDIA, 0x01B4, 1, "nVidia nForce", 0},
-    {0, 0, 0}
-};
 
 /* AMD756 SMBus address offsets */
 #define SMB_ADDR_OFFSET        0xE0
 #define SMB_IOSIZE             16
-#define SMB_GLOBAL_STATUS      (0x0 + amd756_smba)
-#define SMB_GLOBAL_ENABLE      (0x2 + amd756_smba)
-#define SMB_HOST_ADDRESS       (0x4 + amd756_smba)
-#define SMB_HOST_DATA          (0x6 + amd756_smba)
-#define SMB_HOST_COMMAND       (0x8 + amd756_smba)
-#define SMB_HOST_BLOCK_DATA    (0x9 + amd756_smba)
-#define SMB_HAS_DATA           (0xA + amd756_smba)
-#define SMB_HAS_DEVICE_ADDRESS (0xC + amd756_smba)
-#define SMB_HAS_HOST_ADDRESS   (0xE + amd756_smba)
-#define SMB_SNOOP_ADDRESS      (0xF + amd756_smba)
+#define SMB_GLOBAL_STATUS      (0x0 + base)
+#define SMB_GLOBAL_ENABLE      (0x2 + base)
+#define SMB_HOST_ADDRESS       (0x4 + base)
+#define SMB_HOST_DATA          (0x6 + base)
+#define SMB_HOST_COMMAND       (0x8 + base)
+#define SMB_HOST_BLOCK_DATA    (0x9 + base)
+#define SMB_HAS_DATA           (0xA + base)
+#define SMB_HAS_DEVICE_ADDRESS (0xC + base)
+#define SMB_HAS_HOST_ADDRESS   (0xE + base)
+#define SMB_SNOOP_ADDRESS      (0xF + base)
 
 /* PCI Address Constants */
 
@@ -107,7 +95,23 @@
 #define AMD756_PROCESS_CALL 0x04
 #define AMD756_BLOCK_DATA   0x05
 
-/* insmod parameters */
+struct sd {
+    const unsigned short vendor;
+    const unsigned short device;
+    const unsigned short function;
+    const char* name;
+    int (*setupfn)(struct sd *amd_dev, struct pci_dev *device);
+};
+
+struct amd756_data {
+    const struct sd *device;
+    unsigned short base;
+};
+
+struct amd756_adapter {
+    struct i2c_adapter i2c_adapter;
+    struct amd756_data data;    
+};
 
 #ifdef MODULE
 static
@@ -121,29 +125,39 @@
 			 unsigned short flags, char read_write,
 			 u8 command, int size, union i2c_smbus_data *data);
 static void amd756_do_pause(unsigned int amount);
-static void amd756_abort(void);
-static int amd756_transaction(void);
+static void amd756_abort(unsigned short base);
+static int amd756_transaction(unsigned short base);
 static void amd756_inc(struct i2c_adapter *adapter);
 static void amd756_dec(struct i2c_adapter *adapter);
 static u32 amd756_func(struct i2c_adapter *adapter);
+static int __init amd756_setup_nforce(struct sd *amd_dev, struct pci_dev *device);
+static int __init amd756_setup_amd(struct sd *amd_dev, struct pci_dev *device);
 
 #ifdef MODULE
 extern int init_module(void);
 extern int cleanup_module(void);
 #endif				/* MODULE */
 
+static struct sd supported[] = {
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_756, 3, "AMD756", amd756_setup_amd},
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_766, 3, "AMD766", amd756_setup_amd},
+    {PCI_VENDOR_ID_AMD, 0x7443, 3, "AMD768", amd756_setup_amd},
+    {PCI_VENDOR_ID_NVIDIA, 0x01B4, 1, "nVidia nForce", amd756_setup_nforce},
+    {0, 0, 0}
+};
+
 static struct i2c_algorithm smbus_algorithm = {
 	/* name */ "Non-I2C SMBus adapter",
 	/* id */ I2C_ALGO_SMBUS,
 	/* master_xfer */ NULL,
 	/* smbus_access */ amd756_access,
-	/* slave;_send */ NULL,
+	/* slave_send */ NULL,
 	/* slave_rcv */ NULL,
 	/* algo_control */ NULL,
 	/* functionality */ amd756_func,
 };
 
-static struct i2c_adapter amd756_adapter = {
+const static struct i2c_adapter amd756_adapter_template = {
 	"unset",
 	I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
 	&smbus_algorithm,
@@ -154,19 +168,108 @@
 	NULL,
 };
 
-static int __initdata amd756_initialized;
-static struct sd *amd756_sd = NULL;
-static unsigned short amd756_smba = 0;
-
-/* Detect whether a AMD756 can be found, and initialize it, where necessary.
-   Note the differences between kernels with the old PCI BIOS interface and
-   newer kernels with the real PCI interface. In compat.h some things are
-   defined to make the transition easier. */
-int amd756_setup(void)
+static struct amd756_adapter amd756_adapters[AMD756_ADAP_MAX];
+static int amd756_adapter_count = 0;
+
+static int __init amd756_register_adapter(const struct sd *device, unsigned short base)
+{
+	int res;
+	struct amd756_adapter *new_adapter = NULL;	
+
+	if (amd756_adapter_count = AMD756_ADAP_MAX)
+	{
+		printk("i2c-amd756.o: Error: Max number of adapters (%d) reached!\n", 
+			AMD756_ADAP_MAX);
+    		return -ENOMEM;
+	}
+	
+	if (check_region(base, SMB_IOSIZE)) {
+		printk
+		    ("i2c-amd756.o: SMB region 0x%x already in use!\n", base);
+		return -ENODEV;
+	}
+    
+	new_adapter = amd756_adapters + amd756_adapter_count;
+	memcpy(new_adapter, &amd756_adapter_template, sizeof(amd756_adapter_template));
+
+	sprintf(new_adapter->i2c_adapter.name, "SMBus %s adapter at %04x",
+		device->name, base);
+	new_adapter->data.base = base;
+	new_adapter->data.device = device;
+	new_adapter->i2c_adapter.data = &new_adapter->data;
+		
+	if ((res = i2c_add_adapter(&new_adapter->i2c_adapter))) {
+		printk("i2c-amd756.o: Error registering i2c adapter `%s'\n", 
+			new_adapter->i2c_adapter.name);
+		return res;
+	}
+    
+	/* Everything is happy, let's grab the memory and set things up. */
+	request_region(base, SMB_IOSIZE, "amd756-smbus");
+	
+	amd756_adapter_count++;
+	
+	return 0;
+}
+
+static int __init amd756_setup_amd(struct sd *amd_dev, struct pci_dev *device)
 {
 	unsigned char temp;
+	unsigned short base;
+	int res;
+
+	pci_read_config_byte(device, SMBGCFG, &temp);
+	if ((temp & 128) = 0) {
+		printk("i2c-amd756.o: Error: SMBus controller I/O not enabled!\n");
+		return -ENODEV;
+	}
+	
+	/* Determine the address of the SMBus areas */
+	/* Technically it is a dword but... */
+	pci_read_config_word(device, SMBBA, &base);
+	base &= 0xff00;
+	base += SMB_ADDR_OFFSET;
+	
+	if ((res = amd756_register_adapter(amd_dev, base)) != 0) {
+		return res;
+	}
+
+#ifdef DEBUG
+	pci_read_config_byte(device, SMBREV, &temp);
+	printk("i2c-amd756.o: SMBREV = 0x%X\n", temp);
+	printk("i2c-amd756.o: address = 0x%X\n", base);
+#endif				/* DEBUG */
+
+	return 0;
+}
+
+static int __init amd756_setup_nforce(struct sd *amd_dev, struct pci_dev *device)
+{
+	int res;
+
+	/* 
+		The nForce has two smbusses.
+		Don't know how to get the base addresses, so just
+		assume 0x5000 & 0x5500.
+		We could look at the pci io resources if necessary.
+	*/
+	
+	if ((res = amd756_register_adapter(amd_dev, 0x5000)) != 0) {
+		return res;
+	}
+
+	if ((res = amd756_register_adapter(amd_dev, 0x5500)) != 0) {
+		return res;
+	}
+
+	return 0;
+}
+
+int __init amd756_setup(void)
+{
 	struct sd *currdev;
 	struct pci_dev *AMD756_dev = NULL;
+	int res = -ENODEV;
 
 	if (pci_present() = 0) {
 		printk("i2c-amd756.o: Error: No PCI-bus found!\n");
@@ -179,54 +282,20 @@
 						currdev->device, AMD756_dev);
 		if (AMD756_dev != NULL)	{
 			if (PCI_FUNC(AMD756_dev->devfn) = currdev->function)
-				break;
+			{
+				printk(KERN_INFO "i2c-amd756.o: Found %s SMBus controller.\n", 
+					currdev->name);
+				res = currdev->setupfn(currdev, AMD756_dev);
+			}
 		} else {
 		    currdev++;
 		}
 	}
 
-	if (AMD756_dev = NULL) {
-		printk
-		    ("i2c-amd756.o: Error: No AMD756 or compatible device detected!\n");
-		return(-ENODEV);
-	}
-	printk(KERN_INFO "i2c-amd756.o: Found %s SMBus controller.\n", currdev->name);
-
-	if (currdev->amdsetup)
-	{
-		pci_read_config_byte(AMD756_dev, SMBGCFG, &temp);
-		if ((temp & 128) = 0) {
-			printk("i2c-amd756.o: Error: SMBus controller I/O not enabled!\n");
-			return(-ENODEV);
-		}
-
-		/* Determine the address of the SMBus areas */
-		/* Technically it is a dword but... */
-		pci_read_config_word(AMD756_dev, SMBBA, &amd756_smba);
-		amd756_smba &= 0xff00;
-		amd756_smba += SMB_ADDR_OFFSET;
-	} else {
-		amd756_smba = 0x5500;
-	}
-	if (check_region(amd756_smba, SMB_IOSIZE)) {
-		printk
-		    ("i2c-amd756.o: SMB region 0x%x already in use!\n",
-		     amd756_smba);
-		return(-ENODEV);
+	if (amd756_adapter_count = 0) {
+		return res;
 	}
-
-	/* Everything is happy, let's grab the memory and set things up. */
-	request_region(amd756_smba, SMB_IOSIZE, "amd756-smbus");
-
-#ifdef DEBUG
-	pci_read_config_byte(AMD756_dev, SMBREV, &temp);
-	printk("i2c-amd756.o: SMBREV = 0x%X\n", temp);
-	printk("i2c-amd756.o: AMD756_smba = 0x%X\n", amd756_smba);
-#endif				/* DEBUG */
-
-	/* store struct sd * for future reference */
-        amd756_sd = currdev;
-
+	
 	return 0;
 }
 
@@ -258,7 +327,7 @@
 #define GE_HOST_STC (1 << 3)
 #define GE_ABORT (1 << 5)
 
-void amd756_abort(void)
+void amd756_abort(unsigned short base)
 {
 	printk("i2c-amd756.o: Sending abort.\n");
 	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
@@ -266,7 +335,7 @@
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
 }
 
-int amd756_transaction(void)
+int amd756_transaction(unsigned short base)
 {
 	int temp;
 	int result = 0;
@@ -289,11 +358,11 @@
 			amd756_do_pause(1);
 			temp = inw_p(SMB_GLOBAL_STATUS);
 		} while ((temp & (GS_HST_STS | GS_SMB_STS)) &&
-		         (timeout++ < MAX_TIMEOUT));
+			 (timeout++ < MAX_TIMEOUT));
 		/* If the SMBus is still busy, we give up */
 		if (timeout >= MAX_TIMEOUT) {
 			printk("i2c-amd756.o: Busy wait timeout! (%04x)\n", temp);
-			amd756_abort();
+			amd756_abort(base);
 			return(-1);
 		}
 		timeout = 0;
@@ -311,7 +380,7 @@
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
 		printk("i2c-amd756.o: Completion timeout!\n");
-		amd756_abort ();
+		amd756_abort(base);
 		return(-1);
 	}
 
@@ -362,6 +431,7 @@
 		  u8 command, int size, union i2c_smbus_data * data)
 {
 	int i, len;
+	const unsigned short base = ((struct amd756_data*)adap->data)->base;
 
   /** TODO: Should I supporte the 10-bit transfers? */
 	switch (size) {
@@ -422,7 +492,7 @@
 	/* How about enabling interrupts... */
 	outw_p(size & GE_CYC_TYPE_MASK, SMB_GLOBAL_ENABLE);
 
-	if (amd756_transaction())	/* Error in transaction */
+	if (amd756_transaction(base))	/* Error in transaction */
 		return -1;
 
 	if ((read_write = I2C_SMBUS_WRITE) || (size = AMD756_QUICK))
@@ -459,7 +529,6 @@
 
 void amd756_dec(struct i2c_adapter *adapter)
 {
-
 	MOD_DEC_USE_COUNT;
 }
 
@@ -476,49 +545,42 @@
 	printk("i2c-amd756.o version %s (%s)\n", LM_VERSION, LM_DATE);
 #ifdef DEBUG
 /* PE- It might be good to make this a permanent part of the code! */
-	if (amd756_initialized) {
+	if (amd756_adapter_count > 0) {
 		printk
 		    ("i2c-amd756.o: Oops, amd756_init called a second time!\n");
 		return -EBUSY;
 	}
 #endif
-	amd756_initialized = 0;
 	if ((res = amd756_setup())) {
 		printk
 		    ("i2c-amd756.o: AMD756 or compatible device not detected, module not inserted.\n");
-		amd756_cleanup();
 		return res;
 	}
-	amd756_initialized++;
-	sprintf(amd756_adapter.name, "SMBus %s adapter at %04x",
-		amd756_sd->name, amd756_smba);
-	if ((res = i2c_add_adapter(&amd756_adapter))) {
-		printk
-		    ("i2c-amd756.o: Adapter registration failed, module not inserted.\n");
-		amd756_cleanup();
-		return res;
-	}
-	amd756_initialized++;
-	printk("i2c-amd756.o: %s bus detected and initialized\n",
-               amd756_sd->name);
+
 	return 0;
 }
 
 int __init amd756_cleanup(void)
 {
 	int res;
-	if (amd756_initialized >= 2) {
-		if ((res = i2c_del_adapter(&amd756_adapter))) {
-			printk
-			    ("i2c-amd756.o: i2c_del_adapter failed, module not removed\n");
-			return res;
-		} else
-			amd756_initialized--;
-	}
-	if (amd756_initialized >= 1) {
-		release_region(amd756_smba, SMB_IOSIZE);
-		amd756_initialized--;
+	int i;
+	
+	for(i = amd756_adapter_count - 1; i >= 0; i--)
+	{
+		struct amd756_adapter *curr = amd756_adapters + i;
+		if (curr->data.base)
+		{
+			if ((res = i2c_del_adapter(&curr->i2c_adapter))) {
+				printk("i2c-amd756.o: Could not delete adapter `%s', module not removed\n",
+					curr->i2c_adapter.name);
+				return res;
+			}
+			release_region(curr->data.base, SMB_IOSIZE);
+			curr->data.base = 0;
+			amd756_adapter_count--;
+		}
 	}
+
 	return 0;
 }
 
