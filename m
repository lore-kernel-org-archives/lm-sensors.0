From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Dec 2008 14:37:52 +0000
Subject: Re: [lm-sensors] hwmon: add support for w83667hg
Message-Id: <20081210153752.3f153a9d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020ADD2@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020ADD2@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have reviewed your patch yesterday. I fixed many problems reported by
> scripts/checkpatch.pl. Then I also updated drivers/hwmon/Kconfig and
> Documentation/hwmon/w83627ehf to mention the W83667HG. I tested the
> result on my W83627EHG and didn't see any regression, so it looks OK to
> me. The modified patch is at the end of this mail, please test it and
> use it as a base for future changes if needed.

Of course I forgot the patch. Here it goes:

From: Gong Jun <JGong@nuvoton.com>
Subject: hwmon: (w83627ehf) Add support for W83667HG

Add support for the Nuvoton W83667HG chip to the w83627ehf driver.
It has been tested on ASUS P5QL PRO by Gong Jun.

Signed-off-by: Gong Jun <JGong@nuvoton.com>
Acked-by: David Hubbard <david.c.hubbard@gmail.com>
---
 Documentation/hwmon/w83627ehf |   29 ++++++---
 drivers/hwmon/Kconfig         |    4 -
 drivers/hwmon/w83627ehf.c     |  129 ++++++++++++++++++++++++++++-------------
 3 files changed, 112 insertions(+), 50 deletions(-)

--- linux-2.6.28-rc7.orig/drivers/hwmon/w83627ehf.c	2008-12-09 19:06:02.000000000 +0100
+++ linux-2.6.28-rc7/drivers/hwmon/w83627ehf.c	2008-12-10 15:15:50.000000000 +0100
@@ -36,6 +36,7 @@
     w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
                                                0x8860 0xa1
     w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
+    w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
 */
 
 #include <linux/module.h>
@@ -52,12 +53,13 @@
 #include <asm/io.h>
 #include "lm75.h"
 
-enum kinds { w83627ehf, w83627dhg };
+enum kinds { w83627ehf, w83627dhg, w83667hg };
 
 /* used to set data->name = w83627ehf_device_names[data->sio_kind] */
 static const char * w83627ehf_device_names[] = {
 	"w83627ehf",
 	"w83627dhg",
+	"w83667hg",
 };
 
 static unsigned short force_id;
@@ -71,6 +73,7 @@ MODULE_PARM_DESC(force_id, "Override the
  */
 
 #define W83627EHF_LD_HWM	0x0b
+#define W83667HG_LD_VID 	0x0d
 
 #define SIO_REG_LDSEL		0x07	/* Logical device select */
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
@@ -83,6 +86,7 @@ MODULE_PARM_DESC(force_id, "Override the
 #define SIO_W83627EHF_ID	0x8850
 #define SIO_W83627EHG_ID	0x8860
 #define SIO_W83627DHG_ID	0xa020
+#define SIO_W83667HG_ID 	0xa510
 #define SIO_ID_MASK		0xFFF0
 
 static inline void
@@ -149,6 +153,7 @@ static const u16 W83627EHF_REG_FAN_MIN[]
 					 (0x555 + (((nr) - 7) * 2)))
 #define W83627EHF_REG_IN(nr)		((nr < 7) ? (0x20 + (nr)) : \
 					 (0x550 + (nr) - 7))
+#define W83627EHF_REG_IN6_667HG		0x250
 
 #define W83627EHF_REG_TEMP1		0x27
 #define W83627EHF_REG_TEMP1_HYST	0x3a
