From: david.c.hubbard@gmail.com (David Hubbard)
Date: Tue, 26 Dec 2006 08:02:24 +0000
Subject: [lm-sensors] Asus P5B Deluxe / Winbond 83627DHG
Message-Id: <4dfa50520612260002x772906d3p8524a4b4cb9f3c2c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
In-Reply-To: <4dfa50520612211313g7906f3b0kbf8d7aebb2ddcda9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello everyone. This email is to let you know that W83627DHG support
has been added to the kernel source tree (Andrew Morton's -mm branch,
which is for new drivers).

Jean Delvare wrote:
> So, your patch is applied, and will be in the next -mm kernel, and
> will then go in kernel 2.6.21:
> http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/hwmon-w83627ehf-=
add-w83627dhg-support.patch

You are included in this email because some time in the last four
months you expressed interest in W83627DHG support. If you would like
to help test the new driver, the instructions are below. Please
remember to include lm-sensors at lm-sensors.org in any reply messages.

The patch attached to this email and at the URL above applies cleanly
to linux kernel versions 2.6.19-rc6, 2.6.20-rc1 or 2.6.20-rc2. Kernel
tarballs are available at:
http://www.kernel.org/pub/linux/kernel/v2.6/testing/

In addition, the driver may also work for you on 2.6.17 and 2.6.18
kernels by downloading w83627ehf.c.txt, the second attachment to this
email. Then save your original driver and copy it into the kernel
source tree. For example:

# cd /usr/src/linux/drivers/hwmon
hwmon # cp w83627ehf.c w83627ehf.c.orig
hwmon # cp w83627ehf.c.txt w83627ehf.c
hwmon # cd ../..
linux # make && make modules_install

However, if you find any bugs, the first thing you will have to do is
upgrade your kernel to the latest version. This is not an official
backport. There is an official request open for a w83627ehf.c backport
to linux 2.4. (And I would not mind anyone who wants to jump in on
that as well.)

The third attachment is a shell script I use to do basic regression
testing of the driver. If it reports any errors on your system, please
report them! This driver should not break any functionality from
previous drivers. The more important test is continuous usage of the
driver, so please load sensors, ksensors, gkrellm, or whatever
monitoring tools you normally use, and hit reply if you see anything
unusual over the next few weeks.

You may need to download the latest version of the sensors source from
http://www.lm-sensors.org/wiki/Download#SubversionRepository in order
to have W83627DHG support in user space.

Thanks for your assistance,
David

Rudolf: Can you update ticket #2142? This should resolve it.
-------------- next part --------------
This patch adds support for the w83627dhg chip.
Signed-off-by: David Hubbard <david.c.hubbard at gmail.com>

--- old/drivers/hwmon/w83627ehf.c	2006-12-21 14:04:19.000000000 -0800
+++ new/drivers/hwmon/w83627ehf.c	2006-12-24 21:53:54.000000000 -0800
@@ -32,8 +32,10 @@
=20
     Supports the following chips:
=20
-    Chip        #vin    #fan    #pwm    #temp   chip_id    man_id
-    w83627ehf   10      5       4       3       0x88,0xa1  0x5ca3
+    Chip        #vin    #fan    #pwm    #temp  chip IDs       mfg ID
+    w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
+                                               0x8860 0xa1
+    w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
 */
=20
 #include <linux/module.h>
@@ -55,8 +57,18 @@
  * Super-I/O constants and functions
  */
=20
+/*
+ * The three following globals are initialized in w83627ehf_find(), before
+ * the i2c-isa device is created. Otherwise, they could be stored in
+ * w83627ehf_data. This is ugly, but necessary. and when the driver is next
+ * updated to become a platform driver, the globals will disappear.
+ */
 static int REG;		/* The register to read/write */
 static int VAL;		/* The value to read/write */
+/* The w83627ehf/ehg have 10 voltage inputs, but the w83627dhg has 9. This
+ * value is also used in w83627ehf_detect() to export a device name in sys=
fs
+ * (e.g. w83627ehf or w83627dhg) */
+static int w83627ehf_num_in;
=20
 #define W83627EHF_LD_HWM	0x0b
=20
@@ -65,8 +77,10 @@
 #define SIO_REG_ENABLE		0x30	/* Logical device enable */
 #define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */
=20
-#define SIO_W83627EHF_ID	0x8840
-#define SIO_ID_MASK		0xFFC0
+#define SIO_W83627EHF_ID	0x8850
+#define SIO_W83627EHG_ID	0x8860
+#define SIO_W83627DHG_ID	0xa020
+#define SIO_ID_MASK		0xFFF0
=20
 static inline void
 superio_outb(int reg, int val)
@@ -115,8 +129,12 @@
=20
 #define W83627EHF_REG_BANK		0x4E
 #define W83627EHF_REG_CONFIG		0x40
-#define W83627EHF_REG_CHIP_ID		0x49
-#define W83627EHF_REG_MAN_ID		0x4F
+
+/* Not currently used:
+ * REG_MAN_ID has the value 0x5ca3 for all supported chips.
+ * REG_CHIP_ID =3D 0x88/0xa1/0xc1 depending on chip model.
+ * REG_MAN_ID is at port 0x4f
+ * REG_CHIP_ID is at port 0x58 */
=20
 static const u16 W83627EHF_REG_FAN[] =3D { 0x28, 0x29, 0x2a, 0x3f, 0x553 };
 static const u16 W83627EHF_REG_FAN_MIN[] =3D { 0x3b, 0x3c, 0x3d, 0x3e, 0x5=
5c };
@@ -429,7 +447,7 @@
 		}
=20
 		/* Measured voltages and limits */
