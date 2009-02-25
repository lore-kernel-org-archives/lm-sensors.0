From: <JGong@nuvoton.com>
Date: Wed, 25 Feb 2009 09:13:05 +0000
Subject: [lm-sensors]  W83667HG driver test for in6 and temp3
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E0020AE12@ntshml01.nuvoton.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C99729.445F2AD6"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C99729.445F2AD6
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear all,

>I suggest that you make a patch implementing what was said above. Then
>Michael will test it and we'll see which of in6 or temp3 will be
>created on his board. If in6 the problem is solved (as far as Michael's
>system is concerned, at least.) If the incorrect temp3 is displayed
>then we will have to think of a workaround. Either we check the
>temperature value and discard it if it looks unreasonable, or we let
>the user override the configuration manually as I initially proposed. I
>think I prefer the second option. Choosing the configuration based on
>the monitored values somehow voids the point of monitoring.
>Please make sure you include my fan fixes into your patch:
>http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025232.htm=
l

I've made the patch out with what we discussed above (including the fan =
fix from Jean). It has been tested on my ASUS P5QL PRO.

w83667hg-isa-0290
Adapter: ISA adapter
in0:         +1.01 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:         +1.69 V  (min =3D  +1.64 V, max =3D  +2.00 V)
in2:         +3.33 V  (min =3D  +3.14 V, max =3D  +3.47 V)
in3:         +3.30 V  (min =3D  +3.14 V, max =3D  +3.47 V)
in4:         +1.68 V  (min =3D  +0.02 V, max =3D  +0.35 V)   ALARM
in5:         +2.04 V  (min =3D  +0.26 V, max =3D  +1.03 V)   ALARM
in7:         +3.39 V  (min =3D  +3.14 V, max =3D  +3.47 V)
in8:         +3.28 V  (min =3D  +3.14 V, max =3D  +3.47 V)
fan1:          0 RPM  (min =3D 1318 RPM, div =3D 128)  ALARM
fan2:       1875 RPM  (min =3D 1704 RPM, div =3D 8)
fan3:          0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM
fan4:          0 RPM  (min =3D 5273 RPM, div =3D 128)  ALARM
fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
temp1:       +40.0=C2=B0C  (high =3D +45.0=C2=B0C, hyst =3D =
+40.0=C2=B0C)  sensor =3D thermistor
temp2:       +36.5=C2=B0C  (high =3D +45.0=C2=B0C, hyst =3D =
+40.0=C2=B0C)  sensor =3D diode
temp3:       +21.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D =
+75.0=C2=B0C)  sensor =3D thermistor
cpu0_vid:   +1.038 V


To Michael:
	Please try it on your platform. I am looking forward to your response.

Best regards,
Gong Jun


---
 w83627ehf.c |  150 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 99 insertions(+), 51 deletions(-)
---
--- w83627ehf.c.orig	2009-02-25 00:07:24.000000000 +0800
+++ w83627ehf.c	2009-02-26 00:41:58.000000000 +0800
@@ -36,6 +36,7 @@
     w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
                                                0x8860 0xa1
     w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
+    w83667hg     9      5       3       3      0xa510 0xc1    0x5ca3
 */
=20
 #include <linux/module.h>
@@ -51,12 +52,13 @@
 #include <asm/io.h>
 #include "lm75.h"
=20
-enum kinds { w83627ehf, w83627dhg };
+enum kinds { w83627ehf, w83627dhg, w83667hg};
=20
 /* used to set data->name =3D w83627ehf_device_names[data->sio_kind] */
 static const char * w83627ehf_device_names[] =3D {
 	"w83627ehf",
 	"w83627dhg",
+	"w83667hg",
 };
=20
 static unsigned short force_id;
