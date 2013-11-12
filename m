From: Rudolf Marek <r.marek@assembler.cz>
Date: Tue, 12 Nov 2013 13:48:03 +0000
Subject: Re: [lm-sensors] ITE it8603e
Message-Id: <52823193.7010401@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020309090609060704070401"
List-Id: <lm-sensors.vger.kernel.org>
References: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
In-Reply-To: <CAC-0Eqii0d94mPbn=8MoOn9UMP_srC3s5Dt3q45G+GTdo2kptw@mail.gmail.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020309090609060704070401
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm attaching the preliminary changes to support the IT8603E. The chip is v=
ery=20
similar to IT8728, but it has extra internal voltage sensors located at 0x2=
f. I=20
solved that with new "in9" and even with a label, but I consider my=20
implementation not elegant. If you have any idea how to make it better plea=
se=20
let me know or fix it. The 16-bit tachometer enable regs are used for somet=
hing=20
else! Therefore not touch them with this chip (this is also reserved in IT8=
728,=20
so one may need to change the driver). There are also bits used for the oth=
er=20
stuff which overlap old functionality. The ON/OFF mode is gone. We cannot t=
ouch=20
the regs anymore. It will turn on something called "virtual temperature" an=
d=20
this is what David seen, that temperature was stuck. I took the E/F version=
=20
print change from David patch. Rest seems ok.

Just in case:

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

The sensors config:

chip "it8603-*"
     label temp1 "CPU Temp"
     label temp2 "M/B Temp"

     label in0 "Vcore"
     label in1 "in1"
     label in2 "+12V"
     label in3 "+5V"
     label fan1 "CPU Fan"
     label fan2 "CHA Fan"
     label fan3 "PWR Fan"

     compute in2  @ * (12/2), @ / (12/2)
     compute in3  @ * (25/10), @ / (25/10)


k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +0.0=B0C  (high =3D +70.0=B0C)
                        (crit =3D +70.0=B0C, hyst =3D +69.0=B0C)

it8603-isa-0290
Adapter: ISA adapter
Vcore:        +0.98 V  (min =3D  +2.87 V, max =3D  +0.28 V)  ALARM
in1:          +1.64 V  (min =3D  +0.24 V, max =3D  +0.38 V)  ALARM
+12V:        +12.17 V  (min =3D  +0.29 V, max =3D  +9.00 V)  ALARM
+5V:          +5.13 V  (min =3D  +5.04 V, max =3D  +1.17 V)  ALARM
in4:          +1.20 V  (min =3D  +0.06 V, max =3D  +1.85 V)
3VSB:         +3.34 V  (min =3D  +1.75 V, max =3D  +2.54 V)  ALARM
Vbat:         +3.24 V
AVCC3:        +3.38 V
CPU Fan:     1744 RPM  (min =3D  200 RPM)
CHA Fan:        0 RPM  (min =3D  600 RPM)  ALARM
CPU Temp:     +31.0=B0C  (low  =3D +71.0=B0C, high =3D +109.0=B0C)  sensor =
=3D thermistor
M/B Temp:     +34.0=B0C  (low  =3D -72.0=B0C, high =3D -72.0=B0C)  ALARM  s=
ensor =3D thermistor
temp3:       -128.0=B0C  (low  =3D  +0.0=B0C, high =3D  +8.0=B0C)  sensor =
=3D thermistor
intrusion0:  OK


I already commit the sensors-detect change.

Thanks
Rudolf


--------------020309090609060704070401
Content-Type: text/x-diff;
 name="it8306.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="it8306.patch"

Index: linux-3.12/Documentation/hwmon/it87
===================================================================
--- linux-3.12.orig/Documentation/hwmon/it87	2013-11-04 00:41:51.000000000 +0100
+++ linux-3.12/Documentation/hwmon/it87	2013-11-12 14:09:30.940290706 +0100
@@ -2,6 +2,10 @@
 ==================
 
 Supported chips:
+  * IT8603E
+    Prefix: 'it8603'
+    Addresses scanned: from Super I/O config space (8 I/O ports)
+    Datasheet: Not publicly available
   * IT8705F
     Prefix: 'it87'
     Addresses scanned: from Super I/O config space (8 I/O ports)
@@ -90,7 +94,7 @@
 Description
 -----------
 
-This driver implements support for the IT8705F, IT8712F, IT8716F,
+This driver implements support for the IT8603, IT8705F, IT8712F, IT8716F,
 IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8771E, IT8772E,
 IT8782F, IT8783E/F, and SiS950 chips.
 