-		for (i =3D 0; i < 10; i++) {
+		for (i =3D 0; i < w83627ehf_num_in; i++) {
 			data->in[i] =3D w83627ehf_read_value(client,
 				      W83627EHF_REG_IN(i));
 			data->in_min[i] =3D w83627ehf_read_value(client,
@@ -1121,7 +1139,7 @@
 		device_remove_file(dev, &sda_sf3_arrays[i].dev_attr);
 	for (i =3D 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
 		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
-	for (i =3D 0; i < 10; i++) {
+	for (i =3D 0; i < w83627ehf_num_in; i++) {
 		device_remove_file(dev, &sda_in_input[i].dev_attr);
 		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
 		device_remove_file(dev, &sda_in_min[i].dev_attr);
@@ -1196,7 +1214,11 @@
 	client->flags =3D 0;
 	dev =3D &client->dev;
=20
-	strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
+	if (w83627ehf_num_in =3D 9)
+		strlcpy(client->name, "w83627dhg", I2C_NAME_SIZE);
+	else	/* just say ehf. 627EHG is 627EHF in lead-free packaging. */
+		strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);
+
 	data->valid =3D 0;
 	mutex_init(&data->update_lock);
=20
@@ -1246,7 +1268,7 @@
 				goto exit_remove;
 		}
=20
-	for (i =3D 0; i < 10; i++)
+	for (i =3D 0; i < w83627ehf_num_in; i++)
 		if ((err =3D device_create_file(dev, &sda_in_input[i].dev_attr))
 			|| (err =3D device_create_file(dev,
 				&sda_in_alarm[i].dev_attr))
@@ -1340,7 +1362,17 @@
=20
 	val =3D (superio_inb(SIO_REG_DEVID) << 8)
 	    | superio_inb(SIO_REG_DEVID + 1);
-	if ((val & SIO_ID_MASK) !=3D SIO_W83627EHF_ID) {
+	switch (val & SIO_ID_MASK) {
+	case SIO_W83627DHG_ID:
+		w83627ehf_num_in =3D 9;
+		break;
+	case SIO_W83627EHF_ID:
+	case SIO_W83627EHG_ID:
+		w83627ehf_num_in =3D 10;
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
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
 Supported chips:
-  * Winbond W83627EHF/EHG (ISA access ONLY)
+  * Winbond W83627EHF/EHG/DHG (ISA access ONLY)
     Prefix: 'w83627ehf'
     Addresses scanned: ISA address retrieved from Super I/O registers
-    Datasheet: http://www.winbond-usa.com/products/winbond_products/pdfs/P=
CIC/W83627EHF_%20W83627EHGb.pdf
+    Datasheet:
+        http://www.winbond-usa.com/products/winbond_products/pdfs/PCIC/W83=
627EHF_%20W83627EHGb.pdf
+        DHG datasheet confidential.
=20
 Authors:
         Jean Delvare <khali at linux-fr.org>
         Yuan Mu (Winbond)
         Rudolf Marek <r.marek at assembler.cz>
+        David Hubbard <david.c.hubbard at gmail.com>
=20
 Description
 -----------
=20
-This driver implements support for the Winbond W83627EHF and W83627EHG
-super I/O chips. We will refer to them collectively as Winbond chips.
+This driver implements support for the Winbond W83627EHF, W83627EHG, and
+W83627DHG super I/O chips. We will refer to them collectively as Winbond c=
hips.
=20
 The chips implement three temperature sensors, five fan rotation
-speed sensors, ten analog voltage sensors, alarms with beep warnings (cont=
rol
-unimplemented), and some automatic fan regulation strategies (plus manual
-fan control mode).
+speed sensors, ten analog voltage sensors (only nine for the 627DHG), alar=
ms
+with beep warnings (control unimplemented), and some automatic fan regulat=
ion
+strategies (plus manual fan control mode).
=20
 Temperatures are measured in degrees Celsius and measurement resolution is=
 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
@@ -55,6 +58,9 @@
 /sys files
 ----------
=20
+name - this is a standard hwmon device entry. For the W83627EHF and W83627=
EHG,
+       it is set to "w83627ehf" and for the W83627DHG it is set to "w83627=
dhg"
+
 pwm[1-4] - this file stores PWM duty cycle or DC value (fan speed) in rang=
e:
 	   0 (stop) to 255 (full)
=20
@@ -83,3 +89,36 @@
=20
 Note: last two functions are influenced by other control bits, not yet exp=
orted
       by the driver, so a change might not have any effect.
+
+Implementation Details
+----------------------
+Future driver development should bear in mind that the following registers=
 have
+different functions on the 627EHF and the 627DHG. Some registers also have
+different power-on default values, but BIOS should already be loading
+appropriate defaults. Note that bank selection must be performed as is cur=
rently
+done in the driver for all register addresses.
+
+0x49:  only on DHG, selects temperature source for AUX fan, CPU fan0
+0x4a:  not completely documented for the EHF and the DHG documentation ass=
igns
+       different behavior to bits 7 and 6, including extending the tempera=
ture
+       input selection to SmartFan I, not just SmartFan III. Testing on th=
e EHF
+       will reveal whether they are compatible or not.
+
+0x58:  Chip ID: 0xa1=3DEHF 0xc1=3DDHG
+0x5e:  only on DHG, has bits to enable "current mode" temperature detectio=
n and
+       critical temperature protection
+0x45b: only on EHF, bit 3, vin4 alarm (EHF supports 10 inputs, only 9 on D=
HG)
+0x552: only on EHF, vin4
+0x558: only on EHF, vin4 high limit
+0x559: only on EHF, vin4 low limit
+0x6b:  only on DHG, SYS fan critical temperature
+0x6c:  only on DHG, CPU fan0 critical temperature
+0x6d:  only on DHG, AUX fan critical temperature
+0x6e:  only on DHG, CPU fan1 critical temperature
+
+0x50-0x55 and 0x650-0x657 are marked "Test Register" for the EHF, but "Res=
erved
+       Register" for the DHG
+
+The DHG also supports PECI, where the DHG queries Intel CPU temperatures, =
and
+the ICH8 southbridge gets that data via PECI from the DHG, so that the
+southbridge drives the fans. And the DHG supports SST, a one-wire serial b=
us.
-------------- next part --------------
/*
    w83627ehf - Driver for the hardware monitoring functionality of
                the Winbond W83627EHF Super-I/O chip
    Copyright (C) 2005  Jean Delvare <khali at linux-fr.org>
    Copyright (C) 2006  Yuan Mu (Winbond),
                        Rudolf Marek <r.marek at assembler.cz>
                        David Hubbard <david.c.hubbard at gmail.com>

    Shamelessly ripped from the w83627hf driver
    Copyright (C) 2003  Mark Studebaker

    Thanks to Leon Moonen, Steve Cliffe and Grant Coady for their help
    in testing and debugging this driver.

    This driver also supports the W83627EHG, which is the lead-free
    version of the W83627EHF.

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


    Supports the following chips:

    Chip        #vin    #fan    #pwm    #temp  chip IDs       mfg ID
    w83627ehf   10      5       4       3      0x8850 0x88    0x5ca3
                                               0x8860 0xa1
    w83627dhg    9      5       4       3      0xa020 0xc1    0x5ca3
*/

#include <linux/module.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/i2c.h>
#include <linux/i2c-isa.h>
#include <linux/hwmon.h>
#include <linux/hwmon-sysfs.h>
#include <linux/err.h>
#include <linux/mutex.h>
#include <asm/io.h>
#include "lm75.h"

/* The actual ISA address is read from Super-I/O configuration space */
static unsigned short address;

/*
 * Super-I/O constants and functions
 */

/*
 * The three following globals are initialized in w83627ehf_find(), before
 * the i2c-isa device is created. Otherwise, they could be stored in
 * w83627ehf_data. This is ugly, but necessary. and when the driver is next
 * updated to become a platform driver, the globals will disappear.
 */
static int REG;		/* The register to read/write */
static int VAL;		/* The value to read/write */
/* The w83627ehf/ehg have 10 voltage inputs, but the w83627dhg has 9. This
 * value is also used in w83627ehf_detect() to export a device name in sysfs
 * (e.g. w83627ehf or w83627dhg) */
static int w83627ehf_num_in;

#define W83627EHF_LD_HWM	0x0b

#define SIO_REG_LDSEL		0x07	/* Logical device select */
#define SIO_REG_DEVID		0x20	/* Device ID (2 bytes) */
#define SIO_REG_ENABLE		0x30	/* Logical device enable */
#define SIO_REG_ADDR		0x60	/* Logical device address (2 bytes) */

#define SIO_W83627EHF_ID	0x8850
#define SIO_W83627EHG_ID	0x8860
#define SIO_W83627DHG_ID	0xa020
#define SIO_ID_MASK		0xFFF0

static inline void
superio_outb(int reg, int val)
{
	outb(reg, REG);
	outb(val, VAL);
}

static inline int
superio_inb(int reg)
{
	outb(reg, REG);
	return inb(VAL);
}

static inline void
superio_select(int ld)
{
	outb(SIO_REG_LDSEL, REG);
	outb(ld, VAL);
}

static inline void
superio_enter(void)
{
	outb(0x87, REG);
	outb(0x87, REG);
}

static inline void
superio_exit(void)
{
	outb(0x02, REG);
	outb(0x02, VAL);
}

/*
 * ISA constants
 */

#define REGION_ALIGNMENT	~7
#define REGION_OFFSET		5
#define REGION_LENGTH		2
#define ADDR_REG_OFFSET		5
#define DATA_REG_OFFSET		6

#define W83627EHF_REG_BANK		0x4E
#define W83627EHF_REG_CONFIG		0x40

/* Not currently used:
 * REG_MAN_ID has the value 0x5ca3 for all supported chips.
 * REG_CHIP_ID =3D 0x88/0xa1/0xc1 depending on chip model.
 * REG_MAN_ID is at port 0x4f
 * REG_CHIP_ID is at port 0x58 */

static const u16 W83627EHF_REG_FAN[] =3D { 0x28, 0x29, 0x2a, 0x3f, 0x553 };
static const u16 W83627EHF_REG_FAN_MIN[] =3D { 0x3b, 0x3c, 0x3d, 0x3e, 0x55=
c };

/* The W83627EHF registers for nr=3D7,8,9 are in bank 5 */
#define W83627EHF_REG_IN_MAX(nr)	((nr < 7) ? (0x2b + (nr) * 2) : \
					 (0x554 + (((nr) - 7) * 2)))
#define W83627EHF_REG_IN_MIN(nr)	((nr < 7) ? (0x2c + (nr) * 2) : \
					 (0x555 + (((nr) - 7) * 2)))
#define W83627EHF_REG_IN(nr)		((nr < 7) ? (0x20 + (nr)) : \
					 (0x550 + (nr) - 7))

#define W83627EHF_REG_TEMP1		0x27
#define W83627EHF_REG_TEMP1_HYST	0x3a
#define W83627EHF_REG_TEMP1_OVER	0x39
static const u16 W83627EHF_REG_TEMP[] =3D { 0x150, 0x250 };
static const u16 W83627EHF_REG_TEMP_HYST[] =3D { 0x153, 0x253 };
static const u16 W83627EHF_REG_TEMP_OVER[] =3D { 0x155, 0x255 };
static const u16 W83627EHF_REG_TEMP_CONFIG[] =3D { 0x152, 0x252 };

/* Fan clock dividers are spread over the following five registers */
#define W83627EHF_REG_FANDIV1		0x47
#define W83627EHF_REG_FANDIV2		0x4B
#define W83627EHF_REG_VBAT		0x5D
#define W83627EHF_REG_DIODE		0x59
#define W83627EHF_REG_SMI_OVT		0x4C

#define W83627EHF_REG_ALARM1		0x459
#define W83627EHF_REG_ALARM2		0x45A
#define W83627EHF_REG_ALARM3		0x45B

/* SmartFan registers */
/* DC or PWM output fan configuration */
static const u8 W83627EHF_REG_PWM_ENABLE[] =3D {
	0x04,			/* SYS FAN0 output mode and PWM mode */
	0x04,			/* CPU FAN0 output mode and PWM mode */
	0x12,			/* AUX FAN mode */
	0x62,			/* CPU fan1 mode */
};

static const u8 W83627EHF_PWM_MODE_SHIFT[] =3D { 0, 1, 0, 6 };
static const u8 W83627EHF_PWM_ENABLE_SHIFT[] =3D { 2, 4, 1, 4 };

/* FAN Duty Cycle, be used to control */
static const u8 W83627EHF_REG_PWM[] =3D { 0x01, 0x03, 0x11, 0x61 };
static const u8 W83627EHF_REG_TARGET[] =3D { 0x05, 0x06, 0x13, 0x63 };
static const u8 W83627EHF_REG_TOLERANCE[] =3D { 0x07, 0x07, 0x14, 0x62 };


/* Advanced Fan control, some values are common for all fans */
static const u8 W83627EHF_REG_FAN_MIN_OUTPUT[] =3D { 0x08, 0x09, 0x15, 0x64=
 };
static const u8 W83627EHF_REG_FAN_STOP_TIME[] =3D { 0x0C, 0x0D, 0x17, 0x66 =
};

/*
 * Conversions
 */

/* 1 is PWM mode, output in ms */
static inline unsigned int step_time_from_reg(u8 reg, u8 mode)
{
	return mode ? 100 * reg : 400 * reg;
}

static inline u8 step_time_to_reg(unsigned int msec, u8 mode)
{
	return SENSORS_LIMIT((mode ? (msec + 50) / 100 :
						(msec + 200) / 400), 1, 255);
}

static inline unsigned int
fan_from_reg(u8 reg, unsigned int div)
{
	if (reg =3D 0 || reg =3D 255)
		return 0;
	return 1350000U / (reg * div);
}

static inline unsigned int
div_from_reg(u8 reg)
{
	return 1 << reg;
}

static inline int
temp1_from_reg(s8 reg)
{
	return reg * 1000;
}

static inline s8
temp1_to_reg(int temp, int min, int max)
{
	if (temp <=3D min)
		return min / 1000;
	if (temp >=3D max)
		return max / 1000;
	if (temp < 0)
		return (temp - 500) / 1000;
	return (temp + 500) / 1000;
}

/* Some of analog inputs have internal scaling (2x), 8mV is ADC LSB */

static u8 scale_in[10] =3D { 8, 8, 16, 16, 8, 8, 8, 16, 16, 8 };

static inline long in_from_reg(u8 reg, u8 nr)
{
	return reg * scale_in[nr];
}

static inline u8 in_to_reg(u32 val, u8 nr)
{
	return SENSORS_LIMIT(((val + (scale_in[nr] / 2)) / scale_in[nr]), 0, 255);
}

/*
 * Data structures and manipulation thereof
 */

struct w83627ehf_data {
	struct i2c_client client;
	struct class_device *class_dev;
	struct mutex lock;

	struct mutex update_lock;
	char valid;		/* !=3D0 if following fields are valid */
	unsigned long last_updated;	/* In jiffies */

	/* Register values */
	u8 in[10];		/* Register value */
	u8 in_max[10];		/* Register value */
	u8 in_min[10];		/* Register value */
	u8 fan[5];
	u8 fan_min[5];
	u8 fan_div[5];
	u8 has_fan;		/* some fan inputs can be disabled */
	s8 temp1;
	s8 temp1_max;
	s8 temp1_max_hyst;
	s16 temp[2];
	s16 temp_max[2];
	s16 temp_max_hyst[2];
	u32 alarms;

	u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable duty cycle */
	u8 pwm_enable[4]; /* 1->manual
			     2->thermal cruise (also called SmartFan I) */
	u8 pwm[4];
	u8 target_temp[4];
	u8 tolerance[4];

	u8 fan_min_output[4]; /* minimum fan speed */
	u8 fan_stop_time[4];
};

static inline int is_word_sized(u16 reg)
{
	return (((reg & 0xff00) =3D 0x100
	      || (reg & 0xff00) =3D 0x200)
	     && ((reg & 0x00ff) =3D 0x50
	      || (reg & 0x00ff) =3D 0x53
	      || (reg & 0x00ff) =3D 0x55));
}

/* We assume that the default bank is 0, thus the following two functions do
   nothing for registers which live in bank 0. For others, they respectively
   set the bank register to the correct value (before the register is
   accessed), and back to 0 (afterwards). */
static inline void w83627ehf_set_bank(struct i2c_client *client, u16 reg)
{
	if (reg & 0xff00) {
		outb_p(W83627EHF_REG_BANK, client->addr + ADDR_REG_OFFSET);
		outb_p(reg >> 8, client->addr + DATA_REG_OFFSET);
	}
}

static inline void w83627ehf_reset_bank(struct i2c_client *client, u16 reg)
{
	if (reg & 0xff00) {
		outb_p(W83627EHF_REG_BANK, client->addr + ADDR_REG_OFFSET);
		outb_p(0, client->addr + DATA_REG_OFFSET);
	}
}

static u16 w83627ehf_read_value(struct i2c_client *client, u16 reg)
{
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	int res, word_sized =3D is_word_sized(reg);

	mutex_lock(&data->lock);

	w83627ehf_set_bank(client, reg);
	outb_p(reg & 0xff, client->addr + ADDR_REG_OFFSET);
	res =3D inb_p(client->addr + DATA_REG_OFFSET);
	if (word_sized) {
		outb_p((reg & 0xff) + 1,
		       client->addr + ADDR_REG_OFFSET);
		res =3D (res << 8) + inb_p(client->addr + DATA_REG_OFFSET);
	}
	w83627ehf_reset_bank(client, reg);

	mutex_unlock(&data->lock);

	return res;
}

static int w83627ehf_write_value(struct i2c_client *client, u16 reg, u16 va=
lue)
{
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	int word_sized =3D is_word_sized(reg);

	mutex_lock(&data->lock);

	w83627ehf_set_bank(client, reg);
	outb_p(reg & 0xff, client->addr + ADDR_REG_OFFSET);
	if (word_sized) {
		outb_p(value >> 8, client->addr + DATA_REG_OFFSET);
		outb_p((reg & 0xff) + 1,
		       client->addr + ADDR_REG_OFFSET);
	}
	outb_p(value & 0xff, client->addr + DATA_REG_OFFSET);
	w83627ehf_reset_bank(client, reg);

	mutex_unlock(&data->lock);
	return 0;
}

/* This function assumes that the caller holds data->update_lock */
static void w83627ehf_write_fan_div(struct i2c_client *client, int nr)
{
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	u8 reg;

	switch (nr) {
	case 0:
		reg =3D (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0xcf)
		    | ((data->fan_div[0] & 0x03) << 4);
		/* fan5 input control bit is write only, compute the value */
		reg |=3D (data->has_fan & (1 << 4)) ? 1 : 0;
		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
		reg =3D (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xdf)
		    | ((data->fan_div[0] & 0x04) << 3);
		w83627ehf_write_value(client, W83627EHF_REG_VBAT, reg);
		break;
	case 1:
		reg =3D (w83627ehf_read_value(client, W83627EHF_REG_FANDIV1) & 0x3f)
		    | ((data->fan_div[1] & 0x03) << 6);
		/* fan5 input control bit is write only, compute the value */
		reg |=3D (data->has_fan & (1 << 4)) ? 1 : 0;
		w83627ehf_write_value(client, W83627EHF_REG_FANDIV1, reg);
		reg =3D (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0xbf)
		    | ((data->fan_div[1] & 0x04) << 4);
		w83627ehf_write_value(client, W83627EHF_REG_VBAT, reg);
		break;
	case 2:
		reg =3D (w83627ehf_read_value(client, W83627EHF_REG_FANDIV2) & 0x3f)
		    | ((data->fan_div[2] & 0x03) << 6);
		w83627ehf_write_value(client, W83627EHF_REG_FANDIV2, reg);
		reg =3D (w83627ehf_read_value(client, W83627EHF_REG_VBAT) & 0x7f)
		    | ((data->fan_div[2] & 0x04) << 5);
		w83627ehf_write_value(client, W83627EHF_REG_VBAT, reg);
		break;
	case 3:
		reg =3D (w83627ehf_read_value(client, W83627EHF_REG_DIODE) & 0xfc)
		    | (data->fan_div[3] & 0x03);
		w83627ehf_write_value(client, W83627EHF_REG_DIODE, reg);
		reg =3D (w83627ehf_read_value(client, W83627EHF_REG_SMI_OVT) & 0x7f)
		    | ((data->fan_div[3] & 0x04) << 5);
		w83627ehf_write_value(client, W83627EHF_REG_SMI_OVT, reg);
		break;
	case 4:
		reg =3D (w83627ehf_read_value(client, W83627EHF_REG_DIODE) & 0x73)
		    | ((data->fan_div[4] & 0x03) << 3)
		    | ((data->fan_div[4] & 0x04) << 5);
		w83627ehf_write_value(client, W83627EHF_REG_DIODE, reg);
		break;
	}
}

static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
{
	struct i2c_client *client =3D to_i2c_client(dev);
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	int pwmcfg =3D 0, tolerance =3D 0; /* shut up the compiler */
	int i;

	mutex_lock(&data->update_lock);

	if (time_after(jiffies, data->last_updated + HZ)
	 || !data->valid) {
		/* Fan clock dividers */
		i =3D w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
		data->fan_div[0] =3D (i >> 4) & 0x03;
		data->fan_div[1] =3D (i >> 6) & 0x03;
		i =3D w83627ehf_read_value(client, W83627EHF_REG_FANDIV2);
		data->fan_div[2] =3D (i >> 6) & 0x03;
		i =3D w83627ehf_read_value(client, W83627EHF_REG_VBAT);
		data->fan_div[0] |=3D (i >> 3) & 0x04;
		data->fan_div[1] |=3D (i >> 4) & 0x04;
		data->fan_div[2] |=3D (i >> 5) & 0x04;
		if (data->has_fan & ((1 << 3) | (1 << 4))) {
			i =3D w83627ehf_read_value(client, W83627EHF_REG_DIODE);
			data->fan_div[3] =3D i & 0x03;
			data->fan_div[4] =3D ((i >> 2) & 0x03)
					 | ((i >> 5) & 0x04);
		}
		if (data->has_fan & (1 << 3)) {
			i =3D w83627ehf_read_value(client, W83627EHF_REG_SMI_OVT);
			data->fan_div[3] |=3D (i >> 5) & 0x04;
		}

		/* Measured voltages and limits */
		for (i =3D 0; i < w83627ehf_num_in; i++) {
			data->in[i] =3D w83627ehf_read_value(client,
				      W83627EHF_REG_IN(i));
			data->in_min[i] =3D w83627ehf_read_value(client,
					  W83627EHF_REG_IN_MIN(i));
			data->in_max[i] =3D w83627ehf_read_value(client,
					  W83627EHF_REG_IN_MAX(i));
		}

		/* Measured fan speeds and limits */
		for (i =3D 0; i < 5; i++) {
			if (!(data->has_fan & (1 << i)))
				continue;

			data->fan[i] =3D w83627ehf_read_value(client,
				       W83627EHF_REG_FAN[i]);
			data->fan_min[i] =3D w83627ehf_read_value(client,
					   W83627EHF_REG_FAN_MIN[i]);

			/* If we failed to measure the fan speed and clock
			   divider can be increased, let's try that for next
			   time */
			if (data->fan[i] =3D 0xff
			 && data->fan_div[i] < 0x07) {
			 	dev_dbg(&client->dev, "Increasing fan %d "
					"clock divider from %u to %u\n",
					i, div_from_reg(data->fan_div[i]),
					div_from_reg(data->fan_div[i] + 1));
				data->fan_div[i]++;
				w83627ehf_write_fan_div(client, i);
				/* Preserve min limit if possible */
				if (data->fan_min[i] >=3D 2
				 && data->fan_min[i] !=3D 255)
					w83627ehf_write_value(client,
						W83627EHF_REG_FAN_MIN[i],
						(data->fan_min[i] /=3D 2));
			}
		}

		for (i =3D 0; i < 4; i++) {
			/* pwmcfg, tolarance mapped for i=3D0, i=3D1 to same reg */
			if (i !=3D 1) {
				pwmcfg =3D w83627ehf_read_value(client,
						W83627EHF_REG_PWM_ENABLE[i]);
				tolerance =3D w83627ehf_read_value(client,
						W83627EHF_REG_TOLERANCE[i]);
			}
			data->pwm_mode[i] 				((pwmcfg >> W83627EHF_PWM_MODE_SHIFT[i]) & 1)
				? 0 : 1;
			data->pwm_enable[i] 					((pwmcfg >> W83627EHF_PWM_ENABLE_SHIFT[i])
						& 3) + 1;
			data->pwm[i] =3D w83627ehf_read_value(client,
						W83627EHF_REG_PWM[i]);
			data->fan_min_output[i] =3D w83627ehf_read_value(client,
						W83627EHF_REG_FAN_MIN_OUTPUT[i]);
			data->fan_stop_time[i] =3D w83627ehf_read_value(client,
						W83627EHF_REG_FAN_STOP_TIME[i]);
			data->target_temp[i] 				w83627ehf_read_value(client,
					W83627EHF_REG_TARGET[i]) &
					(data->pwm_mode[i] =3D 1 ? 0x7f : 0xff);
			data->tolerance[i] =3D (tolerance >> (i =3D 1 ? 4 : 0))
									& 0x0f;
		}

		/* Measured temperatures and limits */
		data->temp1 =3D w83627ehf_read_value(client,
			      W83627EHF_REG_TEMP1);
		data->temp1_max =3D w83627ehf_read_value(client,
				  W83627EHF_REG_TEMP1_OVER);
		data->temp1_max_hyst =3D w83627ehf_read_value(client,
				       W83627EHF_REG_TEMP1_HYST);
		for (i =3D 0; i < 2; i++) {
			data->temp[i] =3D w83627ehf_read_value(client,
					W83627EHF_REG_TEMP[i]);
			data->temp_max[i] =3D w83627ehf_read_value(client,
					    W83627EHF_REG_TEMP_OVER[i]);
			data->temp_max_hyst[i] =3D w83627ehf_read_value(client,
						 W83627EHF_REG_TEMP_HYST[i]);
		}

		data->alarms =3D w83627ehf_read_value(client,
					W83627EHF_REG_ALARM1) |
			       (w83627ehf_read_value(client,
					W83627EHF_REG_ALARM2) << 8) |
			       (w83627ehf_read_value(client,
					W83627EHF_REG_ALARM3) << 16);

		data->last_updated =3D jiffies;
		data->valid =3D 1;
	}

	mutex_unlock(&data->update_lock);
	return data;
}

/*
 * Sysfs callback functions
 */
#define show_in_reg(reg) \
static ssize_t \
show_##reg(struct device *dev, struct device_attribute *attr, \
	   char *buf) \
{ \
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	return sprintf(buf, "%ld\n", in_from_reg(data->reg[nr], nr)); \
}
show_in_reg(in)
show_in_reg(in_min)
show_in_reg(in_max)

#define store_in_reg(REG, reg) \
static ssize_t \
store_in_##reg (struct device *dev, struct device_attribute *attr, \
			const char *buf, size_t count) \
{ \
	struct i2c_client *client =3D to_i2c_client(dev); \
	struct w83627ehf_data *data =3D i2c_get_clientdata(client); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	u32 val =3D simple_strtoul(buf, NULL, 10); \
 \
	mutex_lock(&data->update_lock); \
	data->in_##reg[nr] =3D in_to_reg(val, nr); \
	w83627ehf_write_value(client, W83627EHF_REG_IN_##REG(nr), \
			      data->in_##reg[nr]); \
	mutex_unlock(&data->update_lock); \
	return count; \
}

store_in_reg(MIN, min)
store_in_reg(MAX, max)

static ssize_t show_alarm(struct device *dev, struct device_attribute *attr=
, char *buf)
{
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev);
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
	int nr =3D sensor_attr->index;
	return sprintf(buf, "%u\n", (data->alarms >> nr) & 0x01);
}

static struct sensor_device_attribute sda_in_input[] =3D {
	SENSOR_ATTR(in0_input, S_IRUGO, show_in, NULL, 0),
	SENSOR_ATTR(in1_input, S_IRUGO, show_in, NULL, 1),
	SENSOR_ATTR(in2_input, S_IRUGO, show_in, NULL, 2),
	SENSOR_ATTR(in3_input, S_IRUGO, show_in, NULL, 3),
	SENSOR_ATTR(in4_input, S_IRUGO, show_in, NULL, 4),
	SENSOR_ATTR(in5_input, S_IRUGO, show_in, NULL, 5),
	SENSOR_ATTR(in6_input, S_IRUGO, show_in, NULL, 6),
	SENSOR_ATTR(in7_input, S_IRUGO, show_in, NULL, 7),
	SENSOR_ATTR(in8_input, S_IRUGO, show_in, NULL, 8),
	SENSOR_ATTR(in9_input, S_IRUGO, show_in, NULL, 9),
};

static struct sensor_device_attribute sda_in_alarm[] =3D {
	SENSOR_ATTR(in0_alarm, S_IRUGO, show_alarm, NULL, 0),
	SENSOR_ATTR(in1_alarm, S_IRUGO, show_alarm, NULL, 1),
	SENSOR_ATTR(in2_alarm, S_IRUGO, show_alarm, NULL, 2),
	SENSOR_ATTR(in3_alarm, S_IRUGO, show_alarm, NULL, 3),
	SENSOR_ATTR(in4_alarm, S_IRUGO, show_alarm, NULL, 8),
	SENSOR_ATTR(in5_alarm, S_IRUGO, show_alarm, NULL, 21),
	SENSOR_ATTR(in6_alarm, S_IRUGO, show_alarm, NULL, 20),
	SENSOR_ATTR(in7_alarm, S_IRUGO, show_alarm, NULL, 16),
	SENSOR_ATTR(in8_alarm, S_IRUGO, show_alarm, NULL, 17),
	SENSOR_ATTR(in9_alarm, S_IRUGO, show_alarm, NULL, 19),
};

static struct sensor_device_attribute sda_in_min[] =3D {
       SENSOR_ATTR(in0_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 0=
),
       SENSOR_ATTR(in1_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 1=
),
       SENSOR_ATTR(in2_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 2=
),
       SENSOR_ATTR(in3_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 3=
),
       SENSOR_ATTR(in4_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 4=
),
       SENSOR_ATTR(in5_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 5=
),
       SENSOR_ATTR(in6_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 6=
),
       SENSOR_ATTR(in7_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 7=
),
       SENSOR_ATTR(in8_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 8=
),
       SENSOR_ATTR(in9_min, S_IWUSR | S_IRUGO, show_in_min, store_in_min, 9=
),
};

static struct sensor_device_attribute sda_in_max[] =3D {
       SENSOR_ATTR(in0_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 0=
),
       SENSOR_ATTR(in1_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 1=
),
       SENSOR_ATTR(in2_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 2=
),
       SENSOR_ATTR(in3_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 3=
),
       SENSOR_ATTR(in4_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 4=
),
       SENSOR_ATTR(in5_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 5=
),
       SENSOR_ATTR(in6_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 6=
),
       SENSOR_ATTR(in7_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 7=
),
       SENSOR_ATTR(in8_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 8=
),
       SENSOR_ATTR(in9_max, S_IWUSR | S_IRUGO, show_in_max, store_in_max, 9=
),
};

#define show_fan_reg(reg) \
static ssize_t \
show_##reg(struct device *dev, struct device_attribute *attr, \
	   char *buf) \
{ \
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	return sprintf(buf, "%d\n", \
		       fan_from_reg(data->reg[nr], \
				    div_from_reg(data->fan_div[nr]))); \
}
show_fan_reg(fan);
show_fan_reg(fan_min);

static ssize_t
show_fan_div(struct device *dev, struct device_attribute *attr,
	     char *buf)
{
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev);
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
	int nr =3D sensor_attr->index;
	return sprintf(buf, "%u\n", div_from_reg(data->fan_div[nr]));
}

