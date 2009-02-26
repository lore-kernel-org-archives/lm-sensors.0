From: <JGong@nuvoton.com>
Date: Thu, 26 Feb 2009 09:37:38 +0000
Subject: Re: [lm-sensors] W83667HG driver test for in6 and temp3
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E0020AE15@ntshml01.nuvoton.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
In-Reply-To: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear Jean,

Thanks very much for your quick comment. I've added the skip_in6 and temp3_disable into the data struct, cut the sda_temp into sub-arrays now.

Best regards,
Gong Jun

---
 w83627ehf.c |  184 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 130 insertions(+), 54 deletions(-)
---
--- w83627ehf.c.orig	2009-02-25 00:07:24.000000000 +0800
+++ w83627ehf.c	2009-02-27 01:12:09.000000000 +0800
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
@@ -288,6 +292,7 @@ struct w83627ehf_data {
 	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle */
 	u8 pwm_enable[4]; /* 1->manual
 			     2->thermal cruise (also called SmartFan I) */
+	u8 pwm_num;		/* number of pwm */
 	u8 pwm[4];
 	u8 target_temp[4];
 	u8 tolerance[4];
@@ -297,6 +302,9 @@ struct w83627ehf_data {
 
 	u8 vid;
 	u8 vrm;
+
+	u8 temp3_disable;
+	u8 in6_skip;
 };
 
 struct w83627ehf_sio_data {
@@ -865,25 +873,37 @@ show_temp_type(struct device *dev, struc
 	return sprintf(buf, "%d\n", (int)data->temp_type[nr]);
 }
 
-static struct sensor_device_attribute sda_temp[] = {
+static struct sensor_device_attribute sda_temp_input[] = {
 	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp1, NULL, 0),
 	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 0),
 	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 1),
+};
+
+static struct sensor_device_attribute sda_temp_max[] = {
 	SENSOR_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp1_max,
 		    store_temp1_max, 0),
 	SENSOR_ATTR(temp2_max, S_IRUGO | S_IWUSR, show_temp_max,
 		    store_temp_max, 0),
 	SENSOR_ATTR(temp3_max, S_IRUGO | S_IWUSR, show_temp_max,
 		    store_temp_max, 1),
+};
+
+static struct sensor_device_attribute sda_temp_max_hyst[] = {
 	SENSOR_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR, show_temp1_max_hyst,
 		    store_temp1_max_hyst, 0),
 	SENSOR_ATTR(temp2_max_hyst, S_IRUGO | S_IWUSR, show_temp_max_hyst,
 		    store_temp_max_hyst, 0),
 	SENSOR_ATTR(temp3_max_hyst, S_IRUGO | S_IWUSR, show_temp_max_hyst,
 		    store_temp_max_hyst, 1),
+};
+
+static struct sensor_device_attribute sda_temp_alarm[] = {
 	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4),
 	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5),
 	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13),
