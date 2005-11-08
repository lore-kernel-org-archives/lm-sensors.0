From: roger@planbit.co.uk (Roger Lucas)
Date: Tue, 08 Nov 2005 16:54:17 +0000
Subject: [lm-sensors] RE: vt8231.c and VRM-VID
Message-Id: <20051108155337.7896512E9E@bluewhale.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Sorry to keep sending more patches...  When I tried Rudolf's patch for the
VRM, I couldn't get the VID to work properly.  On investigation, it turned
out that this register ALSO does not exist on the VT8231.  Whoever ported
the original code to the VT8231 didn't check that all the registers ACTUALLY
EXISTED on the VT8231 device!!!  No comment.

Anyhow, I have now checked that all the registers left do actually exist and
that the driver isn't reading garbage from the device.  This has resulted in
the removal of the PWM controls (as in my mail below) and now also the VID
detection as this isn't supported in the chip either.

I also tidied up my code changes for creating the temp/voltage files.  Don't
know what planet I was on with the original code - it was horrible.

Anyhow, revision 4 is attached.  Hopefully this is the last one.

Rudolf's VRM patch works perfectly BTW, and has ended up in this revision 4
code release as it is part of the updated kernel HWMON source I am now
working from.  I hope that this isn't a problem - I can always remove that
section of the patch and send a revised version if it is.

Thanks for all your work in reviewing my code.

- Roger

-----Original Message-----
From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of Roger Lucas
Sent: 07 November 2005 19:57
To: 'Jean Delvare'
Cc: 'LM Sensors'
Subject: RE: [lm-sensors] RE: vt8231.c

Hi Jean,

Attached is revision 3 of the VT8231 driver.  There are a LOT of changes to
implement your suggestions.  Some of these break compatibility with older
vt8231 driver releases as follows:

tempX sequence
Temperatures are now measured temp0,temp1,temp2,etc.  This causes the
"sensors" user-space program to fail with errors as it expects the older
temperature numbering sequence.

tempX scaling 
Given that we have no idea what the temperature curves for a device are, the
driver now returns the 10-bit value directly from the register.  Older
versions of the driver multiplied the register value by 2.5 (reason unknown
as it DEFINITELY didn't scale it to degrees Centigrade, Fahrenheit or
Kelvin).  Older temperature scaling calculations are now completely wrong.

inX scaling
The driver now scales the measurement to mV.  Inputs such as the 3.3v
internal reference are now completely correct.  Inputs such as IN0-IN5 which
report an external pin now return the value at the pin.  SENSORS.CONF still
has to scale these to compensate for external divider chains (if, for
example, the 12v rail is being measured).

tempX/inX presence
The driver only generates measurements for inputs that are genuinely
measured (according to the CONFIG register).  This causes the "sensors"
program to fail as it expects to see all the tempX and inX sources
available, even if you add "ignore xxx" to the sensors.conf file.  IMHO this
is a bug in the "sensors" program, as "ignore xxx" should cause it to fully
ignore that parameter, not still generate warnings if the parameter doesn't
exist.

PWM controls
The VT8231 doesn't have any PWM controls.  All the code that was in the
driver was erroneous and has been removed (I suspect it was legacy from some
other driver used as the base for an earlier port).

If the newer vt8231 driver is accepted into the kernel tree, would you like
me to go through v2.9.2 of lm_sensors and try to see what can be done to
resolve the compatibilities issues with this newer vt8231 driver?


As far as the web site for the sensors.conf file is concerned, I have no
time to do this in the near-term.  If I get some spare time in the future,
and no-one has done it by then, I will look into it further.

Best regards,

Roger

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: 07 November 2005 09:24
To: roger@planbit.co.uk
Cc: Knut Petersen; LM Sensors
Subject: RE: [lm-sensors] RE: vt8231.c


Hi Roger,

On 2005-11-06, Roger Lucas wrote:
> One question I have is regarding the "1 mV" calibration, and this returns
> me to a general comment/question with the LM-Sensors system:
>
> The LM-Sensors system appears to be based on what the sensors chips are
> on the motherboard, rather than what the motherboard is.  From the "probe
> and find out what I have" concept, this is reasonable, but it does cause
> a LOT of problems for users who are less educated.  Many of the sensors
> devices are wired up in different ways on different motherboards, with
> (for example) a voltage input being used for a 12v rail monitor on one
> motherboard and a 5v rail monitor on another. The motherboard
> manufacturer is completely at liberty to wire a device in any way
> they choose.

Completely true.

> This therefore makes a sensors.conf file really a motherboard-specific
> rather than a device specific file.  If you use the configuration file
> according to the device that you have, rather than the motherboard that
> you have, then you run a very high risk of reporting nonsense to a user,
> or (arguably worse) reporting information that looks correct but is
> actually wrong.

True again.

Keep in mind that the folks originally running the project were
passionates with good electronics knowledge. Back then, most users also
had the same profile. This explains a number of technical choices which
turned out not to be suitable for average users. In a way, the project
is the victim of its own success. It is also victim of the increase of
the number of hardware monitoring chips and the exponential growth of
the number of motherboard, each with its own specifics.

We're trying to fix these issues as time permits (e.g. the drivers do no
more set arbitrary limits, and they tend not to reset chips anymore) but
there's still a lot left to do.