static ssize_t
store_fan_min(struct device *dev, struct device_attribute *attr,
	      const char *buf, size_t count)
{
	struct i2c_client *client =3D to_i2c_client(dev);
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
	int nr =3D sensor_attr->index;
	unsigned int val =3D simple_strtoul(buf, NULL, 10);
	unsigned int reg;
	u8 new_div;

	mutex_lock(&data->update_lock);
	if (!val) {
		/* No min limit, alarm disabled */
		data->fan_min[nr] =3D 255;
		new_div =3D data->fan_div[nr]; /* No change */
		dev_info(dev, "fan%u low limit and alarm disabled\n", nr + 1);
	} else if ((reg =3D 1350000U / val) >=3D 128 * 255) {
		/* Speed below this value cannot possibly be represented,
		   even with the highest divider (128) */
		data->fan_min[nr] =3D 254;
		new_div =3D 7; /* 128 =3D (1 << 7) */
		dev_warn(dev, "fan%u low limit %u below minimum %u, set to "
			 "minimum\n", nr + 1, val, fan_from_reg(254, 128));
	} else if (!reg) {
		/* Speed above this value cannot possibly be represented,
		   even with the lowest divider (1) */
		data->fan_min[nr] =3D 1;
		new_div =3D 0; /* 1 =3D (1 << 0) */
		dev_warn(dev, "fan%u low limit %u above maximum %u, set to "
			 "maximum\n", nr + 1, val, fan_from_reg(1, 1));
	} else {
		/* Automatically pick the best divider, i.e. the one such
		   that the min limit will correspond to a register value
		   in the 96..192 range */
		new_div =3D 0;
		while (reg > 192 && new_div < 7) {
			reg >>=3D 1;
			new_div++;
		}
		data->fan_min[nr] =3D reg;
	}

	/* Write both the fan clock divider (if it changed) and the new
	   fan min (unconditionally) */
	if (new_div !=3D data->fan_div[nr]) {
		if (new_div > data->fan_div[nr])
			data->fan[nr] >>=3D (data->fan_div[nr] - new_div);
		else
			data->fan[nr] <<=3D (new_div - data->fan_div[nr]);

		dev_dbg(dev, "fan%u clock divider changed from %u to %u\n",
			nr + 1, div_from_reg(data->fan_div[nr]),
			div_from_reg(new_div));
		data->fan_div[nr] =3D new_div;
		w83627ehf_write_fan_div(client, nr);
	}
	w83627ehf_write_value(client, W83627EHF_REG_FAN_MIN[nr],
			      data->fan_min[nr]);
	mutex_unlock(&data->update_lock);

	return count;
}