+};
+
+static struct sensor_device_attribute sda_temp_type[] = {
 	SENSOR_ATTR(temp1_type, S_IRUGO, show_temp_type, NULL, 0),
 	SENSOR_ATTR(temp2_type, S_IRUGO, show_temp_type, NULL, 1),
 	SENSOR_ATTR(temp3_type, S_IRUGO, show_temp_type, NULL, 2),
@@ -1180,6 +1200,8 @@ static void w83627ehf_device_remove_file
 	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
 		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
 	for (i = 0; i < data->in_num; i++) {
+		if ((i = 6) && data->in6_skip)
+			continue;
 		device_remove_file(dev, &sda_in_input[i].dev_attr);
 		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
 		device_remove_file(dev, &sda_in_min[i].dev_attr);
@@ -1191,15 +1213,22 @@ static void w83627ehf_device_remove_file
 		device_remove_file(dev, &sda_fan_div[i].dev_attr);
 		device_remove_file(dev, &sda_fan_min[i].dev_attr);
 	}
-	for (i = 0; i < 4; i++) {
+	for (i = 0; i < data->pwm_num; i++) {
 		device_remove_file(dev, &sda_pwm[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
 		device_remove_file(dev, &sda_target_temp[i].dev_attr);
 		device_remove_file(dev, &sda_tolerance[i].dev_attr);
 	}
-	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
-		device_remove_file(dev, &sda_temp[i].dev_attr);
+	for (i = 0; i < 3; i++) {
+		if(( i = 2) && data->temp3_disable)
+			continue;
+		device_remove_file(dev, &sda_temp_input[i].dev_attr);
+		device_remove_file(dev, &sda_temp_max[i].dev_attr);
+		device_remove_file(dev, &sda_temp_max_hyst[i].dev_attr);
+		device_remove_file(dev, &sda_temp_alarm[i].dev_attr);
+		device_remove_file(dev, &sda_temp_type[i].dev_attr);
+	}
 
 	device_remove_file(dev, &dev_attr_name);
 	device_remove_file(dev, &dev_attr_cpu0_vid);
@@ -1221,6 +1250,8 @@ static inline void __devinit w83627ehf_i
 	for (i = 0; i < 2; i++) {
 		tmp = w83627ehf_read_value(data,
 					   W83627EHF_REG_TEMP_CONFIG[i]);
+		if ((i = 1) && (data->in6_skip || data->temp3_disable))
+			continue;
 		if (tmp & 0x01)
 			w83627ehf_write_value(data,
 					      W83627EHF_REG_TEMP_CONFIG[i],
@@ -1271,8 +1302,16 @@ static int __devinit w83627ehf_probe(str
 	data->name = w83627ehf_device_names[sio_data->kind];
 	platform_set_drvdata(pdev, data);
 
-	/* 627EHG and 627EHF have 10 voltage inputs; DHG has 9 */
-	data->in_num = (sio_data->kind = w83627dhg) ? 9 : 10;
+	/* 627EHG and 627EHF have 10 voltage inputs; DHG and 667HG have 9 */
+	data->in_num = (sio_data->kind = w83627ehf) ? 10 : 9;
+	/* 667HG has 3 pwms */
+	data->pwm_num = (sio_data->kind = w83667hg) ? 3 : 4;
+
+	/* Check temp3 configuration bit for 667HG */
+	if (sio_data->kind = w83667hg) {
+		data->temp3_disable = w83627ehf_read_value(data, W83627EHF_REG_TEMP_CONFIG[1]) & 0x01;
+		data->in6_skip = !(w83627ehf_read_value(data, W83627EHF_REG_TEMP_CONFIG[1]) & 0x01);
+	}
 
 	/* Initialize the chip */
 	w83627ehf_init_device(data);
@@ -1280,44 +1319,60 @@ static int __devinit w83627ehf_probe(str
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
 
-	fan5pin = superio_inb(sio_data->sioreg, 0x24) & 0x2;
-	fan4pin = superio_inb(sio_data->sioreg, 0x29) & 0x6;
+	if (sio_data->kind = w83667hg) {
+		fan5pin = superio_inb(sio_data->sioreg, 0x27) & 0x20;
+		fan4pin = superio_inb(sio_data->sioreg, 0x27) & 0x40;
+	} else {			
+		fan5pin = !(superio_inb(sio_data->sioreg, 0x24) & 0x02);
+		fan4pin = !(superio_inb(sio_data->sioreg, 0x29) & 0x06);
+	}
 	superio_exit(sio_data->sioreg);
 
 	/* It looks like fan4 and fan5 pins can be alternatively used
@@ -1328,9 +1383,9 @@ static int __devinit w83627ehf_probe(str
 
 	data->has_fan = 0x07; /* fan1, fan2 and fan3 */
 	i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
-	if ((i & (1 << 2)) && (!fan4pin))
+	if ((i & (1 << 2)) && fan4pin)
 		data->has_fan |= (1 << 3);
-	if (!(i & (1 << 1)) && (!fan5pin))
+	if (!(i & (1 << 1)) && fan5pin)
 		data->has_fan |= (1 << 4);
 
 	/* Read fan clock dividers immediately */
@@ -1343,23 +1398,27 @@ static int __devinit w83627ehf_probe(str
 			goto exit_remove;
 
 	/* if fan4 is enabled create the sf3 files for it */
-	if (data->has_fan & (1 << 3))
+	if ((sio_data->kind != w83667hg) && 
+		(data->has_fan & (1 << 3)))
 		for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
 			if ((err = device_create_file(dev,
 				&sda_sf3_arrays_fan4[i].dev_attr)))
 				goto exit_remove;
 		}
 
-	for (i = 0; i < data->in_num; i++)
-		if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
-			|| (err = device_create_file(dev,
-				&sda_in_alarm[i].dev_attr))
-			|| (err = device_create_file(dev,
-				&sda_in_min[i].dev_attr))
-			|| (err = device_create_file(dev,
-				&sda_in_max[i].dev_attr)))
-			goto exit_remove;
-
+	for (i = 0; i < data->in_num; i++) {
+		if ((i = 6) && data->in6_skip) 
+			continue;
+		else
+			if ((err = device_create_file(dev, &sda_in_input[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_in_alarm[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_in_min[i].dev_attr))
+				|| (err = device_create_file(dev,
+					&sda_in_max[i].dev_attr)))
+				goto exit_remove;
+		}
 	for (i = 0; i < 5; i++) {
 		if (data->has_fan & (1 << i)) {
 			if ((err = device_create_file(dev,
@@ -1371,8 +1430,8 @@ static int __devinit w83627ehf_probe(str
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
@@ -1386,9 +1445,21 @@ static int __devinit w83627ehf_probe(str
 		}
 	}
 
-	for (i = 0; i < ARRAY_SIZE(sda_temp); i++)
-		if ((err = device_create_file(dev, &sda_temp[i].dev_attr)))
+	for (i = 0; i < 3; i++) {
+		if ( ( i = 2) && data->temp3_disable) 
+			continue;
+		if ((err = device_create_file(dev, 
+				&sda_temp_input[i].dev_attr))
+			|| (err = device_create_file(dev, 
+				&sda_temp_max[i].dev_attr))
+			|| (err = device_create_file(dev,
+				&sda_temp_max_hyst[i].dev_attr))
+			|| (err = device_create_file(dev,
+				&sda_temp_alarm[i].dev_attr))
+			|| (err = device_create_file(dev,
+				&sda_temp_type[i].dev_attr)))
 			goto exit_remove;
+	}
 
 	err = device_create_file(dev, &dev_attr_name);
 	if (err)
@@ -1441,6 +1512,7 @@ static int __init w83627ehf_find(int sio
 	static const char __initdata sio_name_W83627EHF[] = "W83627EHF";
 	static const char __initdata sio_name_W83627EHG[] = "W83627EHG";
 	static const char __initdata sio_name_W83627DHG[] = "W83627DHG";
+	static const char __initdata sio_name_W83667HG[] = "W83667HG";
 
 	u16 val;
 	const char *sio_name;
@@ -1465,6 +1537,10 @@ static int __init w83627ehf_find(int sio
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
