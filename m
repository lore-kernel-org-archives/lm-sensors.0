From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 06 Sep 2006 05:31:41 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <4dfa50520609052231w351b3aek2a4d628a16f92bd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again,

Here is a first shot at w83627dhg support. The datasheet files were
very helpful, especially the file that showed just the differences
between the EHF and DHG chips.

@Jean: Could you give me some feedback on the attached patch? Thanks!

@Michael Walle and Michael Nelson:

You can patch -p1 on a linux-2.6.18-rc4 kernel, or you can replace
/usr/src/linux/drivers/hwmon/w83627ehf.c with the attached
w83627ehf.c. The driver now prints a line as it detects your chip:

w83627ehf 9191-0290: detected W83627EHF/EHG (A1)

or

w83627ehf 9191-0290: detected W83627DHG (C1)

(You must turn on driver debug messages in your kernel config to see
this message.)

I have also attached w83627ehf_regression.sh, which should check that
your module loads and unloads correctly, verify that the sysfs files
have sane values, and runs the fans through their paces. Please at
least glance at the source of the script if you are thinking of
running it. :-)

The new driver works fine on my machine, and detects my chip
correctly. Please try it out and let me know how it goes.

Thanks,
David
-------------- next part --------------
Add support for w83627dhg.
Bug: driver may not currently be reading under-voltage alarm

diff -ur linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c
--- linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c	2006-09-05 22:38:38.000000000 -0700
+++ linux-2.6.18-rc4/drivers/hwmon/w83627ehf.c	2006-09-05 23:17:54.000000000 -0700
@@ -34,6 +34,7 @@
 
     Chip        #vin    #fan    #pwm    #temp   chip_id    man_id
     w83627ehf   10      5       4       3       0x88,0xa1  0x5ca3
+    w83627dhg    9      5       4       3       0xa0,0xc1  0x5ca3
 */
 
 #include <linux/module.h>
@@ -115,9 +116,42 @@
 
 #define W83627EHF_REG_BANK		0x4E
 #define W83627EHF_REG_CONFIG		0x40
-#define W83627EHF_REG_CHIP_ID		0x49
+#define W83627EHF_REG_CHIP_ID		0x58
 #define W83627EHF_REG_MAN_ID		0x4F
 
+/*
+ * Please remember when implementing more features that the following registers
+ * have different functions on the w83627ehf and w83627dhg. Registers may also
+ * have different power-on default values, but the BIOS has probably also set
+ * default values, so chip-specific differences are not important for that.
+ *
+ * ISA Register      Explanation of difference
+ * ----------------- -------------------------
+ *              0x49 DHG only: selects temp used for SmartFan AUX fan, CPU fan0
+ *              0x4a not completely documented on EHF, and DHG docs assign
+ *                   different behavior to bits 7 and 6. Also EHF might only
+ *                   select temp input for SmartFan III, DHG selects temp input
+ *                   in any SmartFan mode. Further EHF testing is required.
+ * 0x50-0x55, bank 0 EHF docs say "Test Reg," DHG docs say "Reserved Reg"
+ * 0x50-0x57, bank 6 EHF docs say "Test Reg," DHG docs say "Reserved Reg"
+ *      0x58, bank 0 Chip ID, of course. EHF: 0xa1. DHG: 0xc1
+ *      0x5e, bank 0 DHG only: enable bits for current mode for thermal diodes
+ *                   and critical temperature protection feature
+ *      0x50, bank 4 EHF only: bit 3, vin4 over limit
+ *      0x5b, bank 4 EHF only: bit 3, vin4 under limit
+ *      0x52, bank 5 EHF only: vin4 from A/D
+ *      0x58, bank 5 EHF only: vin4 high limit
+ *      0x59, bank 5 EHF only: vin4 low limit
+ *              0x6b DHG only: SYS fan critical temperature limit
+ *              0x6c DHG only: CPU fan0 critical temperature limit
+ *              0x6d DHG only: AUX fan critical temperature limit
+ *              0x6e DHG only: CPU fan1 critical temperature limit
+ *
+ * The w83627dhg supports Intel PECI and SST interfaces for new CPU's (e.g.
+ * Intel Core). DHG queries PECI interface on CPU to read temps, and ICH8
+ * chipset can read DHG temp data and drive fans. SST is a 1-wire serial bus.
+ */
+
 static const u16 W83627EHF_REG_FAN[] = { 0x28, 0x29, 0x2a, 0x3f, 0x553 };
 static const u16 W83627EHF_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d, 0x3e, 0x55c };
 
@@ -252,6 +286,7 @@
 	u8 fan[5];
 	u8 fan_min[5];
 	u8 fan_div[5];
+	u8 num_in;		/* 10 VIN for ehf, 9 VIN for dhg */
 	u8 has_fan;		/* some fan inputs can be disabled */
 	s8 temp1;
 	s8 temp1_max;
@@ -425,7 +460,7 @@
 		}
 
 		/* Measured voltages and limits */
-		for (i = 0; i < 10; i++) {
+		for (i = 0; i < data->num_in; i++) {
 			data->in[i] = w83627ehf_read_value(client,
 				      W83627EHF_REG_IN(i));
 			data->in_min[i] = w83627ehf_read_value(client,
@@ -1214,7 +1249,23 @@
 	fan5pin = superio_inb(0x24) & 0x2;
 	fan4pin = superio_inb(0x29) & 0x6;
 	superio_exit();
-	
+
+	/* Detect w83627ehf (10 VIN) and w83627dhg (9 VIN) */
+	i = w83627ehf_read_value(client, W83627EHF_REG_CHIP_ID);
+	if (i = 0xa1) {	/* w83627ehf */
+		dev_dbg(dev, "detected W83627EHF/EHG (A1)\n");
+		data->num_in = 10;
+	}
+	else if (i = 0xc1) {	/* w83627dhg */
+		dev_dbg(dev, "detected W83627DHG (C1)\n");
+		data->num_in = 9;
+	}
+	else {
+		dev_err(dev, "unknown CHIP_ID (0x%02x)\n", i);
+		err = -ENODEV;
+		goto exit_remove;
+	}
+
 	/* It looks like fan4 and fan5 pins can be alternatively used
 	   as fan on/off switches */
 	
@@ -1238,7 +1289,7 @@
 				goto exit_remove;
 		}
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i < data->num_in; i++)
 		if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
 			|| (err = device_create_file(dev,
 				&sda_in_alarm[i].dev_attr))
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf.c
Type: application/octet-stream
Size: 46305 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060905/b016fd6d/attachment-0001.obj 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_regression.sh
Type: application/x-sh
Size: 16291 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060905/b016fd6d/attachment-0001.sh 