static struct sensor_device_attribute sda_fan_input[] =3D {
	SENSOR_ATTR(fan1_input, S_IRUGO, show_fan, NULL, 0),
	SENSOR_ATTR(fan2_input, S_IRUGO, show_fan, NULL, 1),
	SENSOR_ATTR(fan3_input, S_IRUGO, show_fan, NULL, 2),
	SENSOR_ATTR(fan4_input, S_IRUGO, show_fan, NULL, 3),
	SENSOR_ATTR(fan5_input, S_IRUGO, show_fan, NULL, 4),
};

static struct sensor_device_attribute sda_fan_alarm[] =3D {
	SENSOR_ATTR(fan1_alarm, S_IRUGO, show_alarm, NULL, 6),
	SENSOR_ATTR(fan2_alarm, S_IRUGO, show_alarm, NULL, 7),
	SENSOR_ATTR(fan3_alarm, S_IRUGO, show_alarm, NULL, 11),
	SENSOR_ATTR(fan4_alarm, S_IRUGO, show_alarm, NULL, 10),
	SENSOR_ATTR(fan5_alarm, S_IRUGO, show_alarm, NULL, 23),
};

static struct sensor_device_attribute sda_fan_min[] =3D {
	SENSOR_ATTR(fan1_min, S_IWUSR | S_IRUGO, show_fan_min,
		    store_fan_min, 0),
	SENSOR_ATTR(fan2_min, S_IWUSR | S_IRUGO, show_fan_min,
		    store_fan_min, 1),
	SENSOR_ATTR(fan3_min, S_IWUSR | S_IRUGO, show_fan_min,
		    store_fan_min, 2),
	SENSOR_ATTR(fan4_min, S_IWUSR | S_IRUGO, show_fan_min,
		    store_fan_min, 3),
	SENSOR_ATTR(fan5_min, S_IWUSR | S_IRUGO, show_fan_min,
		    store_fan_min, 4),
};

static struct sensor_device_attribute sda_fan_div[] =3D {
	SENSOR_ATTR(fan1_div, S_IRUGO, show_fan_div, NULL, 0),
	SENSOR_ATTR(fan2_div, S_IRUGO, show_fan_div, NULL, 1),
	SENSOR_ATTR(fan3_div, S_IRUGO, show_fan_div, NULL, 2),
	SENSOR_ATTR(fan4_div, S_IRUGO, show_fan_div, NULL, 3),
	SENSOR_ATTR(fan5_div, S_IRUGO, show_fan_div, NULL, 4),
};

#define show_temp1_reg(reg) \
static ssize_t \
show_##reg(struct device *dev, struct device_attribute *attr, \
	   char *buf) \
{ \
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev); \
	return sprintf(buf, "%d\n", temp1_from_reg(data->reg)); \
}
show_temp1_reg(temp1);
show_temp1_reg(temp1_max);
show_temp1_reg(temp1_max_hyst);

#define store_temp1_reg(REG, reg) \
static ssize_t \
store_temp1_##reg(struct device *dev, struct device_attribute *attr, \
		  const char *buf, size_t count) \
{ \
	struct i2c_client *client =3D to_i2c_client(dev); \
	struct w83627ehf_data *data =3D i2c_get_clientdata(client); \
	u32 val =3D simple_strtoul(buf, NULL, 10); \
 \
	mutex_lock(&data->update_lock); \
	data->temp1_##reg =3D temp1_to_reg(val, -128000, 127000); \
	w83627ehf_write_value(client, W83627EHF_REG_TEMP1_##REG, \
			      data->temp1_##reg); \
	mutex_unlock(&data->update_lock); \
	return count; \
}
store_temp1_reg(OVER, max);
store_temp1_reg(HYST, max_hyst);

#define show_temp_reg(reg) \
static ssize_t \
show_##reg(struct device *dev, struct device_attribute *attr, \
	   char *buf) \
{ \
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	return sprintf(buf, "%d\n", \
		       LM75_TEMP_FROM_REG(data->reg[nr])); \
}
show_temp_reg(temp);
show_temp_reg(temp_max);
show_temp_reg(temp_max_hyst);