@@ -129,6 +133,10 @@
 The IT8728F, IT8771E, and IT8772E are considered compatible with the IT8721F,
 until a datasheet becomes available (hopefully.)
 
+The IT8603E is a custom design, hardware monitoring part is similar to
+IT8728F. There is 16-bit only fan mode only, the full speed mode of the fan
+is not supported (value 0 of pwmX_enable).
+
 Temperatures are measured in degrees Celsius. An alarm is triggered once
 when the Overtemperature Shutdown limit is crossed.
 
@@ -145,10 +153,10 @@
 maximum limit. Note that minimum in this case always means 'closest to
 zero'; this is important for negative voltage measurements. All voltage
 inputs can measure voltages between 0 and 4.08 volts, with a resolution of
-0.016 volt (except IT8721F/IT8758E and IT8728F: 0.012 volt.) The battery
+0.016 volt (except IT8721F/IT8758E/IT8603E and IT8728F: 0.012 volt.) The battery
 voltage in8 does not have limit registers.
 
-On the IT8721F/IT8758E, IT8782F, and IT8783E/F, some voltage inputs are
+On the IT8721F/IT8758E/IT8603E, IT8782F, and IT8783E/F, some voltage inputs are
 internal and scaled inside the chip (in7 (optional for IT8782F and IT8783E/F),
 in8 and optionally in3). The driver handles this transparently so user-space
 doesn't have to care.
Index: linux-3.12/drivers/hwmon/it87.c
===================================================================
--- linux-3.12.orig/drivers/hwmon/it87.c	2013-11-04 00:41:51.000000000 +0100
+++ linux-3.12/drivers/hwmon/it87.c	2013-11-12 14:21:31.555231353 +0100
@@ -23,6 +23,7 @@
  *            IT8772E  Super I/O chip w/LPC interface
  *            IT8782F  Super I/O chip w/LPC interface
  *            IT8783E/F Super I/O chip w/LPC interface
+ *            IT8603E  Super I/O chip w/LPC interface
  *            Sis950   A clone of the IT8705F
  *
  *  Copyright (C) 2001 Chris Gauthron
@@ -64,7 +65,7 @@
 #define DRVNAME "it87"
 
 enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it8771,
-	     it8772, it8782, it8783 };
+	     it8772, it8782, it8783, it8603 };
 
 static unsigned short force_id;
 module_param(force_id, ushort, 0);
@@ -146,6 +147,7 @@
 #define IT8772E_DEVID 0x8772
 #define IT8782F_DEVID 0x8782
 #define IT8783E_DEVID 0x8783
+#define IT8306E_DEVID 0x8603
 #define IT87_ACT_REG  0x30
 #define IT87_BASE_REG 0x60
 
@@ -315,6 +317,12 @@
 		  | FEAT_TEMP_OLD_PECI,
 		.old_peci_mask = 0x4,
 	},
+	[it8603] = {
+		.name = "it8603",
+		.features = FEAT_NEWER_AUTOPWM | FEAT_12MV_ADC | FEAT_16BIT_FANS
+		  | FEAT_TEMP_OFFSET | FEAT_TEMP_PECI,
+		.peci_mask = 0x07,
+	},
 };
 
 #define has_16bit_fans(data)	((data)->features & FEAT_16BIT_FANS)
@@ -334,7 +342,7 @@
 	u8 revision;
 	u8 vid_value;
 	u8 beep_pin;
-	u8 internal;	/* Internal sensors can be labeled */
+	u16 internal;	/* Internal sensors can be labeled */
 	/* Features skipped based on config or DMI */
 	u16 skip_in;
 	u8 skip_vid;
@@ -361,7 +369,7 @@
 	unsigned long last_updated;	/* In jiffies */
 
 	u16 in_scaled;		/* Internal voltage sensors are scaled */
-	u8 in[9][3];		/* [nr][0]=in, [1]=min, [2]=max */
+	u8 in[10][3];		/* [nr][0]=in, [1]=min, [2]=max */
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[5][2];		/* Register values, [nr][0]=fan, [1]=min */
 	u8 has_temp;		/* Bitfield, temp sensors enabled */
@@ -578,6 +586,8 @@
 			    7, 2);
 
 static SENSOR_DEVICE_ATTR_2(in8_input, S_IRUGO, show_in, NULL, 8, 0);
+static SENSOR_DEVICE_ATTR_2(in9_input, S_IRUGO, show_in, NULL, 9, 0);
+
 
 /* 3 temperatures */
 static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
