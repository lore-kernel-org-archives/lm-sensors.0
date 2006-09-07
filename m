From: david.c.hubbard@gmail.com (David Hubbard)
Date: Thu, 07 Sep 2006 06:20:00 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4dfa50520609062320g6a273481t2889d2abc9dfc0e2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I have attached an updated patch (it now includes changes to
drivers/hwmon/w83627ehf.c and a new Documentation/hwmon/w83627ehf
file), plus w83627ehf.c. Michael and Michael, please try out the new
driver. No changes to w83627ehf_regression.sh.

> >      Chip        #vin    #fan    #pwm    #temp   chip_id    man_id
> >      w83627ehf   10      5       4       3       0x88,0xa1  0x5ca3
> > +    w83627dhg    9      5       4       3       0xa0,0xc1  0x5ca3
>
> Where does the "0xa0" comes from? I only see 0xC1 in the datasheet.

For an EHF CR[0x20] = 0x88, and for a DHG CR[0x20] = 0xa0. Thanks to
Michael Walle for catching this:

> With the correct SuperIO ID and mask (0xa020/0xfff0)
> the driver seems to work here

It's in the new patch, please comment :-)

> "Test Reg" and "Reserved Reg" is really the same, not worth documenting.

OK

> That's interesting documentation, but I'd move it to
> Documentation/hwmon/w83627ehf. Also I think you can be more concise at
> times, for example "DHG has no in9" summarizes 5 lines above. The
> datasheet is there for the details, what we want in the documentation
> is a summary of the differences that matter to us.

Done, added new file Documentation/hwmon/w83627ehf. By the way, I used
the w83627hf documentation as a template, and it has this link in it:
http://www2.lm-sensors.nu/~lm78/cvs/browse.cgi/lm_sensors2/doc/vid

Does that link need to be updated?

> A1 and C1 are really only arbitrary hexadecimal numbers, I see little
> benefit in exporting them to userspace.
>
> I'd make it a warning rather than an error. Nothing really bad happened.
>
> A switch/case might look better.

OK

> You don't use data->num for file removal... I agree it'll work
> (removing a non-existing file isn't an error) but given that you have
> the value available, using it looks both more logical and more
> efficient.

OK

David
-------------- next part --------------
Add support for w83627dhg.
Add Documentation/hwmon/w83627ehf
Bug: driver may not currently be reading under-voltage alarm

diff -ur linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c
--- linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c	2006-09-05 22:38:38.000000000 -0700
+++ linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c	2006-09-07 00:16:48.000000000 -0700
@@ -32,8 +32,9 @@
 
     Supports the following chips:
 
-    Chip        #vin    #fan    #pwm    #temp   chip_id    man_id
-    w83627ehf   10      5       4       3       0x88,0xa1  0x5ca3
+    Chip        #vin    #fan    #pwm    #temp  sio_ID & 0xfff0 chip_id mfg_id
+    w83627ehf   10      5       4       3      0x8860          0xa1    0x5ca3
+    w83627dhg    9      5       4       3      0xa020          0xc1    0x5ca3
 */
 
 #include <linux/module.h>
@@ -65,8 +66,9 @@
 #define SIO_REG_ENABLE		0x30	/* Logical device enable */
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
 
-#define SIO_W83627EHF_ID	0x8840
-#define SIO_ID_MASK		0xFFC0
+#define SIO_W83627EHF_ID	0x8860
+#define SIO_W83627DHG_ID	0xa020
+#define SIO_ID_MASK		0xFFF0
 
 static inline void
 superio_outb(int reg, int val)
@@ -115,7 +117,7 @@
 
 #define W83627EHF_REG_BANK		0x4E
 #define W83627EHF_REG_CONFIG		0x40
-#define W83627EHF_REG_CHIP_ID		0x49
+#define W83627EHF_REG_CHIP_ID		0x58
 #define W83627EHF_REG_MAN_ID		0x4F
 
 static const u16 W83627EHF_REG_FAN[] = { 0x28, 0x29, 0x2a, 0x3f, 0x553 };
@@ -252,6 +254,7 @@
 	u8 fan[5];
 	u8 fan_min[5];
 	u8 fan_div[5];
+	u8 num_in;		/* 10 VIN for ehf, 9 VIN for dhg */
 	u8 has_fan;		/* some fan inputs can be disabled */
 	s8 temp1;
 	s8 temp1_max;
@@ -425,7 +428,7 @@
 		}
 
 		/* Measured voltages and limits */
