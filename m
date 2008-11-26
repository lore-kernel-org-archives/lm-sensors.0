From: <JGong@nuvoton.com>
Date: Wed, 26 Nov 2008 07:39:19 +0000
Subject: [lm-sensors] hwmon: add support for w83667hg
Message-Id: <29CFBC9A3FDC81418F5FACEEC8970E0020ADD2@ntshml01.nuvoton.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C94F9A.17406A6B"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C94F9A.17406A6B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear all,

	This patch adds support for the Nuvoton w83667hg chip to the w83627ehf =
driver. It has been tested on ASUS P5QL PRO by Gong Jun.

Best regards,
Gong Jun

Signed-off-by: Gong Jun <JGong@nuvoton.com>
---
 w83627ehf.c |  122 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 84 insertions(+), 38 deletions(-)
---
--- w83627ehf.c.orig	2008-11-26 11:13:12.000000000 +0800
+++ w83627ehf.c	2008-11-26 15:37:15.000000000 +0800
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
@@ -148,6 +152,7 @@ static const u16 W83627EHF_REG_FAN_MIN[]
 					 (0x555 + (((nr) - 7) * 2)))
 #define W83627EHF_REG_IN(nr)		((nr < 7) ? (0x20 + (nr)) : \
 					 (0x550 + (nr) - 7))
+#define W83627EHF_REG_IN6_667HG	0x250		// vin6 register for 667hg is =
0x250
=20
 #define W83627EHF_REG_TEMP1		0x27
 #define W83627EHF_REG_TEMP1_HYST	0x3a
