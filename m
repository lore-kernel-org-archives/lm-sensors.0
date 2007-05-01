From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Tue, 01 May 2007 20:49:20 +0000
Subject: Re: [lm-sensors] [PATCH] Add LM93 support
Message-Id: <200705012249.20973.hjk@linutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_Qf6NGIJVoEt4R0m"
List-Id: <lm-sensors.vger.kernel.org>
References: <200704131723.42773.hjk@linutronix.de>
In-Reply-To: <200704131723.42773.hjk@linutronix.de>
To: lm-sensors@vger.kernel.org

--Boundary-00=_Qf6NGIJVoEt4R0m
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Dienstag 01 Mai 2007 05:30 schrieb Mark M. Hoffman:
> Hi Hans:
>=20
> > Am Montag 30 April 2007 06:07 schrieb Mark M. Hoffman:
> > > First: would you like to add an entry to MAINTAINERS for this driver,=
 pointing
> > > to yourself?  Although I wrote the original, I no longer have access =
to the
> > > hardware.
>=20
> * Hans-J=FCrgen Koch <hjk@linutronix.de> [2007-04-30 11:56:34 +0200]:
> > I have a similar problem. The hardware I'm testing with now is not my p=
roperty,
> > I'll have to give it back one day. I'm thinking about building a i2c_pa=
rport
> > adapter where I can attach sensors chips. Dunno yet if this is feasible=
=2E If
> > I have a LM93 available permanently, I have no problems with becoming i=
ts
> > driver's maintainer. But I don't want to add myself to MAINTAINERS befo=
re that
> > is the case.
>=20
> It's not too difficult to build one of those. =20

I used to be a hardware developer for many years, so I think I could do tha=
t.
It's more a question of time...

> Or if you can solder fine pitch,=20
> you can fly some wires off of a DIMM for SCL/SDA. =20

Aaarrgh!

> Or search the i2c archives=20
> for a USB->I2C device designed by Till Harbaum (sp?).

Sounds interesting, I'll have a look.

>=20
> Anyway, it's up to you if you want to patch yourself into MAINTAINERS or =
not.

I'm in MAINTAINERS for the MAX6650 driver already. I think I should only be
listed there for drivers where I actually got the device ready for tests.
As soon as I call a LM93 my own, I'll send a patch and apply for being added
to MAINTAINERS.

[...]=20
>=20
> You missed some of my comments near the bottom of the driver source:

No, I didn't. 2nd order stupidity on my side. Too tired to handle tools=20
correctly. Sorry for the inconvenience.


>=20
> > +	err =3D PTR_ERR(data->class_dev);
> > +	dev_err(&client->dev, "error registering hwmon device.\n");
> > +	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
> > +err_detach:
> > +	i2c_detach_client(client);
> > +err_free:
> > +	kfree(client);
>=20
> kfree(data);

fixed.

>=20
> > +err_out:
> > +	return err;
> > +}
> > +
> > +/* This function is called when:
> > +     * lm93_driver is inserted (when this module is loaded), for each
> > +       available adapter
> > +     * when a new adapter is inserted (and lm93_driver is still presen=
t) */
> > +static int lm93_attach_adapter(struct i2c_adapter *adapter)
> > +{
> > +	return i2c_probe(adapter, &addr_data, lm93_detect);
> > +}
> > +
> > +static int lm93_detach_client(struct i2c_client *client)
> > +{
> > +	struct lm93_data *data =3D i2c_get_clientdata(client);
> > +	int err =3D 0;
> > +
> > +	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
> > +	hwmon_device_unregister(data->class_dev);
> > +
>=20
> The hwmon_device_unregister() should precede the sysfs_remove_group().

fixed.

>=20
> > +	err =3D i2c_detach_client(client);
> > +	if (!err)
> > +		kfree(client);
>=20
> kfree(data);

fixed.

>=20
> > +	return err;
> > +}
> > +
> > +static int __init lm93_init(void)
> > +{
> > +	return i2c_add_driver(&lm93_driver);
> > +}
>

=46ind attached the corrected version of the patch.

Thanks,
Hans




--Boundary-00=_Qf6NGIJVoEt4R0m
Content-Type: text/x-diff; charset="iso-8859-1"; name="lm93-support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lm93-support.patch"

Index: linux-2.6.22-rc/drivers/hwmon/Kconfig
===================================================================
--- linux-2.6.22-rc.orig/drivers/hwmon/Kconfig	2007-04-30 11:15:59.000000000 +0200
+++ linux-2.6.22-rc/drivers/hwmon/Kconfig	2007-04-30 11:17:30.000000000 +0200
@@ -366,6 +366,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called lm92.
 
+config SENSORS_LM93
+	tristate "National Semiconductor LM93 and compatibles"
+	depends on HWMON && I2C
+	select HWMON_VID
+	help
+	  If you say yes here you get support for National Semiconductor LM93
+	  sensor chips.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called lm93.
+
 config SENSORS_MAX1619
 	tristate "Maxim MAX1619 sensor chip"
 	depends on HWMON && I2C
Index: linux-2.6.22-rc/drivers/hwmon/Makefile
===================================================================
--- linux-2.6.22-rc.orig/drivers/hwmon/Makefile	2007-04-30 11:15:59.000000000 +0200
+++ linux-2.6.22-rc/drivers/hwmon/Makefile	2007-04-30 11:17:30.000000000 +0200
@@ -42,6 +42,7 @@
 obj-$(CONFIG_SENSORS_LM87)	+= lm87.o
 obj-$(CONFIG_SENSORS_LM90)	+= lm90.o
 obj-$(CONFIG_SENSORS_LM92)	+= lm92.o
+obj-$(CONFIG_SENSORS_LM93)	+= lm93.o
 obj-$(CONFIG_SENSORS_MAX1619)	+= max1619.o
 obj-$(CONFIG_SENSORS_PC87360)	+= pc87360.o
 obj-$(CONFIG_SENSORS_PC87427)	+= pc87427.o