> Following this through, when you request that the driver report the
> voltage detected in mV, I am _hoping_ that you are asking for the
> voltage at the pin of the device, rather than the voltage that the
> device happens to be ultimately connected to on this particular
> motherboard?  Reporting the voltage at the device pin is the only
> consistent behaviour that I can see for a motherboard-independent device
> driver.

Yes, of course. Drivers are written for chips. All the rest belongs to
userspace (libsensors or whatever).

> If the above makes sense, then would there be any interest in building
> some kind of database of known good sensors.conf files for specific
> motherboards?

There have been 472 people complaining of the lack of such a database
already. A dozen of these said they would build one. Two of these
actually did. One is already dead, one is available at
http://lm-sensors-db.berlios.de/ but doesn't actually work.

We rejected the idea that we would include the configuration files one by
one in the lm_sensors project as people send them, because it would be
too much work. An external, web-based system where people could post and
retrieve their configuration files would be prefered. But we are still
in need of one which would work.

It might be discussed what to do with the sensors.conf.eg file. It
started as a small file when there were only a couple supported chips,
and motherboard manufacturers were following the chip maker's
recommendations on wiring. Now the file is quite large, and has lots of
conditionals (expressed as comments) to try and help users to get a
working configuration file. according to their hardware. I agree that it
isn't suitable for the average user.

Maybe we should stop installing this file to /etc/sensors.conf
automatically. As you say, It's probably better not to have a
configuration file than to have a bad one. However, this still a good
base for people to start tinkering, so we probably can't get rid of it
unless we actually have a database with configuration files for the most
popular boards.

> I would suggest that the output of "LSHW" or a similar utility is used
> to obtain unique identifying details for the motherboard, and then this
> used to determine the appropriate motherboard conf file.  A simple web
> page with known motherboards on it and their associated .conf would be a
> very good start.  New motherboards could then be added by people with
> their matching .conf file.

We would probably use the DMI fields for board identification (using
dmidecode, which is more standard than lshw I think). However, the
difficult part is to gather the data. What you call "a simple web
page" won't work. We want something the average user can freely
contribute to, with a minimum maintenance workload from us. Briefly:

* Any user can add a configuration file. He/she must pick from a list of
motherboard makers, or add one if his/her aint in the list. Then he/she
types the name of his/her motherboard and uploads his file. Ideally we
would do a brief content check to make sure nobody uploads crap.

* Any user can update (overwrite) a configuration file. We probably need
to backup older files just in case though.

* We need an administration interface to fix about anything (manufacturer
or board name, broken configuration statements) and even delete files if
needed.

* Users should have the possibility to alert us if they think something
is wrong.

* Not sure how to deal with duplicates. We probably want one single
configuration file per board, but it might be hard to enforce.

Note that there still is a problem with the fact that not all users of
the same board will use the same fans, so fan limits (and, to some
extent, temperature limits) depend on the user. The configuration files
are still templates. If we want to ultimately install them
automatically, we will probably need to enforce the fact that
configuration files should not set limits for fans and temperatures, nor
ignore statements for fans. These configuration files should essentially
contain label and compute statements.

This ain't simple, else this would have been done already. But if you
want to work on this (preferably *after* we are done with the vt8231
port ;)) you're very welcome.

--
Jean Delvare
-------------- next part --------------
diff -Naur reference/drivers/hwmon/Kconfig linux-2.6.14/drivers/hwmon/Kconfig
--- reference/drivers/hwmon/Kconfig	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/drivers/hwmon/Kconfig	2005-11-07 12:44:21.000000000 +0000
@@ -350,6 +350,18 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called via686a.
 
+config SENSORS_VT8231
+	tristate "VT8231"
+	depends on HWMON && I2C && PCI && EXPERIMENTAL
+	select HWMON_VID
+	select I2C_ISA
+	help
+	  If you say yes here then you get support for the integrated sensors
+	  in the VIA VT8231 device.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called vt8231.
+
 config SENSORS_W83781D
 	tristate "Winbond W83781D, W83782D, W83783S, W83627HF, Asus AS99127F"
 	depends on HWMON && I2C
diff -Naur reference/drivers/hwmon/Makefile linux-2.6.14/drivers/hwmon/Makefile
--- reference/drivers/hwmon/Makefile	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/drivers/hwmon/Makefile	2005-11-01 10:59:10.000000000 +0000
@@ -40,6 +40,7 @@
 obj-$(CONFIG_SENSORS_SMSC47B397)+= smsc47b397.o
 obj-$(CONFIG_SENSORS_SMSC47M1)	+= smsc47m1.o
 obj-$(CONFIG_SENSORS_VIA686A)	+= via686a.o
+obj-$(CONFIG_SENSORS_VT8231)	+= vt8231.o
 obj-$(CONFIG_SENSORS_W83627EHF)	+= w83627ehf.o
 obj-$(CONFIG_SENSORS_W83L785TS)	+= w83l785ts.o
 
diff -Naur reference/drivers/hwmon/hwmon-vid.c linux-2.6.14/drivers/hwmon/hwmon-vid.c
--- reference/drivers/hwmon/hwmon-vid.c	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/drivers/hwmon/hwmon-vid.c	2005-11-08 15:10:42.000000000 +0000
@@ -49,6 +49,11 @@
         . . . .
        11110  =  0.800 V
        11111  =  0.000 V (off)