@@ -289,6 +294,7 @@ struct w83627ehf_data {
 	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle */
 	u8 pwm_enable[4]; /* 1->manual
 			     2->thermal cruise (also called SmartFan I) */
+	u8 pwm_num;		/* number of pwm */
 	u8 pwm[4];
 	u8 target_temp[4];
 	u8 tolerance[4];
@@ -454,6 +460,8 @@ static struct w83627ehf_data *w83627ehf_
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
 	int pwmcfg = 0, tolerance = 0; /* shut up the compiler */
 	int i;
+	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	u8 reg;
 
 	mutex_lock(&data->update_lock);
 
@@ -464,8 +472,21 @@ static struct w83627ehf_data *w83627ehf_
 
 		/* Measured voltages and limits */
 		for (i = 0; i < data->in_num; i++) {
-			data->in[i] = w83627ehf_read_value(data,
-				      W83627EHF_REG_IN(i));
+			if ((sio_data->kind = w83667hg) && (i = 6)) {
+				/* W83667HG, try fix in6 lost problem */
+				reg = w83627ehf_read_value(data,
+				      W83627EHF_REG_TEMP_CONFIG[1]);
+				w83627ehf_write_value(data,
+						W83627EHF_REG_TEMP_CONFIG[1],
+						reg | 0x01);
+				data->in[i] = w83627ehf_read_value(data,
+					      W83627EHF_REG_IN6_667HG);
+				w83627ehf_write_value(data,
+						W83627EHF_REG_TEMP_CONFIG[1],
+						reg);
+			} else
+				data->in[i] = w83627ehf_read_value(data,
+					      W83627EHF_REG_IN(i));
 			data->in_min[i] = w83627ehf_read_value(data,
 					  W83627EHF_REG_IN_MIN(i));
 			data->in_max[i] = w83627ehf_read_value(data,
@@ -1192,7 +1213,7 @@ static void w83627ehf_device_remove_file
 		device_remove_file(dev, &sda_fan_div[i].dev_attr);
 		device_remove_file(dev, &sda_fan_min[i].dev_attr);
 	}
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < data->pwm_num; i++) {
 		device_remove_file(dev, &sda_pwm[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
@@ -1272,8 +1293,10 @@ static int __devinit w83627ehf_probe(str
 	data->name = w83627ehf_device_names[sio_data->kind];
 	platform_set_drvdata(pdev, data);
 
-	/* 627EHG and 627EHF have 10 voltage inputs; DHG has 9 */
-	data->in_num = (sio_data->kind = w83627dhg) ? 9 : 10;
+	/* 627EHG and 627EHF have 10 voltage inputs; 627DHG and 667HG have 9 */
+	data->in_num = (sio_data->kind = w83627ehf) ? 10 : 9;
+	/* 667HG has 3 pwms */
+	data->pwm_num = (sio_data->kind = w83667hg) ? 3 : 4;
 
 	/* Initialize the chip */
 	w83627ehf_init_device(data);
@@ -1281,44 +1304,64 @@ static int __devinit w83627ehf_probe(str
 	data->vrm = vid_which_vrm();
 	superio_enter(sio_data->sioreg);
 	/* Read VID value */
-	superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
-	if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
-		/* Set VID input sensibility if needed. In theory the BIOS
-		   should have set it, but in practice it's not always the
-		   case. We only do it for the W83627EHF/EHG because the
-		   W83627DHG is more complex in this respect. */
-		if (sio_data->kind = w83627ehf) {
-			en_vrm10 = superio_inb(sio_data->sioreg,
-					       SIO_REG_EN_VRM10);
-			if ((en_vrm10 & 0x08) && data->vrm = 90) {
-				dev_warn(dev, "Setting VID input voltage to "
-					 "TTL\n");
-				superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
-					     en_vrm10 & ~0x08);
-			} else if (!(en_vrm10 & 0x08) && data->vrm = 100) {
-				dev_warn(dev, "Setting VID input voltage to "
-					 "VRM10\n");
-				superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
-					     en_vrm10 | 0x08);
-			}
-		}
-
-		data->vid = superio_inb(sio_data->sioreg, SIO_REG_VID_DATA);
-		if (sio_data->kind = w83627ehf) /* 6 VID pins only */
-			data->vid &= 0x3f;
-
+	if (sio_data->kind = w83667hg) {
+		/* W83667HG has different pins for VID input and output, so
+		we can get the VID input values directly at logical device D
+		0xe3. */
+		superio_select(sio_data->sioreg, W83667HG_LD_VID);
+		data->vid = superio_inb(sio_data->sioreg, 0xe3);
 		err = device_create_file(dev, &dev_attr_cpu0_vid);
 		if (err)
 			goto exit_release;
 	} else {
-		dev_info(dev, "VID pins in output mode, CPU VID not "
-			 "available\n");
+		superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
+		if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
+			/* Set VID input sensibility if needed. In theory the
+			   BIOS should have set it, but in practice it's not
+			   always the case. We only do it for the W83627EHF/EHG
+			   because the W83627DHG is more complex in this
+			   respect. */
+			if (sio_data->kind = w83627ehf) {
+				en_vrm10 = superio_inb(sio_data->sioreg,
+						       SIO_REG_EN_VRM10);
+				if ((en_vrm10 & 0x08) && data->vrm = 90) {
+					dev_warn(dev, "Setting VID input "
+						 "voltage to TTL\n");
+					superio_outb(sio_data->sioreg,
+						     SIO_REG_EN_VRM10,
+						     en_vrm10 & ~0x08);
+				} else if (!(en_vrm10 & 0x08)
+					&& data->vrm = 100) {
+					dev_warn(dev, "Setting VID input "
+						 "voltage to VRM10\n");
+					superio_outb(sio_data->sioreg,
+						     SIO_REG_EN_VRM10,
+						     en_vrm10 | 0x08);
+				}
+			}
+
+			data->vid = superio_inb(sio_data->sioreg,
+						SIO_REG_VID_DATA);
+			if (sio_data->kind = w83627ehf) /* 6 VID pins only */
+				data->vid &= 0x3f;
+
+			err = device_create_file(dev, &dev_attr_cpu0_vid);
+			if (err)
+				goto exit_release;
+		} else {
+			dev_info(dev, "VID pins in output mode, CPU VID not "
+				 "available\n");
+		}
 	}
 
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
-
-	fan5pin = superio_inb(sio_data->sioreg, 0x24) & 0x2;
-	fan4pin = superio_inb(sio_data->sioreg, 0x29) & 0x6;
+	if (sio_data->kind = w83667hg) {
+		fan5pin = superio_inb(sio_data->sioreg, 0x27) & 0x20;
+		fan4pin = superio_inb(sio_data->sioreg, 0x27) & 0x40;
+	} else {
+		fan5pin = superio_inb(sio_data->sioreg, 0x24) & 0x2;
+		fan4pin = superio_inb(sio_data->sioreg, 0x29) & 0x6;
+	}
 	superio_exit(sio_data->sioreg);
 
 	/* It looks like fan4 and fan5 pins can be alternatively used
@@ -1344,7 +1387,8 @@ static int __devinit w83627ehf_probe(str
 			goto exit_remove;
 
 	/* if fan4 is enabled create the sf3 files for it */
-	if (data->has_fan & (1 << 3))
+	if ((sio_data->kind != w83667hg) &&
+		(data->has_fan & (1 << 3)))
 		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
 			if ((err = device_create_file(dev,
 				&sda_sf3_arrays_fan4[i].dev_attr)))
@@ -1372,8 +1416,8 @@ static int __devinit w83627ehf_probe(str
 				|| (err = device_create_file(dev,
 					&sda_fan_min[i].dev_attr)))
 				goto exit_remove;
-			if (i < 4 && /* w83627ehf only has 4 pwm */
-				((err = device_create_file(dev,
+			if (i < data->pwm_num &&
+			    ((err = device_create_file(dev,
 					&sda_pwm[i].dev_attr))
 				|| (err = device_create_file(dev,
 					&sda_pwm_mode[i].dev_attr))
@@ -1442,6 +1486,7 @@ static int __init w83627ehf_find(int sio
 	static const char __initdata sio_name_W83627EHF[] = "W83627EHF";
 	static const char __initdata sio_name_W83627EHG[] = "W83627EHG";
 	static const char __initdata sio_name_W83627DHG[] = "W83627DHG";
+	static const char __initdata sio_name_W83667HG[] = "W83667HG";
 
 	u16 val;
 	const char *sio_name;
@@ -1466,6 +1511,10 @@ static int __init w83627ehf_find(int sio
 		sio_data->kind = w83627dhg;
 		sio_name = sio_name_W83627DHG;
 		break;
+	case SIO_W83667HG_ID:
+		sio_data->kind = w83667hg;
+		sio_name = sio_name_W83667HG;
+		break;
 	default:
 		if (val != 0xffff)
 			pr_debug(DRVNAME ": unsupported chip ID: 0x%04x\n",
--- linux-2.6.28-rc7.orig/Documentation/hwmon/w83627ehf	2008-12-09 19:05:02.000000000 +0100
+++ linux-2.6.28-rc7/Documentation/hwmon/w83627ehf	2008-12-09 19:06:03.000000000 +0100
@@ -2,30 +2,40 @@ Kernel driver w83627ehf
 =========== 
 Supported chips:
-  * Winbond W83627EHF/EHG/DHG (ISA access ONLY)
+  * Winbond W83627EHF/EHG (ISA access ONLY)
     Prefix: 'w83627ehf'
     Addresses scanned: ISA address retrieved from Super I/O registers
     Datasheet:
-        http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83627EHF_%20W83627EHGb.pdf
-        DHG datasheet confidential.
+        http://www.nuvoton.com.tw/NR/rdonlyres/A6A258F0-F0C9-4F97-81C0-C4D29E7E943E/0/W83627EHF.pdf
+  * Winbond W83627DHG
+    Prefix: 'w83627dhg'
+    Addresses scanned: ISA address retrieved from Super I/O registers
+    Datasheet:
+        http://www.nuvoton.com.tw/NR/rdonlyres/7885623D-A487-4CF9-A47F-30C5F73D6FE6/0/W83627DHG.pdf
+ * Winbond W83667HG
+   Prefix: 'w83667hg'
+   Addresses scanned: ISA address retrieved from Super I/O registers
+   Datasheet: not available
 
 Authors:
         Jean Delvare <khali@linux-fr.org>
         Yuan Mu (Winbond)
         Rudolf Marek <r.marek@assembler.cz>
         David Hubbard <david.c.hubbard@gmail.com>
+        Gong Jun <JGong@nuvoton.com>
 
 Description
 -----------
 
-This driver implements support for the Winbond W83627EHF, W83627EHG, and
-W83627DHG super I/O chips. We will refer to them collectively as Winbond chips.
+This driver implements support for the Winbond W83627EHF, W83627EHG,
+W83627DHG and W83667HG super I/O chips. We will refer to them collectively
+as Winbond chips.
 
 The chips implement three temperature sensors, five fan rotation
 speed sensors, ten analog voltage sensors (only nine for the 627DHG), one
-VID (6 pins for the 627EHF/EHG, 8 pins for the 627DHG), alarms with beep
-warnings (control unimplemented), and some automatic fan regulation
-strategies (plus manual fan control mode).
+VID (6 pins for the 627EHF/EHG, 8 pins for the 627DHG and 667HG), alarms
+with beep warnings (control unimplemented), and some automatic fan
+regulation strategies (plus manual fan control mode).
 
 Temperatures are measured in degrees Celsius and measurement resolution is 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
@@ -54,7 +64,8 @@ follows:
 temp1 -> pwm1
 temp2 -> pwm2
 temp3 -> pwm3
-prog  -> pwm4 (the programmable setting is not supported by the driver)
+prog  -> pwm4 (not on 667HG, the programmable setting is not supported by
+	       the driver)
 
 /sys files
 ----------
--- linux-2.6.28-rc7.orig/drivers/hwmon/Kconfig	2008-12-09 19:06:01.000000000 +0100
+++ linux-2.6.28-rc7/drivers/hwmon/Kconfig	2008-12-09 19:06:03.000000000 +0100
@@ -826,7 +826,7 @@ config SENSORS_W83627HF
 	  will be called w83627hf.
 
 config SENSORS_W83627EHF
-	tristate "Winbond W83627EHF/DHG"
+	tristate "Winbond W83627EHF/EHG/DHG, W83667HG"
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the hardware
@@ -837,6 +837,8 @@ config SENSORS_W83627EHF
 	  chip suited for specific Intel processors that use PECI such as
 	  the Core 2 Duo.
 
+	  This driver also supports the W83667HG chip.
+
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627ehf.
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