@@ -734,7 +744,7 @@
 {
 	int ctrl = data->fan_main_ctrl & (1 << nr);
 
-	if (ctrl == 0)					/* Full speed */
+	if ((ctrl == 0) && (data->type != it8603)) /* Full speed */
 		return 0;
 	if (data->pwm_ctrl[nr] & 0x80)			/* Automatic mode */
 		return 2;
@@ -929,6 +939,10 @@
 			return -EINVAL;
 	}
 
+	/* IT8603E does not have on/off mode */
+	if ((val == 0) && (data->type == it8603))
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
 
 	if (val == 0) {
@@ -948,10 +962,13 @@
 		else					/* Automatic mode */
 			data->pwm_ctrl[nr] = 0x80 | data->pwm_temp_map[nr];
 		it87_write_value(data, IT87_REG_PWM(nr), data->pwm_ctrl[nr]);
-		/* set SmartGuardian mode */
-		data->fan_main_ctrl |= (1 << nr);
-		it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
-				 data->fan_main_ctrl);
+
+		if (data->type != it8603) {
+			/* set SmartGuardian mode */
+			data->fan_main_ctrl |= (1 << nr);
+			it87_write_value(data, IT87_REG_FAN_MAIN_CTRL,
+					 data->fan_main_ctrl);
+		}
 	}
 
 	mutex_unlock(&data->update_lock);
@@ -1406,15 +1423,25 @@
 		"3VSB",
 		"Vbat",
 	};
+	static const char * const labels_it8603[] = {
+		"AVCC3",
+		"3VSB",
+		"Vbat",
+	};
 	struct it87_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr(attr)->index;
 
+	if (data->type == it8603)
+		return sprintf(buf, "%s\n", labels_it8603[nr]);
+
 	return sprintf(buf, "%s\n", has_12mv_adc(data) ? labels_it8721[nr]
 						       : labels[nr]);
 }
 static SENSOR_DEVICE_ATTR(in3_label, S_IRUGO, show_label, NULL, 0);
 static SENSOR_DEVICE_ATTR(in7_label, S_IRUGO, show_label, NULL, 1);
 static SENSOR_DEVICE_ATTR(in8_label, S_IRUGO, show_label, NULL, 2);
+/* special AVCC3 IT8306 in9 */
+static SENSOR_DEVICE_ATTR(in9_label, S_IRUGO, show_label, NULL, 0);
 
 static ssize_t show_name(struct device *dev, struct device_attribute
 			 *devattr, char *buf)