+
+    The 1718 specification is in fact Intel Mobile Voltage Positioning -
+    (IMVP-II). You can find more information in the datasheet of Max1718
+    http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2452
+
 */
 
 /* vrm is the VRM/VRD document version multiplied by 10.
@@ -60,9 +65,6 @@
 
 	switch(vrm) {
 
-	case  0:
-		return 0;
-
 	case 100:               /* VRD 10.0 */
 		if((val & 0x1f) = 0x1f)
 			return 0;
@@ -91,10 +93,16 @@
 	case 84:		/* VRM 8.4 */
 		val &= 0x0f;
 				/* fall through */
-	default:		/* VRM 8.2 */
+	case 82:		/* VRM 8.2 */
 		return(val = 0x1f ? 0 :
 		       val & 0x10  ? 5100 - (val) * 100 :
 		                     2050 - (val) * 50);
+	case 1718:		/* Intel IMVP-II */
+		return(val & 0x10 ? 975 - (val & 0xF) * 25 :
+				    1750 - val * 50);
+	default:		/* report 0 for unknown */
+		printk(KERN_INFO "hwmon-vid: requested unknown VRM version\n");
+		return 0;
 	}
 }
 
@@ -108,6 +116,7 @@
 	u8 vendor;
 	u8 eff_family;
 	u8 eff_model;
+	u8 eff_stepping;
 	int vrm_type;
 };
 
@@ -115,23 +124,28 @@
 
 #ifdef CONFIG_X86
 
+/* the stepping parameter is highest acceptable stepping for current line */
+
 static struct vrm_model vrm_models[] = {
-	{X86_VENDOR_AMD, 0x6, ANY, 90},		/* Athlon Duron etc */
-	{X86_VENDOR_AMD, 0xF, ANY, 24},		/* Athlon 64, Opteron */
-	{X86_VENDOR_INTEL, 0x6, 0x9, 85},	/* 0.13um too */
-	{X86_VENDOR_INTEL, 0x6, 0xB, 85},	/* Tualatin */
-	{X86_VENDOR_INTEL, 0x6, ANY, 82},	/* any P6 */
-	{X86_VENDOR_INTEL, 0x7, ANY, 0},	/* Itanium */
-	{X86_VENDOR_INTEL, 0xF, 0x0, 90},	/* P4 */
-	{X86_VENDOR_INTEL, 0xF, 0x1, 90},	/* P4 Willamette */
-	{X86_VENDOR_INTEL, 0xF, 0x2, 90},	/* P4 Northwood */
-	{X86_VENDOR_INTEL, 0xF, 0x3, 100},	/* P4 Prescott */
-	{X86_VENDOR_INTEL, 0xF, 0x4, 100},	/* P4 Prescott */
-	{X86_VENDOR_INTEL, 0x10,ANY, 0},	/* Itanium 2 */
-	{X86_VENDOR_UNKNOWN, ANY, ANY, 0}	/* stop here */
+	{X86_VENDOR_AMD, 0x6, ANY, ANY, 90},		/* Athlon Duron etc */
+	{X86_VENDOR_AMD, 0xF, ANY, ANY, 24},		/* Athlon 64, Opteron and above VRM 24 */
+	{X86_VENDOR_INTEL, 0x6, 0x9, ANY, 85},		/* 0.13um too */
+	{X86_VENDOR_INTEL, 0x6, 0xB, ANY, 85},		/* Tualatin */
+	{X86_VENDOR_INTEL, 0x6, ANY, ANY, 82},		/* any P6 */
+	{X86_VENDOR_INTEL, 0x7, ANY, ANY, 0},		/* Itanium */
+	{X86_VENDOR_INTEL, 0xF, 0x0, ANY, 90},		/* P4 */
+	{X86_VENDOR_INTEL, 0xF, 0x1, ANY, 90},		/* P4 Willamette */
+	{X86_VENDOR_INTEL, 0xF, 0x2, ANY, 90},		/* P4 Northwood */
+	{X86_VENDOR_INTEL, 0xF, ANY, ANY, 100},		/* Prescott and above assume VRD 10 */
+	{X86_VENDOR_INTEL, 0x10, ANY, ANY, 0},		/* Itanium 2 */
+	{X86_VENDOR_CENTAUR, 0x6, 0x7, ANY, 85},	/* Eden ESP/Ezra */
+	{X86_VENDOR_CENTAUR, 0x6, 0x8, 0x7, 85},	/* Ezra T */
+	{X86_VENDOR_CENTAUR, 0x6, 0x9, 0x7, 85},	/* Nemiah */
+	{X86_VENDOR_CENTAUR, 0x6, 0x9, ANY, 1718},	/* C3-M */
+	{X86_VENDOR_UNKNOWN, ANY, ANY, ANY, 0}		/* stop here */
 };
 
-static int find_vrm(u8 eff_family, u8 eff_model, u8 vendor)
+static int find_vrm(u8 eff_family, u8 eff_model, u8 eff_stepping, u8 vendor)
 {
 	int i = 0;
 
@@ -139,7 +153,8 @@
 		if (vrm_models[i].vendor=vendor)
 			if ((vrm_models[i].eff_family=eff_family)
 			 && ((vrm_models[i].eff_model=eff_model) ||
-			     (vrm_models[i].eff_model=ANY)))
+			     (vrm_models[i].eff_model=ANY)) &&
+			     (eff_stepping <= vrm_models[i].eff_stepping))
 				return vrm_models[i].vrm_type;
 		i++;
 	}