#define store_temp_reg(REG, reg) \
static ssize_t \
store_##reg(struct device *dev, struct device_attribute *attr, \
	    const char *buf, size_t count) \
{ \
	struct i2c_client *client =3D to_i2c_client(dev); \
	struct w83627ehf_data *data =3D i2c_get_clientdata(client); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	u32 val =3D simple_strtoul(buf, NULL, 10); \
 \
	mutex_lock(&data->update_lock); \
	data->reg[nr] =3D LM75_TEMP_TO_REG(val); \
	w83627ehf_write_value(client, W83627EHF_REG_TEMP_##REG[nr], \
			      data->reg[nr]); \
	mutex_unlock(&data->update_lock); \
	return count; \
}
store_temp_reg(OVER, temp_max);
store_temp_reg(HYST, temp_max_hyst);

static struct sensor_device_attribute sda_temp[] =3D {
	SENSOR_ATTR(temp1_input, S_IRUGO, show_temp1, NULL, 0),
	SENSOR_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 0),
	SENSOR_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 1),
	SENSOR_ATTR(temp1_max, S_IRUGO | S_IWUSR, show_temp1_max,
		    store_temp1_max, 0),
	SENSOR_ATTR(temp2_max, S_IRUGO | S_IWUSR, show_temp_max,
		    store_temp_max, 0),
	SENSOR_ATTR(temp3_max, S_IRUGO | S_IWUSR, show_temp_max,
		    store_temp_max, 1),
	SENSOR_ATTR(temp1_max_hyst, S_IRUGO | S_IWUSR, show_temp1_max_hyst,
		    store_temp1_max_hyst, 0),
	SENSOR_ATTR(temp2_max_hyst, S_IRUGO | S_IWUSR, show_temp_max_hyst,
		    store_temp_max_hyst, 0),
	SENSOR_ATTR(temp3_max_hyst, S_IRUGO | S_IWUSR, show_temp_max_hyst,
		    store_temp_max_hyst, 1),
	SENSOR_ATTR(temp1_alarm, S_IRUGO, show_alarm, NULL, 4),
	SENSOR_ATTR(temp2_alarm, S_IRUGO, show_alarm, NULL, 5),
	SENSOR_ATTR(temp3_alarm, S_IRUGO, show_alarm, NULL, 13),
};

#define show_pwm_reg(reg) \
static ssize_t show_##reg (struct device *dev, struct device_attribute *att=
r, \
				char *buf) \
{ \
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	return sprintf(buf, "%d\n", data->reg[nr]); \
}

show_pwm_reg(pwm_mode)
show_pwm_reg(pwm_enable)
show_pwm_reg(pwm)

static ssize_t
store_pwm_mode(struct device *dev, struct device_attribute *attr,
			const char *buf, size_t count)
{
	struct i2c_client *client =3D to_i2c_client(dev);
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
	int nr =3D sensor_attr->index;
	u32 val =3D simple_strtoul(buf, NULL, 10);
	u16 reg;

	if (val > 1)
		return -EINVAL;
	mutex_lock(&data->update_lock);
	reg =3D w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
	data->pwm_mode[nr] =3D val;
	reg &=3D ~(1 << W83627EHF_PWM_MODE_SHIFT[nr]);
	if (!val)
		reg |=3D 1 << W83627EHF_PWM_MODE_SHIFT[nr];
	w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr], reg);
	mutex_unlock(&data->update_lock);
	return count;
}

static ssize_t
store_pwm(struct device *dev, struct device_attribute *attr,
			const char *buf, size_t count)
{
	struct i2c_client *client =3D to_i2c_client(dev);
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
	int nr =3D sensor_attr->index;
	u32 val =3D SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 0, 255);

	mutex_lock(&data->update_lock);
	data->pwm[nr] =3D val;
	w83627ehf_write_value(client, W83627EHF_REG_PWM[nr], val);
	mutex_unlock(&data->update_lock);
	return count;
}

static ssize_t
store_pwm_enable(struct device *dev, struct device_attribute *attr,
			const char *buf, size_t count)
{
	struct i2c_client *client =3D to_i2c_client(dev);
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
	int nr =3D sensor_attr->index;
	u32 val =3D simple_strtoul(buf, NULL, 10);
	u16 reg;

	if (!val || (val > 2))	/* only modes 1 and 2 are supported */
		return -EINVAL;
	mutex_lock(&data->update_lock);
	reg =3D w83627ehf_read_value(client, W83627EHF_REG_PWM_ENABLE[nr]);
	data->pwm_enable[nr] =3D val;
	reg &=3D ~(0x03 << W83627EHF_PWM_ENABLE_SHIFT[nr]);
	reg |=3D (val - 1) << W83627EHF_PWM_ENABLE_SHIFT[nr];
	w83627ehf_write_value(client, W83627EHF_REG_PWM_ENABLE[nr], reg);
	mutex_unlock(&data->update_lock);
	return count;
}


#define show_tol_temp(reg) \
static ssize_t show_##reg(struct device *dev, struct device_attribute *attr=
, \
				char *buf) \
{ \
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	return sprintf(buf, "%d\n", temp1_from_reg(data->reg[nr])); \
}

show_tol_temp(tolerance)
show_tol_temp(target_temp)

static ssize_t
store_target_temp(struct device *dev, struct device_attribute *attr,
			const char *buf, size_t count)
{
	struct i2c_client *client =3D to_i2c_client(dev);
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
	int nr =3D sensor_attr->index;
	u8 val =3D temp1_to_reg(simple_strtoul(buf, NULL, 10), 0, 127000);

	mutex_lock(&data->update_lock);
	data->target_temp[nr] =3D val;
	w83627ehf_write_value(client, W83627EHF_REG_TARGET[nr], val);
	mutex_unlock(&data->update_lock);
	return count;
}

static ssize_t
store_tolerance(struct device *dev, struct device_attribute *attr,
			const char *buf, size_t count)
{
	struct i2c_client *client =3D to_i2c_client(dev);
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr);
	int nr =3D sensor_attr->index;
	u16 reg;
	/* Limit the temp to 0C - 15C */
	u8 val =3D temp1_to_reg(simple_strtoul(buf, NULL, 10), 0, 15000);

	mutex_lock(&data->update_lock);
	reg =3D w83627ehf_read_value(client, W83627EHF_REG_TOLERANCE[nr]);
	data->tolerance[nr] =3D val;
	if (nr =3D 1)
		reg =3D (reg & 0x0f) | (val << 4);
	else
		reg =3D (reg & 0xf0) | val;
	w83627ehf_write_value(client, W83627EHF_REG_TOLERANCE[nr], reg);
	mutex_unlock(&data->update_lock);
	return count;
}

static struct sensor_device_attribute sda_pwm[] =3D {
	SENSOR_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0),
	SENSOR_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1),
	SENSOR_ATTR(pwm3, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 2),
	SENSOR_ATTR(pwm4, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 3),
};

static struct sensor_device_attribute sda_pwm_mode[] =3D {
	SENSOR_ATTR(pwm1_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
		    store_pwm_mode, 0),
	SENSOR_ATTR(pwm2_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
		    store_pwm_mode, 1),
	SENSOR_ATTR(pwm3_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
		    store_pwm_mode, 2),
	SENSOR_ATTR(pwm4_mode, S_IWUSR | S_IRUGO, show_pwm_mode,
		    store_pwm_mode, 3),
};

static struct sensor_device_attribute sda_pwm_enable[] =3D {
	SENSOR_ATTR(pwm1_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
		    store_pwm_enable, 0),
	SENSOR_ATTR(pwm2_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
		    store_pwm_enable, 1),
	SENSOR_ATTR(pwm3_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
		    store_pwm_enable, 2),
	SENSOR_ATTR(pwm4_enable, S_IWUSR | S_IRUGO, show_pwm_enable,
		    store_pwm_enable, 3),
};

static struct sensor_device_attribute sda_target_temp[] =3D {
	SENSOR_ATTR(pwm1_target, S_IWUSR | S_IRUGO, show_target_temp,
		    store_target_temp, 0),
	SENSOR_ATTR(pwm2_target, S_IWUSR | S_IRUGO, show_target_temp,
		    store_target_temp, 1),
	SENSOR_ATTR(pwm3_target, S_IWUSR | S_IRUGO, show_target_temp,
		    store_target_temp, 2),
	SENSOR_ATTR(pwm4_target, S_IWUSR | S_IRUGO, show_target_temp,
		    store_target_temp, 3),
};

static struct sensor_device_attribute sda_tolerance[] =3D {
	SENSOR_ATTR(pwm1_tolerance, S_IWUSR | S_IRUGO, show_tolerance,
		    store_tolerance, 0),
	SENSOR_ATTR(pwm2_tolerance, S_IWUSR | S_IRUGO, show_tolerance,
		    store_tolerance, 1),
	SENSOR_ATTR(pwm3_tolerance, S_IWUSR | S_IRUGO, show_tolerance,
		    store_tolerance, 2),
	SENSOR_ATTR(pwm4_tolerance, S_IWUSR | S_IRUGO, show_tolerance,
		    store_tolerance, 3),
};

/* Smart Fan registers */

