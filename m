From: david.c.hubbard@gmail.com (David Hubbard)
Date: Mon, 25 Dec 2006 04:58:48 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <4dfa50520612242058o64e4d2e3s2fa7b91acadfe1e2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> The 4 LSB of the Super-I/O chip ID (4 LSB of LPC register 0x21) are
> subject to change in the future, which is why we mask them out when
> checking for device ID.

I updated the comment and replaced the 4 LSB with zeros. There isn't
room to note that the 4 LSB are ignored in the comment, but the
implementation uses SIO_ID_MASK = 0xFFF0, so it should be correct. In
w83627ehf_find(), I thought about masking val when printing the
KERN_WARNING, but I prefer more information rather than less
information. Also, I think the it is more readable to mask val in
switch (val & SIO_ID_MASK).

> Strange choice. You store one specific difference between both chips
> first, then deduce the chip name again based on this difference. A
> saner approach would be to store the chip id (or kind) as a global, and
> then in w83627ehf_detect(), use the value to set the number of voltage
> inputs as a data structure member. It would be much more flexible that
> the current approach. This will also make your job easier when
> converting the driver to a platform driver.

I agree. I would prefer to store specific values in w83627ehf_data and
detect the chips only once. However, I went with a compromise and so
in w83627ehf_find() when I detect the 627ehf, 627ehg, or 627dhg, I
store one value (w83627ehf_num_in) when I should be storing both
num_in and name. I consider the creation of a global variable a poor
solution, and I will change the implementation as quickly as possible.
I don't want to detect things twice (once in w83627ehf_find() and
later in w83627ehf_detect()).

> You can take a look at the it87 driver, it does exactly this.

I will, in a future patch.

> > +
> > +/* Not currently used. 0x4f does not make sense.
>
> How that?
>
> > + * REG_MAN_ID is 0x5ca3 for all supported chips.
> > + * REG_CHIP_ID = 0x88/0xa1/0xc1 depending on chip model. */
> >  #define W83627EHF_REG_MAN_ID         0x4F
> > +#define W83627EHF_REG_CHIP_ID                0x58
>
> Why define them at all if we don't use them? Unused defines make
> preprocessing more expensive.

In this patch I have changed the defines to comments. When I said
"0x4f does not make sense" I don't know why I typed 0x4f there. I
meant 0x49. The patch deletes the #define W83627EHF_REG_CHIP_ID 0x49.
The correct port is 0x4f.

> It could be one of the other W83627 chips (HF and THF), which are not
> (and will never be) supported by this driver, so this comment is a bit
> misleading. Maybe just "Unsupported chip"?

Good catch. Message updated.

> Broken alignment.

Fixed.

> Maybe move the final dot outside of the quotes to avoid unnecessaryt
> confusion.

I just deleted the period.

> This last paragraph isn't particularly helpful, "test" and "reserved"
> really mean the same.

Yes, but I feel the information is still worth adding, for
completeness. (It could be argued that all the information in this
section isn't particularly helpful; one should just read the driver. I
would argue that it is still worth having.) I have left it in the
patch, but if you feel strongly about it, I'll delete it.

Thanks,
David
-------------- next part --------------
This patch adds support for the w83627dhg chip.
Signed-off-by: David Hubbard <david.c.hubbard at gmail.com>

--- old/drivers/hwmon/w83627ehf.c	2006-12-21 14:04:19.000000000 -0800
+++ new/drivers/hwmon/w83627ehf.c	2006-12-24 21:53:54.000000000 -0800
@@ -32,8 +32,10 @@
 
     Supports the following chips:
 
-    Chip        #vin    #fan    #pwm    #temp   chip_id    man_id
-    w83627ehf   10      5       4       3       0x88,0xa1  0x5ca3
+    Chip        #vin    #fan    #pwm    #temp  chip IDs       mfg ID
+    w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
+                                               0x8860 0xa1
+    w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
 */
 
 #include <linux/module.h>
@@ -55,8 +57,18 @@
  * Super-I/O constants and functions
  */
 
