From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 18 Jan 2009 22:34:26 +0000
Subject: [lm-sensors] PATCH: i2c-i801-dmi-detect-fscsyl.patch
Message-Id: <4973AE72.8080902@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010806080200050201060701"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010806080200050201060701
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

<resend with list in the CC>

Hi Jean,

This patch adds support to the i2c-i801.c driver for i2c slave enumeration on
the basis of the motherboard dmi tables onboard table. And uses this support
to detect the presense of an FSC Syleus IC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


--------------010806080200050201060701
Content-Type: text/plain;
 name="i2c-i801-dmi-detect-fscsyl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i2c-i801-dmi-detect-fscsyl.patch"

This patch adds support to the i2c-i801.c driver for i2c slave enumeration on
the basis of the motherboard dmi tables onboard table. And uses this support
to detect the presense of an FSC Syleus IC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/i2c/busses/i2c-i801.c	2009-01-18 23:11:44.000000000 +0100
+++ linux/drivers/i2c/busses/i2c-i801.c	2009-01-18 23:14:49.000000000 +0100
@@ -65,6 +65,7 @@
 #include <linux/i2c.h>
 #include <linux/acpi.h>
 #include <linux/io.h>
+#include <linux/dmi.h>
 
 /* I801 SMBus address offsets */
 #define SMBHSTSTS	(0 + i801_smba)
@@ -136,6 +137,10 @@
 #define FEATURE_I2C_BLOCK_READ	(1 << 3)
 static unsigned int i801_features;
 
+static int i2c_devs_found;
+static unsigned short i2c_devs_addresses[4];
+static char i2c_devs_types[4][I2C_NAME_SIZE];
+
 /* Make sure the SMBus host is ready to start transmitting.
    Return 0 if it is, -EBUSY if it is not. */
 static int i801_check_pre(void)
@@ -584,8 +589,6 @@
 MODULE_DEVICE_TABLE (pci, i801_ids);
 
 #if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
-static unsigned char apanel_addr;
-
 /* Scan the system ROM for the signature "FJKEYINF" */
 static __init const void __iomem *bios_signature(const void __iomem *bios)
 {
@@ -609,7 +612,9 @@
 	p = bios_signature(bios);
 	if (p) {
 		/* just use the first address */
-		apanel_addr = readb(p + 8 + 3) >> 1;
+		i2c_devs_addresses[0] = readb(p + 8 + 3) >> 1;
+		strlcpy(i2c_devs_types[0], "fujitsu_apanel", I2C_NAME_SIZE);
+		i2c_devs_found = 1;
 	}
 	iounmap(bios);
 }
@@ -617,10 +622,82 @@
 static void __init input_apanel_init(void) {}
 #endif
 
+#if defined CONFIG_SENSORS_FSCHMD || defined CONFIG_SENSORS_FSCHMD_MODULE
+struct dmi_onboard_device_info {
+	const char *name;
+	u8 type;
+	unsigned short i2c_addr;
+	const char *i2c_type;
+};
+
+static struct dmi_onboard_device_info dmi_devices[] = {
+	{ "Syleus", DMI_DEV_TYPE_OTHER, 0x73, "fscsyl" },
+};
+
+static void dmi_check_onboard_device(u8 type, const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dmi_devices); i++) {
+		/* & ~0x80, ignore enabled/disabled bit */
+		if ((type & ~0x80) != dmi_devices[i].type)
+			continue;
+		if (strcmp(name, dmi_devices[i].name))
+			continue;
+
+		if (i2c_devs_found + 1 == ARRAY_SIZE(i2c_devs_addresses)) {
+			printk(KERN_WARNING "Warning size of i2c_devs array "
+				"is too small please report this!");
+			return;
+		}
+
+		i2c_devs_addresses[i2c_devs_found] = dmi_devices[i].i2c_addr;
+		strlcpy(i2c_devs_types[i2c_devs_found],
+			dmi_devices[i].i2c_type, I2C_NAME_SIZE);
+		i2c_devs_found++;
+		return;
+	}
+}
+
+/* We use our own function to check for onboard devices instead of
+   dmi_find_device() as some buggy BIOS's have the devices we are interested
+   in marked as disabled */
+static void dmi_check_onboard_devices(const struct dmi_header *dm)
+{
+	int i, count = (dm->length - sizeof(struct dmi_header)) / 2;
+
+	if (dm->type != 10)
+		return;
+
+	for (i = 0; i < count; i++) {
+		const u8 *d = (char *)(dm + 1) + (i * 2);
+		const char *name = ((char *) dm) + dm->length;
+		u8 type = d[0];
+		u8 s = d[1];
+
+		if (!s)
+			continue;
+		s--;
+		while (s > 0 && name[0]) {
+			name += strlen(name) + 1;
+			s--;
+		}
+		dmi_check_onboard_device(type, name);
+	}
+}
+
+static void __init dmi_onboard_devices_init(void)
+{
+	dmi_walk(dmi_check_onboard_devices);
+}
+#else
+static void __init dmi_onboard_devices_init(void) {}
+#endif
+
 static int __devinit i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	unsigned char temp;
-	int err;
+	int i, err;
 
 	I801_dev = dev;
 	i801_features = 0;
@@ -703,16 +780,16 @@
 	}
 
 	/* Register optional slaves */
-#if defined CONFIG_INPUT_APANEL || defined CONFIG_INPUT_APANEL_MODULE
-	if (apanel_addr) {
+	for (i = 0; i < i2c_devs_found; i++) {
 		struct i2c_board_info info;
 
 		memset(&info, 0, sizeof(struct i2c_board_info));
-		info.addr = apanel_addr;
-		strlcpy(info.type, "fujitsu_apanel", I2C_NAME_SIZE);
+		info.addr = i2c_devs_addresses[i];
+		strlcpy(info.type, i2c_devs_types[i], I2C_NAME_SIZE);
 		i2c_new_device(&i801_adapter, &info);
+		dev_dbg(&dev->dev, "Added slave device: %s @ %02x",
+			info.type, (int)info.addr);
 	}
-#endif
 
 	return 0;
 
@@ -765,6 +842,7 @@
 static int __init i2c_i801_init(void)
 {
 	input_apanel_init();
+	dmi_onboard_devices_init();
 	return pci_register_driver(&i801_driver);
 }
 


--------------010806080200050201060701
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010806080200050201060701--
