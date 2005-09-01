From: jim.cromie@gmail.com (Jim Cromie)
Date: Thu, 01 Sep 2005 00:15:09 +0000
Subject: [lm-sensors] [patch 2/2] pc87360 vref-int-ext - add 3 module params
Message-Id: <200508312214.j7VMEMA4008330@harpo.jimc.earth>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

02	pc87360-02-vref-options.patch  *(RFC)*

adds 3 new module-parameters, which allow the well-equipped user to
improve the accuracy of her on-board voltage measurements.  

Im seeking input for whether any/all of these parameters are useful or
excessive, and where any additional commentary should go - Ive not put
it in the parameter-info, though that would be the most usable place
for it; I dont know the norms for verbosity here, and Ive already
added a 2nd line for each.

The following comments could reasonably go into Docs, but if so, where
- theres none currently, and it feels a bit presumptuous to create it
anew.

The 3 params, most usable 1st, are:


+module_param(vrefext, int, 0);

The PC87366 Spec recommends a that a voltage of 1.211 volts be fed to
the external vref input, so the code matches that expectation, but
your board may differ.  If you measure your boards actual voltage, you
can tell the driver aobout it.

This param could be used to workaround the bug fixed by the 1st patch,
and ironically, it is more verifiable without that bug fixed.


+module_param(vrefscale, int, 0);

If you *also* measure several of the other reported voltages, you can
do some math (y=mx+b) to determine where your scaling factor is in the
specified range; 2.45 V +/- 50 mV.  This parameter is clamped to that
range.


+module_param(vrefint, int, 0);

If youve tweaked both of the above, *and* have the ability to switch
to an internal voltage reference, you can then do more math (y=mx+b)
to determine what the internal voltage ref really is.


[jimc@harpo pset-pc87360-vref]$ diffstat pc87360-0*
 V-2/drivers/hwmon/pc87360.c |   30 +++++++++++++++++++++++++++++-


Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>

diff -ruNp -X exclude-diffs V-1/drivers/hwmon/pc87360.c V-2/drivers/hwmon/pc87360.c
--- V-1/drivers/hwmon/pc87360.c	2005-08-31 15:14:21.000000000 -0600
+++ V-2/drivers/hwmon/pc87360.c	2005-08-31 15:22:09.000000000 -0600
@@ -60,6 +60,26 @@ MODULE_PARM_DESC(init,
  " 2: Forcibly enable all voltage and temperature channels, except in9\n"
  " 3: Forcibly enable all voltage and temperature channels, including in9");
 
+static int vrefext = 1211;
+module_param(vrefext, int, 0);
+MODULE_PARM_DESC(vrefext,
+		 " External Voltage Reference, specd at 1211 mV\n"
+		 "   measure your actual value before changing!\n");
+
+static int vrefscale = 2450;
+module_param(vrefscale, int, 0);
+MODULE_PARM_DESC(vrefscale,
+		 " Voltage Reference Scale (2450mV nominal +/- 50mV)\n"
+		 "   overridden values are clamped: 2400mV .. 2500mV\n");
+
+static int vrefint = 1235;
+module_param(vrefint, int, 0);
+MODULE_PARM_DESC(vrefint,
+		 " Internal Voltage Reference, specd at 1235 mV\n"
+		 "   Do not change unless you know what you're doing\n");
+
+#define VREFSCALE 1000	/* mV per volt, */
+
 /*
  * Super-I/O registers and operations
  */
@@ -798,7 +818,11 @@ static int pc87360_detect(struct i2c_ada
 			i &= pc87360_read_value(data, LD_TEMP, NO_BANK,
 						PC87365_REG_TEMP_CONFIG);
 		}
-		data->in_vref = (i&0x02) ? 2966 : 3025;
+		data->in_vref = ((i&0x02) /* vrefs are in milliVolts */
+				 ? (vrefext * vrefscale)
+				 : (vrefint * vrefscale)
+				 ) / VREFSCALE; /* avoided rounding errs */
+
 		dev_dbg(&new_client->dev, "Using %s reference voltage\n",
 			(i&0x02) ? "external" : "internal");
 
@@ -1301,6 +1325,10 @@ static int __init pc87360_init(void)
 {
 	int i;
 
+	/* clamp vrefscale 2450mV +- 50mV */
+	vrefscale = (vrefscale<2400) ? 2400 : vrefscale;
+	vrefscale = (vrefscale>2500) ? 2500 : vrefscale;
+
 	if (pc87360_find(0x2e, &devid, extra_isa)
 	 && pc87360_find(0x4e, &devid, extra_isa)) {
 		printk(KERN_WARNING "pc87360: PC8736x not detected, "