@@ -151,7 +166,7 @@
 {
 	struct cpuinfo_x86 *c = cpu_data;
 	u32 eax;
-	u8 eff_family, eff_model;
+	u8 eff_family, eff_model, eff_stepping;
 	int vrm_ret;
 
 	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
@@ -160,18 +175,19 @@
 	eax = cpuid_eax(1);
 	eff_family = ((eax & 0x00000F00)>>8);
 	eff_model  = ((eax & 0x000000F0)>>4);
+	eff_stepping = eax & 0xF;
 	if (eff_family = 0xF) {	/* use extended model & family */
 		eff_family += ((eax & 0x00F00000)>>20);
 		eff_model += ((eax & 0x000F0000)>>16)<<4;
 	}
-	vrm_ret = find_vrm(eff_family,eff_model,c->x86_vendor);
+	vrm_ret = find_vrm(eff_family, eff_model, eff_stepping, c->x86_vendor);
 	if (vrm_ret = 0)
 		printk(KERN_INFO "hwmon-vid: Unknown VRM version of your "
 		       "x86 CPU\n");
 	return vrm_ret;
 }
 
-/* and now something completely different for the non-x86 world */
+/* and now for something completely different for the non-x86 world */
 #else
 int vid_which_vrm(void)
 {
diff -Naur reference/drivers/hwmon/vt8231.c linux-2.6.14/drivers/hwmon/vt8231.c
--- reference/drivers/hwmon/vt8231.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.14/drivers/hwmon/vt8231.c	2005-11-08 15:44:33.000000000 +0000
@@ -0,0 +1,808 @@
+/*
+	vt8231.c - Part of lm_sensors, Linux kernel modules
+				for hardware monitoring
+
+	Copyright (c) 2002 Mark D. Studebaker <mdsxyz123@yahoo.com>
+			   Aaron M. Marsh <amarsh@sdf.lonestar.org>
+
+	This program is free software; you can redistribute it and/or modify
+	it under the terms of the GNU General Public License as published by
+	the Free Software Foundation; either version 2 of the License, or
+	(at your option) any later version.
+
+	This program is distributed in the hope that it will be useful,
+	but WITHOUT ANY WARRANTY; without even the implied warranty of
+	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+	GNU General Public License for more details.
+
+	You should have received a copy of the GNU General Public License
+	along with this program; if not, write to the Free Software
+	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+/* Supports VIA VT8231 South Bridge embedded sensors
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+#include <linux/jiffies.h>
+#include <linux/i2c.h>
+#include <linux/i2c-isa.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/hwmon-vid.h>
+#include <linux/err.h>
+#include <asm/io.h>
+
+static int force_addr;
+module_param(force_addr, int, 0);
+MODULE_PARM_DESC(force_addr, "Initialize the base address of the sensors");
+
+/* Device address
+   Note that we can't determine the ISA address until we have initialized
+   our module */
+static unsigned short isa_address;
+
+#define VT8231_EXTENT 0x80
+#define VT8231_BASE_REG 0x70
+#define VT8231_ENABLE_REG 0x74
+
+/* The VT8231 registers
+
+   The default value for the input channel configuration is used (Reg 0x4A=0x07)
+   which sets the selected inputs marked with '*' below if multiple options are
+   possible:
+
+	Sensor		Voltage Mode	Temp Mode
+	--------	------------	---------
+	CPU Diode	N/A		temp0
+	UIC1		in0		temp1 *
+	UIC2		in1 *		temp2
+	UIC3		in2 *		temp3
+	UIC4		in3 *		temp4
+	UIC5		in4 *		temp5
+	3.3V		in5		N/A
+*/
+
+/* ins numbered 0-5 */
+/* fans numbered 1-2 */
+#define VT8231_REG_FAN_MIN(nr) (0x3a + (nr))
+#define VT8231_REG_FAN(nr)	 (0x28 + (nr))
+
+static const u8 regtemp[]    = { 0x1f, 0x21, 0x22, 0x23, 0x24, 0x25 };
+static const u8 regtempmax[] = { 0x39, 0x3d, 0x2b, 0x2d, 0x2f, 0x31 };
+static const u8 regtempmin[] = { 0x3a, 0x3e, 0x2c, 0x2e, 0x30, 0x32 };
+
+static const u8 regvolt[]    = { 0x21, 0x22, 0x23, 0x24, 0x25, 0x26 };
+static const u8 regvoltmax[] = { 0x3d, 0x2b, 0x2d, 0x2f, 0x31, 0x33 };
+static const u8 regvoltmin[] = { 0x3e, 0x2c, 0x2e, 0x30, 0x32, 0x34 };
+
+/* temps numbered 0-5 */
+#define VT8231_REG_TEMP_LOW01	0x49
+#define VT8231_REG_TEMP_LOW25	0x4d
+
+#define VT8231_REG_CONFIG 0x40
+#define VT8231_REG_ALARM1 0x41
+#define VT8231_REG_ALARM2 0x42
+#define VT8231_REG_FANDIV 0x47
+#define VT8231_REG_UCH_CONFIG 0x4a
+#define VT8231_REG_TEMP1_CONFIG 0x4b
+#define VT8231_REG_TEMP2_CONFIG 0x4c
+
+/* temps 0-5 */
+#define ISTEMP(i, ch_config) ((i) < 0 ? 0 : \
+			      (i) = 0 ? 1 : \
+			      (i) > 5 ? 0 : \
+			      ((ch_config) >> ((i)+1)) & 0x01)
+/* voltages 0-6 */
+#define ISVOLT(i, ch_config) ((i) < 0 ? 0 : \
+			      (i) > 5 ? 0 : \
+			      (i) = 5 ? 1 : \
+			      !(((ch_config) >> ((i)+2)) & 0x01))
+
+#define DIV_FROM_REG(val) (1 << (val))
+
+
+/* NB  The values returned here are NOT temperatures.  The calibration curves
+**     for the thermistor curves are board-specific and must go in the
+**     sensors.conf file.  Temperature sensors 0 and 1 are ten bits, whilst
+**     temperature sensors 2-5 are eight bits, so we scale all the values to be
+**     equivalent to ten bits for consistency.
+**     TEMP_TO_REG() sets the hardware comparisons and these are all use the 8 
+**     MSBs so we apply scaling in the macro to compensate.
+*/
+#define TEMP_TO_REG(val) (SENSORS_LIMIT((val)>>2, 0, 255))
+
+#define IN_TO_REG(val)   (SENSORS_LIMIT((val), 0, 255))
+
+/********* FAN RPM CONVERSIONS ********/
+/* But this chip saturates back at 0, not at 255 like all the other chips.
+   So, 0 means 0 RPM */
+static inline u8 FAN_TO_REG(long rpm, int div)
+{
+	if (rpm = 0)
+		return 0;
+	return SENSORS_LIMIT((1310720 + rpm * div / 2) / (rpm * div), 1, 255);
+}
+
+#define FAN_FROM_REG(val, div) ((val)=0?0:1310720/((val)*(div)))
+
+struct vt8231_data {
+	struct i2c_client client;
+	struct semaphore update_lock;
+	struct class_device *class_dev;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u8 in[6];		/* Register value */
+	u8 in_max[6];		/* Register value */
+	u8 in_min[6];		/* Register value */
+	u16 temp[6];		/* Register value 10 bit */
+	u8 temp_max[6];		/* Register value */
+	u8 temp_min[6];		/* Register value */
+	u8 fan[2];		/* Register value */
+	u8 fan_min[2];		/* Register value */
+	u8 fan_div[2];		/* Register encoding, shifted right */
+	u16 alarms;		/* Register encoding */
+	u8 vrm;
+	u8 uch_config;
+};
+
+static struct pci_dev *s_bridge;
+static int vt8231_detect(struct i2c_adapter *adapter);
+static int vt8231_detach_client(struct i2c_client *client);
+
+static inline int vt8231_read_value(struct i2c_client *client, u8 reg)
+{
+	return inb_p(client->addr + reg);
+}
+
+static inline void vt8231_write_value(struct i2c_client *client, u8 reg,
+					u8 value)
+{
+	outb_p(value, client->addr + reg);
+}
+
+static struct vt8231_data *vt8231_update_device(struct device *dev);
+static void vt8231_init_client(struct i2c_client *client);
+
+/* following are the sysfs callback functions */
+static ssize_t show_in(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct vt8231_data *data = vt8231_update_device(dev);
+
+	switch(nr)
+	{
+		case 5: // in5 is scaled to 3.3v internally
+			// No floating point so 1/(0.0958*0.6296 ~= 1657/100 
+			return sprintf(buf, "%d\n", 
+				(int)(((data->in[nr] - 3) * 1657) / 100));
+
+		default:
+			// No floating point so 1/(0.0958 ~= 1044/100 
+			return sprintf(buf, "%d\n", 
+				(int)(((data->in[nr] - 3) * 1044) / 100));
+	};
+}
+
+static ssize_t show_in_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct vt8231_data *data = vt8231_update_device(dev);
+	switch(nr)
+	{
+		case 5: // in5 is scaled to 3.3v internally
+			return sprintf(buf, "%d\n",
+				(int)(((data->in_min[nr] - 3) * 1657) / 100));
+
+		default:
+			return sprintf(buf, "%d\n", 
+				(int)(((data->in_min[nr] - 3) * 1044) / 100));
+	};
+}
+
+static ssize_t show_in_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct vt8231_data *data = vt8231_update_device(dev);
+	switch(nr)
+	{
+		case 5: // in5 is scaled to 3.3v internally
+			return sprintf(buf, "%d\n",
+				(int)(((data->in_max[nr] - 3) * 1657) / 100));
+
+		default:
+			return sprintf(buf, "%d\n", 
+				(int)(((data->in_max[nr] - 3) * 1044) / 100));
+	};
+}
+
+static ssize_t set_in_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+
+	down(&data->update_lock);
+	switch(nr)
+	{
+		case 5: // in5 is scaled to 3.3v internally
+			data->in_min[nr] = IN_TO_REG(((val * 100) / 1657) + 3);
+			break;
+		default:
+			data->in_min[nr] = IN_TO_REG(((val * 100) / 1044) + 3);
+			break;
+	};
+	vt8231_write_value(client, regvoltmin[nr], data->in_min[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_in_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	down(&data->update_lock);
+	switch(nr)
+	{
+		case 5: // in5 is scaled to 3.3v internally
+			data->in_max[nr] = IN_TO_REG(((val * 100) / 1657) + 3);
+			break;
+		default:
+			data->in_max[nr] = IN_TO_REG(((val * 100) / 1044) + 3);
+			break;
+	};
+	vt8231_write_value(client, regvoltmax[nr], data->in_max[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+#define show_in_offset(offset)					\
+static SENSOR_DEVICE_ATTR(in##offset##_input, S_IRUGO,		\
+		show_in, NULL, offset);
+
+#define limit_in_offset(offset)					\
+static SENSOR_DEVICE_ATTR(in##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_in_min, set_in_min, offset);		\
+static SENSOR_DEVICE_ATTR(in##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_in_max, set_in_max, offset);
+
+show_in_offset(0);
+limit_in_offset(0);
+show_in_offset(1);
+limit_in_offset(1);
+show_in_offset(2);
+limit_in_offset(2);
+show_in_offset(3);
+limit_in_offset(3);
+show_in_offset(4);
+limit_in_offset(4);
+show_in_offset(5);
+limit_in_offset(5);
+
+/* 3 temperatures */
+static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n",  data->temp[nr]);
+}
+static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", data->temp_max[nr]);
+}
+static ssize_t show_temp_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", data->temp_min[nr]);
+}
+static ssize_t set_temp_max(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	down(&data->update_lock);
+	data->temp_max[nr] = TEMP_TO_REG(val);
+	vt8231_write_value(client, regtempmax[nr], data->temp_max[nr]);
+	up(&data->update_lock);
+	return count;
+}
+static ssize_t set_temp_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	down(&data->update_lock);
+	data->temp_min[nr] = TEMP_TO_REG(val);
+	vt8231_write_value(client, regtempmin[nr],
+			data->temp_min[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+#define show_temp_offset(offset)					\
+static SENSOR_DEVICE_ATTR(temp##offset##_input, S_IRUGO,		\
+		show_temp, NULL, offset);				\
+static SENSOR_DEVICE_ATTR(temp##offset##_max, S_IRUGO | S_IWUSR,	\
+		show_temp_max, set_temp_max, offset);			\
+static SENSOR_DEVICE_ATTR(temp##offset##_min, S_IRUGO | S_IWUSR,	\
+		show_temp_min, set_temp_min, offset);
+
+show_temp_offset(0);
+show_temp_offset(1);
+show_temp_offset(2);
+show_temp_offset(3);
+show_temp_offset(4);
+show_temp_offset(5);
+
+#define CFG_INFO_TEMP(id)	{ id, \
+				&sensor_dev_attr_temp##id##_input.dev_attr, \
+				&sensor_dev_attr_temp##id##_min.dev_attr, \
+				&sensor_dev_attr_temp##id##_max.dev_attr }
+#define CFG_INFO_VOLT(id)	{ id, \
+				&sensor_dev_attr_in##id##_input.dev_attr, \
+				&sensor_dev_attr_in##id##_min.dev_attr, \
+				&sensor_dev_attr_in##id##_max.dev_attr, \
+				}
+struct strDeviceAttrTable {
+	int	id;
+	struct device_attribute *input;
+	struct device_attribute *min;
+	struct device_attribute *max;
+};
+
+struct strDeviceAttrTable cfgInfoTemp[] = {
+	CFG_INFO_TEMP(0),
+	CFG_INFO_TEMP(1),
+	CFG_INFO_TEMP(2),
+	CFG_INFO_TEMP(3),
+	CFG_INFO_TEMP(4),
+	CFG_INFO_TEMP(5),
+	{ .id = -1 }
+};
+
+struct strDeviceAttrTable cfgInfoVolt[] = {
+	CFG_INFO_VOLT(0),
+	CFG_INFO_VOLT(1),
+	CFG_INFO_VOLT(2),
+	CFG_INFO_VOLT(3),
+	CFG_INFO_VOLT(4),
+	CFG_INFO_VOLT(5),
+	{ .id = -1 }
+};
+
+/* 2 Fans */
+static ssize_t show_fan(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index - 1;
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr],
+				DIV_FROM_REG(data->fan_div[nr])));
+}
+
+static ssize_t show_fan_min(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index - 1;
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n",
+		FAN_FROM_REG(data->fan_min[nr],
+			DIV_FROM_REG(data->fan_div[nr])));
+}
+static ssize_t show_fan_div(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index - 1;
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", DIV_FROM_REG(data->fan_div[nr]));
+}
+static ssize_t set_fan_min(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index - 1;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtoul(buf, NULL, 10);
+	down(&data->update_lock);
+	data->fan_min[nr] = FAN_TO_REG(val, DIV_FROM_REG(data->fan_div[nr]));
+	vt8231_write_value(client, VT8231_REG_FAN_MIN(nr+1), data->fan_min[nr]);
+	up(&data->update_lock);
+	return count;
+}
+
+static ssize_t set_fan_div(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct sensor_device_attribute *sensor_attr = to_sensor_dev_attr(attr);
+	int nr = sensor_attr->index - 1;
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	unsigned long val = simple_strtoul(buf, NULL, 10);
+	down(&data->update_lock);
+	int old = vt8231_read_value(client, VT8231_REG_FANDIV);
+
+	switch (val) {
+		case 1: data->fan_div[nr] = 0; break;
+		case 2: data->fan_div[nr] = 1; break;
+		case 4: data->fan_div[nr] = 2; break;
+		case 8: data->fan_div[nr] = 3; break;
+		default:
+			dev_err(&client->dev, "fan_div value %ld not "
+			      "supported. Choose one of 1, 2, 4 or 8!\n", val);
+			up(&data->update_lock);
+			return -EINVAL;
+	}
+
+	old = (old & 0x0f) | (data->fan_div[1] << 6) | (data->fan_div[0] << 4);
+	vt8231_write_value(client, VT8231_REG_FANDIV, old);
+	up(&data->update_lock);
+	return count;
+}
+
+
+#define show_fan_offset(offset)						\
+static SENSOR_DEVICE_ATTR(fan##offset##_input, S_IRUGO,			\
+		show_fan, NULL, offset);				\
+static SENSOR_DEVICE_ATTR(fan##offset##_div, S_IRUGO | S_IWUSR,		\
+		show_fan_div, set_fan_div, offset);			\
+static SENSOR_DEVICE_ATTR(fan##offset##_min, S_IRUGO | S_IWUSR,		\
+		show_fan_min, set_fan_min, offset);
+
+show_fan_offset(1);
+show_fan_offset(2);
+
+/* Alarms */
+static ssize_t show_alarms(struct device *dev, struct device_attribute *attr,
+			char *buf) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", data->alarms);
+}
+static DEVICE_ATTR(alarms, S_IRUGO, show_alarms, NULL);
+
+
+/**** VRM and VID *****/
+static ssize_t show_vrm(struct device *dev, struct device_attribute *attr,
+			char *buf) {
+	struct vt8231_data *data = vt8231_update_device(dev);
+	return sprintf(buf, "%d\n", (unsigned)data->vrm);
+}
+static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count) {
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int val = simple_strtol(buf, NULL, 10);
+	down(&data->update_lock);
+	data->vrm = val;
+	up(&data->update_lock);
+	return count;
+}
+static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
+
+static struct i2c_driver vt8231_driver = {
+	.owner		= THIS_MODULE,
+	.name		= "vt8231",
+	.id		= I2C_DRIVERID_VT8231,
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= vt8231_detect,
+	.detach_client	= vt8231_detach_client,
+};
+
+static struct pci_device_id vt8231_pci_ids[] = {
+	{ PCI_DEVICE( PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_8231_4) },
+	{ 0, }
+};
+
+MODULE_DEVICE_TABLE(pci, vt8231_pci_ids);
+
+static int __devinit vt8231_pci_probe(struct pci_dev *dev,
+				const struct pci_device_id *id);
+
+static struct pci_driver vt8231_pci_driver = {
+	.name		= "vt8231",
+	.id_table	= vt8231_pci_ids,
+	.probe		= vt8231_pci_probe,
+};
+
+int vt8231_detect(struct i2c_adapter *adapter)
+{
+	struct i2c_client *new_client;
+	struct vt8231_data *data;
+	int err = 0, i;
+	u16 val;
+
+	/* 8231 requires multiple of 256 */
+	if (force_addr)
+		isa_address = force_addr & 0xFF00;
+
+	if (force_addr) {
+		dev_warn(&adapter->dev, "forcing ISA address 0x%04X\n",
+				 isa_address);
+		if (PCIBIOS_SUCCESSFUL != pci_write_config_word(s_bridge,
+						VT8231_BASE_REG, isa_address))
+			return -ENODEV;
+	}
+	if (PCIBIOS_SUCCESSFUL !+		pci_read_config_word(s_bridge, VT8231_ENABLE_REG, &val))
+		return -ENODEV;
+	if (!(val & 0x0001)) {
+		dev_warn(&adapter->dev, "enabling sensors\n");
+		if (PCIBIOS_SUCCESSFUL !+			pci_write_config_word(s_bridge, VT8231_ENABLE_REG,
+							  val | 0x0001))
+			return -ENODEV;
+	}
+
+	/* Reserve the ISA region */
+	if (!request_region(isa_address, VT8231_EXTENT, vt8231_pci_driver.name)) {
+		dev_err(&adapter->dev, "region 0x%x already in use!\n",
+			   isa_address);
+		return -ENODEV;
+	}
+
+	if (!(data = kzalloc(sizeof(struct vt8231_data), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto exit_release;
+	}
+
+	new_client = &data->client;
+	i2c_set_clientdata(new_client, data);
+	new_client->addr = isa_address;
+	new_client->adapter = adapter;
+	new_client->driver = &vt8231_driver;
+	new_client->dev.parent = &adapter->dev;
+
+	/* Fill in the remaining client fields and put into the global list */
+	strcpy(new_client->name, "vt8231");
+
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto exit_free;
+
+	vt8231_init_client(new_client);
+
+	/* Register sysfs hooks */
+	data->class_dev = hwmon_device_register(&new_client->dev);
+	if (IS_ERR(data->class_dev)) {
+		err = PTR_ERR(data->class_dev);
+		goto exit_detach;
+	}
+
+	/* Must update device information to find out the config field */
+	data->uch_config = vt8231_read_value(new_client, VT8231_REG_UCH_CONFIG);
+
+	for(i=0; cfgInfoTemp[i].id >= 0; i++)
+	{
+		struct strDeviceAttrTable *pEntry = &cfgInfoTemp[i];
+		if ( ISTEMP(pEntry->id, data->uch_config) )
+		{
+			device_create_file(&new_client->dev, pEntry->input);
+			device_create_file(&new_client->dev, pEntry->max);
+			device_create_file(&new_client->dev, pEntry->min);
+		}
+	}
+
+	for(i=0; cfgInfoVolt[i].id >= 0; i++)
+	{
+		struct strDeviceAttrTable *pEntry = &cfgInfoVolt[i];
+		if ( ISVOLT(pEntry->id, data->uch_config) )
+		{
+			device_create_file(&new_client->dev, pEntry->input);
+			device_create_file(&new_client->dev, pEntry->max);
+			device_create_file(&new_client->dev, pEntry->min);
+		}
+	}
+
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_input.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_min.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan1_div.dev_attr);
+	device_create_file(&new_client->dev, &sensor_dev_attr_fan2_div.dev_attr);
+
+	device_create_file(&new_client->dev, &dev_attr_alarms);
+	device_create_file(&new_client->dev, &dev_attr_vrm);
+
+	return 0;
+
+exit_detach:
+	i2c_detach_client(new_client);
+exit_free:
+	kfree(data);
+exit_release:
+	release_region(isa_address, VT8231_EXTENT);
+	return err;
+}
+
+static int vt8231_detach_client(struct i2c_client *client)
+{
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int err;
+
+	hwmon_device_unregister(data->class_dev);
+
+	if ((err = i2c_detach_client(client))) {
+		return err;
+	}
+
+	release_region(client->addr, VT8231_EXTENT);
+	kfree(data);
+
+	return 0;
+}
+
+static void vt8231_init_client(struct i2c_client *client)
+{
+	struct vt8231_data *data = i2c_get_clientdata(client);
+
+	data->vrm = vid_which_vrm();
+
+	/* set "default" interrupt mode for alarms, which isn't the default */
+	vt8231_write_value(client, VT8231_REG_TEMP1_CONFIG, 0);
+	vt8231_write_value(client, VT8231_REG_TEMP2_CONFIG, 0);
+}
+
+static struct vt8231_data *vt8231_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct vt8231_data *data = i2c_get_clientdata(client);
+	int i, j;
+
+	down(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		data->uch_config = vt8231_read_value(client,
+						VT8231_REG_UCH_CONFIG);
+		for (i = 0; i < 6; i++) {
+			if(ISVOLT(i, data->uch_config)) {
+				data->in[i] = vt8231_read_value(client,
+						regvolt[i]);
+				data->in_min[i] = vt8231_read_value(client,
+						regvoltmin[i]);
+				data->in_max[i] = vt8231_read_value(client,
+						regvoltmax[i]);
+			}
+		}
+		for (i = 1; i < 3; i++) {
+			data->fan[i - 1] = vt8231_read_value(client,
+						VT8231_REG_FAN(i));
+			data->fan_min[i - 1] = vt8231_read_value(client,
+						VT8231_REG_FAN_MIN(i));
+		}
+		for (i = 0; i < 6; i++) {
+			if(ISTEMP(i, data->uch_config)) {
+				data->temp[i] = vt8231_read_value(client,
+						       regtemp[i]) << 2;
+				switch(i) {
+					case 0:	j = (vt8231_read_value(client,
+							VT8231_REG_TEMP_LOW01)
+						      >> 6) & 0x03;
+						break;
+
+					case 1:	j = (vt8231_read_value(client,
+							VT8231_REG_TEMP_LOW01)
+						      >> 4) & 0x03;
+						break;
+					case 2:
+					case 3:
+					case 4:
+					case 5:	j = (vt8231_read_value(client,
+						  	VT8231_REG_TEMP_LOW25)
+							 >> ((i-2)*2)) & 0x03;
+						break;
+
+					default: j = 0;
+						break;
+				}
+				data->temp[i] |= j;
+				data->temp_max[i] = vt8231_read_value(client,
+						      regtempmax[i]);
+				data->temp_min[i] = vt8231_read_value(client,
+						      regtempmin[i]);
+			}
+		}
+
+		i = vt8231_read_value(client, VT8231_REG_FANDIV);
+		data->fan_div[0] = (i >> 4) & 0x03;
+		data->fan_div[1] = i >> 6;
+		data->alarms = vt8231_read_value(client, VT8231_REG_ALARM1) |
+			(vt8231_read_value(client, VT8231_REG_ALARM2) << 8);
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+
+	return data;
+}
+
+static int __devinit vt8231_pci_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
+{
+	u16 val;
+
+	if (PCIBIOS_SUCCESSFUL != pci_read_config_word(dev, VT8231_BASE_REG,
+							&val))
+		return -ENODEV;
+
+	isa_address = val & ~(VT8231_EXTENT - 1);
+	if (isa_address = 0 && force_addr = 0) {
+		dev_err(&dev->dev, "base address not set -\
+				 upgrade BIOS or use force_addr=0xaddr\n");
+		return -ENODEV;
+	}
+
+	s_bridge = pci_dev_get(dev);
+
+	if (i2c_isa_add_driver(&vt8231_driver)) {
+		pci_dev_put(s_bridge);
+		s_bridge = NULL;
+	}
+
+	/* Always return failure here.  This is to allow other drivers to bind
+	* to this pci device.  We don't really want to have control over the
+	* pci device, we only wanted to read as few register values from it.
+	*/
+	return -ENODEV;
+}
+
+static int __init sm_vt8231_init(void)
+{
+	return pci_module_init(&vt8231_pci_driver);
+}
+
+static void __exit sm_vt8231_exit(void)
+{
+	pci_unregister_driver(&vt8231_pci_driver);
+	if (s_bridge != NULL) {
+		i2c_isa_del_driver(&vt8231_driver);
+		pci_dev_put(s_bridge);
+		s_bridge = NULL;
+	}
+}
+
+MODULE_AUTHOR("Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_DESCRIPTION("VT8231 sensors");
+MODULE_LICENSE("GPL");
+
+module_init(sm_vt8231_init);
+module_exit(sm_vt8231_exit);
+
