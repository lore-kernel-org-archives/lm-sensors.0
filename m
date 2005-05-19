From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: ADM1030/ADM1031 user-space support
Message-Id: <20040517100022.54fae886.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Avrel,

Here are my comments on your user-space support for the adm1031 driver.

diff -urN -x CVS lm_sensors2/kernel/chips/adm1031.c lm_sensors2_mine/kernel/chips/adm1031.c
--- lm_sensors2/kernel/chips/adm1031.c	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2_mine/kernel/chips/adm1031.c	2004-05-16 19:31:14.000000000 +0200
(...)
+/*
+ * For instance, this file is the placeholder for the SYSFS numbers
+ * needed for libsensors to work with the adm1031 / adm1030 chip. It
+ * does not contains any driver code yet.  
+ */

"For instance" means "par exemple". The expression you need here is "For
now" or "At the moment" or something similar.

Also, the values are not about Sysfs. Sysfs is for Linux 2.6. The values
here are SYSCTL constants, which is something different.

+/*
+ * Addresses to scan
+ * Address is fully defined internally and cannot be changed.
+ */
+
+static unsigned short normal_i2c[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { 0x2c, 0x2e, SENSORS_I2C_END };

The comment doesn't match the code. If there are three possible
addresses, then the address is not "fully defined" and can be changed.

diff -urN -x CVS lm_sensors2/kernel/chips/adm1031.c~ lm_sensors2_mine/kernel/chips/adm1031.c~
--- lm_sensors2/kernel/chips/adm1031.c~	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2_mine/kernel/chips/adm1031.c~	2004-05-16 18:30:52.000000000 +0200

Please don't include backup files into the diffs ;)

diff -urN -x CVS lm_sensors2/lib/chips.c lm_sensors2_mine/lib/chips.c
--- lm_sensors2/lib/chips.c	2004-04-24 10:10:48.000000000 +0200
+++ lm_sensors2_mine/lib/chips.c	2004-05-16 18:30:07.000000000 +0200
@@ -360,6 +360,110 @@
     { 0 }
   };
 
+
+static sensors_chip_feature adm1030_features[] +  {
+    { SENSORS_ADM1031_TEMP1, "temp1_input", NOMAP, NOMAP,
+                              R, ADM1031_SYSCTL_TEMP1, VALUE(4), 
+                              3 },
+    { SENSORS_ADM1031_TEMP1_MIN, "temp1_min", SENSORS_ADM1031_TEMP1, SENSORS_ADM1031_TEMP1,
+                              RW, ADM1031_SYSCTL_TEMP1_MIN, VALUE(1), 
+                              3 },
+    { SENSORS_ADM1031_TEMP1_MAX, "temp1_max", SENSORS_ADM1031_TEMP1, SENSORS_ADM1031_TEMP1,
+                              RW, ADM1031_SYSCTL_TEMP1_MAX, VALUE(2), 
+                              3 },
+    { SENSORS_ADM1031_TEMP1_CRIT, "temp1_crit", SENSORS_ADM1031_TEMP1, SENSORS_ADM1031_TEMP1,
+                              RW, ADM1031_SYSCTL_TEMP1_CRIT, VALUE(3), 
+                              3 },

The usual order is: max, min, crit, current. And you should not include
the "_input" in the symbol name. The library knows that readings map to
the same symbol with "_input" appended in 2.6. This is important because
the symbol name is used by default by "sensors" when no label is given,
and long names break the output (I guess you had noticed).

Also, please move the trailing "3" on the previous line each time, it
definitely fits.

+    { SENSORS_ADM1031_ALARMS, "alarms", NOMAP, 
+                              NOMAP, RW, 
+                              ADM1031_SYSCTL_ALARMS, VALUE(1), 0 },
+    { 0 }

RW, really?

Same applies to the adm1031 table, of course.

diff -urN -x CVS lm_sensors2/lib/chips.h lm_sensors2_mine/lib/chips.h
--- lm_sensors2/lib/chips.h	2004-04-24 10:10:48.000000000 +0200
+++ lm_sensors2_mine/lib/chips.h	2004-05-16 18:30:29.000000000 +0200
@@ -184,6 +184,36 @@
+#define SENSORS_ADM1031_TEMP3 71 /* R */
+#define SENSORS_ADM1031_TEMP3_MIN 72 /* RW */
+#define SENSORS_ADM1031_TEMP3_MAX 73 /* RW */
+#define SENSORS_ADM1031_TEMP3_CRIT 74 /* RW */
+
+#define SENSORS_ADM1031_FAN1 70 /* R */
+#define SENSORS_ADM1031_FAN1_MIN 71 /* R */
+#define SENSORS_ADM1031_FAN2 72 /* R */
+#define SENSORS_ADM1031_FAN2_MIN 73 /* R */

Values overlap! I guess you missed it because it doesn't matter for the
ADM1030, but it does for the ADM1031.

Also, FAN_MINs are RW.

diff -urN -x CVS lm_sensors2/prog/sensors/chips.c lm_sensors2_mine/prog/sensors/chips.c
--- lm_sensors2/prog/sensors/chips.c	2004-05-08 14:24:16.000000000 +0200
+++ lm_sensors2_mine/prog/sensors/chips.c	2004-05-16 18:46:12.000000000 +0200
@@ -4726,6 +4726,117 @@
   free_the_label(&label);
 }
 