@@ -70,6 +72,7 @@ MODULE_PARM_DESC(force_id, "Override the
  */
=20
 #define W83627EHF_LD_HWM	0x0b
+#define W83667HG_LD_VID 	0x0d
=20
 #define SIO_REG_LDSEL		0x07	/* Logical device select */
 #define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
@@ -82,6 +85,7 @@ MODULE_PARM_DESC(force_id, "Override the
 #define SIO_W83627EHF_ID	0x8850
 #define SIO_W83627EHG_ID	0x8860
 #define SIO_W83627DHG_ID	0xa020
+#define SIO_W83667HG_ID 	0xa510
 #define SIO_ID_MASK		0xFFF0
=20
 static inline void
@@ -288,6 +292,7 @@ struct w83627ehf_data {
 	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle =
*/
 	u8 pwm_enable[4]; /* 1->manual
 			     2->thermal cruise (also called SmartFan I) */
+	u8 pwm_num;		/* number of pwm */
 	u8 pwm[4];
 	u8 target_temp[4];
 	u8 tolerance[4];
@@ -297,6 +302,8 @@ struct w83627ehf_data {
=20
 	u8 vid;
 	u8 vrm;
+
+	u8 en_temp3;
 };
=20
 struct w83627ehf_sio_data {
@@ -1180,6 +1187,8 @@ static void w83627ehf_device_remove_file
 	for (i =3D 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
 		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
 	for (i =3D 0; i < data->in_num; i++) {
+		if ((i =3D=3D 6) && (!strcmp(data->name, "w83667hg")) && =
!data->en_temp3)
+			continue;
 		device_remove_file(dev, &sda_in_input[i].dev_attr);
 		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
 		device_remove_file(dev, &sda_in_min[i].dev_attr);
@@ -1191,15 +1200,19 @@ static void w83627ehf_device_remove_file
 		device_remove_file(dev, &sda_fan_div[i].dev_attr);
 		device_remove_file(dev, &sda_fan_min[i].dev_attr);
 	}
-	for (i =3D 0; i < 4; i++) {
+	for (i =3D 0; i < data->pwm_num; i++) {
 		device_remove_file(dev, &sda_pwm[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
 		device_remove_file(dev, &sda_target_temp[i].dev_attr);
 		device_remove_file(dev, &sda_tolerance[i].dev_attr);
 	}
-	for (i =3D 0; i < ARRAY_SIZE(sda_temp); i++)
+	for (i =3D 0; i < ARRAY_SIZE(sda_temp); i++) {
+		if (strstr(sda_temp[i].dev_attr.attr.name, "temp3")
+                	&& (!strcmp(data->name, "w83667hg")) && =
data->en_temp3)
+			continue;
 		device_remove_file(dev, &sda_temp[i].dev_attr);
+	}
=20
 	device_remove_file(dev, &dev_attr_name);
 	device_remove_file(dev, &dev_attr_cpu0_vid);
@@ -1219,6 +1232,8 @@ static inline void __devinit w83627ehf_i
=20
 	/* Enable temp2 and temp3 if needed */
 	for (i =3D 0; i < 2; i++) {
+		if (!strcmp(data->name, "w83667hg") && (i =3D=3D 1))
+			continue;
 		tmp =3D w83627ehf_read_value(data,
 					   W83627EHF_REG_TEMP_CONFIG[i]);
 		if (tmp & 0x01)
@@ -1271,8 +1286,10 @@ static int __devinit w83627ehf_probe(str
 	data->name =3D w83627ehf_device_names[sio_data->kind];
 	platform_set_drvdata(pdev, data);
=20
-	/* 627EHG and 627EHF have 10 voltage inputs; DHG has 9 */
-	data->in_num =3D (sio_data->kind =3D=3D w83627dhg) ? 9 : 10;
+	/* 627EHG and 627EHF have 10 voltage inputs; DHG and 667HG have 9 */
+	data->in_num =3D (sio_data->kind =3D=3D w83627ehf) ? 10 : 9;
+	/* 667HG has 3 pwms */
+	data->pwm_num =3D (sio_data->kind =3D=3D w83667hg) ? 3 : 4;
=20
 	/* Initialize the chip */
 	w83627ehf_init_device(data);
@@ -1280,44 +1297,60 @@ static int __devinit w83627ehf_probe(str
 	data->vrm =3D vid_which_vrm();
 	superio_enter(sio_data->sioreg);
 	/* Read VID value */
-	superio_select(sio_data->sioreg, W83627EHF_LD_HWM);
-	if (superio_inb(sio_data->sioreg, SIO_REG_VID_CTRL) & 0x80) {
-		/* Set VID input sensibility if needed. In theory the BIOS
-		   should have set it, but in practice it's not always the
-		   case. We only do it for the W83627EHF/EHG because the
-		   W83627DHG is more complex in this respect. */
-		if (sio_data->kind =3D=3D w83627ehf) {
-			en_vrm10 =3D superio_inb(sio_data->sioreg,
-					       SIO_REG_EN_VRM10);
-			if ((en_vrm10 & 0x08) && data->vrm =3D=3D 90) {
-				dev_warn(dev, "Setting VID input voltage to "
-					 "TTL\n");
-				superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
-					     en_vrm10 & ~0x08);
-			} else if (!(en_vrm10 & 0x08) && data->vrm =3D=3D 100) {
-				dev_warn(dev, "Setting VID input voltage to "
-					 "VRM10\n");
-				superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
-					     en_vrm10 | 0x08);
-			}
-		}
-
-		data->vid =3D superio_inb(sio_data->sioreg, SIO_REG_VID_DATA);
-		if (sio_data->kind =3D=3D w83627ehf) /* 6 VID pins only */
-			data->vid &=3D 0x3f;
-
+	if (sio_data->kind =3D=3D w83667hg) {
+		/* W83667HG has different pins for VID input and output, so=20
+ 		we can get the VID input values directly at logical device D
+		0xe3. */
+		superio_select(sio_data->sioreg, W83667HG_LD_VID);
+		data->vid =3D superio_inb(sio_data->sioreg, 0xe3);
 		err =3D device_create_file(dev, &dev_attr_cpu0_vid);
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
+			if (sio_data->kind =3D=3D w83627ehf) {
+				en_vrm10 =3D superio_inb(sio_data->sioreg,
+						       SIO_REG_EN_VRM10);
+				if ((en_vrm10 & 0x08) && data->vrm =3D=3D 90) {
+					dev_warn(dev, "Setting VID input voltage to "
+						 "TTL\n");
+					superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
+						     en_vrm10 & ~0x08);
+				} else if (!(en_vrm10 & 0x08) && data->vrm =3D=3D 100) {
+					dev_warn(dev, "Setting VID input voltage to "
+						 "VRM10\n");
+					superio_outb(sio_data->sioreg, SIO_REG_EN_VRM10,
+						     en_vrm10 | 0x08);
+				}
+			}
+
+			data->vid =3D superio_inb(sio_data->sioreg, SIO_REG_VID_DATA);
+			if (sio_data->kind =3D=3D w83627ehf) /* 6 VID pins only */
+				data->vid &=3D 0x3f;
+
+			err =3D device_create_file(dev, &dev_attr_cpu0_vid);
+			if (err)
+				goto exit_release;
+		} else {
+			dev_info(dev, "VID pins in output mode, CPU VID not "
+				 "available\n");
+		}
 	}
=20
 	/* fan4 and fan5 share some pins with the GPIO and serial flash */
=20
-	fan5pin =3D superio_inb(sio_data->sioreg, 0x24) & 0x2;
-	fan4pin =3D superio_inb(sio_data->sioreg, 0x29) & 0x6;
+	if (sio_data->kind =3D=3D w83667hg) {
+		fan5pin =3D superio_inb(sio_data->sioreg, 0x27) & 0x20;
+		fan4pin =3D superio_inb(sio_data->sioreg, 0x27) & 0x40;
+	} else {		=09
+		fan5pin =3D !(superio_inb(sio_data->sioreg, 0x24) & 0x02);
+		fan4pin =3D !(superio_inb(sio_data->sioreg, 0x29) & 0x06);
+	}
 	superio_exit(sio_data->sioreg);
=20
 	/* It looks like fan4 and fan5 pins can be alternatively used
@@ -1328,9 +1361,9 @@ static int __devinit w83627ehf_probe(str
=20
 	data->has_fan =3D 0x07; /* fan1, fan2 and fan3 */
 	i =3D w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
-	if ((i & (1 << 2)) && (!fan4pin))
+	if ((i & (1 << 2)) && fan4pin)
 		data->has_fan |=3D (1 << 3);
-	if (!(i & (1 << 1)) && (!fan5pin))
+	if (!(i & (1 << 1)) && fan5pin)
 		data->has_fan |=3D (1 << 4);
=20
 	/* Read fan clock dividers immediately */
@@ -1343,23 +1376,29 @@ static int __devinit w83627ehf_probe(str
 			goto exit_remove;
=20
 	/* if fan4 is enabled create the sf3 files for it */
-	if (data->has_fan & (1 << 3))
+	if ((sio_data->kind !=3D w83667hg) &&=20
+		(data->has_fan & (1 << 3)))
 		for (i =3D 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
 			if ((err =3D device_create_file(dev,
 				&sda_sf3_arrays_fan4[i].dev_attr)))
 				goto exit_remove;
 		}
+=09
+	data->en_temp3 =3D w83627ehf_read_value(data, =
W83627EHF_REG_TEMP_CONFIG[1]) & 0x01;
=20
-	for (i =3D 0; i < data->in_num; i++)
-		if ((err =3D device_create_file(dev, &sda_in_input[i].dev_attr))
-			|| (err =3D device_create_file(dev,
-				&sda_in_alarm[i].dev_attr))
-			|| (err =3D device_create_file(dev,
-				&sda_in_min[i].dev_attr))
-			|| (err =3D device_create_file(dev,
-				&sda_in_max[i].dev_attr)))
-			goto exit_remove;
-
+	for (i =3D 0; i < data->in_num; i++) {
+		if ((i =3D=3D 6) && (sio_data->kind =3D=3D w83667hg) && =
!data->en_temp3)=20
+			continue;
+		else
+			if ((err =3D device_create_file(dev, &sda_in_input[i].dev_attr))
+				|| (err =3D device_create_file(dev,
+					&sda_in_alarm[i].dev_attr))
+				|| (err =3D device_create_file(dev,
+					&sda_in_min[i].dev_attr))
+				|| (err =3D device_create_file(dev,
+					&sda_in_max[i].dev_attr)))
+				goto exit_remove;
+		}
 	for (i =3D 0; i < 5; i++) {
 		if (data->has_fan & (1 << i)) {
 			if ((err =3D device_create_file(dev,
@@ -1371,8 +1410,8 @@ static int __devinit w83627ehf_probe(str
 				|| (err =3D device_create_file(dev,
 					&sda_fan_min[i].dev_attr)))
 				goto exit_remove;
-			if (i < 4 && /* w83627ehf only has 4 pwm */
-				((err =3D device_create_file(dev,
+	if(i < data->pwm_num &&
+			((err =3D device_create_file(dev,
 					&sda_pwm[i].dev_attr))
 				|| (err =3D device_create_file(dev,
 					&sda_pwm_mode[i].dev_attr))
@@ -1386,9 +1425,13 @@ static int __devinit w83627ehf_probe(str
 		}
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(sda_temp); i++)
+	for (i =3D 0; i < ARRAY_SIZE(sda_temp); i++) {
+		if (strstr(sda_temp[i].dev_attr.attr.name, "temp3")
+			&& (sio_data->kind =3D=3D w83667hg) && data->en_temp3)=20
+			continue;
 		if ((err =3D device_create_file(dev, &sda_temp[i].dev_attr)))
 			goto exit_remove;
+	}
=20
 	err =3D device_create_file(dev, &dev_attr_name);
 	if (err)
@@ -1441,6 +1484,7 @@ static int __init w83627ehf_find(int sio
 	static const char __initdata sio_name_W83627EHF[] =3D "W83627EHF";
 	static const char __initdata sio_name_W83627EHG[] =3D "W83627EHG";
 	static const char __initdata sio_name_W83627DHG[] =3D "W83627DHG";
+	static const char __initdata sio_name_W83667HG[] =3D "W83667HG";
=20
 	u16 val;
 	const char *sio_name;
@@ -1465,6 +1509,10 @@ static int __init w83627ehf_find(int sio
 		sio_data->kind =3D w83627dhg;
 		sio_name =3D sio_name_W83627DHG;
 		break;
+	case SIO_W83667HG_ID:
+		sio_data->kind =3D w83667hg;
+		sio_name =3D sio_name_W83667HG;
+		break;
 	default:
 		if (val !=3D 0xffff)
 			pr_debug(DRVNAME ": unsupported chip ID: 0x%04x\n",



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The privileged confidential information contained in this email is =
intended for use only by the addressees as indicated by the original =
sender of this email. If you are not the addressee indicated in this =
email or are not responsible for delivery of the email to such  a =
person, please kindly reply to the sender indicating this fact and =
delete all copies of it from your computer and network server =
immediately. Your cooperation is highly appreciated. It is advised that =
any unauthorized use of confidential information of Nuvoton is strictly =
prohibited; and any information in this email irrelevant to the official =
business of Nuvoton shall be deemed as neither given nor endorsed by =
Nuvoton.

------_=_NextPart_001_01C99729.445F2AD6
Content-Type: application/octet-stream;
	name="hwmon-add-support-for-w83667hg-in-w83627ehf-driver-test-in6-temp3.patch"
Content-Transfer-Encoding: base64
Content-Description: hwmon-add-support-for-w83667hg-in-w83627ehf-driver-test-in6-temp3.patch
Content-Disposition: attachment;
	filename="hwmon-add-support-for-w83667hg-in-w83627ehf-driver-test-in6-temp3.patch"

LS0tCiB3ODM2MjdlaGYuYyB8ICAxNTAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA5OSBpbnNlcnRpb25zKCspLCA1MSBk
ZWxldGlvbnMoLSkKLS0tCi0tLSB3ODM2MjdlaGYuYy5vcmlnCTIwMDktMDItMjUgMDA6MDc6MjQu
MDAwMDAwMDAwICswODAwCisrKyB3ODM2MjdlaGYuYwkyMDA5LTAyLTI2IDAwOjQxOjU4LjAwMDAw
MDAwMCArMDgwMApAQCAtMzYsNiArMzYsNyBAQAogICAgIHc4MzYyN2VoZiAgIDEwICAgICAgNSAg
ICAgICA0ICAgICAgIDMgICAgICAweDg4NTAgMHg4OCAgICAweDVjYTMKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHg4ODYwIDB4YTEKICAgICB3ODM2Mjdk
aGcgICAgOSAgICAgIDUgICAgICAgNCAgICAgICAzICAgICAgMHhhMDIwIDB4YzEgICAgMHg1Y2Ez
CisgICAgdzgzNjY3aGcgICAgIDkgICAgICA1ICAgICAgIDMgICAgICAgMyAgICAgIDB4YTUxMCAw
eGMxICAgIDB4NWNhMwogKi8KIAogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgpAQCAtNTEsMTIg
KzUyLDEzIEBACiAjaW5jbHVkZSA8YXNtL2lvLmg+CiAjaW5jbHVkZSAibG03NS5oIgogCi1lbnVt
IGtpbmRzIHsgdzgzNjI3ZWhmLCB3ODM2MjdkaGcgfTsKK2VudW0ga2luZHMgeyB3ODM2MjdlaGYs
IHc4MzYyN2RoZywgdzgzNjY3aGd9OwogCiAvKiB1c2VkIHRvIHNldCBkYXRhLT5uYW1lID0gdzgz
NjI3ZWhmX2RldmljZV9uYW1lc1tkYXRhLT5zaW9fa2luZF0gKi8KIHN0YXRpYyBjb25zdCBjaGFy
ICogdzgzNjI3ZWhmX2RldmljZV9uYW1lc1tdID0gewogCSJ3ODM2MjdlaGYiLAogCSJ3ODM2Mjdk
aGciLAorCSJ3ODM2NjdoZyIsCiB9OwogCiBzdGF0aWMgdW5zaWduZWQgc2hvcnQgZm9yY2VfaWQ7
CkBAIC03MCw2ICs3Miw3IEBAIE1PRFVMRV9QQVJNX0RFU0MoZm9yY2VfaWQsICJPdmVycmlkZSB0
aGUKICAqLwogCiAjZGVmaW5lIFc4MzYyN0VIRl9MRF9IV00JMHgwYgorI2RlZmluZSBXODM2NjdI
R19MRF9WSUQgCTB4MGQKIAogI2RlZmluZSBTSU9fUkVHX0xEU0VMCQkweDA3CS8qIExvZ2ljYWwg
ZGV2aWNlIHNlbGVjdCAqLwogI2RlZmluZSBTSU9fUkVHX0RFVklECQkweDIwCS8qIERldmljZSBJ
RCAoMiBieXRlcykgKi8KQEAgLTgyLDYgKzg1LDcgQEAgTU9EVUxFX1BBUk1fREVTQyhmb3JjZV9p
ZCwgIk92ZXJyaWRlIHRoZQogI2RlZmluZSBTSU9fVzgzNjI3RUhGX0lECTB4ODg1MAogI2RlZmlu
ZSBTSU9fVzgzNjI3RUhHX0lECTB4ODg2MAogI2RlZmluZSBTSU9fVzgzNjI3REhHX0lECTB4YTAy
MAorI2RlZmluZSBTSU9fVzgzNjY3SEdfSUQgCTB4YTUxMAogI2RlZmluZSBTSU9fSURfTUFTSwkJ
MHhGRkYwCiAKIHN0YXRpYyBpbmxpbmUgdm9pZApAQCAtMjg4LDYgKzI5Miw3IEBAIHN0cnVjdCB3
ODM2MjdlaGZfZGF0YSB7CiAJdTggcHdtX21vZGVbNF07IC8qIDAtPkRDIHZhcmlhYmxlIHZvbHRh
Z2UsIDEtPlBXTSB2YXJpYWJsZSBkdXR5IGN5Y2xlICovCiAJdTggcHdtX2VuYWJsZVs0XTsgLyog
MS0+bWFudWFsCiAJCQkgICAgIDItPnRoZXJtYWwgY3J1aXNlIChhbHNvIGNhbGxlZCBTbWFydEZh
biBJKSAqLworCXU4IHB3bV9udW07CQkvKiBudW1iZXIgb2YgcHdtICovCiAJdTggcHdtWzRdOwog
CXU4IHRhcmdldF90ZW1wWzRdOwogCXU4IHRvbGVyYW5jZVs0XTsKQEAgLTI5Nyw2ICszMDIsOCBA
QCBzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgewogCiAJdTggdmlkOwogCXU4IHZybTsKKworCXU4IGVu
X3RlbXAzOwogfTsKIAogc3RydWN0IHc4MzYyN2VoZl9zaW9fZGF0YSB7CkBAIC0xMTgwLDYgKzEx
ODcsOCBAQCBzdGF0aWMgdm9pZCB3ODM2MjdlaGZfZGV2aWNlX3JlbW92ZV9maWxlCiAJZm9yIChp
ID0gMDsgaSA8IEFSUkFZX1NJWkUoc2RhX3NmM19hcnJheXNfZmFuNCk7IGkrKykKIAkJZGV2aWNl
X3JlbW92ZV9maWxlKGRldiwgJnNkYV9zZjNfYXJyYXlzX2ZhbjRbaV0uZGV2X2F0dHIpOwogCWZv
ciAoaSA9IDA7IGkgPCBkYXRhLT5pbl9udW07IGkrKykgeworCQlpZiAoKGkgPT0gNikgJiYgKCFz
dHJjbXAoZGF0YS0+bmFtZSwgInc4MzY2N2hnIikpICYmICFkYXRhLT5lbl90ZW1wMykKKwkJCWNv
bnRpbnVlOwogCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmc2RhX2luX2lucHV0W2ldLmRldl9h
dHRyKTsKIAkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJnNkYV9pbl9hbGFybVtpXS5kZXZfYXR0
cik7CiAJCWRldmljZV9yZW1vdmVfZmlsZShkZXYsICZzZGFfaW5fbWluW2ldLmRldl9hdHRyKTsK
QEAgLTExOTEsMTUgKzEyMDAsMTkgQEAgc3RhdGljIHZvaWQgdzgzNjI3ZWhmX2RldmljZV9yZW1v
dmVfZmlsZQogCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmc2RhX2Zhbl9kaXZbaV0uZGV2X2F0
dHIpOwogCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmc2RhX2Zhbl9taW5baV0uZGV2X2F0dHIp
OwogCX0KLQlmb3IgKGkgPSAwOyBpIDwgNDsgaSsrKSB7CisJZm9yIChpID0gMDsgaSA8IGRhdGEt
PnB3bV9udW07IGkrKykgewogCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmc2RhX3B3bVtpXS5k
ZXZfYXR0cik7CiAJCWRldmljZV9yZW1vdmVfZmlsZShkZXYsICZzZGFfcHdtX21vZGVbaV0uZGV2
X2F0dHIpOwogCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmc2RhX3B3bV9lbmFibGVbaV0uZGV2
X2F0dHIpOwogCQlkZXZpY2VfcmVtb3ZlX2ZpbGUoZGV2LCAmc2RhX3RhcmdldF90ZW1wW2ldLmRl
dl9hdHRyKTsKIAkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJnNkYV90b2xlcmFuY2VbaV0uZGV2
X2F0dHIpOwogCX0KLQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzZGFfdGVtcCk7IGkrKykK
Kwlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzZGFfdGVtcCk7IGkrKykgeworCQlpZiAoc3Ry
c3RyKHNkYV90ZW1wW2ldLmRldl9hdHRyLmF0dHIubmFtZSwgInRlbXAzIikKKyAgICAgICAgICAg
ICAgICAJJiYgKCFzdHJjbXAoZGF0YS0+bmFtZSwgInc4MzY2N2hnIikpICYmIGRhdGEtPmVuX3Rl
bXAzKQorCQkJY29udGludWU7CiAJCWRldmljZV9yZW1vdmVfZmlsZShkZXYsICZzZGFfdGVtcFtp
XS5kZXZfYXR0cik7CisJfQogCiAJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJmRldl9hdHRyX25h
bWUpOwogCWRldmljZV9yZW1vdmVfZmlsZShkZXYsICZkZXZfYXR0cl9jcHUwX3ZpZCk7CkBAIC0x
MjE5LDYgKzEyMzIsOCBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX19kZXZpbml0IHc4MzYyN2VoZl9p
CiAKIAkvKiBFbmFibGUgdGVtcDIgYW5kIHRlbXAzIGlmIG5lZWRlZCAqLwogCWZvciAoaSA9IDA7
IGkgPCAyOyBpKyspIHsKKwkJaWYgKCFzdHJjbXAoZGF0YS0+bmFtZSwgInc4MzY2N2hnIikgJiYg
KGkgPT0gMSkpCisJCQljb250aW51ZTsKIAkJdG1wID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoZGF0
YSwKIAkJCQkJICAgVzgzNjI3RUhGX1JFR19URU1QX0NPTkZJR1tpXSk7CiAJCWlmICh0bXAgJiAw
eDAxKQpAQCAtMTI3MSw4ICsxMjg2LDEwIEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHc4MzYyN2Vo
Zl9wcm9iZShzdHIKIAlkYXRhLT5uYW1lID0gdzgzNjI3ZWhmX2RldmljZV9uYW1lc1tzaW9fZGF0
YS0+a2luZF07CiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgZGF0YSk7CiAKLQkvKiA2MjdF
SEcgYW5kIDYyN0VIRiBoYXZlIDEwIHZvbHRhZ2UgaW5wdXRzOyBESEcgaGFzIDkgKi8KLQlkYXRh
LT5pbl9udW0gPSAoc2lvX2RhdGEtPmtpbmQgPT0gdzgzNjI3ZGhnKSA/IDkgOiAxMDsKKwkvKiA2
MjdFSEcgYW5kIDYyN0VIRiBoYXZlIDEwIHZvbHRhZ2UgaW5wdXRzOyBESEcgYW5kIDY2N0hHIGhh
dmUgOSAqLworCWRhdGEtPmluX251bSA9IChzaW9fZGF0YS0+a2luZCA9PSB3ODM2MjdlaGYpID8g
MTAgOiA5OworCS8qIDY2N0hHIGhhcyAzIHB3bXMgKi8KKwlkYXRhLT5wd21fbnVtID0gKHNpb19k
YXRhLT5raW5kID09IHc4MzY2N2hnKSA/IDMgOiA0OwogCiAJLyogSW5pdGlhbGl6ZSB0aGUgY2hp
cCAqLwogCXc4MzYyN2VoZl9pbml0X2RldmljZShkYXRhKTsKQEAgLTEyODAsNDQgKzEyOTcsNjAg
QEAgc3RhdGljIGludCBfX2RldmluaXQgdzgzNjI3ZWhmX3Byb2JlKHN0cgogCWRhdGEtPnZybSA9
IHZpZF93aGljaF92cm0oKTsKIAlzdXBlcmlvX2VudGVyKHNpb19kYXRhLT5zaW9yZWcpOwogCS8q
IFJlYWQgVklEIHZhbHVlICovCi0Jc3VwZXJpb19zZWxlY3Qoc2lvX2RhdGEtPnNpb3JlZywgVzgz
NjI3RUhGX0xEX0hXTSk7Ci0JaWYgKHN1cGVyaW9faW5iKHNpb19kYXRhLT5zaW9yZWcsIFNJT19S
RUdfVklEX0NUUkwpICYgMHg4MCkgewotCQkvKiBTZXQgVklEIGlucHV0IHNlbnNpYmlsaXR5IGlm
IG5lZWRlZC4gSW4gdGhlb3J5IHRoZSBCSU9TCi0JCSAgIHNob3VsZCBoYXZlIHNldCBpdCwgYnV0
IGluIHByYWN0aWNlIGl0J3Mgbm90IGFsd2F5cyB0aGUKLQkJICAgY2FzZS4gV2Ugb25seSBkbyBp
dCBmb3IgdGhlIFc4MzYyN0VIRi9FSEcgYmVjYXVzZSB0aGUKLQkJICAgVzgzNjI3REhHIGlzIG1v
cmUgY29tcGxleCBpbiB0aGlzIHJlc3BlY3QuICovCi0JCWlmIChzaW9fZGF0YS0+a2luZCA9PSB3
ODM2MjdlaGYpIHsKLQkJCWVuX3ZybTEwID0gc3VwZXJpb19pbmIoc2lvX2RhdGEtPnNpb3JlZywK
LQkJCQkJICAgICAgIFNJT19SRUdfRU5fVlJNMTApOwotCQkJaWYgKChlbl92cm0xMCAmIDB4MDgp
ICYmIGRhdGEtPnZybSA9PSA5MCkgewotCQkJCWRldl93YXJuKGRldiwgIlNldHRpbmcgVklEIGlu
cHV0IHZvbHRhZ2UgdG8gIgotCQkJCQkgIlRUTFxuIik7Ci0JCQkJc3VwZXJpb19vdXRiKHNpb19k
YXRhLT5zaW9yZWcsIFNJT19SRUdfRU5fVlJNMTAsCi0JCQkJCSAgICAgZW5fdnJtMTAgJiB+MHgw
OCk7Ci0JCQl9IGVsc2UgaWYgKCEoZW5fdnJtMTAgJiAweDA4KSAmJiBkYXRhLT52cm0gPT0gMTAw
KSB7Ci0JCQkJZGV2X3dhcm4oZGV2LCAiU2V0dGluZyBWSUQgaW5wdXQgdm9sdGFnZSB0byAiCi0J
CQkJCSAiVlJNMTBcbiIpOwotCQkJCXN1cGVyaW9fb3V0YihzaW9fZGF0YS0+c2lvcmVnLCBTSU9f
UkVHX0VOX1ZSTTEwLAotCQkJCQkgICAgIGVuX3ZybTEwIHwgMHgwOCk7Ci0JCQl9Ci0JCX0KLQot
CQlkYXRhLT52aWQgPSBzdXBlcmlvX2luYihzaW9fZGF0YS0+c2lvcmVnLCBTSU9fUkVHX1ZJRF9E
QVRBKTsKLQkJaWYgKHNpb19kYXRhLT5raW5kID09IHc4MzYyN2VoZikgLyogNiBWSUQgcGlucyBv
bmx5ICovCi0JCQlkYXRhLT52aWQgJj0gMHgzZjsKLQorCWlmIChzaW9fZGF0YS0+a2luZCA9PSB3
ODM2NjdoZykgeworCQkvKiBXODM2NjdIRyBoYXMgZGlmZmVyZW50IHBpbnMgZm9yIFZJRCBpbnB1
dCBhbmQgb3V0cHV0LCBzbyAKKyAJCXdlIGNhbiBnZXQgdGhlIFZJRCBpbnB1dCB2YWx1ZXMgZGly
ZWN0bHkgYXQgbG9naWNhbCBkZXZpY2UgRAorCQkweGUzLiAqLworCQlzdXBlcmlvX3NlbGVjdChz
aW9fZGF0YS0+c2lvcmVnLCBXODM2NjdIR19MRF9WSUQpOworCQlkYXRhLT52aWQgPSBzdXBlcmlv
X2luYihzaW9fZGF0YS0+c2lvcmVnLCAweGUzKTsKIAkJZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxl
KGRldiwgJmRldl9hdHRyX2NwdTBfdmlkKTsKIAkJaWYgKGVycikKIAkJCWdvdG8gZXhpdF9yZWxl
YXNlOwogCX0gZWxzZSB7Ci0JCWRldl9pbmZvKGRldiwgIlZJRCBwaW5zIGluIG91dHB1dCBtb2Rl
LCBDUFUgVklEIG5vdCAiCi0JCQkgImF2YWlsYWJsZVxuIik7CisJCXN1cGVyaW9fc2VsZWN0KHNp
b19kYXRhLT5zaW9yZWcsIFc4MzYyN0VIRl9MRF9IV00pOworCQlpZiAoc3VwZXJpb19pbmIoc2lv
X2RhdGEtPnNpb3JlZywgU0lPX1JFR19WSURfQ1RSTCkgJiAweDgwKSB7CisJCQkvKiBTZXQgVklE
IGlucHV0IHNlbnNpYmlsaXR5IGlmIG5lZWRlZC4gSW4gdGhlb3J5IHRoZSBCSU9TCisJCQkgICBz
aG91bGQgaGF2ZSBzZXQgaXQsIGJ1dCBpbiBwcmFjdGljZSBpdCdzIG5vdCBhbHdheXMgdGhlCisJ
CQkgICBjYXNlLiBXZSBvbmx5IGRvIGl0IGZvciB0aGUgVzgzNjI3RUhGL0VIRyBiZWNhdXNlIHRo
ZQorCQkJICAgVzgzNjI3REhHIGlzIG1vcmUgY29tcGxleCBpbiB0aGlzIHJlc3BlY3QuICovCisJ
CQlpZiAoc2lvX2RhdGEtPmtpbmQgPT0gdzgzNjI3ZWhmKSB7CisJCQkJZW5fdnJtMTAgPSBzdXBl
cmlvX2luYihzaW9fZGF0YS0+c2lvcmVnLAorCQkJCQkJICAgICAgIFNJT19SRUdfRU5fVlJNMTAp
OworCQkJCWlmICgoZW5fdnJtMTAgJiAweDA4KSAmJiBkYXRhLT52cm0gPT0gOTApIHsKKwkJCQkJ
ZGV2X3dhcm4oZGV2LCAiU2V0dGluZyBWSUQgaW5wdXQgdm9sdGFnZSB0byAiCisJCQkJCQkgIlRU
TFxuIik7CisJCQkJCXN1cGVyaW9fb3V0YihzaW9fZGF0YS0+c2lvcmVnLCBTSU9fUkVHX0VOX1ZS
TTEwLAorCQkJCQkJICAgICBlbl92cm0xMCAmIH4weDA4KTsKKwkJCQl9IGVsc2UgaWYgKCEoZW5f
dnJtMTAgJiAweDA4KSAmJiBkYXRhLT52cm0gPT0gMTAwKSB7CisJCQkJCWRldl93YXJuKGRldiwg
IlNldHRpbmcgVklEIGlucHV0IHZvbHRhZ2UgdG8gIgorCQkJCQkJICJWUk0xMFxuIik7CisJCQkJ
CXN1cGVyaW9fb3V0YihzaW9fZGF0YS0+c2lvcmVnLCBTSU9fUkVHX0VOX1ZSTTEwLAorCQkJCQkJ
ICAgICBlbl92cm0xMCB8IDB4MDgpOworCQkJCX0KKwkJCX0KKworCQkJZGF0YS0+dmlkID0gc3Vw
ZXJpb19pbmIoc2lvX2RhdGEtPnNpb3JlZywgU0lPX1JFR19WSURfREFUQSk7CisJCQlpZiAoc2lv
X2RhdGEtPmtpbmQgPT0gdzgzNjI3ZWhmKSAvKiA2IFZJRCBwaW5zIG9ubHkgKi8KKwkJCQlkYXRh
LT52aWQgJj0gMHgzZjsKKworCQkJZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwgJmRldl9h
dHRyX2NwdTBfdmlkKTsKKwkJCWlmIChlcnIpCisJCQkJZ290byBleGl0X3JlbGVhc2U7CisJCX0g
ZWxzZSB7CisJCQlkZXZfaW5mbyhkZXYsICJWSUQgcGlucyBpbiBvdXRwdXQgbW9kZSwgQ1BVIFZJ
RCBub3QgIgorCQkJCSAiYXZhaWxhYmxlXG4iKTsKKwkJfQogCX0KIAogCS8qIGZhbjQgYW5kIGZh
bjUgc2hhcmUgc29tZSBwaW5zIHdpdGggdGhlIEdQSU8gYW5kIHNlcmlhbCBmbGFzaCAqLwogCi0J
ZmFuNXBpbiA9IHN1cGVyaW9faW5iKHNpb19kYXRhLT5zaW9yZWcsIDB4MjQpICYgMHgyOwotCWZh
bjRwaW4gPSBzdXBlcmlvX2luYihzaW9fZGF0YS0+c2lvcmVnLCAweDI5KSAmIDB4NjsKKwlpZiAo
c2lvX2RhdGEtPmtpbmQgPT0gdzgzNjY3aGcpIHsKKwkJZmFuNXBpbiA9IHN1cGVyaW9faW5iKHNp
b19kYXRhLT5zaW9yZWcsIDB4MjcpICYgMHgyMDsKKwkJZmFuNHBpbiA9IHN1cGVyaW9faW5iKHNp
b19kYXRhLT5zaW9yZWcsIDB4MjcpICYgMHg0MDsKKwl9IGVsc2UgewkJCQorCQlmYW41cGluID0g
IShzdXBlcmlvX2luYihzaW9fZGF0YS0+c2lvcmVnLCAweDI0KSAmIDB4MDIpOworCQlmYW40cGlu
ID0gIShzdXBlcmlvX2luYihzaW9fZGF0YS0+c2lvcmVnLCAweDI5KSAmIDB4MDYpOworCX0KIAlz
dXBlcmlvX2V4aXQoc2lvX2RhdGEtPnNpb3JlZyk7CiAKIAkvKiBJdCBsb29rcyBsaWtlIGZhbjQg
YW5kIGZhbjUgcGlucyBjYW4gYmUgYWx0ZXJuYXRpdmVseSB1c2VkCkBAIC0xMzI4LDkgKzEzNjEs
OSBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCB3ODM2MjdlaGZfcHJvYmUoc3RyCiAKIAlkYXRhLT5o
YXNfZmFuID0gMHgwNzsgLyogZmFuMSwgZmFuMiBhbmQgZmFuMyAqLwogCWkgPSB3ODM2MjdlaGZf
cmVhZF92YWx1ZShkYXRhLCBXODM2MjdFSEZfUkVHX0ZBTkRJVjEpOwotCWlmICgoaSAmICgxIDw8
IDIpKSAmJiAoIWZhbjRwaW4pKQorCWlmICgoaSAmICgxIDw8IDIpKSAmJiBmYW40cGluKQogCQlk
YXRhLT5oYXNfZmFuIHw9ICgxIDw8IDMpOwotCWlmICghKGkgJiAoMSA8PCAxKSkgJiYgKCFmYW41
cGluKSkKKwlpZiAoIShpICYgKDEgPDwgMSkpICYmIGZhbjVwaW4pCiAJCWRhdGEtPmhhc19mYW4g
fD0gKDEgPDwgNCk7CiAKIAkvKiBSZWFkIGZhbiBjbG9jayBkaXZpZGVycyBpbW1lZGlhdGVseSAq
LwpAQCAtMTM0MywyMyArMTM3NiwyOSBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCB3ODM2MjdlaGZf
cHJvYmUoc3RyCiAJCQlnb3RvIGV4aXRfcmVtb3ZlOwogCiAJLyogaWYgZmFuNCBpcyBlbmFibGVk
IGNyZWF0ZSB0aGUgc2YzIGZpbGVzIGZvciBpdCAqLwotCWlmIChkYXRhLT5oYXNfZmFuICYgKDEg
PDwgMykpCisJaWYgKChzaW9fZGF0YS0+a2luZCAhPSB3ODM2NjdoZykgJiYgCisJCShkYXRhLT5o
YXNfZmFuICYgKDEgPDwgMykpKQogCQlmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShzZGFfc2Yz
X2FycmF5c19mYW40KTsgaSsrKSB7CiAJCQlpZiAoKGVyciA9IGRldmljZV9jcmVhdGVfZmlsZShk
ZXYsCiAJCQkJJnNkYV9zZjNfYXJyYXlzX2ZhbjRbaV0uZGV2X2F0dHIpKSkKIAkJCQlnb3RvIGV4
aXRfcmVtb3ZlOwogCQl9CisJCisJZGF0YS0+ZW5fdGVtcDMgPSB3ODM2MjdlaGZfcmVhZF92YWx1
ZShkYXRhLCBXODM2MjdFSEZfUkVHX1RFTVBfQ09ORklHWzFdKSAmIDB4MDE7CiAKLQlmb3IgKGkg
PSAwOyBpIDwgZGF0YS0+aW5fbnVtOyBpKyspCi0JCWlmICgoZXJyID0gZGV2aWNlX2NyZWF0ZV9m
aWxlKGRldiwgJnNkYV9pbl9pbnB1dFtpXS5kZXZfYXR0cikpCi0JCQl8fCAoZXJyID0gZGV2aWNl
X2NyZWF0ZV9maWxlKGRldiwKLQkJCQkmc2RhX2luX2FsYXJtW2ldLmRldl9hdHRyKSkKLQkJCXx8
IChlcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LAotCQkJCSZzZGFfaW5fbWluW2ldLmRldl9h
dHRyKSkKLQkJCXx8IChlcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LAotCQkJCSZzZGFfaW5f
bWF4W2ldLmRldl9hdHRyKSkpCi0JCQlnb3RvIGV4aXRfcmVtb3ZlOwotCisJZm9yIChpID0gMDsg
aSA8IGRhdGEtPmluX251bTsgaSsrKSB7CisJCWlmICgoaSA9PSA2KSAmJiAoc2lvX2RhdGEtPmtp
bmQgPT0gdzgzNjY3aGcpICYmICFkYXRhLT5lbl90ZW1wMykgCisJCQljb250aW51ZTsKKwkJZWxz
ZQorCQkJaWYgKChlcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LCAmc2RhX2luX2lucHV0W2ld
LmRldl9hdHRyKSkKKwkJCQl8fCAoZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwKKwkJCQkJ
JnNkYV9pbl9hbGFybVtpXS5kZXZfYXR0cikpCisJCQkJfHwgKGVyciA9IGRldmljZV9jcmVhdGVf
ZmlsZShkZXYsCisJCQkJCSZzZGFfaW5fbWluW2ldLmRldl9hdHRyKSkKKwkJCQl8fCAoZXJyID0g
ZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwKKwkJCQkJJnNkYV9pbl9tYXhbaV0uZGV2X2F0dHIpKSkK
KwkJCQlnb3RvIGV4aXRfcmVtb3ZlOworCQl9CiAJZm9yIChpID0gMDsgaSA8IDU7IGkrKykgewog
CQlpZiAoZGF0YS0+aGFzX2ZhbiAmICgxIDw8IGkpKSB7CiAJCQlpZiAoKGVyciA9IGRldmljZV9j
cmVhdGVfZmlsZShkZXYsCkBAIC0xMzcxLDggKzE0MTAsOCBAQCBzdGF0aWMgaW50IF9fZGV2aW5p
dCB3ODM2MjdlaGZfcHJvYmUoc3RyCiAJCQkJfHwgKGVyciA9IGRldmljZV9jcmVhdGVfZmlsZShk
ZXYsCiAJCQkJCSZzZGFfZmFuX21pbltpXS5kZXZfYXR0cikpKQogCQkJCWdvdG8gZXhpdF9yZW1v
dmU7Ci0JCQlpZiAoaSA8IDQgJiYgLyogdzgzNjI3ZWhmIG9ubHkgaGFzIDQgcHdtICovCi0JCQkJ
KChlcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LAorCWlmKGkgPCBkYXRhLT5wd21fbnVtICYm
CisJCQkoKGVyciA9IGRldmljZV9jcmVhdGVfZmlsZShkZXYsCiAJCQkJCSZzZGFfcHdtW2ldLmRl
dl9hdHRyKSkKIAkJCQl8fCAoZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwKIAkJCQkJJnNk
YV9wd21fbW9kZVtpXS5kZXZfYXR0cikpCkBAIC0xMzg2LDkgKzE0MjUsMTMgQEAgc3RhdGljIGlu
dCBfX2RldmluaXQgdzgzNjI3ZWhmX3Byb2JlKHN0cgogCQl9CiAJfQogCi0JZm9yIChpID0gMDsg
aSA8IEFSUkFZX1NJWkUoc2RhX3RlbXApOyBpKyspCisJZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJ
WkUoc2RhX3RlbXApOyBpKyspIHsKKwkJaWYgKHN0cnN0cihzZGFfdGVtcFtpXS5kZXZfYXR0ci5h
dHRyLm5hbWUsICJ0ZW1wMyIpCisJCQkmJiAoc2lvX2RhdGEtPmtpbmQgPT0gdzgzNjY3aGcpICYm
IGRhdGEtPmVuX3RlbXAzKSAKKwkJCWNvbnRpbnVlOwogCQlpZiAoKGVyciA9IGRldmljZV9jcmVh
dGVfZmlsZShkZXYsICZzZGFfdGVtcFtpXS5kZXZfYXR0cikpKQogCQkJZ290byBleGl0X3JlbW92
ZTsKKwl9CiAKIAllcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LCAmZGV2X2F0dHJfbmFtZSk7
CiAJaWYgKGVycikKQEAgLTE0NDEsNiArMTQ4NCw3IEBAIHN0YXRpYyBpbnQgX19pbml0IHc4MzYy
N2VoZl9maW5kKGludCBzaW8KIAlzdGF0aWMgY29uc3QgY2hhciBfX2luaXRkYXRhIHNpb19uYW1l
X1c4MzYyN0VIRltdID0gIlc4MzYyN0VIRiI7CiAJc3RhdGljIGNvbnN0IGNoYXIgX19pbml0ZGF0
YSBzaW9fbmFtZV9XODM2MjdFSEdbXSA9ICJXODM2MjdFSEciOwogCXN0YXRpYyBjb25zdCBjaGFy
IF9faW5pdGRhdGEgc2lvX25hbWVfVzgzNjI3REhHW10gPSAiVzgzNjI3REhHIjsKKwlzdGF0aWMg
Y29uc3QgY2hhciBfX2luaXRkYXRhIHNpb19uYW1lX1c4MzY2N0hHW10gPSAiVzgzNjY3SEciOwog
CiAJdTE2IHZhbDsKIAljb25zdCBjaGFyICpzaW9fbmFtZTsKQEAgLTE0NjUsNiArMTUwOSwxMCBA
QCBzdGF0aWMgaW50IF9faW5pdCB3ODM2MjdlaGZfZmluZChpbnQgc2lvCiAJCXNpb19kYXRhLT5r
aW5kID0gdzgzNjI3ZGhnOwogCQlzaW9fbmFtZSA9IHNpb19uYW1lX1c4MzYyN0RIRzsKIAkJYnJl
YWs7CisJY2FzZSBTSU9fVzgzNjY3SEdfSUQ6CisJCXNpb19kYXRhLT5raW5kID0gdzgzNjY3aGc7
CisJCXNpb19uYW1lID0gc2lvX25hbWVfVzgzNjY3SEc7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJ
CWlmICh2YWwgIT0gMHhmZmZmKQogCQkJcHJfZGVidWcoRFJWTkFNRSAiOiB1bnN1cHBvcnRlZCBj
aGlwIElEOiAweCUwNHhcbiIsCg==

------_=_NextPart_001_01C99729.445F2AD6
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------_=_NextPart_001_01C99729.445F2AD6--