@@ -288,6 +293,7 @@ struct w83627ehf_data {
 	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle =
*/
 	u8 pwm_enable[4]; /* 1->manual
 			     2->thermal cruise (also called SmartFan I) */
+	u8 pwm_num;		/* number of pwm */
 	u8 pwm[4];
 	u8 target_temp[4];
 	u8 tolerance[4];
@@ -453,6 +459,8 @@ static struct w83627ehf_data *w83627ehf_
 	struct w83627ehf_data *data =3D dev_get_drvdata(dev);
 	int pwmcfg =3D 0, tolerance =3D 0; /* shut up the compiler */
 	int i;
+	struct w83627ehf_sio_data *sio_data =3D dev->platform_data;
+	u8 reg;
=20
 	mutex_lock(&data->update_lock);
=20
@@ -463,6 +471,8 @@ static struct w83627ehf_data *w83627ehf_
=20
 		/* Measured voltages and limits */
 		for (i =3D 0; i < data->in_num; i++) {
+			if ((sio_data->kind =3D=3D w83667hg) && (i =3D=3D 6))
+				continue;
 			data->in[i] =3D w83627ehf_read_value(data,
 				      W83627EHF_REG_IN(i));
 			data->in_min[i] =3D w83627ehf_read_value(data,
@@ -470,6 +480,19 @@ static struct w83627ehf_data *w83627ehf_
 			data->in_max[i] =3D w83627ehf_read_value(data,
 					  W83627EHF_REG_IN_MAX(i));
 		}
+		/* W83667HG, try fix in6 lost problem */
+		if ((sio_data->kind =3D=3D w83667hg)) {
+			reg =3D w83627ehf_read_value(data, W83627EHF_REG_TEMP_CONFIG[1]);
+			w83627ehf_write_value(data, W83627EHF_REG_TEMP_CONFIG[1], reg | =
0x01);
+			data->in[6] =3D w83627ehf_read_value(data,=20
+					  W83627EHF_REG_IN6_667HG);
+			w83627ehf_write_value(data, W83627EHF_REG_TEMP_CONFIG[1], reg);
+
+			data->in_min[6] =3D w83627ehf_read_value(data,
+					  W83627EHF_REG_IN_MIN(6));
+			data->in_max[6] =3D w83627ehf_read_value(data,
+					  W83627EHF_REG_IN_MAX(6));
+		}
=20
 		/* Measured fan speeds and limits */
 		for (i =3D 0; i < 5; i++) {
@@ -1191,7 +1214,7 @@ static void w83627ehf_device_remove_file
 		device_remove_file(dev, &sda_fan_div[i].dev_attr);
 		device_remove_file(dev, &sda_fan_min[i].dev_attr);
 	}
-	for (i =3D 0; i < 4; i++) {
+	for (i =3D 0; i < data->pwm_num; i++) {
 		device_remove_file(dev, &sda_pwm[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
 		device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
@@ -1271,8 +1294,10 @@ static int __devinit w83627ehf_probe(str
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
@@ -1280,44 +1305,59 @@ static int __devinit w83627ehf_probe(str
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
-
-	fan5pin =3D superio_inb(sio_data->sioreg, 0x24) & 0x2;
-	fan4pin =3D superio_inb(sio_data->sioreg, 0x29) & 0x6;
+	if (sio_data->kind =3D=3D w83667hg) {
+		fan5pin =3D superio_inb(sio_data->sioreg, 0x27) & 0x20;
+		fan4pin =3D superio_inb(sio_data->sioreg, 0x27) & 0x40;
+	} else {		=09
+		fan5pin =3D superio_inb(sio_data->sioreg, 0x24) & 0x2;
+		fan4pin =3D superio_inb(sio_data->sioreg, 0x29) & 0x6;
+	}
 	superio_exit(sio_data->sioreg);
=20
 	/* It looks like fan4 and fan5 pins can be alternatively used
@@ -1343,7 +1383,8 @@ static int __devinit w83627ehf_probe(str
 			goto exit_remove;
=20
 	/* if fan4 is enabled create the sf3 files for it */
-	if (data->has_fan & (1 << 3))
+	if ((sio_data->kind !=3D w83667hg) &&=20
+		(data->has_fan & (1 << 3)))
 		for (i =3D 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
 			if ((err =3D device_create_file(dev,
 				&sda_sf3_arrays_fan4[i].dev_attr)))
@@ -1371,8 +1412,8 @@ static int __devinit w83627ehf_probe(str
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
@@ -1441,6 +1482,7 @@ static int __init w83627ehf_find(int sio
 	static const char __initdata sio_name_W83627EHF[] =3D "W83627EHF";
 	static const char __initdata sio_name_W83627EHG[] =3D "W83627EHG";
 	static const char __initdata sio_name_W83627DHG[] =3D "W83627DHG";
+	static const char __initdata sio_name_W83667HG[] =3D "W83667HG";
=20
 	u16 val;
 	const char *sio_name;
@@ -1465,6 +1507,10 @@ static int __init w83627ehf_find(int sio
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

------_=_NextPart_001_01C94F9A.17406A6B
Content-Type: application/octet-stream;
	name="hwmon-add-support-for-w83667hg-in-w83627ehf-driver.patch"
Content-Transfer-Encoding: base64
Content-Description: hwmon-add-support-for-w83667hg-in-w83627ehf-driver.patch
Content-Disposition: attachment;
	filename="hwmon-add-support-for-w83667hg-in-w83627ehf-driver.patch"

RnJvbTogR29uZyBKdW4gPEpHb25nQG51dm90b24uY29tPgoKQWRkIHN1cHBvcnQgZm9yIG5ldyB3
ODM2NjdoZyBjaGlwIGluIHRoZSB3ODM2MjdlaGYgZHJpdmVyLgoKU2lnbmVkLW9mZi1ieTogR29u
ZyBKdW4gPEpHb25nQG51dm90b24uY29tPgotLS0KIHc4MzYyN2VoZi5jIHwgIDEyMiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5n
ZWQsIDg0IGluc2VydGlvbnMoKyksIDM4IGRlbGV0aW9ucygtKQotLS0KLS0tIHc4MzYyN2VoZi5j
Lm9yaWcJMjAwOC0xMS0yNiAxMToxMzoxMi4wMDAwMDAwMDAgKzA4MDAKKysrIHc4MzYyN2VoZi5j
CTIwMDgtMTEtMjYgMTU6Mzc6MTUuMDAwMDAwMDAwICswODAwCkBAIC0zNiw2ICszNiw3IEBACiAg
ICAgdzgzNjI3ZWhmICAgMTAgICAgICA1ICAgICAgIDQgICAgICAgMyAgICAgIDB4ODg1MCAweDg4
ICAgIDB4NWNhMwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAweDg4NjAgMHhhMQogICAgIHc4MzYyN2RoZyAgICA5ICAgICAgNSAgICAgICA0ICAgICAgIDMg
ICAgICAweGEwMjAgMHhjMSAgICAweDVjYTMKKyAgICB3ODM2NjdoZyAgICAgOSAgICAgIDUgICAg
ICAgMyAgICAgICAzICAgICAgMHhhNTEwIDB4YzEgICAgMHg1Y2EzCiAqLwogCiAjaW5jbHVkZSA8
bGludXgvbW9kdWxlLmg+CkBAIC01MSwxMiArNTIsMTMgQEAKICNpbmNsdWRlIDxhc20vaW8uaD4K
ICNpbmNsdWRlICJsbTc1LmgiCiAKLWVudW0ga2luZHMgeyB3ODM2MjdlaGYsIHc4MzYyN2RoZyB9
OworZW51bSBraW5kcyB7IHc4MzYyN2VoZiwgdzgzNjI3ZGhnLCB3ODM2NjdoZ307CiAKIC8qIHVz
ZWQgdG8gc2V0IGRhdGEtPm5hbWUgPSB3ODM2MjdlaGZfZGV2aWNlX25hbWVzW2RhdGEtPnNpb19r
aW5kXSAqLwogc3RhdGljIGNvbnN0IGNoYXIgKiB3ODM2MjdlaGZfZGV2aWNlX25hbWVzW10gPSB7
CiAJInc4MzYyN2VoZiIsCiAJInc4MzYyN2RoZyIsCisJInc4MzY2N2hnIiwKIH07CiAKIHN0YXRp
YyB1bnNpZ25lZCBzaG9ydCBmb3JjZV9pZDsKQEAgLTcwLDYgKzcyLDcgQEAgTU9EVUxFX1BBUk1f
REVTQyhmb3JjZV9pZCwgIk92ZXJyaWRlIHRoZQogICovCiAKICNkZWZpbmUgVzgzNjI3RUhGX0xE
X0hXTQkweDBiCisjZGVmaW5lIFc4MzY2N0hHX0xEX1ZJRCAJMHgwZAogCiAjZGVmaW5lIFNJT19S
RUdfTERTRUwJCTB4MDcJLyogTG9naWNhbCBkZXZpY2Ugc2VsZWN0ICovCiAjZGVmaW5lIFNJT19S
RUdfREVWSUQJCTB4MjAJLyogRGV2aWNlIElEICgyIGJ5dGVzKSAqLwpAQCAtODIsNiArODUsNyBA
QCBNT0RVTEVfUEFSTV9ERVNDKGZvcmNlX2lkLCAiT3ZlcnJpZGUgdGhlCiAjZGVmaW5lIFNJT19X
ODM2MjdFSEZfSUQJMHg4ODUwCiAjZGVmaW5lIFNJT19XODM2MjdFSEdfSUQJMHg4ODYwCiAjZGVm
aW5lIFNJT19XODM2MjdESEdfSUQJMHhhMDIwCisjZGVmaW5lIFNJT19XODM2NjdIR19JRCAJMHhh
NTEwCiAjZGVmaW5lIFNJT19JRF9NQVNLCQkweEZGRjAKIAogc3RhdGljIGlubGluZSB2b2lkCkBA
IC0xNDgsNiArMTUyLDcgQEAgc3RhdGljIGNvbnN0IHUxNiBXODM2MjdFSEZfUkVHX0ZBTl9NSU5b
XQogCQkJCQkgKDB4NTU1ICsgKCgobnIpIC0gNykgKiAyKSkpCiAjZGVmaW5lIFc4MzYyN0VIRl9S
RUdfSU4obnIpCQkoKG5yIDwgNykgPyAoMHgyMCArIChucikpIDogXAogCQkJCQkgKDB4NTUwICsg
KG5yKSAtIDcpKQorI2RlZmluZSBXODM2MjdFSEZfUkVHX0lONl82NjdIRwkweDI1MAkJLy8gdmlu
NiByZWdpc3RlciBmb3IgNjY3aGcgaXMgMHgyNTAKIAogI2RlZmluZSBXODM2MjdFSEZfUkVHX1RF
TVAxCQkweDI3CiAjZGVmaW5lIFc4MzYyN0VIRl9SRUdfVEVNUDFfSFlTVAkweDNhCkBAIC0yODgs
NiArMjkzLDcgQEAgc3RydWN0IHc4MzYyN2VoZl9kYXRhIHsKIAl1OCBwd21fbW9kZVs0XTsgLyog
MC0+REMgdmFyaWFibGUgdm9sdGFnZSwgMS0+UFdNIHZhcmlhYmxlIGR1dHkgY3ljbGUgKi8KIAl1
OCBwd21fZW5hYmxlWzRdOyAvKiAxLT5tYW51YWwKIAkJCSAgICAgMi0+dGhlcm1hbCBjcnVpc2Ug
KGFsc28gY2FsbGVkIFNtYXJ0RmFuIEkpICovCisJdTggcHdtX251bTsJCS8qIG51bWJlciBvZiBw
d20gKi8KIAl1OCBwd21bNF07CiAJdTggdGFyZ2V0X3RlbXBbNF07CiAJdTggdG9sZXJhbmNlWzRd
OwpAQCAtNDUzLDYgKzQ1OSw4IEBAIHN0YXRpYyBzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKnc4MzYy
N2VoZl8KIAlzdHJ1Y3QgdzgzNjI3ZWhmX2RhdGEgKmRhdGEgPSBkZXZfZ2V0X2RydmRhdGEoZGV2
KTsKIAlpbnQgcHdtY2ZnID0gMCwgdG9sZXJhbmNlID0gMDsgLyogc2h1dCB1cCB0aGUgY29tcGls
ZXIgKi8KIAlpbnQgaTsKKwlzdHJ1Y3QgdzgzNjI3ZWhmX3Npb19kYXRhICpzaW9fZGF0YSA9IGRl
di0+cGxhdGZvcm1fZGF0YTsKKwl1OCByZWc7CiAKIAltdXRleF9sb2NrKCZkYXRhLT51cGRhdGVf
bG9jayk7CiAKQEAgLTQ2Myw2ICs0NzEsOCBAQCBzdGF0aWMgc3RydWN0IHc4MzYyN2VoZl9kYXRh
ICp3ODM2MjdlaGZfCiAKIAkJLyogTWVhc3VyZWQgdm9sdGFnZXMgYW5kIGxpbWl0cyAqLwogCQlm
b3IgKGkgPSAwOyBpIDwgZGF0YS0+aW5fbnVtOyBpKyspIHsKKwkJCWlmICgoc2lvX2RhdGEtPmtp
bmQgPT0gdzgzNjY3aGcpICYmIChpID09IDYpKQorCQkJCWNvbnRpbnVlOwogCQkJZGF0YS0+aW5b
aV0gPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShkYXRhLAogCQkJCSAgICAgIFc4MzYyN0VIRl9SRUdf
SU4oaSkpOwogCQkJZGF0YS0+aW5fbWluW2ldID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoZGF0YSwK
QEAgLTQ3MCw2ICs0ODAsMTkgQEAgc3RhdGljIHN0cnVjdCB3ODM2MjdlaGZfZGF0YSAqdzgzNjI3
ZWhmXwogCQkJZGF0YS0+aW5fbWF4W2ldID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoZGF0YSwKIAkJ
CQkJICBXODM2MjdFSEZfUkVHX0lOX01BWChpKSk7CiAJCX0KKwkJLyogVzgzNjY3SEcsIHRyeSBm
aXggaW42IGxvc3QgcHJvYmxlbSAqLworCQlpZiAoKHNpb19kYXRhLT5raW5kID09IHc4MzY2N2hn
KSkgeworCQkJcmVnID0gdzgzNjI3ZWhmX3JlYWRfdmFsdWUoZGF0YSwgVzgzNjI3RUhGX1JFR19U
RU1QX0NPTkZJR1sxXSk7CisJCQl3ODM2MjdlaGZfd3JpdGVfdmFsdWUoZGF0YSwgVzgzNjI3RUhG
X1JFR19URU1QX0NPTkZJR1sxXSwgcmVnIHwgMHgwMSk7CisJCQlkYXRhLT5pbls2XSA9IHc4MzYy
N2VoZl9yZWFkX3ZhbHVlKGRhdGEsIAorCQkJCQkgIFc4MzYyN0VIRl9SRUdfSU42XzY2N0hHKTsK
KwkJCXc4MzYyN2VoZl93cml0ZV92YWx1ZShkYXRhLCBXODM2MjdFSEZfUkVHX1RFTVBfQ09ORklH
WzFdLCByZWcpOworCisJCQlkYXRhLT5pbl9taW5bNl0gPSB3ODM2MjdlaGZfcmVhZF92YWx1ZShk
YXRhLAorCQkJCQkgIFc4MzYyN0VIRl9SRUdfSU5fTUlOKDYpKTsKKwkJCWRhdGEtPmluX21heFs2
XSA9IHc4MzYyN2VoZl9yZWFkX3ZhbHVlKGRhdGEsCisJCQkJCSAgVzgzNjI3RUhGX1JFR19JTl9N
QVgoNikpOworCQl9CiAKIAkJLyogTWVhc3VyZWQgZmFuIHNwZWVkcyBhbmQgbGltaXRzICovCiAJ
CWZvciAoaSA9IDA7IGkgPCA1OyBpKyspIHsKQEAgLTExOTEsNyArMTIxNCw3IEBAIHN0YXRpYyB2
b2lkIHc4MzYyN2VoZl9kZXZpY2VfcmVtb3ZlX2ZpbGUKIAkJZGV2aWNlX3JlbW92ZV9maWxlKGRl
diwgJnNkYV9mYW5fZGl2W2ldLmRldl9hdHRyKTsKIAkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwg
JnNkYV9mYW5fbWluW2ldLmRldl9hdHRyKTsKIAl9Ci0JZm9yIChpID0gMDsgaSA8IDQ7IGkrKykg
eworCWZvciAoaSA9IDA7IGkgPCBkYXRhLT5wd21fbnVtOyBpKyspIHsKIAkJZGV2aWNlX3JlbW92
ZV9maWxlKGRldiwgJnNkYV9wd21baV0uZGV2X2F0dHIpOwogCQlkZXZpY2VfcmVtb3ZlX2ZpbGUo
ZGV2LCAmc2RhX3B3bV9tb2RlW2ldLmRldl9hdHRyKTsKIAkJZGV2aWNlX3JlbW92ZV9maWxlKGRl
diwgJnNkYV9wd21fZW5hYmxlW2ldLmRldl9hdHRyKTsKQEAgLTEyNzEsOCArMTI5NCwxMCBAQCBz
dGF0aWMgaW50IF9fZGV2aW5pdCB3ODM2MjdlaGZfcHJvYmUoc3RyCiAJZGF0YS0+bmFtZSA9IHc4
MzYyN2VoZl9kZXZpY2VfbmFtZXNbc2lvX2RhdGEtPmtpbmRdOwogCXBsYXRmb3JtX3NldF9kcnZk
YXRhKHBkZXYsIGRhdGEpOwogCi0JLyogNjI3RUhHIGFuZCA2MjdFSEYgaGF2ZSAxMCB2b2x0YWdl
IGlucHV0czsgREhHIGhhcyA5ICovCi0JZGF0YS0+aW5fbnVtID0gKHNpb19kYXRhLT5raW5kID09
IHc4MzYyN2RoZykgPyA5IDogMTA7CisJLyogNjI3RUhHIGFuZCA2MjdFSEYgaGF2ZSAxMCB2b2x0
YWdlIGlucHV0czsgREhHIGFuZCA2NjdIRyBoYXZlIDkgKi8KKwlkYXRhLT5pbl9udW0gPSAoc2lv
X2RhdGEtPmtpbmQgPT0gdzgzNjI3ZWhmKSA/IDEwIDogOTsKKwkvKiA2NjdIRyBoYXMgMyBwd21z
ICovCisJZGF0YS0+cHdtX251bSA9IChzaW9fZGF0YS0+a2luZCA9PSB3ODM2NjdoZykgPyAzIDog
NDsKIAogCS8qIEluaXRpYWxpemUgdGhlIGNoaXAgKi8KIAl3ODM2MjdlaGZfaW5pdF9kZXZpY2Uo
ZGF0YSk7CkBAIC0xMjgwLDQ0ICsxMzA1LDU5IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHc4MzYy
N2VoZl9wcm9iZShzdHIKIAlkYXRhLT52cm0gPSB2aWRfd2hpY2hfdnJtKCk7CiAJc3VwZXJpb19l
bnRlcihzaW9fZGF0YS0+c2lvcmVnKTsKIAkvKiBSZWFkIFZJRCB2YWx1ZSAqLwotCXN1cGVyaW9f
c2VsZWN0KHNpb19kYXRhLT5zaW9yZWcsIFc4MzYyN0VIRl9MRF9IV00pOwotCWlmIChzdXBlcmlv
X2luYihzaW9fZGF0YS0+c2lvcmVnLCBTSU9fUkVHX1ZJRF9DVFJMKSAmIDB4ODApIHsKLQkJLyog
U2V0IFZJRCBpbnB1dCBzZW5zaWJpbGl0eSBpZiBuZWVkZWQuIEluIHRoZW9yeSB0aGUgQklPUwot
CQkgICBzaG91bGQgaGF2ZSBzZXQgaXQsIGJ1dCBpbiBwcmFjdGljZSBpdCdzIG5vdCBhbHdheXMg
dGhlCi0JCSAgIGNhc2UuIFdlIG9ubHkgZG8gaXQgZm9yIHRoZSBXODM2MjdFSEYvRUhHIGJlY2F1
c2UgdGhlCi0JCSAgIFc4MzYyN0RIRyBpcyBtb3JlIGNvbXBsZXggaW4gdGhpcyByZXNwZWN0LiAq
LwotCQlpZiAoc2lvX2RhdGEtPmtpbmQgPT0gdzgzNjI3ZWhmKSB7Ci0JCQllbl92cm0xMCA9IHN1
cGVyaW9faW5iKHNpb19kYXRhLT5zaW9yZWcsCi0JCQkJCSAgICAgICBTSU9fUkVHX0VOX1ZSTTEw
KTsKLQkJCWlmICgoZW5fdnJtMTAgJiAweDA4KSAmJiBkYXRhLT52cm0gPT0gOTApIHsKLQkJCQlk
ZXZfd2FybihkZXYsICJTZXR0aW5nIFZJRCBpbnB1dCB2b2x0YWdlIHRvICIKLQkJCQkJICJUVExc
biIpOwotCQkJCXN1cGVyaW9fb3V0YihzaW9fZGF0YS0+c2lvcmVnLCBTSU9fUkVHX0VOX1ZSTTEw
LAotCQkJCQkgICAgIGVuX3ZybTEwICYgfjB4MDgpOwotCQkJfSBlbHNlIGlmICghKGVuX3ZybTEw
ICYgMHgwOCkgJiYgZGF0YS0+dnJtID09IDEwMCkgewotCQkJCWRldl93YXJuKGRldiwgIlNldHRp
bmcgVklEIGlucHV0IHZvbHRhZ2UgdG8gIgotCQkJCQkgIlZSTTEwXG4iKTsKLQkJCQlzdXBlcmlv
X291dGIoc2lvX2RhdGEtPnNpb3JlZywgU0lPX1JFR19FTl9WUk0xMCwKLQkJCQkJICAgICBlbl92
cm0xMCB8IDB4MDgpOwotCQkJfQotCQl9Ci0KLQkJZGF0YS0+dmlkID0gc3VwZXJpb19pbmIoc2lv
X2RhdGEtPnNpb3JlZywgU0lPX1JFR19WSURfREFUQSk7Ci0JCWlmIChzaW9fZGF0YS0+a2luZCA9
PSB3ODM2MjdlaGYpIC8qIDYgVklEIHBpbnMgb25seSAqLwotCQkJZGF0YS0+dmlkICY9IDB4M2Y7
Ci0KKwlpZiAoc2lvX2RhdGEtPmtpbmQgPT0gdzgzNjY3aGcpIHsKKwkJLyogVzgzNjY3SEcgaGFz
IGRpZmZlcmVudCBwaW5zIGZvciBWSUQgaW5wdXQgYW5kIG91dHB1dCwgc28gCisgCQl3ZSBjYW4g
Z2V0IHRoZSBWSUQgaW5wdXQgdmFsdWVzIGRpcmVjdGx5IGF0IGxvZ2ljYWwgZGV2aWNlIEQKKwkJ
MHhlMy4gKi8KKwkJc3VwZXJpb19zZWxlY3Qoc2lvX2RhdGEtPnNpb3JlZywgVzgzNjY3SEdfTERf
VklEKTsKKwkJZGF0YS0+dmlkID0gc3VwZXJpb19pbmIoc2lvX2RhdGEtPnNpb3JlZywgMHhlMyk7
CiAJCWVyciA9IGRldmljZV9jcmVhdGVfZmlsZShkZXYsICZkZXZfYXR0cl9jcHUwX3ZpZCk7CiAJ
CWlmIChlcnIpCiAJCQlnb3RvIGV4aXRfcmVsZWFzZTsKIAl9IGVsc2UgewotCQlkZXZfaW5mbyhk
ZXYsICJWSUQgcGlucyBpbiBvdXRwdXQgbW9kZSwgQ1BVIFZJRCBub3QgIgotCQkJICJhdmFpbGFi
bGVcbiIpOworCQlzdXBlcmlvX3NlbGVjdChzaW9fZGF0YS0+c2lvcmVnLCBXODM2MjdFSEZfTERf
SFdNKTsKKwkJaWYgKHN1cGVyaW9faW5iKHNpb19kYXRhLT5zaW9yZWcsIFNJT19SRUdfVklEX0NU
UkwpICYgMHg4MCkgeworCQkJLyogU2V0IFZJRCBpbnB1dCBzZW5zaWJpbGl0eSBpZiBuZWVkZWQu
IEluIHRoZW9yeSB0aGUgQklPUworCQkJICAgc2hvdWxkIGhhdmUgc2V0IGl0LCBidXQgaW4gcHJh
Y3RpY2UgaXQncyBub3QgYWx3YXlzIHRoZQorCQkJICAgY2FzZS4gV2Ugb25seSBkbyBpdCBmb3Ig
dGhlIFc4MzYyN0VIRi9FSEcgYmVjYXVzZSB0aGUKKwkJCSAgIFc4MzYyN0RIRyBpcyBtb3JlIGNv
bXBsZXggaW4gdGhpcyByZXNwZWN0LiAqLworCQkJaWYgKHNpb19kYXRhLT5raW5kID09IHc4MzYy
N2VoZikgeworCQkJCWVuX3ZybTEwID0gc3VwZXJpb19pbmIoc2lvX2RhdGEtPnNpb3JlZywKKwkJ
CQkJCSAgICAgICBTSU9fUkVHX0VOX1ZSTTEwKTsKKwkJCQlpZiAoKGVuX3ZybTEwICYgMHgwOCkg
JiYgZGF0YS0+dnJtID09IDkwKSB7CisJCQkJCWRldl93YXJuKGRldiwgIlNldHRpbmcgVklEIGlu
cHV0IHZvbHRhZ2UgdG8gIgorCQkJCQkJICJUVExcbiIpOworCQkJCQlzdXBlcmlvX291dGIoc2lv
X2RhdGEtPnNpb3JlZywgU0lPX1JFR19FTl9WUk0xMCwKKwkJCQkJCSAgICAgZW5fdnJtMTAgJiB+
MHgwOCk7CisJCQkJfSBlbHNlIGlmICghKGVuX3ZybTEwICYgMHgwOCkgJiYgZGF0YS0+dnJtID09
IDEwMCkgeworCQkJCQlkZXZfd2FybihkZXYsICJTZXR0aW5nIFZJRCBpbnB1dCB2b2x0YWdlIHRv
ICIKKwkJCQkJCSAiVlJNMTBcbiIpOworCQkJCQlzdXBlcmlvX291dGIoc2lvX2RhdGEtPnNpb3Jl
ZywgU0lPX1JFR19FTl9WUk0xMCwKKwkJCQkJCSAgICAgZW5fdnJtMTAgfCAweDA4KTsKKwkJCQl9
CisJCQl9CisKKwkJCWRhdGEtPnZpZCA9IHN1cGVyaW9faW5iKHNpb19kYXRhLT5zaW9yZWcsIFNJ
T19SRUdfVklEX0RBVEEpOworCQkJaWYgKHNpb19kYXRhLT5raW5kID09IHc4MzYyN2VoZikgLyog
NiBWSUQgcGlucyBvbmx5ICovCisJCQkJZGF0YS0+dmlkICY9IDB4M2Y7CisKKwkJCWVyciA9IGRl
dmljZV9jcmVhdGVfZmlsZShkZXYsICZkZXZfYXR0cl9jcHUwX3ZpZCk7CisJCQlpZiAoZXJyKQor
CQkJCWdvdG8gZXhpdF9yZWxlYXNlOworCQl9IGVsc2UgeworCQkJZGV2X2luZm8oZGV2LCAiVklE
IHBpbnMgaW4gb3V0cHV0IG1vZGUsIENQVSBWSUQgbm90ICIKKwkJCQkgImF2YWlsYWJsZVxuIik7
CisJCX0KIAl9CiAKIAkvKiBmYW40IGFuZCBmYW41IHNoYXJlIHNvbWUgcGlucyB3aXRoIHRoZSBH
UElPIGFuZCBzZXJpYWwgZmxhc2ggKi8KLQotCWZhbjVwaW4gPSBzdXBlcmlvX2luYihzaW9fZGF0
YS0+c2lvcmVnLCAweDI0KSAmIDB4MjsKLQlmYW40cGluID0gc3VwZXJpb19pbmIoc2lvX2RhdGEt
PnNpb3JlZywgMHgyOSkgJiAweDY7CisJaWYgKHNpb19kYXRhLT5raW5kID09IHc4MzY2N2hnKSB7
CisJCWZhbjVwaW4gPSBzdXBlcmlvX2luYihzaW9fZGF0YS0+c2lvcmVnLCAweDI3KSAmIDB4MjA7
CisJCWZhbjRwaW4gPSBzdXBlcmlvX2luYihzaW9fZGF0YS0+c2lvcmVnLCAweDI3KSAmIDB4NDA7
CisJfSBlbHNlIHsJCQkKKwkJZmFuNXBpbiA9IHN1cGVyaW9faW5iKHNpb19kYXRhLT5zaW9yZWcs
IDB4MjQpICYgMHgyOworCQlmYW40cGluID0gc3VwZXJpb19pbmIoc2lvX2RhdGEtPnNpb3JlZywg
MHgyOSkgJiAweDY7CisJfQogCXN1cGVyaW9fZXhpdChzaW9fZGF0YS0+c2lvcmVnKTsKIAogCS8q
IEl0IGxvb2tzIGxpa2UgZmFuNCBhbmQgZmFuNSBwaW5zIGNhbiBiZSBhbHRlcm5hdGl2ZWx5IHVz
ZWQKQEAgLTEzNDMsNyArMTM4Myw4IEBAIHN0YXRpYyBpbnQgX19kZXZpbml0IHc4MzYyN2VoZl9w
cm9iZShzdHIKIAkJCWdvdG8gZXhpdF9yZW1vdmU7CiAKIAkvKiBpZiBmYW40IGlzIGVuYWJsZWQg
Y3JlYXRlIHRoZSBzZjMgZmlsZXMgZm9yIGl0ICovCi0JaWYgKGRhdGEtPmhhc19mYW4gJiAoMSA8
PCAzKSkKKwlpZiAoKHNpb19kYXRhLT5raW5kICE9IHc4MzY2N2hnKSAmJiAKKwkJKGRhdGEtPmhh
c19mYW4gJiAoMSA8PCAzKSkpCiAJCWZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHNkYV9zZjNf
YXJyYXlzX2ZhbjQpOyBpKyspIHsKIAkJCWlmICgoZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRl
diwKIAkJCQkmc2RhX3NmM19hcnJheXNfZmFuNFtpXS5kZXZfYXR0cikpKQpAQCAtMTM3MSw4ICsx
NDEyLDggQEAgc3RhdGljIGludCBfX2RldmluaXQgdzgzNjI3ZWhmX3Byb2JlKHN0cgogCQkJCXx8
IChlcnIgPSBkZXZpY2VfY3JlYXRlX2ZpbGUoZGV2LAogCQkJCQkmc2RhX2Zhbl9taW5baV0uZGV2
X2F0dHIpKSkKIAkJCQlnb3RvIGV4aXRfcmVtb3ZlOwotCQkJaWYgKGkgPCA0ICYmIC8qIHc4MzYy
N2VoZiBvbmx5IGhhcyA0IHB3bSAqLwotCQkJCSgoZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRl
diwKKwlpZihpIDwgZGF0YS0+cHdtX251bSAmJgorCQkJKChlcnIgPSBkZXZpY2VfY3JlYXRlX2Zp
bGUoZGV2LAogCQkJCQkmc2RhX3B3bVtpXS5kZXZfYXR0cikpCiAJCQkJfHwgKGVyciA9IGRldmlj
ZV9jcmVhdGVfZmlsZShkZXYsCiAJCQkJCSZzZGFfcHdtX21vZGVbaV0uZGV2X2F0dHIpKQpAQCAt
MTQ0MSw2ICsxNDgyLDcgQEAgc3RhdGljIGludCBfX2luaXQgdzgzNjI3ZWhmX2ZpbmQoaW50IHNp
bwogCXN0YXRpYyBjb25zdCBjaGFyIF9faW5pdGRhdGEgc2lvX25hbWVfVzgzNjI3RUhGW10gPSAi
VzgzNjI3RUhGIjsKIAlzdGF0aWMgY29uc3QgY2hhciBfX2luaXRkYXRhIHNpb19uYW1lX1c4MzYy
N0VIR1tdID0gIlc4MzYyN0VIRyI7CiAJc3RhdGljIGNvbnN0IGNoYXIgX19pbml0ZGF0YSBzaW9f
bmFtZV9XODM2MjdESEdbXSA9ICJXODM2MjdESEciOworCXN0YXRpYyBjb25zdCBjaGFyIF9faW5p
dGRhdGEgc2lvX25hbWVfVzgzNjY3SEdbXSA9ICJXODM2NjdIRyI7CiAKIAl1MTYgdmFsOwogCWNv
bnN0IGNoYXIgKnNpb19uYW1lOwpAQCAtMTQ2NSw2ICsxNTA3LDEwIEBAIHN0YXRpYyBpbnQgX19p
bml0IHc4MzYyN2VoZl9maW5kKGludCBzaW8KIAkJc2lvX2RhdGEtPmtpbmQgPSB3ODM2MjdkaGc7
CiAJCXNpb19uYW1lID0gc2lvX25hbWVfVzgzNjI3REhHOwogCQlicmVhazsKKwljYXNlIFNJT19X
ODM2NjdIR19JRDoKKwkJc2lvX2RhdGEtPmtpbmQgPSB3ODM2NjdoZzsKKwkJc2lvX25hbWUgPSBz
aW9fbmFtZV9XODM2NjdIRzsKKwkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJaWYgKHZhbCAhPSAweGZm
ZmYpCiAJCQlwcl9kZWJ1ZyhEUlZOQU1FICI6IHVuc3VwcG9ydGVkIGNoaXAgSUQ6IDB4JTA0eFxu
IiwK

------_=_NextPart_001_01C94F9A.17406A6B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------_=_NextPart_001_01C94F9A.17406A6B--