Index: linux-2.6.22-rc/drivers/hwmon/lm93.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.22-rc/drivers/hwmon/lm93.c	2007-05-01 22:33:25.000000000 +0200
@@ -0,0 +1,2734 @@
+/*
+    lm93.c - Part of lm_sensors, Linux kernel modules for hardware monitoring
+
+    Author/Maintainer: Mark M. Hoffman <mhoffman@lightlink.com>
+	Copyright (c) 2004 Utilitek Systems, Inc.
+
+    derived in part from lm78.c:
+	Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
+
+    derived in part from lm85.c:
+	Copyright (c) 2002, 2003 Philip Pokorny <ppokorny@penguincomputing.com>
+	Copyright (c) 2003       Margit Schubert-While <margitsw@t-online.de>
+
+    derived in part from w83l785ts.c:
+	Copyright (c) 2003-2004 Jean Delvare <khali@linux-fr.org>
+
+    Ported to Linux 2.6 by Eric J. Bowersox <ericb@aspsys.com>
+	Copyright (c) 2005 Aspen Systems, Inc.
+
+    Adapted to 2.6.20 by Carsten Emde <ce@osadl.org>
+        Copyright (c) 2006 Carsten Emde, Open Source Automation Development Labs
+
+    Modified for mainline integration by Hans J. Koch <hjk@linutronix.de>
+        Copyright (c) 2007 Hans J. Koch, Linutronix GmbH
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+
+/* LM93 REGISTER ADDRESSES */
+
+/* miscellaneous */
+#define LM93_REG_MFR_ID			0x3e
+#define LM93_REG_VER			0x3f
+#define LM93_REG_STATUS_CONTROL		0xe2
+#define LM93_REG_CONFIG			0xe3
+#define LM93_REG_SLEEP_CONTROL		0xe4
+
+/* alarm values start here */
+#define LM93_REG_HOST_ERROR_1		0x48
+
+/* voltage inputs: in1-in16 (nr => 0-15) */
+#define LM93_REG_IN(nr)			(0x56 + (nr))
+#define LM93_REG_IN_MIN(nr)		(0x90 + (nr) * 2)
+#define LM93_REG_IN_MAX(nr)		(0x91 + (nr) * 2)
+
+/* temperature inputs: temp1-temp4 (nr => 0-3) */
+#define LM93_REG_TEMP(nr)		(0x50 + (nr))
+#define LM93_REG_TEMP_MIN(nr)		(0x78 + (nr) * 2)
+#define LM93_REG_TEMP_MAX(nr)		(0x79 + (nr) * 2)
+
+/* temp[1-4]_auto_boost (nr => 0-3) */
+#define LM93_REG_BOOST(nr)		(0x80 + (nr))
+
+/* #PROCHOT inputs: prochot1-prochot2 (nr => 0-1) */
+#define LM93_REG_PROCHOT_CUR(nr)	(0x67 + (nr) * 2)
+#define LM93_REG_PROCHOT_AVG(nr)	(0x68 + (nr) * 2)
+#define LM93_REG_PROCHOT_MAX(nr)	(0xb0 + (nr))
+
+/* fan tach inputs: fan1-fan4 (nr => 0-3) */
+#define LM93_REG_FAN(nr)		(0x6e + (nr) * 2)
+#define LM93_REG_FAN_MIN(nr)		(0xb4 + (nr) * 2)
+
+/* pwm outputs: pwm1-pwm2 (nr => 0-1, reg => 0-3) */
+#define LM93_REG_PWM_CTL(nr,reg)	(0xc8 + (reg) + (nr) * 4)
+#define LM93_PWM_CTL1	0x0
+#define LM93_PWM_CTL2	0x1
+#define LM93_PWM_CTL3	0x2
+#define LM93_PWM_CTL4	0x3
+
+/* GPIO input state */
+#define LM93_REG_GPI			0x6b
+
+/* vid inputs: vid1-vid2 (nr => 0-1) */
+#define LM93_REG_VID(nr)		(0x6c + (nr))
+
+/* vccp1 & vccp2: VID relative inputs (nr => 0-1) */
+#define LM93_REG_VCCP_LIMIT_OFF(nr)	(0xb2 + (nr))
+
+/* temp[1-4]_auto_boost_hyst */
+#define LM93_REG_BOOST_HYST_12		0xc0
+#define LM93_REG_BOOST_HYST_34		0xc1
+#define LM93_REG_BOOST_HYST(nr)		(0xc0 + (nr)/2)
+
+/* temp[1-4]_auto_pwm_[min|hyst] */
+#define LM93_REG_PWM_MIN_HYST_12	0xc3
+#define LM93_REG_PWM_MIN_HYST_34	0xc4
+#define LM93_REG_PWM_MIN_HYST(nr)	(0xc3 + (nr)/2)
+
+/* prochot_override & prochot_interval */
+#define LM93_REG_PROCHOT_OVERRIDE	0xc6
+#define LM93_REG_PROCHOT_INTERVAL	0xc7
+
+/* temp[1-4]_auto_base (nr => 0-3) */
+#define LM93_REG_TEMP_BASE(nr)		(0xd0 + (nr))
+
+/* temp[1-4]_auto_offsets (step => 0-11) */
+#define LM93_REG_TEMP_OFFSET(step)	(0xd4 + (step))
+
+/* #PROCHOT & #VRDHOT PWM ramp control */
+#define LM93_REG_PWM_RAMP_CTL		0xbf
+
+/* miscellaneous */
+#define LM93_REG_SFC1		0xbc
+#define LM93_REG_SFC2		0xbd
+#define LM93_REG_GPI_VID_CTL	0xbe
+#define LM93_REG_SF_TACH_TO_PWM	0xe0
+
+/* error masks */
+#define LM93_REG_GPI_ERR_MASK	0xec
+#define LM93_REG_MISC_ERR_MASK	0xed
+
+/* LM93 REGISTER VALUES */
+#define LM93_MFR_ID		0x73
+#define LM93_MFR_ID_PROTOTYPE	0x72
+
+/* SMBus capabilities */
+#define LM93_SMBUS_FUNC_FULL (I2C_FUNC_SMBUS_BYTE_DATA | \
+		I2C_FUNC_SMBUS_WORD_DATA | I2C_FUNC_SMBUS_BLOCK_DATA)
+#define LM93_SMBUS_FUNC_MIN  (I2C_FUNC_SMBUS_BYTE_DATA | \
+		I2C_FUNC_SMBUS_WORD_DATA)
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
+
+/* Insmod parameters */
+I2C_CLIENT_INSMOD_1(lm93);
+
+static int disable_block;
+module_param(disable_block, bool, 0);
+MODULE_PARM_DESC(disable_block,
+	"Set to non-zero to disable SMBus block data transactions.");
+
+static int init;
+module_param(init, bool, 0);
+MODULE_PARM_DESC(init, "Set to non-zero to force chip initialization.");
+
+static int vccp_limit_type[2] = {0,0};
+module_param_array(vccp_limit_type, int, NULL, 0);
+MODULE_PARM_DESC(vccp_limit_type, "Configures in7 and in8 limit modes.");
+
+static int vid_agtl;
+module_param(vid_agtl, int, 0);
+MODULE_PARM_DESC(vid_agtl, "Configures VID pin input thresholds.");
+
+/* Function prototypes */
+static u8 lm93_read_byte(struct i2c_client *client, u8 reg);
+static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value);
+static u16 lm93_read_word(struct i2c_client *client, u8 reg);
+static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value);
+static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values);
+static struct lm93_data *lm93_update_device(struct device *dev);
+static void lm93_update_client_common(struct lm93_data *data,
+				      struct i2c_client *client);
+static void lm93_update_client_full(struct lm93_data *data,
+				    struct i2c_client *client);
+static void lm93_update_client_min(struct lm93_data *data,
+				   struct i2c_client *client);
+static void lm93_init_client(struct i2c_client *client);
+static int lm93_detect(struct i2c_adapter *adapter, int address, int kind);
+static int lm93_attach_adapter(struct i2c_adapter *adapter);
+static int lm93_detach_client(struct i2c_client *client);
+
+/* Driver data */
+static struct i2c_driver lm93_driver = {
+	.driver = {
+		.name	= "lm93",
+	},
+	.attach_adapter	= lm93_attach_adapter,
+	.detach_client	= lm93_detach_client,
+};
+
+/* LM93 BLOCK READ COMMANDS */
+static const struct { u8 cmd; u8 len; } lm93_block_read_cmds[12] = {
+	{ 0xf2,  8 },
+	{ 0xf3,  8 },
+	{ 0xf4,  6 },
+	{ 0xf5, 16 },
+	{ 0xf6,  4 },
+	{ 0xf7,  8 },
+	{ 0xf8, 12 },
+	{ 0xf9, 32 },
+	{ 0xfa,  8 },
+	{ 0xfb,  8 },
+	{ 0xfc, 16 },
+	{ 0xfd,  9 },
+};
+
+/* ALARMS: SYSCTL format described further below
+   REG: 64 bits in 8 registers, as immediately below */
+struct block1_t {
+	u8 host_status_1;
+	u8 host_status_2;
+	u8 host_status_3;
+	u8 host_status_4;
+	u8 p1_prochot_status;
+	u8 p2_prochot_status;
+	u8 gpi_status;
+	u8 fan_status;
+};
+
+/* For each registered client, we need to keep some data in memory. That
+   data is pointed to by client->data. The structure itself is dynamically
+   allocated, at the same time the client itself is allocated. */
+struct lm93_data {
+	struct i2c_client client;
+	struct class_device *class_dev;
+
+	struct mutex update_lock;
+	unsigned long last_updated;	/* In jiffies */
+
+	/* client update function */
+	void (*update)(struct lm93_data *, struct i2c_client *);
+
+	char valid; /* !=0 if following fields are valid */
+
+	/* register values, arranged by block read groups */
+	struct block1_t block1;
+
+	/* temp1 - temp4: unfiltered readings
+	   temp1 - temp2: filtered readings */
+	u8 block2[6];
+
+	/* vin1 - vin16: readings */
+	u8 block3[16];
+
+	/* prochot1 - prochot2: readings */
+	struct {
+		u8 cur;
+		u8 avg;
+	} block4[2];
+
+	/* fan counts 1-4 => 14-bits, LE, *left* justified */
+	u16 block5[4];
+
+	/* block6 has a lot of data we don't need */
+	struct {
+		u8 min;
+		u8 max;
+	} temp_lim[3];
+
+	/* vin1 - vin16: low and high limits */
+	struct {
+		u8 min;
+		u8 max;
+	} block7[16];
+
+	/* fan count limits 1-4 => same format as block5 */
+	u16 block8[4];
+
+	/* pwm control registers (2 pwms, 4 regs) */
+	u8 block9[2][4];
+
+	/* auto/pwm base temp and offset temp registers */
+	struct {
+		u8 base[4];
+		u8 offset[12];
+	} block10;
+
+	/* master config register */
+	u8 config;
+
+	/* VID1 & VID2 => register format, 6-bits, right justified */
+	u8 vid[2];
+
+	/* prochot1 - prochot2: limits */
+	u8 prochot_max[2];
+
+	/* vccp1 & vccp2 (in7 & in8): VID relative limits (register format) */
+	u8 vccp_limits[2];
+
+	/* GPIO input state (register format, i.e. inverted) */
+	u8 gpi;
+
+	/* #PROCHOT override (register format) */
+	u8 prochot_override;
+
+	/* #PROCHOT intervals (register format) */
+	u8 prochot_interval;
+
+	/* Fan Boost Temperatures (register format) */
+	u8 boost[4];
+
+	/* Fan Boost Hysteresis (register format) */
+	u8 boost_hyst[2];
+
+	/* Temperature Zone Min. PWM & Hysteresis (register format) */
+	u8 auto_pwm_min_hyst[2];
+
+	/* #PROCHOT & #VRDHOT PWM Ramp Control */
+	u8 pwm_ramp_ctl;
+
+	/* miscellaneous setup regs */
+	u8 sfc1;
+	u8 sfc2;
+	u8 sf_tach_to_pwm;
+
+	/* The two PWM CTL2  registers can read something other than what was
+	   last written for the OVR_DC field (duty cycle override).  So, we
+	   save the user-commanded value here. */
+	u8 pwm_override[2];
+};
+
+/* VID:	mV
+   REG: 6-bits, right justified, *always* using Intel VRM/VRD 10 */
+static int LM93_VID_FROM_REG(u8 reg)
+{
+	return vid_from_reg((reg & 0x3f), 100);
+}
+
+/* min, max, and nominal register values, per channel (u8) */
+static const u8 lm93_vin_reg_min[16] = {
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xae,
+};
+static const u8 lm93_vin_reg_max[16] = {
+	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff,
+	0xff, 0xfa, 0xff, 0xff, 0xff, 0xff, 0xff, 0xd1,
+};
+/* Values from the datasheet. They're here for documentation only.
+static const u8 lm93_vin_reg_nom[16] = {
+	0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0,
+	0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0xc0, 0x40, 0xc0,
+};
+*/
+
+/* min, max, and nominal voltage readings, per channel (mV)*/
+static const unsigned long lm93_vin_val_min[16] = {
+	0, 0, 0, 0, 0, 0, 0, 0,
+	0, 0, 0, 0, 0, 0, 0, 3000,
+};
+
+static const unsigned long lm93_vin_val_max[16] = {
+	1236, 1236, 1236, 1600, 2000, 2000, 1600, 1600,
+	4400, 6500, 3333, 2625, 1312, 1312, 1236, 3600,
+};
+/* Values from the datasheet. They're here for documentation only.
+static const unsigned long lm93_vin_val_nom[16] = {
+	 927,  927,  927, 1200, 1500, 1500, 1200, 1200,
+	3300, 5000, 2500, 1969,  984,  984,  309, 3300,
+};
+*/
+
+static unsigned LM93_IN_FROM_REG(int nr, u8 reg)
+{
+	const long uV_max = lm93_vin_val_max[nr] * 1000;
+	const long uV_min = lm93_vin_val_min[nr] * 1000;
+
+	const long slope = (uV_max - uV_min) /
+		(lm93_vin_reg_max[nr] - lm93_vin_reg_min[nr]);
+	const long intercept = uV_min - slope * lm93_vin_reg_min[nr];
+
+	return (slope * reg + intercept + 500) / 1000;
+}
+
+/* IN: mV, limits determined by channel nr
+   REG: scaling determined by channel nr */
+static u8 LM93_IN_TO_REG(int nr, unsigned val)
+{
+	/* range limit */
+	const long mV = SENSORS_LIMIT(val,
+		lm93_vin_val_min[nr], lm93_vin_val_max[nr]);
+
+	/* try not to lose too much precision here */
+	const long uV = mV * 1000;
+	const long uV_max = lm93_vin_val_max[nr] * 1000;
+	const long uV_min = lm93_vin_val_min[nr] * 1000;
+
+	/* convert */
+	const long slope = (uV_max - uV_min) /
+		(lm93_vin_reg_max[nr] - lm93_vin_reg_min[nr]);
+	const long intercept = uV_min - slope * lm93_vin_reg_min[nr];
+
+	u8 result = ((uV - intercept + (slope/2)) / slope);
+	result = SENSORS_LIMIT(result,
+			lm93_vin_reg_min[nr], lm93_vin_reg_max[nr]);
+	return result;
+}
+
+/* vid in mV, upper == 0 indicates low limit, otherwise upper limit */
+static unsigned LM93_IN_REL_FROM_REG(u8 reg, int upper, int vid)
+{
+	const long uV_offset = upper ? (((reg >> 4 & 0x0f) + 1) * 12500) :
+				(((reg >> 0 & 0x0f) + 1) * -25000);
+	const long uV_vid = vid * 1000;
+	return (uV_vid + uV_offset + 5000) / 10000;
+}
+
+#define LM93_IN_MIN_FROM_REG(reg,vid)	LM93_IN_REL_FROM_REG(reg,0,vid)
+#define LM93_IN_MAX_FROM_REG(reg,vid)	LM93_IN_REL_FROM_REG(reg,1,vid)
+
+/* vid in mV , upper == 0 indicates low limit, otherwise upper limit
+   upper also determines which nibble of the register is returned
+   (the other nibble will be 0x0) */
+static u8 LM93_IN_REL_TO_REG(unsigned val, int upper, int vid)
+{
+	long uV_offset = vid * 1000 - val * 10000;
+	if (upper) {
+		uV_offset = SENSORS_LIMIT(uV_offset, 12500, 200000);
+		return (u8)((uV_offset /  12500 - 1) << 4);
+	} else {
+		uV_offset = SENSORS_LIMIT(uV_offset, -400000, -25000);
+		return (u8)((uV_offset / -25000 - 1) << 0);
+	}
+}
+
+/* TEMP: 1/1000 degrees C (-128C to +127C)
+   REG: 1C/bit, two's complement */
+static int LM93_TEMP_FROM_REG(u8 reg)
+{
+	return (s8)reg * 1000;
+}
+
+#define LM93_TEMP_MIN (-128000)
+#define LM93_TEMP_MAX ( 127000)
+
+/* TEMP: 1/1000 degrees C (-128C to +127C)
+   REG: 1C/bit, two's complement */
+static u8 LM93_TEMP_TO_REG(int temp)
+{
+	int ntemp = SENSORS_LIMIT(temp, LM93_TEMP_MIN, LM93_TEMP_MAX);
+	ntemp += (ntemp<0 ? -500 : 500);
+	return (u8)(ntemp / 1000);
+}
+
+/* Determine 4-bit temperature offset resolution */
+static int LM93_TEMP_OFFSET_MODE_FROM_REG(u8 sfc2, int nr)
+{
+	/* mode: 0 => 1C/bit, nonzero => 0.5C/bit */
+	return sfc2 & (nr < 2 ? 0x10 : 0x20);
+}
+
+/* This function is common to all 4-bit temperature offsets
+   reg is 4 bits right justified
+   mode 0 => 1C/bit, mode !0 => 0.5C/bit */
+static int LM93_TEMP_OFFSET_FROM_REG(u8 reg, int mode)
+{
+	return (reg & 0x0f) * (mode ? 5 : 10);
+}
+
+#define LM93_TEMP_OFFSET_MIN  (  0)
+#define LM93_TEMP_OFFSET_MAX0 (150)
+#define LM93_TEMP_OFFSET_MAX1 ( 75)
+
+/* This function is common to all 4-bit temperature offsets
+   returns 4 bits right justified
+   mode 0 => 1C/bit, mode !0 => 0.5C/bit */
+static u8 LM93_TEMP_OFFSET_TO_REG(int off, int mode)
+{
+	int factor = mode ? 5 : 10;
+
+	off = SENSORS_LIMIT(off, LM93_TEMP_OFFSET_MIN,
+		mode ? LM93_TEMP_OFFSET_MAX1 : LM93_TEMP_OFFSET_MAX0);
+	return (u8)((off + factor/2) / factor);
+}
+
+/* 0 <= nr <= 3 */
+static int LM93_TEMP_AUTO_OFFSET_FROM_REG(u8 reg, int nr, int mode)
+{
+	/* temp1-temp2 (nr=0,1) use lower nibble */
+	if (nr < 2)
+		return LM93_TEMP_OFFSET_FROM_REG(reg & 0x0f, mode);
+
+	/* temp3-temp4 (nr=2,3) use upper nibble */
+	else
+		return LM93_TEMP_OFFSET_FROM_REG(reg >> 4 & 0x0f, mode);
+}
+
+/* TEMP: 1/10 degrees C (0C to +15C (mode 0) or +7.5C (mode non-zero))
+   REG: 1.0C/bit (mode 0) or 0.5C/bit (mode non-zero)
+   0 <= nr <= 3 */
+static u8 LM93_TEMP_AUTO_OFFSET_TO_REG(u8 old, int off, int nr, int mode)
+{
+	u8 new = LM93_TEMP_OFFSET_TO_REG(off, mode);
+
+	/* temp1-temp2 (nr=0,1) use lower nibble */
+	if (nr < 2)
+		return (old & 0xf0) | (new & 0x0f);
+
+	/* temp3-temp4 (nr=2,3) use upper nibble */
+	else
+		return (new << 4 & 0xf0) | (old & 0x0f);
+}
+
+static int LM93_AUTO_BOOST_HYST_FROM_REGS(struct lm93_data *data, int nr,
+		int mode)
+{
+	u8 reg;
+
+	switch (nr) {
+	case 0:
+		reg = data->boost_hyst[0] & 0x0f;
+		break;
+	case 1:
+		reg = data->boost_hyst[0] >> 4 & 0x0f;
+		break;
+	case 2:
+		reg = data->boost_hyst[1] & 0x0f;
+		break;
+	case 3:
+	default:
+		reg = data->boost_hyst[1] >> 4 & 0x0f;
+		break;
+	}
+
+	return LM93_TEMP_FROM_REG(data->boost[nr]) -
+			LM93_TEMP_OFFSET_FROM_REG(reg, mode);
+}
+
+static u8 LM93_AUTO_BOOST_HYST_TO_REG(struct lm93_data *data, long hyst,
+		int nr, int mode)
+{
+	u8 reg = LM93_TEMP_OFFSET_TO_REG(
+			(LM93_TEMP_FROM_REG(data->boost[nr]) - hyst), mode);
+
+	switch (nr) {
+	case 0:
+		reg = (data->boost_hyst[0] & 0xf0) | (reg & 0x0f);
+		break;
+	case 1:
+		reg = (reg << 4 & 0xf0) | (data->boost_hyst[0] & 0x0f);
+		break;
+	case 2:
+		reg = (data->boost_hyst[1] & 0xf0) | (reg & 0x0f);
+		break;
+	case 3:
+	default:
+		reg = (reg << 4 & 0xf0) | (data->boost_hyst[1] & 0x0f);
+		break;
+	}
+
+	return reg;
+}
+
+/* PWM: 0-255 per sensors documentation
+   REG: 0-13 as mapped below... right justified */
+typedef enum { LM93_PWM_MAP_HI_FREQ, LM93_PWM_MAP_LO_FREQ } pwm_freq_t;
+static int lm93_pwm_map[2][14] = {
+	{
+		0x00, /*   0.00% */ 0x40, /*  25.00% */
+		0x50, /*  31.25% */ 0x60, /*  37.50% */
+		0x70, /*  43.75% */ 0x80, /*  50.00% */
+		0x90, /*  56.25% */ 0xa0, /*  62.50% */
+		0xb0, /*  68.75% */ 0xc0, /*  75.00% */
+		0xd0, /*  81.25% */ 0xe0, /*  87.50% */
+		0xf0, /*  93.75% */ 0xff, /* 100.00% */
+	},
+	{
+		0x00, /*   0.00% */ 0x40, /*  25.00% */
+		0x49, /*  28.57% */ 0x52, /*  32.14% */
+		0x5b, /*  35.71% */ 0x64, /*  39.29% */
+		0x6d, /*  42.86% */ 0x76, /*  46.43% */
+		0x80, /*  50.00% */ 0x89, /*  53.57% */
+		0x92, /*  57.14% */ 0xb6, /*  71.43% */
+		0xdb, /*  85.71% */ 0xff, /* 100.00% */
+	},
+};
+
+static int LM93_PWM_FROM_REG(u8 reg, pwm_freq_t freq)
+{
+	return lm93_pwm_map[freq][reg & 0x0f];
+}
+
+/* round up to nearest match */
+static u8 LM93_PWM_TO_REG(int pwm, pwm_freq_t freq)
+{
+	int i;
+	for (i = 0; i < 13; i++)
+		if (pwm <= lm93_pwm_map[freq][i])
+			break;
+
+	/* can fall through with i==13 */
+	return (u8)i;
+}
+
+static int LM93_FAN_FROM_REG(u16 regs)
+{
+	const u16 count = le16_to_cpu(regs) >> 2;
+	return count==0 ? -1 : count==0x3fff ? 0: 1350000 / count;
+}
+
+static u16 LM93_FAN_TO_REG(long rpm)
+{
+	u16 count, regs;
+
+	if (rpm == 0) {
+		count = 0x3fff;
+	} else {
+		rpm = SENSORS_LIMIT(rpm, 1, 1000000);
+		count = SENSORS_LIMIT((1350000 + rpm) / rpm, 1, 0x3ffe);
+	}
+
+	regs = count << 2;
+	return cpu_to_le16(regs);
+}
+
+/* PWM FREQ: HZ
+   REG: 0-7 as mapped below */
+static int lm93_pwm_freq_map[8] = {
+	22500, 96, 84, 72, 60, 48, 36, 12
+};
+
+static int LM93_PWM_FREQ_FROM_REG(u8 reg)
+{
+	return lm93_pwm_freq_map[reg & 0x07];
+}
+
+/* round up to nearest match */
+static u8 LM93_PWM_FREQ_TO_REG(int freq)
+{
+	int i;
+	for (i = 7; i > 0; i--)
+		if (freq <= lm93_pwm_freq_map[i])
+			break;
+
+	/* can fall through with i==0 */
+	return (u8)i;
+}
+
+/* TIME: 1/100 seconds
+ * REG: 0-7 as mapped below */
+static int lm93_spinup_time_map[8] = {
+	0, 10, 25, 40, 70, 100, 200, 400,
+};
+
+static int LM93_SPINUP_TIME_FROM_REG(u8 reg)
+{
+	return lm93_spinup_time_map[reg >> 5 & 0x07];
+}
+
+/* round up to nearest match */
+static u8 LM93_SPINUP_TIME_TO_REG(int time)
+{
+	int i;
+	for (i = 0; i < 7; i++)
+		if (time <= lm93_spinup_time_map[i])
+			break;
+
+	/* can fall through with i==8 */
+	return (u8)i;
+}
+
+#define LM93_RAMP_MIN 0
+#define LM93_RAMP_MAX 75
+
+static int LM93_RAMP_FROM_REG(u8 reg)
+{
+	return (reg & 0x0f) * 5;
+}
+
+/* RAMP: 1/100 seconds
+   REG: 50mS/bit 4-bits right justified */
+static u8 LM93_RAMP_TO_REG(int ramp)
+{
+	ramp = SENSORS_LIMIT(ramp, LM93_RAMP_MIN, LM93_RAMP_MAX);
+	return (u8)((ramp + 2) / 5);
+}
+
+/* PROCHOT: 0-255, 0 => 0%, 255 => > 96.6%
+ * REG: (same) */
+static u8 LM93_PROCHOT_TO_REG(long prochot)
+{
+	prochot = SENSORS_LIMIT(prochot, 0, 255);
+	return (u8)prochot;
+}
+
+/* PROCHOT-INTERVAL: 73 - 37200 (1/100 seconds)
+ * REG: 0-9 as mapped below */
+static int lm93_interval_map[10] = {
+	73, 146, 290, 580, 1170, 2330, 4660, 9320, 18600, 37200,
+};
+
+static int LM93_INTERVAL_FROM_REG(u8 reg)
+{
+	return lm93_interval_map[reg & 0x0f];
+}
+
+/* round up to nearest match */
+static u8 LM93_INTERVAL_TO_REG(long interval)
+{
+	int i;
+	for (i = 0; i < 9; i++)
+		if (interval <= lm93_interval_map[i])
+			break;
+
+	/* can fall through with i==9 */
+	return (u8)i;
+}
+
+/* GPIO: 0-255, GPIO0 is LSB
+ * REG: inverted */
+static unsigned LM93_GPI_FROM_REG(u8 reg)
+{
+	return ~reg & 0xff;
+}
+
+/* alarm bitmask definitions
+   The LM93 has nearly 64 bits of error status... I've pared that down to
+   what I think is a useful subset in order to fit it into 32 bits.
+
+   Especially note that the #VRD_HOT alarms are missing because we provide
+   that information as values in another sysfs file.
+
+   If libsensors is extended to support 64 bit values, this could be revisited.
+*/
+#define LM93_ALARM_IN1		0x00000001
+#define LM93_ALARM_IN2		0x00000002
+#define LM93_ALARM_IN3		0x00000004
+#define LM93_ALARM_IN4		0x00000008
+#define LM93_ALARM_IN5		0x00000010
+#define LM93_ALARM_IN6		0x00000020
+#define LM93_ALARM_IN7		0x00000040
+#define LM93_ALARM_IN8		0x00000080
+#define LM93_ALARM_IN9		0x00000100
+#define LM93_ALARM_IN10		0x00000200
+#define LM93_ALARM_IN11		0x00000400
+#define LM93_ALARM_IN12		0x00000800
+#define LM93_ALARM_IN13		0x00001000
+#define LM93_ALARM_IN14		0x00002000
+#define LM93_ALARM_IN15		0x00004000
+#define LM93_ALARM_IN16		0x00008000
+#define LM93_ALARM_FAN1		0x00010000
+#define LM93_ALARM_FAN2		0x00020000
+#define LM93_ALARM_FAN3		0x00040000
+#define LM93_ALARM_FAN4		0x00080000
+#define LM93_ALARM_PH1_ERR	0x00100000
+#define LM93_ALARM_PH2_ERR	0x00200000
+#define LM93_ALARM_SCSI1_ERR	0x00400000
+#define LM93_ALARM_SCSI2_ERR	0x00800000
+#define LM93_ALARM_DVDDP1_ERR	0x01000000
+#define LM93_ALARM_DVDDP2_ERR	0x02000000
+#define LM93_ALARM_D1_ERR	0x04000000
+#define LM93_ALARM_D2_ERR	0x08000000
+#define LM93_ALARM_TEMP1	0x10000000
+#define LM93_ALARM_TEMP2	0x20000000
+#define LM93_ALARM_TEMP3	0x40000000
+
+static unsigned LM93_ALARMS_FROM_REG(struct block1_t b1)
+{
+	unsigned result;
+	result  = b1.host_status_2 & 0x3f;
+
+	if (vccp_limit_type[0])
+		result |= (b1.host_status_4 & 0x10) << 2;
+	else
+		result |= b1.host_status_2 & 0x40;
+
+	if (vccp_limit_type[1])
+		result |= (b1.host_status_4 & 0x20) << 2;
+	else
+		result |= b1.host_status_2 & 0x80;
+
+	result |= b1.host_status_3 << 8;
+	result |= (b1.fan_status & 0x0f) << 16;
+	result |= (b1.p1_prochot_status & 0x80) << 13;
+	result |= (b1.p2_prochot_status & 0x80) << 14;
+	result |= (b1.host_status_4 & 0xfc) << 20;
+	result |= (b1.host_status_1 & 0x07) << 28;
+	return result;
+}
+
+/* following are the sysfs callback functions */
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_IN_FROM_REG(nr, data->block3[nr]));
+}
+
+static SENSOR_DEVICE_ATTR(in1_input, S_IRUGO, show_in, NULL, 0);
+static SENSOR_DEVICE_ATTR(in2_input, S_IRUGO, show_in, NULL, 1);
+static SENSOR_DEVICE_ATTR(in3_input, S_IRUGO, show_in, NULL, 2);
+static SENSOR_DEVICE_ATTR(in4_input, S_IRUGO, show_in, NULL, 3);
+static SENSOR_DEVICE_ATTR(in5_input, S_IRUGO, show_in, NULL, 4);
+static SENSOR_DEVICE_ATTR(in6_input, S_IRUGO, show_in, NULL, 5);
+static SENSOR_DEVICE_ATTR(in7_input, S_IRUGO, show_in, NULL, 6);
+static SENSOR_DEVICE_ATTR(in8_input, S_IRUGO, show_in, NULL, 7);
+static SENSOR_DEVICE_ATTR(in9_input, S_IRUGO, show_in, NULL, 8);
+static SENSOR_DEVICE_ATTR(in10_input, S_IRUGO, show_in, NULL, 9);
+static SENSOR_DEVICE_ATTR(in11_input, S_IRUGO, show_in, NULL, 10);
+static SENSOR_DEVICE_ATTR(in12_input, S_IRUGO, show_in, NULL, 11);
+static SENSOR_DEVICE_ATTR(in13_input, S_IRUGO, show_in, NULL, 12);
+static SENSOR_DEVICE_ATTR(in14_input, S_IRUGO, show_in, NULL, 13);
+static SENSOR_DEVICE_ATTR(in15_input, S_IRUGO, show_in, NULL, 14);
+static SENSOR_DEVICE_ATTR(in16_input, S_IRUGO, show_in, NULL, 15);
+
+static ssize_t show_in_min(struct device *dev,
+			struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	int vccp = nr - 6;
+	long rc, vid;
+
+	if ((nr==6 || nr==7) && (vccp_limit_type[vccp])) {
+		vid = LM93_VID_FROM_REG(data->vid[vccp]);
+		rc = LM93_IN_MIN_FROM_REG(data->vccp_limits[vccp],vid);
+	}
+	else {
+		rc = LM93_IN_FROM_REG(nr,data->block7[nr].min); \
+	}
+	return sprintf(buf,"%ld\n",rc); \
+}
+
+static ssize_t store_in_min(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	int vccp = nr - 6;
+	long vid;
+
+	mutex_lock(&data->update_lock);
+	if ((nr==6 || nr==7) && (vccp_limit_type[vccp])) {
+		vid = LM93_VID_FROM_REG(data->vid[vccp]);
+		data->vccp_limits[vccp] = (data->vccp_limits[vccp] & 0xf0) |
+				LM93_IN_REL_TO_REG(val, 0, vid);
+		lm93_write_byte(client, LM93_REG_VCCP_LIMIT_OFF(vccp),
+				data->vccp_limits[vccp]);
+	}
+	else {
+		data->block7[nr].min = LM93_IN_TO_REG(nr,val);
+		lm93_write_byte(client, LM93_REG_IN_MIN(nr),
+				data->block7[nr].min);
+	}
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(in1_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 0);
+static SENSOR_DEVICE_ATTR(in2_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 1);
+static SENSOR_DEVICE_ATTR(in3_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 2);
+static SENSOR_DEVICE_ATTR(in4_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 3);
+static SENSOR_DEVICE_ATTR(in5_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 4);
+static SENSOR_DEVICE_ATTR(in6_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 5);
+static SENSOR_DEVICE_ATTR(in7_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 6);
+static SENSOR_DEVICE_ATTR(in8_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 7);
+static SENSOR_DEVICE_ATTR(in9_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 8);
+static SENSOR_DEVICE_ATTR(in10_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 9);
+static SENSOR_DEVICE_ATTR(in11_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 10);
+static SENSOR_DEVICE_ATTR(in12_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 11);
+static SENSOR_DEVICE_ATTR(in13_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 12);
+static SENSOR_DEVICE_ATTR(in14_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 13);
+static SENSOR_DEVICE_ATTR(in15_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 14);
+static SENSOR_DEVICE_ATTR(in16_min, S_IWUSR | S_IRUGO,
+			  show_in_min, store_in_min, 15);
+
+static ssize_t show_in_max(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	int vccp = nr - 6;
+	long rc, vid;
+
+	if ((nr==6 || nr==7) && (vccp_limit_type[vccp])) {
+		vid = LM93_VID_FROM_REG(data->vid[vccp]);
+		rc = LM93_IN_MAX_FROM_REG(data->vccp_limits[vccp],vid);
+	}
+	else {
+		rc = LM93_IN_FROM_REG(nr,data->block7[nr].max); \
+	}
+	return sprintf(buf,"%ld\n",rc); \
+}
+
+static ssize_t store_in_max(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	int vccp = nr - 6;
+	long vid;
+
+	mutex_lock(&data->update_lock);
+	if ((nr==6 || nr==7) && (vccp_limit_type[vccp])) {
+		vid = LM93_VID_FROM_REG(data->vid[vccp]);
+		data->vccp_limits[vccp] = (data->vccp_limits[vccp] & 0x0f) |
+				LM93_IN_REL_TO_REG(val, 1, vid);
+		lm93_write_byte(client, LM93_REG_VCCP_LIMIT_OFF(vccp),
+				data->vccp_limits[vccp]);
+	}
+	else {
+		data->block7[nr].max = LM93_IN_TO_REG(nr,val);
+		lm93_write_byte(client, LM93_REG_IN_MAX(nr),
+				data->block7[nr].max);
+	}
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(in1_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 0);
+static SENSOR_DEVICE_ATTR(in2_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 1);
+static SENSOR_DEVICE_ATTR(in3_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 2);
+static SENSOR_DEVICE_ATTR(in4_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 3);
+static SENSOR_DEVICE_ATTR(in5_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 4);
+static SENSOR_DEVICE_ATTR(in6_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 5);
+static SENSOR_DEVICE_ATTR(in7_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 6);
+static SENSOR_DEVICE_ATTR(in8_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 7);
+static SENSOR_DEVICE_ATTR(in9_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 8);
+static SENSOR_DEVICE_ATTR(in10_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 9);
+static SENSOR_DEVICE_ATTR(in11_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 10);
+static SENSOR_DEVICE_ATTR(in12_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 11);
+static SENSOR_DEVICE_ATTR(in13_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 12);
+static SENSOR_DEVICE_ATTR(in14_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 13);
+static SENSOR_DEVICE_ATTR(in15_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 14);
+static SENSOR_DEVICE_ATTR(in16_max, S_IWUSR | S_IRUGO,
+			  show_in_max, store_in_max, 15);
+
+static ssize_t show_temp(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->block2[nr]));
+}
+
+static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
+static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
+static SENSOR_DEVICE_ATTR(temp3_input, S_IRUGO, show_temp, NULL, 2);
+
+static ssize_t show_temp_min(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->temp_lim[nr].min));
+}
+
+static ssize_t store_temp_min(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->temp_lim[nr].min = LM93_TEMP_TO_REG(val);
+	lm93_write_byte(client, LM93_REG_TEMP_MIN(nr), data->temp_lim[nr].min);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_min, S_IWUSR | S_IRUGO,
+			  show_temp_min, store_temp_min, 0);
+static SENSOR_DEVICE_ATTR(temp2_min, S_IWUSR | S_IRUGO,
+			  show_temp_min, store_temp_min, 1);
+static SENSOR_DEVICE_ATTR(temp3_min, S_IWUSR | S_IRUGO,
+			  show_temp_min, store_temp_min, 2);
+
+static ssize_t show_temp_max(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->temp_lim[nr].max));
+}
+
+static ssize_t store_temp_max(struct device *dev, struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->temp_lim[nr].max = LM93_TEMP_TO_REG(val);
+	lm93_write_byte(client, LM93_REG_TEMP_MAX(nr), data->temp_lim[nr].max);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_max, S_IWUSR | S_IRUGO,
+			  show_temp_max, store_temp_max, 0);
+static SENSOR_DEVICE_ATTR(temp2_max, S_IWUSR | S_IRUGO,
+			  show_temp_max, store_temp_max, 1);
+static SENSOR_DEVICE_ATTR(temp3_max, S_IWUSR | S_IRUGO,
+			  show_temp_max, store_temp_max, 2);
+
+static ssize_t show_temp_auto_base(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->block10.base[nr]));
+}
+
+static ssize_t store_temp_auto_base(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->block10.base[nr] = LM93_TEMP_TO_REG(val);
+	lm93_write_byte(client, LM93_REG_TEMP_BASE(nr), data->block10.base[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_auto_base, S_IWUSR | S_IRUGO,
+			  show_temp_auto_base, store_temp_auto_base, 0);
+static SENSOR_DEVICE_ATTR(temp2_auto_base, S_IWUSR | S_IRUGO,
+			  show_temp_auto_base, store_temp_auto_base, 1);
+static SENSOR_DEVICE_ATTR(temp3_auto_base, S_IWUSR | S_IRUGO,
+			  show_temp_auto_base, store_temp_auto_base, 2);
+
+static ssize_t show_temp_auto_boost(struct device *dev,
+				    struct device_attribute *attr,char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_TEMP_FROM_REG(data->boost[nr]));
+}
+
+static ssize_t store_temp_auto_boost(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->boost[nr] = LM93_TEMP_TO_REG(val);
+	lm93_write_byte(client, LM93_REG_BOOST(nr), data->boost[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_auto_boost, S_IWUSR | S_IRUGO,
+			  show_temp_auto_boost, store_temp_auto_boost, 0);
+static SENSOR_DEVICE_ATTR(temp2_auto_boost, S_IWUSR | S_IRUGO,
+			  show_temp_auto_boost, store_temp_auto_boost, 1);
+static SENSOR_DEVICE_ATTR(temp3_auto_boost, S_IWUSR | S_IRUGO,
+			  show_temp_auto_boost, store_temp_auto_boost, 2);
+
+static ssize_t show_temp_auto_boost_hyst(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
+	return sprintf(buf,"%d\n",
+		       LM93_AUTO_BOOST_HYST_FROM_REGS(data, nr, mode));
+}
+
+static ssize_t store_temp_auto_boost_hyst(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	/* force 0.5C/bit mode */
+	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
+	data->sfc2 |= ((nr < 2) ? 0x10 : 0x20);
+	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
+	data->boost_hyst[nr/2] = LM93_AUTO_BOOST_HYST_TO_REG(data, val, nr, 1);
+	lm93_write_byte(client, LM93_REG_BOOST_HYST(nr),
+			data->boost_hyst[nr/2]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_auto_boost_hyst, S_IWUSR | S_IRUGO,
+			  show_temp_auto_boost_hyst,
+			  store_temp_auto_boost_hyst, 0);
+static SENSOR_DEVICE_ATTR(temp2_auto_boost_hyst, S_IWUSR | S_IRUGO,
+			  show_temp_auto_boost_hyst,
+			  store_temp_auto_boost_hyst, 1);
+static SENSOR_DEVICE_ATTR(temp3_auto_boost_hyst, S_IWUSR | S_IRUGO,
+			  show_temp_auto_boost_hyst,
+			  store_temp_auto_boost_hyst, 2);
+
+static ssize_t show_temp_auto_offset(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index & 0xFF;
+	int ofs = (s_attr->index >> 8) & 0xFF;
+	struct lm93_data *data = lm93_update_device(dev);
+	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
+	return sprintf(buf,"%d\n",
+	       LM93_TEMP_AUTO_OFFSET_FROM_REG(data->block10.offset[ofs],
+					      nr,mode));
+}
+
+static ssize_t store_temp_auto_offset(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index & 0xFF;
+	int ofs = (s_attr->index >> 8) & 0xFF;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	/* force 0.5C/bit mode */
+	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
+	data->sfc2 |= ((nr < 2) ? 0x10 : 0x20);
+	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
+	data->block10.offset[ofs] = LM93_TEMP_AUTO_OFFSET_TO_REG(
+			data->block10.offset[ofs], val, nr, 1);
+	lm93_write_byte(client, LM93_REG_TEMP_OFFSET(ofs),
+			data->block10.offset[ofs]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_auto_offset1, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0000);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset2, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0100);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset3, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0200);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset4, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0300);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset5, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0400);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset6, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0500);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset7, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0600);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset8, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0700);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset9, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0800);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset10, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0900);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset11, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0a00);
+static SENSOR_DEVICE_ATTR(temp1_auto_offset12, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0b00);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset1, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0001);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset2, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0101);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset3, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0201);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset4, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0301);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset5, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0401);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset6, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0501);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset7, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0601);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset8, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0701);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset9, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0801);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset10, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0901);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset11, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0a01);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset12, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0b01);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset1, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0002);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset2, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0102);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset3, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0202);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset4, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0302);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset5, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0402);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset6, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0502);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset7, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0602);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset8, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0702);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset9, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0802);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset10, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0902);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset11, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0a02);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset12, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset,
+			  store_temp_auto_offset, 0x0b02);
+
+static ssize_t show_temp_auto_pwm_min(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	u8 reg, ctl4;
+	struct lm93_data *data = lm93_update_device(dev);
+	reg = data->auto_pwm_min_hyst[nr/2] >> 4 & 0x0f;
+	ctl4 = data->block9[nr][LM93_PWM_CTL4];
+	return sprintf(buf,"%d\n",LM93_PWM_FROM_REG(reg, (ctl4 & 0x07) ?
+				LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
+}
+
+static ssize_t store_temp_auto_pwm_min(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 reg, ctl4;
+
+	mutex_lock(&data->update_lock);
+	reg = lm93_read_byte(client, LM93_REG_PWM_MIN_HYST(nr));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
+	reg = (reg & 0x0f) |
+		LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
+				LM93_PWM_MAP_LO_FREQ :
+				LM93_PWM_MAP_HI_FREQ) << 4;
+	data->auto_pwm_min_hyst[nr/2] = reg;
+	lm93_write_byte(client, LM93_REG_PWM_MIN_HYST(nr), reg);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_auto_pwm_min, S_IWUSR | S_IRUGO,
+			  show_temp_auto_pwm_min,
+			  store_temp_auto_pwm_min, 0);
+static SENSOR_DEVICE_ATTR(temp2_auto_pwm_min, S_IWUSR | S_IRUGO,
+			  show_temp_auto_pwm_min,
+			  store_temp_auto_pwm_min, 1);
+static SENSOR_DEVICE_ATTR(temp3_auto_pwm_min, S_IWUSR | S_IRUGO,
+			  show_temp_auto_pwm_min,
+			  store_temp_auto_pwm_min, 2);
+
+static ssize_t show_temp_auto_offset_hyst(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	int mode = LM93_TEMP_OFFSET_MODE_FROM_REG(data->sfc2, nr);
+	return sprintf(buf,"%d\n",LM93_TEMP_OFFSET_FROM_REG(
+					data->auto_pwm_min_hyst[nr/2], mode));
+}
+
+static ssize_t store_temp_auto_offset_hyst(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 reg;
+
+	mutex_lock(&data->update_lock);
+	/* force 0.5C/bit mode */
+	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
+	data->sfc2 |= ((nr < 2) ? 0x10 : 0x20);
+	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
+	reg = data->auto_pwm_min_hyst[nr/2];
+	reg = (reg & 0xf0) | (LM93_TEMP_OFFSET_TO_REG(val, 1) & 0x0f);
+	data->auto_pwm_min_hyst[nr/2] = reg;
+	lm93_write_byte(client, LM93_REG_PWM_MIN_HYST(nr), reg);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(temp1_auto_offset_hyst, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset_hyst,
+			  store_temp_auto_offset_hyst, 0);
+static SENSOR_DEVICE_ATTR(temp2_auto_offset_hyst, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset_hyst,
+			  store_temp_auto_offset_hyst, 1);
+static SENSOR_DEVICE_ATTR(temp3_auto_offset_hyst, S_IWUSR | S_IRUGO,
+			  show_temp_auto_offset_hyst,
+			  store_temp_auto_offset_hyst, 2);
+
+static ssize_t show_fan_input(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+
+	return sprintf(buf,"%d\n",LM93_FAN_FROM_REG(data->block5[nr]));
+}
+
+static SENSOR_DEVICE_ATTR(fan1_input, S_IRUGO, show_fan_input, NULL, 0);
+static SENSOR_DEVICE_ATTR(fan2_input, S_IRUGO, show_fan_input, NULL, 1);
+static SENSOR_DEVICE_ATTR(fan3_input, S_IRUGO, show_fan_input, NULL, 2);
+static SENSOR_DEVICE_ATTR(fan4_input, S_IRUGO, show_fan_input, NULL, 3);
+
+static ssize_t show_fan_min(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+
+	return sprintf(buf,"%d\n",LM93_FAN_FROM_REG(data->block8[nr]));
+}
+
+static ssize_t store_fan_min(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->block8[nr] = LM93_FAN_TO_REG(val);
+	lm93_write_word(client,LM93_REG_FAN_MIN(nr),data->block8[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(fan1_min, S_IWUSR | S_IRUGO,
+			  show_fan_min, store_fan_min, 0);
+static SENSOR_DEVICE_ATTR(fan2_min, S_IWUSR | S_IRUGO,
+			  show_fan_min, store_fan_min, 1);
+static SENSOR_DEVICE_ATTR(fan3_min, S_IWUSR | S_IRUGO,
+			  show_fan_min, store_fan_min, 2);
+static SENSOR_DEVICE_ATTR(fan4_min, S_IWUSR | S_IRUGO,
+			  show_fan_min, store_fan_min, 3);
+
+/* some tedious bit-twiddling here to deal with the register format:
+
+	data->sf_tach_to_pwm: (tach to pwm mapping bits)
+
+		bit |  7  |  6  |  5  |  4  |  3  |  2  |  1  |  0
+		     T4:P2 T4:P1 T3:P2 T3:P1 T2:P2 T2:P1 T1:P2 T1:P1
+
+	data->sfc2: (enable bits)
+
+		bit |  3  |  2  |  1  |  0
+		       T4    T3    T2    T1
+*/
+
+static ssize_t show_fan_smart_tach(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	long rc = 0;
+	int mapping;
+
+	/* extract the relevant mapping */
+	mapping = (data->sf_tach_to_pwm >> (nr * 2)) & 0x03;
+
+	/* if there's a mapping and it's enabled */
+	if (mapping && ((data->sfc2 >> nr) & 0x01))
+		rc = mapping;
+	return sprintf(buf,"%ld\n",rc);
+}
+
+/* helper function - must grab data->update_lock before calling
+   fan is 0-3, indicating fan1-fan4 */
+static void lm93_write_fan_smart_tach(struct i2c_client *client,
+	struct lm93_data *data, int fan, long value)
+{
+	/* insert the new mapping and write it out */
+	data->sf_tach_to_pwm = lm93_read_byte(client, LM93_REG_SF_TACH_TO_PWM);
+	data->sf_tach_to_pwm &= ~(0x3 << fan * 2);
+	data->sf_tach_to_pwm |= value << fan * 2;
+	lm93_write_byte(client, LM93_REG_SF_TACH_TO_PWM, data->sf_tach_to_pwm);
+
+	/* insert the enable bit and write it out */
+	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
+	if (value)
+		data->sfc2 |= 1 << fan;
+	else
+		data->sfc2 &= ~(1 << fan);
+	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
+}
+
+static ssize_t store_fan_smart_tach(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	/* sanity test, ignore the write otherwise */
+	if (0 <= val && val <= 2) {
+		/* can't enable if pwm freq is 22.5KHz */
+		if (val) {
+			u8 ctl4 = lm93_read_byte(client,
+				LM93_REG_PWM_CTL(val-1,LM93_PWM_CTL4));
+			if ((ctl4 & 0x07) == 0)
+				val = 0;
+		}
+		lm93_write_fan_smart_tach(client, data, nr, val);
+	}
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(fan1_smart_tach, S_IWUSR | S_IRUGO,
+			  show_fan_smart_tach, store_fan_smart_tach, 0);
+static SENSOR_DEVICE_ATTR(fan2_smart_tach, S_IWUSR | S_IRUGO,
+			  show_fan_smart_tach, store_fan_smart_tach, 1);
+static SENSOR_DEVICE_ATTR(fan3_smart_tach, S_IWUSR | S_IRUGO,
+			  show_fan_smart_tach, store_fan_smart_tach, 2);
+static SENSOR_DEVICE_ATTR(fan4_smart_tach, S_IWUSR | S_IRUGO,
+			  show_fan_smart_tach, store_fan_smart_tach, 3);
+
+static ssize_t show_pwm(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	u8 ctl2, ctl4;
+	long rc;
+
+	ctl2 = (data->block9[nr][LM93_PWM_CTL2] >> 4) & 0x0f;
+	ctl4 = data->block9[nr][LM93_PWM_CTL4];
+	if (ctl2 & 0x01) /* show user commanded value if enabled */
+		rc = data->pwm_override[nr];
+	else /* show present h/w value if manual pwm disabled */
+		rc = LM93_PWM_FROM_REG(ctl2, (ctl4 & 0x07) ?
+			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ);
+	return sprintf(buf,"%ld\n",rc);
+}
+
+static ssize_t store_pwm(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 ctl2, ctl4;
+
+	mutex_lock(&data->update_lock);
+	ctl2 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2));
+	ctl4 = lm93_read_byte(client, LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
+	ctl2 = (ctl2 & 0x0f) | LM93_PWM_TO_REG(val,(ctl4 & 0x07) ?
+			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ) << 4;
+	/* save user commanded value */
+	data->pwm_override[nr] = LM93_PWM_FROM_REG(ctl2 >> 4 & 0x0f,
+			(ctl4 & 0x07) ?  LM93_PWM_MAP_LO_FREQ :
+			LM93_PWM_MAP_HI_FREQ);
+	lm93_write_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2),ctl2);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(pwm1, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 0);
+static SENSOR_DEVICE_ATTR(pwm2, S_IWUSR | S_IRUGO, show_pwm, store_pwm, 1);
+
+static ssize_t show_pwm_override(struct device *dev,
+	       			struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	u8 ctl2;
+
+	ctl2 = data->block9[nr][LM93_PWM_CTL2];
+	return sprintf(buf,"%d\n",(ctl2 & 0x01) ? 1 : 0);
+}
+
+static ssize_t store_pwm_override(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 ctl2;
+
+	mutex_lock(&data->update_lock);
+	ctl2 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2));
+	if (val)
+		ctl2 |= 0x01;
+	else
+		ctl2 &= ~0x01;
+	lm93_write_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL2),ctl2);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(pwm1_override, S_IWUSR | S_IRUGO,
+			  show_pwm_override, store_pwm_override, 0);
+static SENSOR_DEVICE_ATTR(pwm2_override, S_IWUSR | S_IRUGO,
+			  show_pwm_override, store_pwm_override, 1);
+
+static ssize_t show_pwm_freq(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	u8 ctl4;
+
+	ctl4 = data->block9[nr][LM93_PWM_CTL4];
+	return sprintf(buf,"%d\n",LM93_PWM_FREQ_FROM_REG(ctl4));
+}
+
+/* helper function - must grab data->update_lock before calling
+   pwm is 0-1, indicating pwm1-pwm2
+   this disables smart tach for all tach channels bound to the given pwm */
+static void lm93_disable_fan_smart_tach(struct i2c_client *client,
+	struct lm93_data *data, int pwm)
+{
+	int mapping = lm93_read_byte(client, LM93_REG_SF_TACH_TO_PWM);
+	int mask;
+
+	/* collapse the mapping into a mask of enable bits */
+	mapping = (mapping >> pwm) & 0x55;
+	mask = mapping & 0x01;
+	mask |= (mapping & 0x04) >> 1;
+	mask |= (mapping & 0x10) >> 2;
+	mask |= (mapping & 0x40) >> 3;
+
+	/* disable smart tach according to the mask */
+	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
+	data->sfc2 &= ~mask;
+	lm93_write_byte(client, LM93_REG_SFC2, data->sfc2);
+}
+
+static ssize_t store_pwm_freq(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 ctl4;
+
+	mutex_lock(&data->update_lock);
+	ctl4 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4));
+	ctl4 = (ctl4 & 0xf8) | LM93_PWM_FREQ_TO_REG(val);
+	data->block9[nr][LM93_PWM_CTL4] = ctl4;
+	/* ctl4 == 0 -> 22.5KHz -> disable smart tach */
+	if (!ctl4)
+		lm93_disable_fan_smart_tach(client, data, nr);
+	lm93_write_byte(client,	LM93_REG_PWM_CTL(nr,LM93_PWM_CTL4), ctl4);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(pwm1_freq, S_IWUSR | S_IRUGO,
+			  show_pwm_freq, store_pwm_freq, 0);
+static SENSOR_DEVICE_ATTR(pwm2_freq, S_IWUSR | S_IRUGO,
+			  show_pwm_freq, store_pwm_freq, 1);
+
+static ssize_t show_pwm_auto_channels(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",data->block9[nr][LM93_PWM_CTL1]);
+}
+
+static ssize_t store_pwm_auto_channels(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->block9[nr][LM93_PWM_CTL1] = SENSORS_LIMIT(val, 0, 255);
+	lm93_write_byte(client,	LM93_REG_PWM_CTL(nr,LM93_PWM_CTL1),
+				data->block9[nr][LM93_PWM_CTL1]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_channels, S_IWUSR | S_IRUGO,
+			  show_pwm_auto_channels, store_pwm_auto_channels, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_channels, S_IWUSR | S_IRUGO,
+			  show_pwm_auto_channels, store_pwm_auto_channels, 1);
+
+static ssize_t show_pwm_auto_spinup_min(struct device *dev,
+				struct device_attribute *attr,char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	u8 ctl3, ctl4;
+
+	ctl3 = data->block9[nr][LM93_PWM_CTL3];
+	ctl4 = data->block9[nr][LM93_PWM_CTL4];
+	return sprintf(buf,"%d\n",
+		       LM93_PWM_FROM_REG(ctl3 & 0x0f, (ctl4 & 0x07) ?
+			LM93_PWM_MAP_LO_FREQ : LM93_PWM_MAP_HI_FREQ));
+}
+
+static ssize_t store_pwm_auto_spinup_min(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 ctl3, ctl4;
+
+	mutex_lock(&data->update_lock);
+	ctl3 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
+	ctl4 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL4));
+	ctl3 = (ctl3 & 0xf0) | 	LM93_PWM_TO_REG(val, (ctl4 & 0x07) ?
+			LM93_PWM_MAP_LO_FREQ :
+			LM93_PWM_MAP_HI_FREQ);
+	data->block9[nr][LM93_PWM_CTL3] = ctl3;
+	lm93_write_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_spinup_min, S_IWUSR | S_IRUGO,
+			  show_pwm_auto_spinup_min,
+			  store_pwm_auto_spinup_min, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_spinup_min, S_IWUSR | S_IRUGO,
+			  show_pwm_auto_spinup_min,
+			  store_pwm_auto_spinup_min, 1);
+
+static ssize_t show_pwm_auto_spinup_time(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_SPINUP_TIME_FROM_REG(
+				data->block9[nr][LM93_PWM_CTL3]));
+}
+
+static ssize_t store_pwm_auto_spinup_time(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 ctl3;
+
+	mutex_lock(&data->update_lock);
+	ctl3 = lm93_read_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3));
+	ctl3 = (ctl3 & 0x1f) | (LM93_SPINUP_TIME_TO_REG(val) << 5 & 0xe0);
+	data->block9[nr][LM93_PWM_CTL3] = ctl3;
+	lm93_write_byte(client,LM93_REG_PWM_CTL(nr, LM93_PWM_CTL3), ctl3);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(pwm1_auto_spinup_time, S_IWUSR | S_IRUGO,
+			  show_pwm_auto_spinup_time,
+			  store_pwm_auto_spinup_time, 0);
+static SENSOR_DEVICE_ATTR(pwm2_auto_spinup_time, S_IWUSR | S_IRUGO,
+			  show_pwm_auto_spinup_time,
+			  store_pwm_auto_spinup_time, 1);
+
+static ssize_t show_pwm_auto_prochot_ramp(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",
+		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl >> 4 & 0x0f));
+}
+
+static ssize_t store_pwm_auto_prochot_ramp(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 ramp;
+
+	mutex_lock(&data->update_lock);
+	ramp = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
+	ramp = (ramp & 0x0f) | (LM93_RAMP_TO_REG(val) << 4 & 0xf0);
+	lm93_write_byte(client, LM93_REG_PWM_RAMP_CTL, ramp);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(pwm_auto_prochot_ramp, S_IRUGO | S_IWUSR,
+			show_pwm_auto_prochot_ramp,
+			store_pwm_auto_prochot_ramp);
+
+static ssize_t show_pwm_auto_vrdhot_ramp(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",
+		       LM93_RAMP_FROM_REG(data->pwm_ramp_ctl & 0x0f));
+}
+
+static ssize_t store_pwm_auto_vrdhot_ramp(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 ramp;
+
+	mutex_lock(&data->update_lock);
+	ramp = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
+	ramp = (ramp & 0xf0) | (LM93_RAMP_TO_REG(val) & 0x0f);
+	lm93_write_byte(client, LM93_REG_PWM_RAMP_CTL, ramp);
+	mutex_unlock(&data->update_lock);
+	return 0;
+}
+
+static DEVICE_ATTR(pwm_auto_vrdhot_ramp, S_IRUGO | S_IWUSR,
+			show_pwm_auto_vrdhot_ramp,
+			store_pwm_auto_vrdhot_ramp);
+
+static ssize_t show_vid(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_VID_FROM_REG(data->vid[nr]));
+}
+
+static SENSOR_DEVICE_ATTR(vid1, S_IRUGO, show_vid, NULL, 0);
+static SENSOR_DEVICE_ATTR(vid2, S_IRUGO, show_vid, NULL, 1);
+
+static ssize_t show_prochot(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",data->block4[nr].cur);
+}
+
+static SENSOR_DEVICE_ATTR(prochot1, S_IRUGO, show_prochot, NULL, 0);
+static SENSOR_DEVICE_ATTR(prochot2, S_IRUGO, show_prochot, NULL, 1);
+
+static ssize_t show_prochot_avg(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",data->block4[nr].avg);
+}
+
+static SENSOR_DEVICE_ATTR(prochot1_avg, S_IRUGO, show_prochot_avg, NULL, 0);
+static SENSOR_DEVICE_ATTR(prochot2_avg, S_IRUGO, show_prochot_avg, NULL, 1);
+
+static ssize_t show_prochot_max(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",data->prochot_max[nr]);
+}
+
+static ssize_t store_prochot_max(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->prochot_max[nr] = LM93_PROCHOT_TO_REG(val);
+	lm93_write_byte(client, LM93_REG_PROCHOT_MAX(nr),
+			data->prochot_max[nr]);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(prochot1_max, S_IWUSR | S_IRUGO,
+			  show_prochot_max, store_prochot_max, 0);
+static SENSOR_DEVICE_ATTR(prochot2_max, S_IWUSR | S_IRUGO,
+			  show_prochot_max, store_prochot_max, 1);
+
+static const u8 prochot_override_mask[] = { 0x80, 0x40 };
+
+static ssize_t show_prochot_override(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",
+		(data->prochot_override & prochot_override_mask[nr]) ? 1 : 0);
+}
+
+static ssize_t store_prochot_override(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	if (val)
+		data->prochot_override |= prochot_override_mask[nr];
+	else
+		data->prochot_override &= (~prochot_override_mask[nr]);
+	lm93_write_byte(client, LM93_REG_PROCHOT_OVERRIDE,
+			data->prochot_override);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(prochot1_override, S_IWUSR | S_IRUGO,
+			  show_prochot_override, store_prochot_override, 0);
+static SENSOR_DEVICE_ATTR(prochot2_override, S_IWUSR | S_IRUGO,
+			  show_prochot_override, store_prochot_override, 1);
+
+static ssize_t show_prochot_interval(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	u8 tmp;
+	if (nr==1)
+		tmp = (data->prochot_interval & 0xf0) >> 4;
+	else
+		tmp = data->prochot_interval & 0x0f;
+	return sprintf(buf,"%d\n",LM93_INTERVAL_FROM_REG(tmp));
+}
+
+static ssize_t store_prochot_interval(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+	u8 tmp;
+
+	mutex_lock(&data->update_lock);
+	tmp = lm93_read_byte(client, LM93_REG_PROCHOT_INTERVAL);
+	if (nr==1)
+		tmp = (tmp & 0x0f) | (LM93_INTERVAL_TO_REG(val) << 4);
+	else
+		tmp = (tmp & 0xf0) | LM93_INTERVAL_TO_REG(val);
+	data->prochot_interval = tmp;
+	lm93_write_byte(client, LM93_REG_PROCHOT_INTERVAL, tmp);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static SENSOR_DEVICE_ATTR(prochot1_interval, S_IWUSR | S_IRUGO,
+			  show_prochot_interval, store_prochot_interval, 0);
+static SENSOR_DEVICE_ATTR(prochot2_interval, S_IWUSR | S_IRUGO,
+			  show_prochot_interval, store_prochot_interval, 1);
+
+static ssize_t show_prochot_override_duty_cycle(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",data->prochot_override & 0x0f);
+}
+
+static ssize_t store_prochot_override_duty_cycle(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	data->prochot_override = (data->prochot_override & 0xf0) |
+					SENSORS_LIMIT(val, 0, 15);
+	lm93_write_byte(client, LM93_REG_PROCHOT_OVERRIDE,
+			data->prochot_override);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(prochot_override_duty_cycle, S_IRUGO | S_IWUSR,
+			show_prochot_override_duty_cycle,
+			store_prochot_override_duty_cycle);
+
+static ssize_t show_prochot_short(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",(data->config & 0x10) ? 1 : 0);
+}
+
+static ssize_t store_prochot_short(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	u32 val = simple_strtoul(buf, NULL, 10);
+
+	mutex_lock(&data->update_lock);
+	if (val)
+		data->config |= 0x10;
+	else
+		data->config &= ~0x10;
+	lm93_write_byte(client, LM93_REG_CONFIG, data->config);
+	mutex_unlock(&data->update_lock);
+	return count;
+}
+
+static DEVICE_ATTR(prochot_short, S_IRUGO | S_IWUSR,
+		   show_prochot_short, store_prochot_short);
+
+static ssize_t show_vrdhot(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct sensor_device_attribute *s_attr = to_sensor_dev_attr(attr);
+	int nr = s_attr->index;
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",
+		       data->block1.host_status_1 & (1 << (nr+4)) ? 1 : 0);
+}
+
+static SENSOR_DEVICE_ATTR(vrdhot1, S_IRUGO, show_vrdhot, NULL, 0);
+static SENSOR_DEVICE_ATTR(vrdhot2, S_IRUGO, show_vrdhot, NULL, 1);
+
+static ssize_t show_gpio(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_GPI_FROM_REG(data->gpi));
+}
+
+static DEVICE_ATTR(gpio, S_IRUGO, show_gpio, NULL);
+
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+				char *buf)
+{
+	struct lm93_data *data = lm93_update_device(dev);
+	return sprintf(buf,"%d\n",LM93_ALARMS_FROM_REG(data->block1));
+}
+
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+static struct attribute *lm93_attrs[] = {
+	&sensor_dev_attr_in1_input.dev_attr.attr,
+	&sensor_dev_attr_in2_input.dev_attr.attr,
+	&sensor_dev_attr_in3_input.dev_attr.attr,
+	&sensor_dev_attr_in4_input.dev_attr.attr,
+	&sensor_dev_attr_in5_input.dev_attr.attr,
+	&sensor_dev_attr_in6_input.dev_attr.attr,
+	&sensor_dev_attr_in7_input.dev_attr.attr,
+	&sensor_dev_attr_in8_input.dev_attr.attr,
+	&sensor_dev_attr_in9_input.dev_attr.attr,
+	&sensor_dev_attr_in10_input.dev_attr.attr,
+	&sensor_dev_attr_in11_input.dev_attr.attr,
+	&sensor_dev_attr_in12_input.dev_attr.attr,
+	&sensor_dev_attr_in13_input.dev_attr.attr,
+	&sensor_dev_attr_in14_input.dev_attr.attr,
+	&sensor_dev_attr_in15_input.dev_attr.attr,
+	&sensor_dev_attr_in16_input.dev_attr.attr,
+	&sensor_dev_attr_in1_min.dev_attr.attr,
+	&sensor_dev_attr_in2_min.dev_attr.attr,
+	&sensor_dev_attr_in3_min.dev_attr.attr,
+	&sensor_dev_attr_in4_min.dev_attr.attr,
+	&sensor_dev_attr_in5_min.dev_attr.attr,
+	&sensor_dev_attr_in6_min.dev_attr.attr,
+	&sensor_dev_attr_in7_min.dev_attr.attr,
+	&sensor_dev_attr_in8_min.dev_attr.attr,
+	&sensor_dev_attr_in9_min.dev_attr.attr,
+	&sensor_dev_attr_in10_min.dev_attr.attr,
+	&sensor_dev_attr_in11_min.dev_attr.attr,
+	&sensor_dev_attr_in12_min.dev_attr.attr,
+	&sensor_dev_attr_in13_min.dev_attr.attr,
+	&sensor_dev_attr_in14_min.dev_attr.attr,
+	&sensor_dev_attr_in15_min.dev_attr.attr,
+	&sensor_dev_attr_in16_min.dev_attr.attr,
+	&sensor_dev_attr_in1_max.dev_attr.attr,
+	&sensor_dev_attr_in2_max.dev_attr.attr,
+	&sensor_dev_attr_in3_max.dev_attr.attr,
+	&sensor_dev_attr_in4_max.dev_attr.attr,
+	&sensor_dev_attr_in5_max.dev_attr.attr,
+	&sensor_dev_attr_in6_max.dev_attr.attr,
+	&sensor_dev_attr_in7_max.dev_attr.attr,
+	&sensor_dev_attr_in8_max.dev_attr.attr,
+	&sensor_dev_attr_in9_max.dev_attr.attr,
+	&sensor_dev_attr_in10_max.dev_attr.attr,
+	&sensor_dev_attr_in11_max.dev_attr.attr,
+	&sensor_dev_attr_in12_max.dev_attr.attr,
+	&sensor_dev_attr_in13_max.dev_attr.attr,
+	&sensor_dev_attr_in14_max.dev_attr.attr,
+	&sensor_dev_attr_in15_max.dev_attr.attr,
+	&sensor_dev_attr_in16_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	&sensor_dev_attr_temp2_input.dev_attr.attr,
+	&sensor_dev_attr_temp3_input.dev_attr.attr,
+	&sensor_dev_attr_temp1_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_max.dev_attr.attr,
+	&sensor_dev_attr_temp2_max.dev_attr.attr,
+	&sensor_dev_attr_temp3_max.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_base.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_base.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_base.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_boost.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_boost.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_boost.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_boost_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_boost_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_boost_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset1.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset2.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset3.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset4.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset5.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset6.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset7.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset8.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset9.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset10.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset11.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset12.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset1.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset2.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset3.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset4.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset5.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset6.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset7.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset8.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset9.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset10.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset11.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset12.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset1.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset2.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset3.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset4.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset5.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset6.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset7.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset8.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset9.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset10.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset11.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset12.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_pwm_min.dev_attr.attr,
+	&sensor_dev_attr_temp1_auto_offset_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp2_auto_offset_hyst.dev_attr.attr,
+	&sensor_dev_attr_temp3_auto_offset_hyst.dev_attr.attr,
+	&sensor_dev_attr_fan1_input.dev_attr.attr,
+	&sensor_dev_attr_fan2_input.dev_attr.attr,
+	&sensor_dev_attr_fan3_input.dev_attr.attr,
+	&sensor_dev_attr_fan4_input.dev_attr.attr,
+	&sensor_dev_attr_fan1_min.dev_attr.attr,
+	&sensor_dev_attr_fan2_min.dev_attr.attr,
+	&sensor_dev_attr_fan3_min.dev_attr.attr,
+	&sensor_dev_attr_fan4_min.dev_attr.attr,
+	&sensor_dev_attr_fan1_smart_tach.dev_attr.attr,
+	&sensor_dev_attr_fan2_smart_tach.dev_attr.attr,
+	&sensor_dev_attr_fan3_smart_tach.dev_attr.attr,
+	&sensor_dev_attr_fan4_smart_tach.dev_attr.attr,
+	&sensor_dev_attr_pwm1.dev_attr.attr,
+	&sensor_dev_attr_pwm2.dev_attr.attr,
+	&sensor_dev_attr_pwm1_override.dev_attr.attr,
+	&sensor_dev_attr_pwm2_override.dev_attr.attr,
+	&sensor_dev_attr_pwm1_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm2_freq.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_channels.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_channels.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_spinup_min.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_spinup_min.dev_attr.attr,
+	&sensor_dev_attr_pwm1_auto_spinup_time.dev_attr.attr,
+	&sensor_dev_attr_pwm2_auto_spinup_time.dev_attr.attr,
+	&dev_attr_pwm_auto_prochot_ramp.attr,
+	&dev_attr_pwm_auto_vrdhot_ramp.attr,
+	&sensor_dev_attr_vid1.dev_attr.attr,
+	&sensor_dev_attr_vid2.dev_attr.attr,
+	&sensor_dev_attr_prochot1.dev_attr.attr,
+	&sensor_dev_attr_prochot2.dev_attr.attr,
+	&sensor_dev_attr_prochot1_avg.dev_attr.attr,
+	&sensor_dev_attr_prochot2_avg.dev_attr.attr,
+	&sensor_dev_attr_prochot1_max.dev_attr.attr,
+	&sensor_dev_attr_prochot2_max.dev_attr.attr,
+	&sensor_dev_attr_prochot1_override.dev_attr.attr,
+	&sensor_dev_attr_prochot2_override.dev_attr.attr,
+	&sensor_dev_attr_prochot1_interval.dev_attr.attr,
+	&sensor_dev_attr_prochot2_interval.dev_attr.attr,
+	&dev_attr_prochot_override_duty_cycle.attr,
+	&dev_attr_prochot_short.attr,
+	&sensor_dev_attr_vrdhot1.dev_attr.attr,
+	&sensor_dev_attr_vrdhot2.dev_attr.attr,
+	&dev_attr_gpio.attr,
+	&dev_attr_alarms.attr,
+	NULL
+};
+
+static struct attribute_group lm93_attr_grp = {
+	.attrs = lm93_attrs,
+};
+
+#define MAX_RETRIES 5
+
+static u8 lm93_read_byte(struct i2c_client *client, u8 reg)
+{
+	int value, i;
+
+	/* retry in case of read errors */
+	for (i=1; i<=MAX_RETRIES; i++) {
+		if ((value = i2c_smbus_read_byte_data(client, reg)) >= 0) {
+			return value;
+		} else {
+			dev_warn(&client->dev,"lm93: read byte data failed, "
+				"address 0x%02x.\n", reg);
+			mdelay(i + 3);
+		}
+
+	}
+
+	/* <TODO> what to return in case of error? */
+	dev_err(&client->dev,"lm93: All read byte retries failed!!\n");
+	return 0;
+}
+
+static int lm93_write_byte(struct i2c_client *client, u8 reg, u8 value)
+{
+	int result;
+
+	/* <TODO> how to handle write errors? */
+	result = i2c_smbus_write_byte_data(client, reg, value);
+
+	if (result < 0)
+		dev_warn(&client->dev,"lm93: write byte data failed, "
+			 "0x%02x at address 0x%02x.\n", value, reg);
+
+	return result;
+}
+
+static u16 lm93_read_word(struct i2c_client *client, u8 reg)
+{
+	int value, i;
+
+	/* retry in case of read errors */
+	for (i=1; i<=MAX_RETRIES; i++) {
+		if ((value = i2c_smbus_read_word_data(client, reg)) >= 0) {
+			return value;
+		} else {
+			dev_warn(&client->dev,"lm93: read word data failed, "
+				 "address 0x%02x.\n", reg);
+			mdelay(i + 3);
+		}
+
+	}
+
+	/* <TODO> what to return in case of error? */
+	dev_err(&client->dev,"lm93: All read word retries failed!!\n");
+	return 0;
+}
+
+static int lm93_write_word(struct i2c_client *client, u8 reg, u16 value)
+{
+	int result;
+
+	/* <TODO> how to handle write errors? */
+	result = i2c_smbus_write_word_data(client, reg, value);
+
+	if (result < 0)
+		dev_warn(&client->dev,"lm93: write word data failed, "
+			 "0x%04x at address 0x%02x.\n", value, reg);
+
+	return result;
+}
+
+static u8 lm93_block_buffer[I2C_SMBUS_BLOCK_MAX];
+
+/*
+	read block data into values, retry if not expected length
+	fbn => index to lm93_block_read_cmds table
+		(Fixed Block Number - section 14.5.2 of LM93 datasheet)
+*/
+static void lm93_read_block(struct i2c_client *client, u8 fbn, u8 *values)
+{
+	int i, result=0;
+
+	for (i = 1; i <= MAX_RETRIES; i++) {
+		result = i2c_smbus_read_block_data(client,
+			lm93_block_read_cmds[fbn].cmd, lm93_block_buffer);
+
+		if (result == lm93_block_read_cmds[fbn].len) {
+			break;
+		} else {
+			dev_warn(&client->dev,"lm93: block read data failed, "
+				 "command 0x%02x.\n",
+				 lm93_block_read_cmds[fbn].cmd);
+			mdelay(i + 3);
+		}
+	}
+
+	if (result == lm93_block_read_cmds[fbn].len) {
+		memcpy(values,lm93_block_buffer,lm93_block_read_cmds[fbn].len);
+	} else {
+		/* <TODO> what to do in case of error? */
+	}
+}
+
+static struct lm93_data *lm93_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct lm93_data *data = i2c_get_clientdata(client);
+	const unsigned long interval = HZ + (HZ / 2);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies - data->last_updated, interval) ||
+		time_before(jiffies, data->last_updated) || !data->valid) {
+
+		data->update(data, client);
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+	return data;
+}
+
+/* update routine for data that has no corresponding SMBus block command */
+static void lm93_update_client_common(struct lm93_data *data,
+				      struct i2c_client *client)
+{
+	int i;
+	u8 *ptr;
+
+	/* temp1 - temp4: limits */
+	for (i = 0; i < 4; i++) {
+		data->temp_lim[i].min =
+			lm93_read_byte(client, LM93_REG_TEMP_MIN(i));
+		data->temp_lim[i].max =
+			lm93_read_byte(client, LM93_REG_TEMP_MAX(i));
+	}
+
+	/* config register */
+	data->config = lm93_read_byte(client, LM93_REG_CONFIG);
+
+	/* vid1 - vid2: values */
+	for (i = 0; i < 2; i++)
+		data->vid[i] = lm93_read_byte(client, LM93_REG_VID(i));
+
+	/* prochot1 - prochot2: limits */
+	for (i = 0; i < 2; i++)
+		data->prochot_max[i] = lm93_read_byte(client,
+				LM93_REG_PROCHOT_MAX(i));
+
+	/* vccp1 - vccp2: VID relative limits */
+	for (i = 0; i < 2; i++)
+		data->vccp_limits[i] = lm93_read_byte(client,
+				LM93_REG_VCCP_LIMIT_OFF(i));
+
+	/* GPIO input state */
+	data->gpi = lm93_read_byte(client, LM93_REG_GPI);
+
+	/* #PROCHOT override state */
+	data->prochot_override = lm93_read_byte(client,
+			LM93_REG_PROCHOT_OVERRIDE);
+
+	/* #PROCHOT intervals */
+	data->prochot_interval = lm93_read_byte(client,
+			LM93_REG_PROCHOT_INTERVAL);
+
+	/* Fan Boost Termperature registers */
+	for (i = 0; i < 4; i++)
+		data->boost[i] = lm93_read_byte(client, LM93_REG_BOOST(i));
+
+	/* Fan Boost Temperature Hyst. registers */
+	data->boost_hyst[0] = lm93_read_byte(client, LM93_REG_BOOST_HYST_12);
+	data->boost_hyst[1] = lm93_read_byte(client, LM93_REG_BOOST_HYST_34);
+
+	/* Temperature Zone Min. PWM & Hysteresis registers */
+	data->auto_pwm_min_hyst[0] =
+			lm93_read_byte(client, LM93_REG_PWM_MIN_HYST_12);
+	data->auto_pwm_min_hyst[1] =
+			lm93_read_byte(client, LM93_REG_PWM_MIN_HYST_34);
+
+	/* #PROCHOT & #VRDHOT PWM Ramp Control register */
+	data->pwm_ramp_ctl = lm93_read_byte(client, LM93_REG_PWM_RAMP_CTL);
+
+	/* misc setup registers */
+	data->sfc1 = lm93_read_byte(client, LM93_REG_SFC1);
+	data->sfc2 = lm93_read_byte(client, LM93_REG_SFC2);
+	data->sf_tach_to_pwm = lm93_read_byte(client,
+			LM93_REG_SF_TACH_TO_PWM);
+
+	/* write back alarm values to clear */
+	for (i = 0, ptr = (u8 *)(&data->block1); i < 8; i++)
+		lm93_write_byte(client, LM93_REG_HOST_ERROR_1 + i, *(ptr + i));
+}
+
+/* update routine which uses SMBus block data commands */
+static void lm93_update_client_full(struct lm93_data *data,
+				    struct i2c_client *client)
+{
+	dev_dbg(&client->dev,"lm93: starting device update "
+				"(block data enabled)\n");
+
+	/* in1 - in16: values & limits */
+	lm93_read_block(client, 3, (u8 *)(data->block3));
+	lm93_read_block(client, 7, (u8 *)(data->block7));
+
+	/* temp1 - temp4: values */
+	lm93_read_block(client, 2, (u8 *)(data->block2));
+
+	/* prochot1 - prochot2: values */
+	lm93_read_block(client, 4, (u8 *)(data->block4));
+
+	/* fan1 - fan4: values & limits */
+	lm93_read_block(client, 5, (u8 *)(data->block5));
+	lm93_read_block(client, 8, (u8 *)(data->block8));
+
+	/* pmw control registers */
+	lm93_read_block(client, 9, (u8 *)(data->block9));
+
+	/* alarm values */
+	lm93_read_block(client, 1, (u8 *)(&data->block1));
+
+	/* auto/pwm registers */
+	lm93_read_block(client, 10, (u8 *)(&data->block10));
+
+	lm93_update_client_common(data, client);
+}
+
+/* update routine which uses SMBus byte/word data commands only */
+static void lm93_update_client_min(struct lm93_data *data,
+				   struct i2c_client *client)
+{
+	int i,j;
+	u8 *ptr;
+
+	dev_dbg(&client->dev,"lm93: starting device update "
+				"(block data disabled)\n");
+
+	/* in1 - in16: values & limits */
+	for (i = 0; i < 16; i++) {
+		data->block3[i] =
+			lm93_read_byte(client, LM93_REG_IN(i));
+		data->block7[i].min =
+			lm93_read_byte(client, LM93_REG_IN_MIN(i));
+		data->block7[i].max =
+			lm93_read_byte(client, LM93_REG_IN_MAX(i));
+	}
+
+	/* temp1 - temp4: values */
+	for (i = 0; i < 4; i++) {
+		data->block2[i] =
+			lm93_read_byte(client, LM93_REG_TEMP(i));
+	}
+
+	/* prochot1 - prochot2: values */
+	for (i = 0; i < 2; i++) {
+		data->block4[i].cur =
+			lm93_read_byte(client, LM93_REG_PROCHOT_CUR(i));
+		data->block4[i].avg =
+			lm93_read_byte(client, LM93_REG_PROCHOT_AVG(i));
+	}
+
+	/* fan1 - fan4: values & limits */
+	for (i = 0; i < 4; i++) {
+		data->block5[i] =
+			lm93_read_word(client, LM93_REG_FAN(i));
+		data->block8[i] =
+			lm93_read_word(client, LM93_REG_FAN_MIN(i));
+	}
+
+	/* pwm control registers */
+	for (i = 0; i < 2; i++) {
+		for (j = 0; j < 4; j++) {
+			data->block9[i][j] =
+				lm93_read_byte(client, LM93_REG_PWM_CTL(i,j));
+		}
+	}
+
+	/* alarm values */
+	for (i = 0, ptr = (u8 *)(&data->block1); i < 8; i++) {
+		*(ptr + i) =
+			lm93_read_byte(client, LM93_REG_HOST_ERROR_1 + i);
+	}
+
+	/* auto/pwm (base temp) registers */
+	for (i = 0; i < 4; i++) {
+		data->block10.base[i] =
+			lm93_read_byte(client, LM93_REG_TEMP_BASE(i));
+	}
+
+	/* auto/pwm (offset temp) registers */
+	for (i = 0; i < 12; i++) {
+		data->block10.offset[i] =
+			lm93_read_byte(client, LM93_REG_TEMP_OFFSET(i));
+	}
+
+	lm93_update_client_common(data, client);
+}
+
+static void lm93_init_client(struct i2c_client *client)
+{
+	int i;
+	u8 reg;
+
+	/* configure VID pin input thresholds */
+	reg = lm93_read_byte(client, LM93_REG_GPI_VID_CTL);
+	lm93_write_byte(client, LM93_REG_GPI_VID_CTL,
+			reg | (vid_agtl ? 0x03 : 0x00));
+
+	if (init) {
+		/* enable #ALERT pin */
+		reg = lm93_read_byte(client, LM93_REG_CONFIG);
+		lm93_write_byte(client, LM93_REG_CONFIG, reg | 0x08);
+
+		/* enable ASF mode for BMC status registers */
+		reg = lm93_read_byte(client, LM93_REG_STATUS_CONTROL);
+		lm93_write_byte(client, LM93_REG_STATUS_CONTROL, reg | 0x02);
+
+		/* set sleep state to S0 */
+		lm93_write_byte(client, LM93_REG_SLEEP_CONTROL, 0);
+
+		/* unmask #VRDHOT and dynamic VCCP (if nec) error events */
+		reg = lm93_read_byte(client, LM93_REG_MISC_ERR_MASK);
+		reg &= ~0x03;
+		reg &= ~(vccp_limit_type[0] ? 0x10 : 0);
+		reg &= ~(vccp_limit_type[1] ? 0x20 : 0);
+		lm93_write_byte(client, LM93_REG_MISC_ERR_MASK, reg);
+	}
+
+	/* start monitoring */
+	reg = lm93_read_byte(client, LM93_REG_CONFIG);
+	lm93_write_byte(client, LM93_REG_CONFIG, reg | 0x01);
+
+	/* spin until ready */
+	for (i=0; i<20; i++) {
+		msleep(10);
+		if ((lm93_read_byte(client, LM93_REG_CONFIG) & 0x80) == 0x80)
+			return;
+	}
+
+	dev_warn(&client->dev,"lm93: timed out waiting for sensor "
+		 "chip to signal ready!\n");
+}
+
+static int lm93_detect(struct i2c_adapter *adapter, int address, int kind)
+{
+	struct lm93_data *data;
+	struct i2c_client *client;
+
+	int err = -ENODEV, func;
+	void (*update)(struct lm93_data *, struct i2c_client *);
+
+	/* choose update routine based on bus capabilities */
+	func = i2c_get_functionality(adapter);
+	if ( ((LM93_SMBUS_FUNC_FULL & func) == LM93_SMBUS_FUNC_FULL) &&
+			(!disable_block) ) {
+		dev_dbg(&adapter->dev,"lm93: using SMBus block data "
+			"transactions\n");
+		update = lm93_update_client_full;
+	} else if ((LM93_SMBUS_FUNC_MIN & func) == LM93_SMBUS_FUNC_MIN) {
+		dev_dbg(&adapter->dev,"lm93: disabled SMBus block data "
+			"transactions\n");
+		update = lm93_update_client_min;
+	} else {
+		dev_dbg(&adapter->dev,"lm93: detect failed, "
+			"smbus byte and/or word data not supported!\n");
+		goto err_out;
+	}
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access lm78_{read,write}_value. */
+
+	if ( !(data = kzalloc(sizeof(struct lm93_data), GFP_KERNEL))) {
+		dev_dbg(&adapter->dev,"lm93: out of memory!\n");
+		err = -ENOMEM;
+		goto err_out;
+	}
+
+	client = &data->client;
+	i2c_set_clientdata(client, data);
+	client->addr = address;
+	client->adapter = adapter;
+	client->driver = &lm93_driver;
+
+	/* detection */
+	if (kind < 0) {
+		int mfr = lm93_read_byte(client, LM93_REG_MFR_ID);
+
+		if (mfr != 0x01) {
+			dev_dbg(&adapter->dev,"lm93: detect failed, "
+				"bad manufacturer id 0x%02x!\n", mfr);
+			goto err_free;
+		}
+	}
+
+	if (kind <= 0) {
+		int ver = lm93_read_byte(client, LM93_REG_VER);
+
+		if ((ver == LM93_MFR_ID) || (ver == LM93_MFR_ID_PROTOTYPE)) {
+			kind = lm93;
+		} else {
+			dev_dbg(&adapter->dev,"lm93: detect failed, "
+				"bad version id 0x%02x!\n", ver);
+			if (kind == 0)
+				dev_dbg(&adapter->dev,"lm93: "
+					"(ignored 'force' parameter)\n");
+			goto err_free;
+		}
+	}
+
+	/* fill in remaining client fields */
+	strlcpy(client->name, "lm93", I2C_NAME_SIZE);
+	dev_dbg(&adapter->dev,"lm93: loading %s at %d,0x%02x\n",
+		client->name, i2c_adapter_id(client->adapter),
+		client->addr);
+
+	/* housekeeping */
+	data->valid = 0;
+	data->update = update;
+	mutex_init(&data->update_lock);
+
+	/* tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(client)))
+		goto err_free;
+
+	/* initialize the chip */
+	lm93_init_client(client);
+
+	err = sysfs_create_group(&client->dev.kobj, &lm93_attr_grp);
+	if (err)
+		goto err_detach;
+
+	/* Register hwmon driver class */
+	data->class_dev = hwmon_device_register(&client->dev);
+	if ( !IS_ERR(data->class_dev))
+		return 0;
+
+	err = PTR_ERR(data->class_dev);
+	dev_err(&client->dev, "error registering hwmon device.\n");
+	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
+err_detach:
+	i2c_detach_client(client);
+err_free:
+	kfree(data);
+err_out:
+	return err;
+}
+
+/* This function is called when:
+     * lm93_driver is inserted (when this module is loaded), for each
+       available adapter
+     * when a new adapter is inserted (and lm93_driver is still present) */
+static int lm93_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_probe(adapter, &addr_data, lm93_detect);
+}
+
+static int lm93_detach_client(struct i2c_client *client)
+{
+	struct lm93_data *data = i2c_get_clientdata(client);
+	int err = 0;
+
+	hwmon_device_unregister(data->class_dev);
+	sysfs_remove_group(&client->dev.kobj, &lm93_attr_grp);
+
+	err = i2c_detach_client(client);
+	if (!err)
+		kfree(data);
+	return err;
+}
+
+static int __init lm93_init(void)
+{
+	return i2c_add_driver(&lm93_driver);
+}
+
+static void __exit lm93_exit(void)
+{
+	i2c_del_driver(&lm93_driver);
+}
+
+MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>, "
+		"Hans J. Koch <hjk@linutronix.de");
+MODULE_DESCRIPTION("LM93 driver");
+MODULE_LICENSE("GPL");
+
+module_init(lm93_init);
+module_exit(lm93_exit);
Index: linux-2.6.22-rc/Documentation/hwmon/lm93
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.22-rc/Documentation/hwmon/lm93	2007-04-30 11:43:34.000000000 +0200
@@ -0,0 +1,412 @@
+Kernel driver lm93
+==================
+
+Supported chips:
+  * National Semiconductor LM93
+    Prefix 'lm93'
+    Addresses scanned: I2C 0x2c-0x2e
+    Datasheet: http://www.national.com/ds.cgi/LM/LM93.pdf
+
+Author:
+	Mark M. Hoffman <mhoffman@lightlink.com>
+	Ported to 2.6 by Eric J. Bowersox <ericb@aspsys.com>
+	Adapted to 2.6.20 by Carsten Emde <ce@osadl.org>
+	Modified for mainline integration by Hans J. Koch <hjk@linutronix.de>
+
+Module Parameters
+-----------------
+
+(specific to LM93)
+* init: integer
+  Set to non-zero to force some initializations (default is 0).
+* disable_block: integer
+  A "0" allows SMBus block data transactions if the host supports them.  A "1"
+  disables SMBus block data transactions.  The default is 0.
+* vccp_limit_type: integer array (2)
+  Configures in7 and in8 limit type, where 0 means absolute and non-zero
+  means relative.  "Relative" here refers to "Dynamic Vccp Monitoring using
+  VID" from the datasheet.  It greatly simplifies the interface to allow
+  only one set of limits (absolute or relative) to be in operation at a
+  time (even though the hardware is capable of enabling both).  There's
+  not a compelling use case for enabling both at once, anyway.  The default
+  is "0,0".
+* vid_agtl: integer
+  A "0" configures the VID pins for V(ih) = 2.1V min, V(il) = 0.8V max.
+  A "1" configures the VID pins for V(ih) = 0.8V min, V(il) = 0.4V max.
+  (The latter setting is referred to as AGTL+ Compatible in the datasheet.)
+  I.e. this parameter controls the VID pin input thresholds; if your VID
+  inputs are not working, try changing this.  The default value is "0".
+
+(common among sensor drivers)
+* force: short array (min = 1, max = 48)
+  List of adapter,address pairs to assume to be present.  Autodetection
+  of the target device will still be attempted.  Use one of the more
+  specific force directives below if this doesn't detect the device.
+* force_lm93: short array (min = 1, max = 48)
+  List of adapter,address pairs which are unquestionably assumed to contain
+  a 'lm93' chip
+* ignore: short array (min = 1, max = 48)
+  List of adapter,address pairs not to scan
+* ignore_range: short array (min = 1, max = 48)
+  List of adapter,start-addr,end-addr triples not to scan
+* probe: short array (min = 1, max = 48)
+  List of adapter,address pairs to scan additionally
+* probe_range: short array (min = 1, max = 48)
+  List of adapter,start-addr,end-addr triples to scan additionally
+
+
+Hardware Description
+--------------------
+
+(from the datasheet)
+
+The LM93, hardware monitor, has a two wire digital interface compatible with
+SMBus 2.0. Using an 8-bit ADC, the LM93 measures the temperature of two remote
+diode connected transistors as well as its own die and 16 power supply
+voltages. To set fan speed, the LM93 has two PWM outputs that are each
+controlled by up to four temperature zones. The fancontrol algorithm is lookup
+table based. The LM93 includes a digital filter that can be invoked to smooth
+temperature readings for better control of fan speed. The LM93 has four
+tachometer inputs to measure fan speed. Limit and status registers for all
+measured values are included. The LM93 builds upon the functionality of
+previous motherboard management ASICs and uses some of the LM85 s features
+(i.e. smart tachometer mode). It also adds measurement and control support
+for dynamic Vccp monitoring and PROCHOT. It is designed to monitor a dual
+processor Xeon class motherboard with a minimum of external components.
+
+
+Driver Description
+------------------
+
+This driver implements support for the National Semiconductor LM93.
+
+
+User Interface
+--------------
+
+#PROCHOT:
+
+The LM93 can monitor two #PROCHOT signals.  The results are found in the
+sysfs files prochot1, prochot2, prochot1_avg, prochot2_avg, prochot1_max,
+and prochot2_max.  prochot1_max and prochot2_max contain the user limits
+for #PROCHOT1 and #PROCHOT2, respectively.  prochot1 and prochot2 contain
+the current readings for the most recent complete time interval.  The
+value of prochot1_avg and prochot2_avg is something like a 2 period
+exponential moving average (but not quite - check the datasheet). Note
+that this third value is calculated by the chip itself.  All values range
+from 0-255 where 0 indicates no throttling, and 255 indicates > 99.6%.
+
+The monitoring intervals for the two #PROCHOT signals is also configurable.
+These intervals can be found in the sysfs files prochot1_interval and
+prochot2_interval.  The values in these files specify the intervals for
+#P1_PROCHOT and #P2_PROCHOT, respectively.  Selecting a value not in this
+list will cause the driver to use the next largest interval.  The available
+intervals are:
+
+#PROCHOT intervals: 0.73, 1.46, 2.9, 5.8, 11.7, 23.3, 46.6, 93.2, 186, 372
+
+It is possible to configure the LM93 to logically short the two #PROCHOT
+signals.  I.e. when #P1_PROCHOT is asserted, the LM93 will automatically
+assert #P2_PROCHOT, and vice-versa.  This mode is enabled by writing a
+non-zero integer to the sysfs file prochot_short.
+
+The LM93 can also override the #PROCHOT pins by driving a PWM signal onto
+one or both of them.  When overridden, the signal has a period of 3.56 mS,
+a minimum pulse width of 5 clocks (at 22.5kHz => 6.25% duty cycle), and
+a maximum pulse width of 80 clocks (at 22.5kHz => 99.88% duty cycle).
+
+The sysfs files prochot1_override and prochot2_override contain boolean
+intgers which enable or disable the override function for #P1_PROCHOT and
+#P2_PROCHOT, respectively.  The sysfs file prochot_override_duty_cycle
+contains a value controlling the duty cycle for the PWM signal used when
+the override function is enabled.  This value ranges from 0 to 15, with 0
+indicating minimum duty cycle and 15 indicating maximum.
+
+#VRD_HOT:
+
+The LM93 can monitor two #VRD_HOT signals. The results are found in the
+sysfs files vrdhot1 and vrdhot2. There is one value per file: a boolean for
+which 1 indicates #VRD_HOT is asserted and 0 indicates it is negated. These
+files are read-only.
+
+Smart Tach Mode:
+
+(from the datasheet)
+
+	If a fan is driven using a low-side drive PWM, the tachometer
+	output of the fan is corrupted. The LM93 includes smart tachometer
+	circuitry that allows an accurate tachometer reading to be
+	achieved despite the signal corruption.  In smart tach mode all
+	four signals are measured within 4 seconds.
+
+Smart tach mode is enabled by the driver by writing 1 or 2 (associating the
+the fan tachometer with a pwm) to the sysfs file fan<n>_smart_tach.  A zero
+will disable the function for that fan.  Note that Smart tach mode cannot be
+enabled if the PWM output frequency is 22500 Hz (see below).
+
+Manual PWM:
+
+The LM93 has a fixed or override mode for the two PWM outputs (although, there
+are still some conditions that will override even this mode - see section
+15.10.6 of the datasheet for details.)  The sysfs files pwm1_override
+and pwm2_override are used to enable this mode; each is a boolean integer
+where 0 disables and 1 enables the manual control mode.  The sysfs files pwm1
+and pwm2 are used to set the manual duty cycle; each is an integer (0-255)
+where 0 is 0% duty cycle, and 255 is 100%.  Note that the duty cycle values
+are constrained by the hardware. Selecting a value which is not available
+will cause the driver to use the next largest value.  Also note: when manual
+PWM mode is disabled, the value of pwm1 and pwm2 indicates the current duty
+cycle chosen by the h/w.
+
+PWM Output Frequency:
+
+The LM93 supports several different frequencies for the PWM output channels.
+The sysfs files pwm1_freq and pwm2_freq are used to select the frequency. The
+frequency values are constrained by the hardware.  Selecting a value which is
+not available will cause the driver to use the next largest value.  Also note
+that this parameter has implications for the Smart Tach Mode (see above).
+
+PWM Output Frequencies: 12, 36, 48, 60, 72, 84, 96, 22500 (h/w default)
+
+Automatic PWM:
+
+The LM93 is capable of complex automatic fan control, with many different
+points of configuration.  To start, each PWM output can be bound to any
+combination of eight control sources.  The final PWM is the largest of all
+individual control sources to which the PWM output is bound.
+
+The eight control sources are: temp1-temp4 (aka "zones" in the datasheet),
+#PROCHOT 1 & 2, and #VRDHOT 1 & 2.  The bindings are expressed as a bitmask
+in the sysfs files pwm<n>_auto_channels, where a "1" enables the binding, and
+ a "0" disables it. The h/w default is 0x0f (all temperatures bound).
+
+	0x01 - Temp 1
+	0x02 - Temp 2
+	0x04 - Temp 3
+	0x08 - Temp 4
+	0x10 - #PROCHOT 1
+	0x20 - #PROCHOT 2
+	0x40 - #VRDHOT 1
+	0x80 - #VRDHOT 2
+
+The function y = f(x) takes a source temperature x to a PWM output y.  This
+function of the LM93 is derived from a base temperature and a table of 12
+temperature offsets.  The base temperature is expressed in degrees C in the
+sysfs files temp<n>_auto_base.  The offsets are expressed in cumulative
+degrees C, with the value of offset <i> for temperature value <n> being
+contained in the file temp<n>_auto_offset<i>.  E.g. if the base temperature
+is 40C:
+
+     offset #	temp<n>_auto_offset<i>	range		pwm
+	 1		0		-		 25.00%
+	 2		0		-		 28.57%
+	 3		1		40C - 41C	 32.14%
+	 4		1		41C - 42C	 35.71%
+	 5		2		42C - 44C	 39.29%
+	 6		2		44C - 46C	 42.86%
+	 7		2		48C - 50C	 46.43%
+	 8		2		50C - 52C	 50.00%
+	 9		2		52C - 54C	 53.57%
+	10		2		54C - 56C	 57.14%
+	11		2		56C - 58C	 71.43%
+	12		2		58C - 60C	 85.71%
+					> 60C		100.00%
+
+Valid offsets are in the range 0C <= x <= 7.5C in 0.5C increments.
+
+There is an independent base temperature for each temperature channel. Note,
+however, there are only two tables of offsets: one each for temp[12] and
+temp[34].  Therefore, any change to e.g. temp1_auto_offset<i> will also
+affect temp2_auto_offset<i>.
+
+The LM93 can also apply hysteresis to the offset table, to prevent unwanted
+oscillation between two steps in the offsets table.  These values are found in
+the sysfs files temp<n>_auto_offset_hyst.  The value in this file has the
+same representation as in temp<n>_auto_offset<i>.
+
+If a temperature reading falls below the base value for that channel, the LM93
+will use the minimum PWM value.  These values are found in the sysfs files
+temp<n>_auto_pwm_min.  Note, there are only two minimums: one each for temp[12]
+and temp[34].  Therefore, any change to e.g. temp1_auto_pwm_min will also
+affect temp2_auto_pwm_min.
+
+PWM Spin-Up Cycle:
+
+A spin-up cycle occurs when a PWM output is commanded from 0% duty cycle to
+some value > 0%.  The LM93 supports a minimum duty cycle during spin-up.  These
+values are found in the sysfs files pwm<n>_auto_spinup_min. The value in this
+file has the same representation as other PWM duty cycle values. The
+duration of the spin-up cycle is also configurable.  These values are found in
+the sysfs files pwm<n>_auto_spinup_time. The value in this file is
+the spin-up time in seconds.  The available spin-up times are constrained by
+the hardware.  Selecting a value which is not available will cause the driver
+to use the next largest value.
+
+Spin-up Durations: 0 (disabled, h/w default), 0.1, 0.25, 0.4, 0.7, 1.0,
+		   2.0, 4.0
+
+#PROCHOT and #VRDHOT PWM Ramping:
+
+If the #PROCHOT or #VRDHOT signals are asserted while bound to a PWM output
+channel, the LM93 will ramp the PWM output up to 100% duty cycle in discrete
+steps. The duration of each step is configurable. There are two files, with
+one value each in seconds: pwm_auto_prochot_ramp and pwm_auto_vrdhot_ramp.
+The available ramp times are constrained by the hardware.  Selecting a value
+which is not available will cause the driver to use the next largest value.
+
+Ramp Times: 0 (disabled, h/w default) to 0.75 in 0.05 second intervals
+
+Fan Boost:
+
+For each temperature channel, there is a boost temperature: if the channel
+exceeds this limit, the LM93 will immediately drive both PWM outputs to 100%.
+This limit is expressed in degrees C in the sysfs files temp<n>_auto_boost.
+There is also a hysteresis temperature for this function: after the boost
+limit is reached, the temperature channel must drop below this value before
+the boost function is disabled.  This temperature is also expressed in degrees
+C in the sysfs files temp<n>_auto_boost_hyst.
+
+GPIO Pins:
+
+The LM93 can monitor the logic level of four dedicated GPIO pins as well as the
+four tach input pins.  GPIO0-GPIO3 correspond to (fan) tach 1-4, respectively.
+All eight GPIOs are read by reading the bitmask in the sysfs file gpio.  The
+LSB is GPIO0, and the MSB is GPIO7.
+
+
+LM93 Unique sysfs Files
+-----------------------
+
+	file			description
+	-------------------------------------------------------------
+
+	prochot<n>		current #PROCHOT %
+
+	prochot<n>_avg		moving average #PROCHOT %
+
+	prochot<n>_max		limit #PROCHOT %
+
+	prochot_short		enable or disable logical #PROCHOT pin short
+
+	prochot<n>_override	force #PROCHOT assertion as PWM
+
+	prochot_override_duty_cycle
+				duty cycle for the PWM signal used when
+				#PROCHOT is overridden
+
+	prochot<n>_interval	#PROCHOT PWM sampling interval
+
+	vrdhot<n>		0 means negated, 1 means asserted
+
+	fan<n>_smart_tach	enable or disable smart tach mode
+
+	pwm<n>_auto_channels	select control sources for PWM outputs
+
+	pwm<n>_auto_spinup_min	minimum duty cycle during spin-up
+
+	pwm<n>_auto_spinup_time	duration of spin-up
+
+	pwm_auto_prochot_ramp	ramp time per step when #PROCHOT asserted
+
+	pwm_auto_vrdhot_ramp	ramp time per step when #VRDHOT asserted
+
+	temp<n>_auto_base	temperature channel base
+
+	temp<n>_auto_offset[1-12]
+				temperature channel offsets
+
+	temp<n>_auto_offset_hyst
+				temperature channel offset hysteresis
+
+	temp<n>_auto_boost	temperature channel boost (PWMs to 100%) limit
+
+	temp<n>_auto_boost_hyst	temperature channel boost hysteresis
+
+	gpio			input state of 8 GPIO pins; read-only
+
+
+Sample Configuration File
+-------------------------
+
+Here is a sample LM93 chip config for sensors.conf:
+
+---------- cut here ----------
+chip "lm93-*"
+
+# VOLTAGE INPUTS
+
+	# labels and scaling based on datasheet recommendations
+	label in1	"+12V1"
+	compute in1	@ * 12.945, @ / 12.945
+	set in1_min	12 * 0.90
+	set in1_max	12 * 1.10
+
+	label in2	"+12V2"
+	compute in2	@ * 12.945, @ / 12.945
+	set in2_min	12 * 0.90
+	set in2_max	12 * 1.10
+
+	label in3	"+12V3"
+	compute in3	@ * 12.945, @ / 12.945
+	set in3_min	12 * 0.90
+	set in3_max	12 * 1.10
+
+	label in4	"FSB_Vtt"
+
+	label in5	"3GIO"
+
+	label in6	"ICH_Core"
+
+	label in7	"Vccp1"
+
+	label in8	"Vccp2"
+
+	label in9	"+3.3V"
+	set in9_min	3.3 * 0.90
+	set in9_max	3.3 * 1.10
+
+	label in10	"+5V"
+	set in10_min	5.0 * 0.90
+	set in10_max	5.0 * 1.10
+
+	label in11	"SCSI_Core"
+
+	label in12	"Mem_Core"
+
+	label in13	"Mem_Vtt"
+
+	label in14	"Gbit_Core"
+
+	# Assuming R1/R2 = 4.1143, and 3.3V reference
+	# -12V = (4.1143 + 1) * (@ - 3.3) + 3.3
+	label in15	"-12V"
+	compute in15 @ * 5.1143 - 13.57719, (@ + 13.57719) / 5.1143
+	set in15_min	-12 * 0.90
+	set in15_max	-12 * 1.10
+
+	label in16	"+3.3VSB"
+	set in16_min	3.3 * 0.90
+	set in16_max	3.3 * 1.10
+
+# TEMPERATURE INPUTS
+
+	label temp1	"CPU1"
+	label temp2	"CPU2"
+	label temp3	"LM93"
+
+# TACHOMETER INPUTS
+
+	label fan1	"Fan1"
+	set fan1_min	3000
+	label fan2	"Fan2"
+	set fan2_min	3000
+	label fan3	"Fan3"
+	set fan3_min	3000
+	label fan4	"Fan4"
+	set fan4_min	3000
+
+# PWM OUTPUTS
+
+	label pwm1	"CPU1"
+	label pwm2	"CPU2"
+

--Boundary-00=_Qf6NGIJVoEt4R0m
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_Qf6NGIJVoEt4R0m--