#define fan_functions(reg, REG) \
static ssize_t show_##reg(struct device *dev, struct device_attribute *attr=
, \
		       char *buf) \
{ \
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	return sprintf(buf, "%d\n", data->reg[nr]); \
}\
static ssize_t \
store_##reg(struct device *dev, struct device_attribute *attr, \
			    const char *buf, size_t count) \
{\
	struct i2c_client *client =3D to_i2c_client(dev); \
	struct w83627ehf_data *data =3D i2c_get_clientdata(client); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	u32 val =3D SENSORS_LIMIT(simple_strtoul(buf, NULL, 10), 1, 255); \
	mutex_lock(&data->update_lock); \
	data->reg[nr] =3D val; \
	w83627ehf_write_value(client, W83627EHF_REG_##REG[nr],  val); \
	mutex_unlock(&data->update_lock); \
	return count; \
}

fan_functions(fan_min_output, FAN_MIN_OUTPUT)

#define fan_time_functions(reg, REG) \
static ssize_t show_##reg(struct device *dev, struct device_attribute *attr=
, \
				char *buf) \
{ \
	struct w83627ehf_data *data =3D w83627ehf_update_device(dev); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	return sprintf(buf, "%d\n", \
			step_time_from_reg(data->reg[nr], data->pwm_mode[nr])); \
} \
\
static ssize_t \
store_##reg(struct device *dev, struct device_attribute *attr, \
			const char *buf, size_t count) \
{ \
	struct i2c_client *client =3D to_i2c_client(dev); \
	struct w83627ehf_data *data =3D i2c_get_clientdata(client); \
	struct sensor_device_attribute *sensor_attr =3D to_sensor_dev_attr(attr); \
	int nr =3D sensor_attr->index; \
	u8 val =3D step_time_to_reg(simple_strtoul(buf, NULL, 10), \
					data->pwm_mode[nr]); \
	mutex_lock(&data->update_lock); \
	data->reg[nr] =3D val; \
	w83627ehf_write_value(client, W83627EHF_REG_##REG[nr], val); \
	mutex_unlock(&data->update_lock); \
	return count; \
} \

fan_time_functions(fan_stop_time, FAN_STOP_TIME)


static struct sensor_device_attribute sda_sf3_arrays_fan4[] =3D {
	SENSOR_ATTR(pwm4_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
		    store_fan_stop_time, 3),
	SENSOR_ATTR(pwm4_min_output, S_IWUSR | S_IRUGO, show_fan_min_output,
		    store_fan_min_output, 3),
};

static struct sensor_device_attribute sda_sf3_arrays[] =3D {
	SENSOR_ATTR(pwm1_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
		    store_fan_stop_time, 0),
	SENSOR_ATTR(pwm2_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
		    store_fan_stop_time, 1),
	SENSOR_ATTR(pwm3_stop_time, S_IWUSR | S_IRUGO, show_fan_stop_time,
		    store_fan_stop_time, 2),
	SENSOR_ATTR(pwm1_min_output, S_IWUSR | S_IRUGO, show_fan_min_output,
		    store_fan_min_output, 0),
	SENSOR_ATTR(pwm2_min_output, S_IWUSR | S_IRUGO, show_fan_min_output,
		    store_fan_min_output, 1),
	SENSOR_ATTR(pwm3_min_output, S_IWUSR | S_IRUGO, show_fan_min_output,
		    store_fan_min_output, 2),
};

/*
 * Driver and client management
 */

static void w83627ehf_device_remove_files(struct device *dev)
{
	/* some entries in the following arrays may not have been used in
	 * device_create_file(), but device_remove_file() will ignore them */
	int i;

	for (i =3D 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
		device_remove_file(dev, &sda_sf3_arrays[i].dev_attr);
	for (i =3D 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++)
		device_remove_file(dev, &sda_sf3_arrays_fan4[i].dev_attr);
	for (i =3D 0; i < w83627ehf_num_in; i++) {
		device_remove_file(dev, &sda_in_input[i].dev_attr);
		device_remove_file(dev, &sda_in_alarm[i].dev_attr);
		device_remove_file(dev, &sda_in_min[i].dev_attr);
		device_remove_file(dev, &sda_in_max[i].dev_attr);
	}
	for (i =3D 0; i < 5; i++) {
		device_remove_file(dev, &sda_fan_input[i].dev_attr);
		device_remove_file(dev, &sda_fan_alarm[i].dev_attr);
		device_remove_file(dev, &sda_fan_div[i].dev_attr);
		device_remove_file(dev, &sda_fan_min[i].dev_attr);
	}
	for (i =3D 0; i < 4; i++) {
		device_remove_file(dev, &sda_pwm[i].dev_attr);
		device_remove_file(dev, &sda_pwm_mode[i].dev_attr);
		device_remove_file(dev, &sda_pwm_enable[i].dev_attr);
		device_remove_file(dev, &sda_target_temp[i].dev_attr);
		device_remove_file(dev, &sda_tolerance[i].dev_attr);
	}
	for (i =3D 0; i < ARRAY_SIZE(sda_temp); i++)
		device_remove_file(dev, &sda_temp[i].dev_attr);
}

static struct i2c_driver w83627ehf_driver;

static void w83627ehf_init_client(struct i2c_client *client)
{
	int i;
	u8 tmp;

	/* Start monitoring is needed */
	tmp =3D w83627ehf_read_value(client, W83627EHF_REG_CONFIG);
	if (!(tmp & 0x01))
		w83627ehf_write_value(client, W83627EHF_REG_CONFIG,
				      tmp | 0x01);

	/* Enable temp2 and temp3 if needed */
	for (i =3D 0; i < 2; i++) {
		tmp =3D w83627ehf_read_value(client,
					   W83627EHF_REG_TEMP_CONFIG[i]);
		if (tmp & 0x01)
			w83627ehf_write_value(client,
					      W83627EHF_REG_TEMP_CONFIG[i],
					      tmp & 0xfe);
	}
}

static int w83627ehf_detect(struct i2c_adapter *adapter)
{
	struct i2c_client *client;
	struct w83627ehf_data *data;
	struct device *dev;
	u8 fan4pin, fan5pin;
	int i, err =3D 0;

	if (!request_region(address + REGION_OFFSET, REGION_LENGTH,
	                    w83627ehf_driver.driver.name)) {
		err =3D -EBUSY;
		goto exit;
	}

	if (!(data =3D kzalloc(sizeof(struct w83627ehf_data), GFP_KERNEL))) {
		err =3D -ENOMEM;
		goto exit_release;
	}

	client =3D &data->client;
	i2c_set_clientdata(client, data);
	client->addr =3D address;
	mutex_init(&data->lock);
	client->adapter =3D adapter;
	client->driver =3D &w83627ehf_driver;
	client->flags =3D 0;
	dev =3D &client->dev;

	if (w83627ehf_num_in =3D 9)
		strlcpy(client->name, "w83627dhg", I2C_NAME_SIZE);
	else	/* just say ehf. 627EHG is 627EHF in lead-free packaging. */
		strlcpy(client->name, "w83627ehf", I2C_NAME_SIZE);

	data->valid =3D 0;
	mutex_init(&data->update_lock);

	/* Tell the i2c layer a new client has arrived */
	if ((err =3D i2c_attach_client(client)))
		goto exit_free;

	/* Initialize the chip */
	w83627ehf_init_client(client);

	/* A few vars need to be filled upon startup */
	for (i =3D 0; i < 5; i++)
		data->fan_min[i] =3D w83627ehf_read_value(client,
				   W83627EHF_REG_FAN_MIN[i]);

	/* fan4 and fan5 share some pins with the GPIO and serial flash */

	superio_enter();
	fan5pin =3D superio_inb(0x24) & 0x2;
	fan4pin =3D superio_inb(0x29) & 0x6;
	superio_exit();

	/* It looks like fan4 and fan5 pins can be alternatively used
	   as fan on/off switches, but fan5 control is write only :/
	   We assume that if the serial interface is disabled, designers
	   connected fan5 as input unless they are emitting log 1, which
	   is not the default. */

	data->has_fan =3D 0x07; /* fan1, fan2 and fan3 */
	i =3D w83627ehf_read_value(client, W83627EHF_REG_FANDIV1);
	if ((i & (1 << 2)) && (!fan4pin))
		data->has_fan |=3D (1 << 3);
	if (!(i & (1 << 1)) && (!fan5pin))
		data->has_fan |=3D (1 << 4);

	/* Register sysfs hooks */
  	for (i =3D 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
		if ((err =3D device_create_file(dev,
			&sda_sf3_arrays[i].dev_attr)))
			goto exit_remove;

	/* if fan4 is enabled create the sf3 files for it */
	if (data->has_fan & (1 << 3))
		for (i =3D 0; i < ARRAY_SIZE(sda_sf3_arrays_fan4); i++) {
			if ((err =3D device_create_file(dev,
				&sda_sf3_arrays_fan4[i].dev_attr)))
				goto exit_remove;
		}

	for (i =3D 0; i < w83627ehf_num_in; i++)
		if ((err =3D device_create_file(dev, &sda_in_input[i].dev_attr))
			|| (err =3D device_create_file(dev,
				&sda_in_alarm[i].dev_attr))
			|| (err =3D device_create_file(dev,
				&sda_in_min[i].dev_attr))
			|| (err =3D device_create_file(dev,
				&sda_in_max[i].dev_attr)))
			goto exit_remove;

	for (i =3D 0; i < 5; i++) {
		if (data->has_fan & (1 << i)) {
			if ((err =3D device_create_file(dev,
					&sda_fan_input[i].dev_attr))
				|| (err =3D device_create_file(dev,
					&sda_fan_alarm[i].dev_attr))
				|| (err =3D device_create_file(dev,
					&sda_fan_div[i].dev_attr))
				|| (err =3D device_create_file(dev,
					&sda_fan_min[i].dev_attr)))
				goto exit_remove;
			if (i < 4 && /* w83627ehf only has 4 pwm */
				((err =3D device_create_file(dev,
					&sda_pwm[i].dev_attr))
				|| (err =3D device_create_file(dev,
					&sda_pwm_mode[i].dev_attr))
				|| (err =3D device_create_file(dev,
					&sda_pwm_enable[i].dev_attr))
				|| (err =3D device_create_file(dev,
					&sda_target_temp[i].dev_attr))
				|| (err =3D device_create_file(dev,
					&sda_tolerance[i].dev_attr))))
				goto exit_remove;
		}
	}

	for (i =3D 0; i < ARRAY_SIZE(sda_temp); i++)
		if ((err =3D device_create_file(dev, &sda_temp[i].dev_attr)))
			goto exit_remove;

	data->class_dev =3D hwmon_device_register(dev);
	if (IS_ERR(data->class_dev)) {
		err =3D PTR_ERR(data->class_dev);
		goto exit_remove;
	}

	return 0;

exit_remove:
	w83627ehf_device_remove_files(dev);
	i2c_detach_client(client);
exit_free:
	kfree(data);
exit_release:
	release_region(address + REGION_OFFSET, REGION_LENGTH);
exit:
	return err;
}

static int w83627ehf_detach_client(struct i2c_client *client)
{
	struct w83627ehf_data *data =3D i2c_get_clientdata(client);
	int err;

	hwmon_device_unregister(data->class_dev);
	w83627ehf_device_remove_files(&client->dev);

	if ((err =3D i2c_detach_client(client)))
		return err;
	release_region(client->addr + REGION_OFFSET, REGION_LENGTH);
	kfree(data);

	return 0;
}

static struct i2c_driver w83627ehf_driver =3D {
	.driver =3D {
		.owner	=3D THIS_MODULE,
		.name	=3D "w83627ehf",
	},
	.attach_adapter	=3D w83627ehf_detect,
	.detach_client	=3D w83627ehf_detach_client,
};

static int __init w83627ehf_find(int sioaddr, unsigned short *addr)
{
	u16 val;

	REG =3D sioaddr;
	VAL =3D sioaddr + 1;
	superio_enter();

	val =3D (superio_inb(SIO_REG_DEVID) << 8)
	    | superio_inb(SIO_REG_DEVID + 1);
	switch (val & SIO_ID_MASK) {
	case SIO_W83627DHG_ID:
		w83627ehf_num_in =3D 9;
		break;
	case SIO_W83627EHF_ID:
	case SIO_W83627EHG_ID:
		w83627ehf_num_in =3D 10;
		break;
	default:
		printk(KERN_WARNING "w83627ehf: unsupported chip ID: 0x%04x\n",
			val);
		superio_exit();
		return -ENODEV;
	}

	superio_select(W83627EHF_LD_HWM);
	val =3D (superio_inb(SIO_REG_ADDR) << 8)
	    | superio_inb(SIO_REG_ADDR + 1);
	*addr =3D val & REGION_ALIGNMENT;
	if (*addr =3D 0) {
		superio_exit();
		return -ENODEV;
	}

	/* Activate logical device if needed */
	val =3D superio_inb(SIO_REG_ENABLE);
	if (!(val & 0x01))
		superio_outb(SIO_REG_ENABLE, val | 0x01);

	superio_exit();
	return 0;
}

static int __init sensors_w83627ehf_init(void)
{
	if (w83627ehf_find(0x2e, &address)
	 && w83627ehf_find(0x4e, &address))
		return -ENODEV;

	return i2c_isa_add_driver(&w83627ehf_driver);
}

static void __exit sensors_w83627ehf_exit(void)
{
	i2c_isa_del_driver(&w83627ehf_driver);
}

MODULE_AUTHOR("Jean Delvare <khali at linux-fr.org>");
MODULE_DESCRIPTION("W83627EHF driver");
MODULE_LICENSE("GPL");

module_init(sensors_w83627ehf_init);
module_exit(sensors_w83627ehf_exit);
-------------- next part --------------
#!/bin/bash

if [ $UID !=3D 0 ]; then
    echo "This script tests the w83627ehf module. It must be run as root."
    exit 1
fi

echo "* WARNING: This will run your system fans through many possible"
echo "           combinations. There is a possibility your system will"
echo "           overheat. Use this script at your own risk!"

# locate the w83627ehf in the sysfs
SYS=3D"`awk '{if (\$3=3D\"sysfs\") {print \$2;exit}}' /etc/mtab`"
#'
found_w83627ehf=3D""
if [ -d $SYS/class/hwmon ]; then
    for a in $SYS/class/hwmon/*; do
        if [ "`cat $a/device/name`" =3D "w83627ehf" ]; then
            found_w83627ehf=3D"$a"
	fi
    done
fi
if [ -z "$found_w83627ehf" ]; then
    echo "No w83627ehf driver in system. Loading module."
    modprobe w83627ehf || exit 1
else
    if lsmod | grep -q w83627ehf; then
        if modprobe -r w83627ehf && modprobe w83627ehf; then
            :
        else
            echo "Module w83627ehf: modprobe and unload failed."
            exit 1
        fi
    fi
fi

# check sysfs entries, permissions
hw=3D${found_w83627ehf/$SYS\/class\/hwmon\//}
#`
cd "$found_w83627ehf/device"
ls -l | cut -c-28,42- | (
    d=3D0
    check_line()
    {
        read a || exit 1
        if [ "$a" !=3D "$1" ]; then
            if [ $d =3D 0 ]; then
                echo "Permissions or files mismatched ($found_w83627ehf/dev=
ice)"
            fi
            echo "$a"
            d=3D1
        fi
    }
    check_line_skip()
    {
        while true; do
            if ! read a; then
                if [ $d =3D 0 ]; then
                    echo "xPermissions or files mismatched ($found_w83627eh=
f/device)"
                fi
                d=3D1
                break
            fi
            if [ "$a" =3D "$1" ]; then
                break
            fi
        done
    }
    check_line "total 0"
    check_line "lrwxrwxrwx 1 root root    0 bus -> ../../../../bus/i2c"
    l=3D"driver -> ../../../../bus/i2c/drivers/w83627ehf"
    check_line "lrwxrwxrwx 1 root root    0 $l"
    check_line "-r--r--r-- 1 root root 4096 fan1_alarm"
    check_line "-r--r--r-- 1 root root 4096 fan1_div"
    check_line "-r--r--r-- 1 root root 4096 fan1_input"
    check_line "-rw-r--r-- 1 root root 4096 fan1_min"
    #check_line "-rw-r--r-- 1 root root 4096 fan1_min_output"
    #check_line "-rw-r--r-- 1 root root 4096 fan1_stop_time"
    check_line "-r--r--r-- 1 root root 4096 fan2_alarm"
    check_line "-r--r--r-- 1 root root 4096 fan2_div"
    check_line "-r--r--r-- 1 root root 4096 fan2_input"
    #check_line "-rw-r--r-- 1 root root 4096 fan2_max_output"
    check_line "-rw-r--r-- 1 root root 4096 fan2_min"
    #check_line "-rw-r--r-- 1 root root 4096 fan2_min_output"
    #check_line "-rw-r--r-- 1 root root 4096 fan2_step"
    #check_line "-rw-r--r-- 1 root root 4096 fan2_stop_time"
    check_line "-r--r--r-- 1 root root 4096 fan3_alarm"
    check_line "-r--r--r-- 1 root root 4096 fan3_div"
    check_line "-r--r--r-- 1 root root 4096 fan3_input"
    check_line "-rw-r--r-- 1 root root 4096 fan3_min"
    #check_line "-rw-r--r-- 1 root root 4096 fan3_min_output"
    #check_line "-rw-r--r-- 1 root root 4096 fan3_stop_time"
    # skips any fan4_*, fan5_* entries...this could be done better
    # check_line "-r--r--r-- 1 root root 4096 fan4_alarm"
    # check_line "-r--r--r-- 1 root root 4096 fan4_div"
    # check_line "-r--r--r-- 1 root root 4096 fan4_input"
    # check_line "-rw-r--r-- 1 root root 4096 fan4_max_output"
    # check_line "-rw-r--r-- 1 root root 4096 fan4_min"
    # check_line "-rw-r--r-- 1 root root 4096 fan4_min_output"
    # check_line "-rw-r--r-- 1 root root 4096 fan4_step"
    # check_line "-rw-r--r-- 1 root root 4096 fan4_stop_time"
    #check_line "-rw-r--r-- 1 root root 4096 fan_step_down_time"
    #check_line "-rw-r--r-- 1 root root 4096 fan_step_up_time"
    l=3D"hwmon:$hw -> ../../../../class/hwmon/$hw"
    check_line_skip "lrwxrwxrwx 1 root root    0 $l"
    check_line "-r--r--r-- 1 root root 4096 in0_alarm"
    check_line "-r--r--r-- 1 root root 4096 in0_input"
    check_line "-rw-r--r-- 1 root root 4096 in0_max"
    check_line "-rw-r--r-- 1 root root 4096 in0_min"
    check_line "-r--r--r-- 1 root root 4096 in1_alarm"
    check_line "-r--r--r-- 1 root root 4096 in1_input"
    check_line "-rw-r--r-- 1 root root 4096 in1_max"
    check_line "-rw-r--r-- 1 root root 4096 in1_min"
    check_line "-r--r--r-- 1 root root 4096 in2_alarm"
    check_line "-r--r--r-- 1 root root 4096 in2_input"
    check_line "-rw-r--r-- 1 root root 4096 in2_max"
    check_line "-rw-r--r-- 1 root root 4096 in2_min"
    check_line "-r--r--r-- 1 root root 4096 in3_alarm"
    check_line "-r--r--r-- 1 root root 4096 in3_input"
    check_line "-rw-r--r-- 1 root root 4096 in3_max"
    check_line "-rw-r--r-- 1 root root 4096 in3_min"
    check_line "-r--r--r-- 1 root root 4096 in4_alarm"
    check_line "-r--r--r-- 1 root root 4096 in4_input"
    check_line "-rw-r--r-- 1 root root 4096 in4_max"
    check_line "-rw-r--r-- 1 root root 4096 in4_min"
    check_line "-r--r--r-- 1 root root 4096 in5_alarm"
    check_line "-r--r--r-- 1 root root 4096 in5_input"
    check_line "-rw-r--r-- 1 root root 4096 in5_max"
    check_line "-rw-r--r-- 1 root root 4096 in5_min"
    check_line "-r--r--r-- 1 root root 4096 in6_alarm"
    check_line "-r--r--r-- 1 root root 4096 in6_input"
    check_line "-rw-r--r-- 1 root root 4096 in6_max"
    check_line "-rw-r--r-- 1 root root 4096 in6_min"
    check_line "-r--r--r-- 1 root root 4096 in7_alarm"
    check_line "-r--r--r-- 1 root root 4096 in7_input"
    check_line "-rw-r--r-- 1 root root 4096 in7_max"
    check_line "-rw-r--r-- 1 root root 4096 in7_min"
    check_line "-r--r--r-- 1 root root 4096 in8_alarm"
    check_line "-r--r--r-- 1 root root 4096 in8_input"
    check_line "-rw-r--r-- 1 root root 4096 in8_max"
    check_line "-rw-r--r-- 1 root root 4096 in8_min"
    # skips any in9_* entries...this could be done better
    #check_line "-r--r--r-- 1 root root 4096 in9_alarm"
    #check_line "-r--r--r-- 1 root root 4096 in9_input"
    #check_line "-rw-r--r-- 1 root root 4096 in9_max"
    #check_line "-rw-r--r-- 1 root root 4096 in9_min"
    check_line_skip "-r--r--r-- 1 root root 4096 name"
    check_line "drwxr-xr-x 2 root root    0 power"
    check_line "-rw-r--r-- 1 root root 4096 pwm1"
    check_line "-rw-r--r-- 1 root root 4096 pwm1_enable"
    check_line "-rw-r--r-- 1 root root 4096 pwm1_min_output"
    check_line "-rw-r--r-- 1 root root 4096 pwm1_mode"
    check_line "-rw-r--r-- 1 root root 4096 pwm1_stop_time"
    check_line "-rw-r--r-- 1 root root 4096 pwm1_target"
    check_line "-rw-r--r-- 1 root root 4096 pwm1_tolerance"
    check_line "-rw-r--r-- 1 root root 4096 pwm2"
    check_line "-rw-r--r-- 1 root root 4096 pwm2_enable"
    check_line "-rw-r--r-- 1 root root 4096 pwm2_min_output"
    check_line "-rw-r--r-- 1 root root 4096 pwm2_mode"
    check_line "-rw-r--r-- 1 root root 4096 pwm2_stop_time"
    check_line "-rw-r--r-- 1 root root 4096 pwm2_target"
    check_line "-rw-r--r-- 1 root root 4096 pwm2_tolerance"
    check_line "-rw-r--r-- 1 root root 4096 pwm3"
    check_line "-rw-r--r-- 1 root root 4096 pwm3_enable"
    check_line "-rw-r--r-- 1 root root 4096 pwm3_min_output"
    check_line "-rw-r--r-- 1 root root 4096 pwm3_mode"
    check_line "-rw-r--r-- 1 root root 4096 pwm3_stop_time"
    check_line "-rw-r--r-- 1 root root 4096 pwm3_target"
    check_line "-rw-r--r-- 1 root root 4096 pwm3_tolerance"
    # skips any pwm4_* entries...this could be done better
    check_line_skip "-r--r--r-- 1 root root 4096 temp1_alarm"
    check_line "-r--r--r-- 1 root root 4096 temp1_input"
    check_line "-rw-r--r-- 1 root root 4096 temp1_max"
    check_line "-rw-r--r-- 1 root root 4096 temp1_max_hyst"
    #check_line "-rw-r--r-- 1 root root 4096 temp1_target"
    #check_line "-rw-r--r-- 1 root root 4096 temp1_tolerance"
    check_line "-r--r--r-- 1 root root 4096 temp2_alarm"
    check_line "-r--r--r-- 1 root root 4096 temp2_input"
    check_line "-rw-r--r-- 1 root root 4096 temp2_max"
    check_line "-rw-r--r-- 1 root root 4096 temp2_max_hyst"
    #check_line "-rw-r--r-- 1 root root 4096 temp2_target"
    #check_line "-rw-r--r-- 1 root root 4096 temp2_tolerance"
    check_line "-r--r--r-- 1 root root 4096 temp3_alarm"
    check_line "-r--r--r-- 1 root root 4096 temp3_input"
    check_line "-rw-r--r-- 1 root root 4096 temp3_max"
    check_line "-rw-r--r-- 1 root root 4096 temp3_max_hyst"
    #check_line "-rw-r--r-- 1 root root 4096 temp3_target"
    #check_line "-rw-r--r-- 1 root root 4096 temp3_tolerance"
    # skip any temp_4* entires...this could be done better
    #check_line "-rw-r--r-- 1 root root 4096 temp4_target"
    #check_line "-rw-r--r-- 1 root root 4096 temp4_tolerance"
    check_line_skip "--w------- 1 root root 4096 uevent"
    if read a; then echo "$a"; d=3D1; fi
    [ $d !=3D 0 ] && exit 1
    :
    ) || exit 1

# input voltages
# *** BUG? *** Are these formulas still being used? - dh
#    label in0 "VCore"
#    label in1 "VIN0"
#    compute in1 @*(1+(56/10)),  @/(1+(56/10))
#    label in2 "AVCC"
#    label in3 "3VCC"
#    label in4 "VIN1"
#    label in5 "VIN2"
#    label in6 "VIN3"
#    compute in6 @*(1+(22/10)),  @/(1+(22/10))
#    label in7 "VSB"
#    label in8 "VBAT"
#    label in9 "VIN4"

check_voltage()
{
    V=3D"`cat $1_input`" || exit 1
    L=3D"`cat $1_min`" || exit 1
    H=3D"`cat $1_max`" || exit 1
    A=3D"`cat $1_alarm`" || exit 1
    if [ $V -lt $L -a $A =3D 0 ]; then
        echo "Sensor   mV   min   max"
        printf "%-5s %5d %5d %5d\n" "$2" $(($V$3)) $(($L$3)) $(($H$3))
        echo "  Volts below min, alarm didn't go off."
        exit 1
    fi
    if [ $V -gt $H -a $A =3D 0 ]; then
        echo "Sensor   mV   min   max"
        printf "%-5s %5d %5d %5d\n" "$2" $(($V$3)) $(($L$3)) $(($H$3))
        echo "  Volts above max, alarm didn't go off."
        exit 1
    fi
    if [ $V -gt $L -a $V -lt $H -a $A !=3D 0 ]; then
        echo "Sensor   mV   min   max"
        printf "%-5s %5d %5d %5d\n" "$2" $(($V$3)) $(($L$3)) $(($H$3))
        echo "  Volts between max and min but alarm went off."
        exit 1
    fi
}
check_voltage in0 "VCore" ""
check_voltage in1 "+12V" "*66/10"
check_voltage in2 "AVCC" ""
check_voltage in3 "3VCC" ""
check_voltage in4 "VIN1" ""
check_voltage in5 "VIN2" ""
check_voltage in6 "+5V" "*32/10"
check_voltage in7 "VSB" ""
check_voltage in8 "VBAT" ""
check_voltage in9 "VIN4" ""

check_temp()
{
    T=3D"`cat $1_input`" || exit 1
    if [ "$T" -lt "1" ]; then
        echo "$1 too low: $T"
        exit 1
    fi
}
check_temp temp1
check_temp temp2
check_temp temp3

test_smartfan1()
{
# fan$1_min_output is the minimum $2 will go to
# why doesn't the fan stop?
# maybe fan$1_min controls where fan$1_alarm is triggered
#
# SmartFan III items: fan2_step, fan2_max_output, fan4_step, fan4_max_output
    echo ""
    echo "test_smartfan1 \$1=3D\"$1\" \$2=3D\"$2\""

    # ********* MUST VERIFY THAT fan_step_time IS CORRECT (PWM->100 ms, DC-=
>400 ms)
    # while $2 < 255 lower temp$1_target +/- temp$1_tolerance,
    #     verify that $2 increases and temp$1_input decreases
    # while $2 > fan$1_min_output increase temp$1_target +/- temp$1_toleran=
ce,
    #     verify that $2 decreases, stop if temp$1_input >=3D MIN(target+to=
lerance, 60000)
    # restore temp$1_target
}
#test_smartfan1 3 pwm3

#exit 0

# build a mapping from pwm output to fan rpm input
echo "Mapping fans...setting all PWMs to 100%"
for a in pwm*_enable; do
    p=3D${a/_enable/}
    echo 1 > $a || exit 1
    echo 255 > $p || exit 1
done

sleep 1

read_fan_rpm()
{
    # take three readings. if they are not within 45% of each other, try ag=
ain
    retry=3D2
    while [ $retry !=3D 0 ]; do
        sleep 2
        t1=3D"`cat fan$1_input`" || exit 1
        sleep 2
        t2=3D"`cat fan$1_input`" || exit 1
        sleep 2
        t3=3D"`cat fan$1_input`" || exit 1
        l=3D"$t1"
        [ "$t2" -lt "$l" ] && l=3D"$t2"
        [ "$t3" -lt "$l" ] && l=3D"$t3"
        h=3D"$t1"
        [ "$t2" -gt "$h" ] && h=3D"$t2"
        [ "$t3" -gt "$h" ] && h=3D"$t3"
        if [ $l -gt 0 ]; then
            h=3D$(($h-$l))
            h=3D$(($h*10/$l))
            [ "$h" -lt "4" ] && break
        fi
        retry=3D$(($retry-1))
    done
}

for a in fan*_div; do
    i=3D${a/fan/}
    i=3D${i/_div/}
    map[$i]=3D""
    rpm=3D"`cat fan${i}_input`" || exit 1
    if [ "`cat $a`" =3D "128" -a "$rpm" =3D "0" ]; then
        echo "    fan $i $rpm RPM: ignored. (Fan not installed?)"
        continue
    fi

    # take the max of two readings
    sleep 2
    t=3D"`cat fan${i}_input`" || exit 1
    [ "$t" -gt "$rpm" ] && rpm=3D"$t"

    echo "    fan $i $rpm RPM:"
    m=3D""
    n=3D""
    for b in pwm*_enable; do
        echo 1 > ${b/_enable/}_mode || exit 1
        echo 27 > ${b/_enable/} || exit 1
        read_fan_rpm $i
        echo 255 > ${b/_enable/} || exit 1
        if [ $retry =3D 0 ]; then
            echo "        ${b/_enable/} RPM highly variable? ignored."
        else
            d=3D$(($rpm-$l))
            d=3D$(($d*4/$rpm))
            if [ "$d" -gt "1" ]; then
                echo "        ${b/_enable/} $l RPM: connected."
                if [ -z "$m" ]; then
                    m=3D"${b/_enable/}"
                else
                    n=3D"${b/_enable/}"
                fi
                sleep 1
            else
                echo "        ${b/_enable/} $l RPM"
            fi
        fi
        if [ -n "$n" ]; then
            echo "        Multiple PWMs mapped to fan? ignored."
        else
            map[$i]=3D"$m"
        fi
    done
done

set_pwm_dc()
{
    echo $2 > $1_mode || exit 1
    u=3D"`cat $1_mode`" || exit 1
    if [ "$u" !=3D "$2" ]; then
        [ "$2" =3D "0" ] && echo -e "\nFailure: could not set PWM mode."
        [ "$2" !=3D "0" ] && echo -e "\nFailure: could not set DC mode."
        exit 1
    fi
}

for a in fan*_div; do
    i=3D${a/fan/}
    i=3D${i/_div/}
    [ -z "${map[$i]}" ] && continue
    echo -n "Testing fan $i - ${map[$i]} ..."
    # 1. test clock divider auto-scaling (high RPM and low RPM)
    m=FAn${i}_min
    echo 1 > $m || exit 1
    u=3D"`cat $m`" || exit 1
    v=3D"`cat $a`" || exit 1
    if [ "$u" -lt "41" -o "$v" !=3D "128" ]; then
        echo -e "\nFailure: $m =3D `cat $m` (not 41)  $a =3D `cat $a` (not =
128)"
        exit 1
    fi
    dd
    for b in 210 421 843 1687 3375 6750 13500; do
        echo $b > $m || exit 1
        u=3D"`cat $m`" || exit 1
        v=3D"`cat $a`" || exit 1
        if [ "$u" !=3D "$b" -o "$v" !=3D "$d" ]; then
            # one retry, cause we are in a race condition with the driver
            echo $b > $m || exit 1
            u=3D"`cat $m`" || exit 1
            v=3D"`cat $a`" || exit 1
            if [ "$u" !=3D "$b" -o "$v" !=3D "$d" ]; then
                echo -e "\nFailure: $m =3D $u (not $b)  $a =3D $v (not $d)"
                exit 1
            fi
        fi
        d=3D$(($d/2))
    done
    echo -n " div OK"
    # 2. test PWM vs DC mode
    u=3D"`cat ${map[$i]}_mode`" || exit 1
    if [ "$u" !=3D "1" ]; then
        echo -e "\nLogic error: not in PWM mode"
        exit 1
    fi
    read_fan_rpm $i
    pwm_rpm=3D$l
    set_pwm_dc ${map[$i]} 0 # DC mode
    read_fan_rpm $i
    d=3D$(($l-$pwm_rpm))
    [ $d -lt 0 ] && d=3D$((-$d))
    d=3D$(($d*10/$l))
    if [ $d -gt 4 ]; then
        echo -e "\nFailure: PWM $pwm_rpm RPM, DC $l RPM at 100%."
        exit 1
    fi
    set_pwm_dc ${map[$i]} 1 # PWM mode
    echo 128 > ${map[$i]} || exit 1
    read_fan_rpm $i
    pwm_rpm=3D$l
    set_pwm_dc ${map[$i]} 0 # DC mode
    read_fan_rpm $i
    d=3D$(($l-$pwm_rpm))
    [ $d -lt 0 ] && d=3D$((-$d))
    d=3D$(($d*10/$l))
    if [ $d -lt 4 ]; then
        echo -e "\nFailure: PWM $pwm_rpm RPM, DC $l RPM at 50%."
        exit 1
    fi
    echo -n ", PWM/DC OK"
    if false; then
        # disabled mode is not in the driver anymore...
        # test disabled mode (RPM should increase)
        echo 0 > ${map[$i]}_enable || exit 1
        lorpm=3D$l
        read_fan_rpm $i
        d=3D$(($l-$lorpm))
        d=3D$(($d*10/$lorpm))
        if [ $d -lt 4 ]; then
            echo -e "\nFailure: 50% $lorpm RPM, disabled (100%) $l RPM."
            exit 1
        fi
        echo 1 > ${map[$i]}_enable || exit 1
        echo -n ", enable OK"
    fi

    # 4. test SmartFan I mode (thermal cruise)
    echo 2 > ${map[$i]}_enable || exit 1
    #test_smartfan1 "$i" "${map[$i]}"
    echo ", SF1 OK"
done