+/*
+ * The three following globals are initialized in w83627ehf_find(), before
+ * the i2c-isa device is created. Otherwise, they could be stored in
+ * w83627ehf_data. This is ugly, but necessary. and when the driver is next
+ * updated to become a platform driver, the globals will disappear.
+ */
 static int REG;		/* The register to read/write */
 static int VAL;		/* The value to read/write */
+/* The w83627ehf/ehg have 10 voltage inputs, but the w83627dhg has 9. This
+ * value is also used in w83627ehf_detect() to export a device name in sysfs
+ * (e.g. w83627ehf or w83627dhg) */
+static int w83627ehf_num_in;
 
 #define W83627EHF_LD_HWM	0x0b
 
@@ -65,8 +77,10 @@
 #define SIO_REG_ENABLE		0x30	/* Logical device enable */
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
 
-#define SIO_W83627EHF_ID	0x8840
-#define SIO_ID_MASK		0xFFC0
+#define SIO_W83627EHF_ID	0x8850
+#define SIO_W83627EHG_ID	0x8860
+#define SIO_W83627DHG_ID	0xa020
+#define SIO_ID_MASK		0xFFF0
 
 static inline void
 superio_outb(int reg, int val)
@@ -115,8 +129,12 @@
 
 #define W83627EHF_REG_BANK		0x4E
 #define W83627EHF_REG_CONFIG		0x40
-#define W83627EHF_REG_CHIP_ID		0x49
-#define W83627EHF_REG_MAN_ID		0x4F
+
+/* Not currently used:
+ * REG_MAN_ID has the value 0x5ca3 for all supported chips.
+ * REG_CHIP_ID = 0x88/0xa1/0xc1 depending on chip model.
+ * REG_MAN_ID is at port 0x4f
+ * REG_CHIP_ID is at port 0x58 */
 
 static const u16 W83627EHF_REG_FAN[] = { 0x28, 0x29, 0x2a, 0x3f, 0x553 };
 static const u16 W83627EHF_REG_FAN_MIN[] = { 0x3b, 0x3c, 0x3d, 0x3e, 0x55c };
@@ -429,7 +447,7 @@
 		}
 
 		/* Measured voltages and limits */