-		for (i = 0; i < 10; i++) {
+		for (i = 0; i < data->num_in; i++) {
 			data->in[i] = w83627ehf_read_value(client,
 				      W83627EHF_REG_IN(i));
 			data->in_min[i] = w83627ehf_read_value(client,
@@ -1107,7 +1110,8 @@
  * Driver and client management
  */
 
-static void w83627ehf_device_remove_files(struct device *dev)
+static void w83627ehf_device_remove_files(struct device *dev,
+					  struct w83627ehf_data *data)
 {
 	/* some entries in the following arrays may not have been used in
 	 * device_create_file(), but device_remove_file() will ignore them */
@@ -1117,7 +1121,7 @@
 		device_remove_file(dev, &sda_sf3_arrays[i].dev_attr);
 	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
 		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
-	for (i = 0; i < 10; i++) {
+	for (i = 0; i < data->num_in; i++) {
 		device_remove_file(dev, &sda_in_input[i].dev_attr);
 		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
 		device_remove_file(dev, &sda_in_min[i].dev_attr);
@@ -1215,6 +1219,23 @@
 	fan4pin = superio_inb(0x29) & 0x6;
 	superio_exit();
 	
+	/* Detect w83627ehf (10 VIN) and w83627dhg (9 VIN) */
+	i = w83627ehf_read_value(client, W83627EHF_REG_CHIP_ID);
+	switch (i) {
+	case 0xa1:	/* w83627ehf */
+		dev_dbg(dev, "detected W83627EHF/EHG\n");
+		data->num_in = 10;
+		break;
+	case 0xc1:	/* w83627dhg */
+		dev_dbg(dev, "detected W83627DHG\n");
+		data->num_in = 9;
+		break;
+	default:
+		dev_warn(dev, "unknown CHIP_ID (0x%02x), 9 VIN only.\n", i);
+		data->num_in = 9;
+		break;
+	}
+
 	/* It looks like fan4 and fan5 pins can be alternatively used
 	   as fan on/off switches */
 	
@@ -1238,7 +1259,7 @@
 				goto exit_remove;
 		}
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i < data->num_in; i++)
 		if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
 			|| (err = device_create_file(dev,
 				&sda_in_alarm[i].dev_attr))
@@ -1288,7 +1309,7 @@
 	return 0;
 
 exit_remove:
-	w83627ehf_device_remove_files(dev);
+	w83627ehf_device_remove_files(dev, data);
 	i2c_detach_client(client);
 exit_free:
 	kfree(data);
@@ -1303,7 +1324,7 @@
 	struct w83627ehf_data *data = i2c_get_clientdata(client);
 	int err;
 
-	w83627ehf_device_remove_files(&client->dev);
+	w83627ehf_device_remove_files(&client->dev, data);
 	hwmon_device_unregister(data->class_dev);
 
 	if ((err = i2c_detach_client(client)))
@@ -1332,7 +1353,13 @@
 
 	val = (superio_inb(SIO_REG_DEVID) << 8)
 	    | superio_inb(SIO_REG_DEVID + 1);
-	if ((val & SIO_ID_MASK) != SIO_W83627EHF_ID) {
+	switch (val & SIO_ID_MASK) {
+	case SIO_W83627EHF_ID:
+	case SIO_W83627DHG_ID:
+		break;
+	default:
+		printk(KERN_DEBUG "w83627ehf: unknown SuperIO ID: "
+			"0x%04x & 0x%04x\n", val, SIO_ID_MASK);
 		superio_exit();
 		return -ENODEV;
 	}
--- linux-2.6.18-rc4/Documentation/hwmon/w83627ehf	2006-09-07 00:15:30.000000000 -0700
+++ linux-2.6.18-rc4/Documentation/hwmon/w83627ehf	2006-09-07 00:15:07.000000000 -0700
@@ -0,0 +1,62 @@
+Kernel driver w83627ehf
+===========+
+Supported chips:
+  * Winbond W83627EHF and W83627EHG (lead-free version)
+    Addresses scanned: ISA address retrieved from Super I/O registers
+  * Winbond W83627DHG
+    Addresses scanned: ISA address retrieved from Super I/O registers
+
+Authors:
+        Jean Delvare <khali at linux-fr.org>
+        Yuan Mu <Ymu at Winbond.com.tw>,
+        Rudolf Marek <r.marek at sh.cvut.cz>
+        David Hubbard <david.c.hubbard at gmail.com>
+
+Module Parameters
+-----------------
+
+Currently none.
+
+Description
+-----------
+
+This driver implements support for the W83627EHF, W83627EHG, and W83627DHG
+Super I/O chips.
+
+For further information on this driver see the lm-sensors Wiki at
+http://www.lm-sensors.org/wiki
+
+Please remember when implementing more features that the following registers
+have different functions on the w83627ehf and w83627dhg. Registers may also
+have different power-on default values, but the BIOS has probably also set
+default values, so chip-specific differences are not important for that.
+
+ISA Register      Explanation of difference
+----------------- -------------------------
+             0x49 DHG only: selects temp used for SmartFan AUX fan, CPU fan0
+
+             0x4a not completely documented on EHF, and DHG docs assign
+                  different behavior to bits 7 and 6. Also EHF might only
+                  select temp input for SmartFan III, DHG selects temp input
+                  in any SmartFan mode. Further EHF testing is required.
+
+     0x58, bank 0 Chip ID, of course. EHF: 0xa1. DHG: 0xc1
+
+     0x5e, bank 0 DHG only: enable bits for current mode for thermal diodes
+                  and critical temperature protection feature
+
+     0x50, bank 4, bit 3, 0x5b, bank 4, bit 3, 0x52, bank 5, 0x58, bank 5, and
+     0x59, bank 5 EHF only: DHG has no in9 (vin4)
+
+             0x6b DHG only: SYS fan critical temperature limit
+
+             0x6c DHG only: CPU fan0 critical temperature limit
+
+             0x6d DHG only: AUX fan critical temperature limit
+
+             0x6e DHG only: CPU fan1 critical temperature limit
+
+The W83627DHG supports Intel PECI and SST interfaces for new CPU's (e.g.
+Intel Core). DHG queries PECI interface on CPU to read temps, and ICH8
+chipset can read DHG temp data and drive fans. SST is a 1-wire serial bus.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf.c
Type: application/octet-stream
Size: 44681 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/b139bc4d/attachment-0001.obj 
