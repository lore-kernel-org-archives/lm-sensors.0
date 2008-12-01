From: <JGong@nuvoton.com>
Date: Mon, 01 Dec 2008 06:31:50 +0000
Subject: Re: [lm-sensors] hwmon: add support for w83667hg
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E0020ADD5@ntshml01.nuvoton.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020ADD2@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020ADD2@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear David,

>The last two reads are identical to the ones in the for loop. Can this
>code be moved to the for loop instead of skipping it there and then
>reading it after?

Thanks I've fixed it. Here is the updated one.

Best regards,
Gong Jun

Signed-off-by: Gong Jun <JGong@nuvoton.com>
---
 w83627ehf.c |  122 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 40 deletions(-)
---
--- w83627ehf.c.orig	2008-11-26 11:13:12.000000000 +0800
+++ w83627ehf.c	2008-11-27 11:26:01.000000000 +0800
@@ -36,6 +36,7 @@
     w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
                                                0x8860 0xa1
     w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
+    w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
 */
 
 #include <linux/module.h>
@@ -51,12 +52,13 @@
 #include <asm/io.h>
 #include "lm75.h"
 
-enum kinds { w83627ehf, w83627dhg };
+enum kinds { w83627ehf, w83627dhg, w83667hg};
 
 /* used to set data->name = w83627ehf_device_names[data->sio_kind] */
 static const char * w83627ehf_device_names[] = {
 	"w83627ehf",
 	"w83627dhg",
+	"w83667hg",
 };
 
 static unsigned short force_id;
@@ -70,6 +72,7 @@ MODULE_PARM_DESC(force_id, "Override the
  */
 
 #define W83627EHF_LD_HWM	0x0b
+#define W83667HG_LD_VID 	0x0d
 
 #define SIO_REG_LDSEL		0x07	/* Logical device select */
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
@@ -82,6 +85,7 @@ MODULE_PARM_DESC(force_id, "Override the
 #define SIO_W83627EHF_ID	0x8850
 #define SIO_W83627EHG_ID	0x8860
 #define SIO_W83627DHG_ID	0xa020
+#define SIO_W83667HG_ID 	0xa510
 #define SIO_ID_MASK		0xFFF0
 
 static inline void
@@ -148,6 +152,7 @@ static const u16 W83627EHF_REG_FAN_MIN[]
 					 (0x555 + (((nr) - 7) * 2)))
 #define W83627EHF_REG_IN(nr)		((nr < 7) ? (0x20 + (nr)) : \
 					 (0x550 + (nr) - 7))
+#define W83627EHF_REG_IN6_667HG	0x250		// vin6 register for 667hg is 0x250
 
 #define W83627EHF_REG_TEMP1		0x27
 #define W83627EHF_REG_TEMP1_HYST	0x3a