-		for (i = 0; i < 10; i++) {
+		for (i = 0; i < w83627ehf_num_in; i++) {
 			data->in[i] = w83627ehf_read_value(client,
 				      W83627EHF_REG_IN(i));
 			data->in_min[i] = w83627ehf_read_value(client,
@@ -1121,7 +1139,7 @@
 		device_remove_file(dev, &sda_sf3_arrays[i].dev_attr);
 	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
 		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
-	for (i = 0; i < 10; i++) {
+	for (i = 0; i < w83627ehf_num_in; i++) {
 		device_remove_file(dev, &sda_in_input[i].dev_attr);
 		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
 		device_remove_file(dev, &sda_in_min[i].dev_attr);
@@ -1196,7 +1214,11 @@
 	client->flags = 0;
 	dev = &client->dev;
 
-	strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
+	if (w83627ehf_num_in = 9)
+		strlcpy(client->name, "w83627dhg", I2C_NAME_SIZE);
+	else	/* just say ehf. 627EHG is 627EHF in lead-free packaging. */
+		strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
+
 	data->valid = 0;
 	mutex_init(&data->update_lock);
 
@@ -1246,7 +1268,7 @@
 				goto exit_remove;
 		}
 
-	for (i = 0; i < 10; i++)
+	for (i = 0; i < w83627ehf_num_in; i++)
 		if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
 			|| (err = device_create_file(dev,
 				&sda_in_alarm[i].dev_attr))
@@ -1340,7 +1362,17 @@
 
 	val = (superio_inb(SIO_REG_DEVID) << 8)
 	    | superio_inb(SIO_REG_DEVID + 1);
-	if ((val & SIO_ID_MASK) != SIO_W83627EHF_ID) {
+	switch (val & SIO_ID_MASK) {
+	case SIO_W83627DHG_ID:
+		w83627ehf_num_in = 9;
+		break;
+	case SIO_W83627EHF_ID:
+	case SIO_W83627EHG_ID:
+		w83627ehf_num_in = 10;
+		break;
+	default:
+		printk(KERN_WARNING "w83627ehf: unsupported chip ID: 0x%04x\n",
+			val);
 		superio_exit();
 		return -ENODEV;
 	}
--- old/Documentation/hwmon/w83627ehf	2006-12-21 14:04:19.000000000 -0800
+++ new/Documentation/hwmon/w83627ehf	2006-12-24 21:55:46.000000000 -0800
@@ -2,26 +2,29 @@
 =========== 
 Supported chips:
-  * Winbond W83627EHF/EHG (ISA access ONLY)
+  * Winbond W83627EHF/EHG/DHG (ISA access ONLY)
     Prefix: 'w83627ehf'
     Addresses scanned: ISA address retrieved from Super I/O registers
-    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83627EHF_%20W83627EHGb.pdf
+    Datasheet:
+        http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83627EHF_%20W83627EHGb.pdf
+        DHG datasheet confidential.
 
 Authors:
         Jean Delvare <khali at linux-fr.org>
         Yuan Mu (Winbond)
         Rudolf Marek <r.marek at assembler.cz>
+        David Hubbard <david.c.hubbard at gmail.com>
 
 Description
 -----------
 
-This driver implements support for the Winbond W83627EHF and W83627EHG
-super I/O chips. We will refer to them collectively as Winbond chips.
+This driver implements support for the Winbond W83627EHF, W83627EHG, and
+W83627DHG super I/O chips. We will refer to them collectively as Winbond chips.
 
 The chips implement three temperature sensors, five fan rotation
-speed sensors, ten analog voltage sensors, alarms with beep warnings (control
-unimplemented), and some automatic fan regulation strategies (plus manual
-fan control mode).
+speed sensors, ten analog voltage sensors (only nine for the 627DHG), alarms
+with beep warnings (control unimplemented), and some automatic fan regulation
+strategies (plus manual fan control mode).
 
 Temperatures are measured in degrees Celsius and measurement resolution is 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
@@ -55,6 +58,9 @@
 /sys files
 ----------
 
+name - this is a standard hwmon device entry. For the W83627EHF and W83627EHG,
+       it is set to "w83627ehf" and for the W83627DHG it is set to "w83627dhg"
+
 pwm[1-4] - this file stores PWM duty cycle or DC value (fan speed) in range:
 	   0 (stop) to 255 (full)
 
@@ -83,3 +89,36 @@
 
 Note: last two functions are influenced by other control bits, not yet exported
       by the driver, so a change might not have any effect.
+
+Implementation Details
+----------------------
+Future driver development should bear in mind that the following registers have
+different functions on the 627EHF and the 627DHG. Some registers also have
+different power-on default values, but BIOS should already be loading
+appropriate defaults. Note that bank selection must be performed as is currently
+done in the driver for all register addresses.
+
+0x49:  only on DHG, selects temperature source for AUX fan, CPU fan0
+0x4a:  not completely documented for the EHF and the DHG documentation assigns
+       different behavior to bits 7 and 6, including extending the temperature
+       input selection to SmartFan I, not just SmartFan III. Testing on the EHF
+       will reveal whether they are compatible or not.
+
+0x58:  Chip ID: 0xa1=EHF 0xc1=DHG
+0x5e:  only on DHG, has bits to enable "current mode" temperature detection and
+       critical temperature protection
+0x45b: only on EHF, bit 3, vin4 alarm (EHF supports 10 inputs, only 9 on DHG)
+0x552: only on EHF, vin4
+0x558: only on EHF, vin4 high limit
+0x559: only on EHF, vin4 low limit
+0x6b:  only on DHG, SYS fan critical temperature
+0x6c:  only on DHG, CPU fan0 critical temperature
+0x6d:  only on DHG, AUX fan critical temperature
+0x6e:  only on DHG, CPU fan1 critical temperature
+
+0x50-0x55 and 0x650-0x657 are marked "Test Register" for the EHF, but "Reserved
+       Register" for the DHG
+
+The DHG also supports PECI, where the DHG queries Intel CPU temperatures, and
+the ICH8 southbridge gets that data via PECI from the DHG, so that the
+southbridge drives the fans. And the DHG supports SST, a one-wire serial bus.