@@ -1424,7 +1451,7 @@
 }
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
-static struct attribute *it87_attributes_in[9][5] = {
+static struct attribute *it87_attributes_in[10][5] = {
 {
 	&sensor_dev_attr_in0_input.dev_attr.attr,
 	&sensor_dev_attr_in0_min.dev_attr.attr,
@@ -1476,9 +1503,12 @@
 }, {
 	&sensor_dev_attr_in8_input.dev_attr.attr,
 	NULL
+}, {
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	NULL
 } };
 
-static const struct attribute_group it87_group_in[9] = {
+static const struct attribute_group it87_group_in[10] = {
 	{ .attrs = it87_attributes_in[0] },
 	{ .attrs = it87_attributes_in[1] },
 	{ .attrs = it87_attributes_in[2] },
@@ -1488,6 +1518,7 @@
 	{ .attrs = it87_attributes_in[6] },
 	{ .attrs = it87_attributes_in[7] },
 	{ .attrs = it87_attributes_in[8] },
+	{ .attrs = it87_attributes_in[9] },
 };
 
 static struct attribute *it87_attributes_temp[3][6] = {
@@ -1685,6 +1716,7 @@
 	&sensor_dev_attr_in3_label.dev_attr.attr,
 	&sensor_dev_attr_in7_label.dev_attr.attr,
 	&sensor_dev_attr_in8_label.dev_attr.attr,
+	&sensor_dev_attr_in9_label.dev_attr.attr,
 	NULL
 };
 
@@ -1742,6 +1774,9 @@
 	case IT8783E_DEVID:
 		sio_data->type = it8783;
 		break;
+	case IT8306E_DEVID:
+		sio_data->type = it8603;
+		break;
 	case 0xffff:	/* No device at all */
 		goto exit;
 	default:
@@ -1763,12 +1798,15 @@
 
 	err = 0;
 	sio_data->revision = superio_inb(DEVREV) & 0x0f;
-	pr_info("Found IT%04xF chip at 0x%x, revision %d\n",
-		chip_type, *address, sio_data->revision);
+	pr_info("Found IT%04x%c chip at 0x%x, revision %d\n", chip_type,
+		(chip_type == 0x8603) ? 'E' : 'F', *address,
+		sio_data->revision);
 
 	/* in8 (Vbat) is always internal */
 	sio_data->internal = (1 << 2);
 
+	sio_data->skip_in |= (1 << 9); /* No VIN9 */
+
 	/* Read GPIO config and VID value from LDN 7 (GPIO) */
 	if (sio_data->type == it87) {
 		/* The IT8705F doesn't have VID pins at all */
@@ -1844,7 +1882,42 @@
 			sio_data->internal |= (1 << 1);
 
 		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
+	} if (sio_data->type == it8603) {
+		int reg27, reg29;
+
+		sio_data->skip_vid = 1;	/* No VID */
+		superio_select(GPIO);
 
+		reg27 = superio_inb(IT87_SIO_GPIO3_REG);
+
+		/* Check if fan3 is there or not */
+		if (reg27 & (1 << 6))
+			sio_data->skip_pwm |= (1 << 2);
+		if (reg27 & (1 << 7))
+			sio_data->skip_fan |= (1 << 2);
+
+		/* Check if fan2 is there or not */
+		reg29 = superio_inb(IT87_SIO_GPIO5_REG);
+		if (reg29 & (1 << 1))
+			sio_data->skip_pwm |= (1 << 1);
+		if (reg29 & (1 << 2))
+			sio_data->skip_fan |= (1 << 1);
+
+		sio_data->skip_in |= (1 << 5); /* No VIN5 */
+		sio_data->skip_in |= (1 << 6); /* No VIN6 */
+
+		/* no fan4 */
+		sio_data->skip_pwm |= (1 << 3);
+		sio_data->skip_fan |= (1 << 3);
+
+		/* AVCC3 needs a special handling, map 0x2f to in9 */
+		sio_data->internal |= (1 << 3); /* in9 has label */
+		sio_data->skip_in &= ~(1 << 9); /* VIN9 mapped to 0x2f */
+
+		sio_data->internal |= (1 << 1); /* in7 is VSB */
+		sio_data->internal |= (1 << 2); /* in8 is VBAT */
+
+		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
 	} else {
 		int reg;
 		bool uart6;
@@ -1854,7 +1927,7 @@
 		reg = superio_inb(IT87_SIO_GPIO3_REG);
 		if (sio_data->type == it8721 || sio_data->type == it8728 ||
 		    sio_data->type == it8771 || sio_data->type == it8772 ||
-		    sio_data->type == it8782) {
+		    sio_data->type == it8782 || sio_data->type == it8603)  {
 			/*
 			 * IT8721F/IT8758E, and IT8782F don't have VID pins
 			 * at all, not sure about the IT8728F and compatibles.
@@ -2072,6 +2145,10 @@
 	/* Check PWM configuration */
 	enable_pwm_interface = it87_check_pwm(dev);
 
+
+	if (data->type == it8603)
+		data->in_scaled |= (1 << 9); /* in9 is AVCC3 */
+
 	/* Starting with IT8721F, we handle scaling of internal voltages */
 	if (has_12mv_adc(data)) {
 		if (sio_data->internal & (1 << 0))
@@ -2102,7 +2179,7 @@
 	if (err)
 		return err;
 
-	for (i = 0; i < 9; i++) {
+	for (i = 0; i < 10; i++) {
 		if (sio_data->skip_in & (1 << i))
 			continue;
 		err = sysfs_create_group(&dev->kobj, &it87_group_in[i]);
@@ -2202,7 +2279,7 @@
 	}
 
 	/* Export labels for internal sensors */
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < 4; i++) {
 		if (!(sio_data->internal & (1 << i)))
 			continue;
 		err = sysfs_create_file(&dev->kobj,
@@ -2383,8 +2460,8 @@
 	}
 	data->has_fan = (data->fan_main_ctrl >> 4) & 0x07;
 
-	/* Set tachometers to 16-bit mode if needed */
-	if (has_16bit_fans(data)) {
+	/* Set tachometers to 16-bit mode if needed, IT8603E/IT8728? has it by default */
+	if ((has_16bit_fans(data)) && (data->type != it8603)) {
 		tmp = it87_read_value(data, IT87_REG_FAN_16BIT);
 		if (~tmp & 0x07 & data->has_fan) {
 			dev_dbg(&pdev->dev,
@@ -2462,6 +2539,10 @@
 			data->in[i][2] =
 				it87_read_value(data, IT87_REG_VIN_MAX(i));
 		}
+
+		if (data->type == it8603)
+			data->in[9][0] = it87_read_value(data, 0x2f);
+
 		/* in8 (battery) has no limit registers */
 		data->in[8][0] = it87_read_value(data, IT87_REG_VIN(8));
 

--------------020309090609060704070401
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020309090609060704070401--