@@ -288,6 +293,7 @@ struct w83627ehf_data {
 	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle */
 	u8 pwm_enable[4]; /* 1->manual
 			     2->thermal cruise (also called SmartFan I) */
+	u8 pwm_num;		/* number of pwm */
 	u8 pwm[4];
 	u8 target_temp[4];
 	u8 tolerance[4];
@@ -453,6 +459,8 @@ static struct w83627ehf_data *w83627ehf_
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
 	int pwmcfg = 0, tolerance = 0; /* shut up the compiler */
 	int i;
+	struct w83627ehf_sio_data *sio_data = dev->platform_data;
+	u8 reg;
 
 	mutex_lock(&data->update_lock);
 
@@ -463,8 +471,19 @@ static struct w83627ehf_data *w83627ehf_
 
 		/* Measured voltages and limits */
 		for (i = 0; i < data->in_num; i++) {
-			data->in[i] = w83627ehf_read_value(data,
-				      W83627EHF_REG_IN(i));
+			if ((sio_data->kind = w83667hg) && (i = 6)) {
+				/* W83667HG, try fix in6 lost problem */
+				reg = w83627ehf_read_value(data, 
+				      W83627EHF_REG_TEMP_CONFIG[1]);
+				w83627ehf_write_value(data, 
+						W83627EHF_REG_TEMP_CONFIG[1], reg | 0x01);
+				data->in[i] = w83627ehf_read_value(data,
+					      W83627EHF_REG_IN6_667HG);
+				w83627ehf_write_value(data, 
+						W83627EHF_REG_TEMP_CONFIG[1], reg);
+			} else
+				data->in[i] = w83627ehf_read_value(data,
+					      W83627EHF_REG_IN(i));
 			data->in_min[i] = w83627ehf_read_value(data,
 					  W83627EHF_REG_IN_MIN(i));
 			data->in_max[i] = w83627ehf_read_value(data,
@@ -1191,7 +1210,7 @@ static void w83627ehf_device_remove_file
 		device_remove_file(dev, &sda_fan_div[i].dev_attr);
 		device_remove_file(dev, &sda_fan_min[i].dev_attr);
 	}
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < data->pwm_num; i++) {
 		device_remove_file(dev, &sda_pwm[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
@@ -1271,8 +1290,10 @@ static int __devinit w83627ehf_probe(str
 	data->name = w83627ehf_device_names[sio_data->kind];
 	platform_set_drvdata(pdev, data);
 
-	/* 627EHG and 627EHF have 10 voltage inputs; DHG has 9 */
-	data->in_num = (sio_data->kind = w83627dhg) ? 9 : 10;
+	/* 627EHG and 627EHF have 10 voltage inputs; DHG and 667HG have 9 */
+	data->in_num = (sio_data->kind = w83627ehf) ? 10 : 9;
+	/* 667HG has 3 pwms */
+	data->pwm_num = (sio_data->kind = w83667hg) ? 3 : 4;
 
 	/* Initialize the chip */
 	w83627ehf_init_device(data);
@@ -1280,44 +1301,59 @@ static int __devinit w83627ehf_probe(str
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
+ 		we can get the VID input values directly at logical device D
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
+			/* Set VID input sensibility if needed. In theory the BIOS
+			   should have set it, but in practice it's not always the
+			   case. We only do it for the W83627EHF/EHG because the
+			   W83627DHG is more complex in this respect. */
+			if (sio_data->kind = w83627ehf) {
+				en_vrm10 = superio_inb(sio_data->sioreg,
+						       SIO_REG_EN_VRM10);
+				if ((en_vrm10 & 0x08) && data->vrm = 90) {
+					dev_warn(dev, "Setting VID input voltage to "
+						 "TTL\n");
+					superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
+						     en_vrm10 & ~0x08);
+				} else if (!(en_vrm10 & 0x08) && data->vrm = 100) {
+					dev_warn(dev, "Setting VID input voltage to "
+						 "VRM10\n");
+					superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
+						     en_vrm10 | 0x08);
+				}
+			}
+
+			data->vid = superio_inb(sio_data->sioreg, SIO_REG_VID_DATA);
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
@@ -1343,7 +1379,8 @@ static int __devinit w83627ehf_probe(str
 			goto exit_remove;
 
 	/* if fan4 is enabled create the sf3 files for it */
-	if (data->has_fan & (1 << 3))
+	if ((sio_data->kind != w83667hg) && 
+		(data->has_fan & (1 << 3)))
 		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
 			if ((err = device_create_file(dev,
 				&sda_sf3_arrays_fan4[i].dev_attr)))
@@ -1371,8 +1408,8 @@ static int __devinit w83627ehf_probe(str
 				|| (err = device_create_file(dev,
 					&sda_fan_min[i].dev_attr)))
 				goto exit_remove;
-			if (i < 4 && /* w83627ehf only has 4 pwm */
-				((err = device_create_file(dev,
+	if(i < data->pwm_num &&
+			((err = device_create_file(dev,
 					&sda_pwm[i].dev_attr))
 				|| (err = device_create_file(dev,
 					&sda_pwm_mode[i].dev_attr))
@@ -1441,6 +1478,7 @@ static int __init w83627ehf_find(int sio
 	static const char __initdata sio_name_W83627EHF[] = "W83627EHF";
 	static const char __initdata sio_name_W83627EHG[] = "W83627EHG";
 	static const char __initdata sio_name_W83627DHG[] = "W83627DHG";
+	static const char __initdata sio_name_W83667HG[] = "W83667HG";
 
 	u16 val;
 	const char *sio_name;
@@ -1465,6 +1503,10 @@ static int __init w83627ehf_find(int sio
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



=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