+
+void print_adm1031(const sensors_chip_name *name)
+{
+  char *label;
+  double cur, high, low, crit;
+  int valid, alarms;
+  int type = 0;
+
+  if (strncmp("adm1030", name->prefix, 7)){
+      type = 1;
+  }

"type" isn't exactly an explicit variable name IMHO. And you should
default to the less featured chip. What about:

  int is_1031 = !strncmp("adm1031", name->prefix, 7);


+  if (!sensors_get_label_and_valid(*name, SENSORS_ADM1031_TEMP1,
+				   &label, &valid)
+      && !sensors_get_feature(*name, SENSORS_ADM1031_TEMP1, &cur)
+      && !sensors_get_feature(*name, SENSORS_ADM1031_TEMP1_MIN, &low)
+      && !sensors_get_feature(*name, SENSORS_ADM1031_TEMP1_MAX, &high)
+      && !sensors_get_feature(*name, SENSORS_ADM1031_TEMP1_CRIT, &crit)) {
+    if (valid) {
+      print_label(label, 10);
+      print_temp_info(cur, high, crit, CRIT, 0, 0);
+      printf(" %s\n",
+	     alarms&ADM1031_ALARM_TEMP1_CRIT?"CRITICAL":
+	     alarms&(ADM1031_ALARM_TEMP1_HIGH|ADM1031_ALARM_TEMP1_LOW)?"ALARM":"");
+    }
+  } else
+    printf("ERROR: Can't get temp1 temperature data!\n");
+  free_the_label(&label);

You retrieve the MIN value but never display it.

I'd suggest that you display values on two lines: current reading, min
and max on the fisrt line, and crit on a second. That's what I do for
the PC87366, if you want to take a look.

Also, why do you trim the extra resolution? You should display one
decimal place, just like you do for temp2 and temp3.

+	     alarms&ADM1031_ALARM_TEMP2_DIODE?"DIODE_ERROR":

Open diode condition is typically displayed "OPEN" or "DISCONNECT" (we
should standardize this, BTW).

Additional comment:

It should be possible to refactor part of the code if the various
constants have been chosen wisely. At the beginning of the print
function, instead of storing the chip type as a boolean, use it to
define two integers, representing the number of temperature channels and
the number of fans.

Then have two "for" loops, one for fans, one for temperatures (BTW we
usually print them in this order).

This of course requires that, for example, SENSORS_ADM1031_TEMP2 is
defined as SENSORS_ADM1031_TEMP1 + 1 (or any other constant as long as
you are consistent), and the same for all other SENSORS_ constants. This
should help reduce the size of the sensors program, which tends to grow
out of limit as we add support for more and more chips.

Actually you may not be able to factor temp1 because alarm bits are
different... but you should be able to factor temp2 with temp3 and fan1
with fan2. I've done that for the pc87366 and it helped much (it has 11
voltage inputs...) It's not possible to do this for all chips, it really
depends how logical the chip designers have been when placing the alarm
bits.

Also, please provide a sample configuration section in
etc/sensors.conf.eg. It doesn't have to be long and complex, we just
need a placeholder so that people can change labels, set limits etc...

A preliminary doc/chips/adm1031 file would be welcome as well, even if
there is no 2.4 driver yet. Present the chips briefly, who made them,
what they do, and that there is no driver yet ;) Pick any file from this
directory for examples.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
