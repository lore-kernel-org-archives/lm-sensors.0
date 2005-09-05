From: gregkh@suse.de (Greg KH)
Date: Mon, 05 Sep 2005 23:48:40 +0000
Subject: [lm-sensors] [PATCH] I2C: Separate non-i2c hwmon drivers from
Message-Id: <11259567662511@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11259567663617@kroah.com>
In-Reply-To: <11259567663617@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] I2C: Separate non-i2c hwmon drivers from i2c-core (7/9)

Kill normal_isa in header files, documentation and all chip drivers, as
it is no more used.

normal_i2c could be renamed to normal, but I decided not to do so at the
moment, so as to limit the number of changes. This might be done later
as part of the i2c_probe/i2c_detect merge.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5071860aba7fc69279ab822638ed2c2e4549f9fd
tree e23a3c7eba547c9d81c7680a40c41536c8a45da3
parent 4926c0d4de77c5396a274ee7941ed7fc02afed26
author Jean Delvare <khali@linux-fr.org> Wed, 20 Jul 2005 00:02:32 +0200
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 05 Sep 2005 09:14:12 -0700

 Documentation/i2c/porting-clients |    7 ++++---
 Documentation/i2c/writing-clients |   35 +++++++++++++++--------------------
 drivers/hwmon/adm1021.c           |    1 -
 drivers/hwmon/adm1025.c           |    1 -
 drivers/hwmon/adm1026.c           |    1 -
 drivers/hwmon/adm1031.c           |    1 -
 drivers/hwmon/adm9240.c           |    2 --
 drivers/hwmon/asb100.c            |    3 ---
 drivers/hwmon/atxp1.c             |    1 -
 drivers/hwmon/ds1621.c            |    1 -
 drivers/hwmon/fscher.c            |    1 -
 drivers/hwmon/fscpos.c            |    1 -
 drivers/hwmon/gl518sm.c           |    1 -
 drivers/hwmon/gl520sm.c           |    1 -
 drivers/hwmon/it87.c              |    1 -
 drivers/hwmon/lm63.c              |    1 -
 drivers/hwmon/lm75.c              |    1 -
 drivers/hwmon/lm77.c              |    1 -
 drivers/hwmon/lm78.c              |    1 -
 drivers/hwmon/lm80.c              |    1 -
 drivers/hwmon/lm83.c              |    1 -
 drivers/hwmon/lm85.c              |    1 -
 drivers/hwmon/lm87.c              |    1 -
 drivers/hwmon/lm90.c              |    1 -
 drivers/hwmon/lm92.c              |    1 -
 drivers/hwmon/max1619.c           |    1 -
 drivers/hwmon/w83781d.c           |    1 -
 drivers/hwmon/w83l785ts.c         |    1 -
 drivers/i2c/chips/ds1337.c        |    1 -
 drivers/i2c/chips/eeprom.c        |    1 -
 drivers/i2c/chips/max6875.c       |    1 -
 drivers/i2c/chips/pca9539.c       |    1 -
 drivers/i2c/chips/pcf8574.c       |    1 -
 drivers/i2c/chips/pcf8591.c       |    1 -
 include/linux/i2c-sensor.h        |   36 +++++++++++++++---------------------
 include/linux/i2c.h               |    8 ++------
 36 files changed, 36 insertions(+), 85 deletions(-)

diff --git a/Documentation/i2c/porting-clients b/Documentation/i2c/porting-clients
--- a/Documentation/i2c/porting-clients
+++ b/Documentation/i2c/porting-clients
@@ -29,8 +29,8 @@ Technical changes:
   Please respect this inclusion order. Some extra headers may be
   required for a given driver (e.g. "lm75.h").
 
-* [Addresses] SENSORS_I2C_END becomes I2C_CLIENT_END, SENSORS_ISA_END
-  becomes I2C_CLIENT_ISA_END.
+* [Addresses] SENSORS_I2C_END becomes I2C_CLIENT_END, ISA addresses
+  are no more handled by the i2c core.
 
 * [Client data] Get rid of sysctl_id. Try using standard names for
   register values (for example, temp_os becomes temp_max). You're
@@ -72,7 +72,8 @@ Technical changes:
   name string, which will be filled with a lowercase, short string
   (typically the driver name, e.g. "lm75").
   In i2c-only drivers, drop the i2c_is_isa_adapter check, it's
-  useless.
+  useless. Same for isa-only drivers, as the test would always be
+  true. Only hybrid drivers (which are quite rare) still need it.
   The errorN labels are reduced to the number needed. If that number
   is 2 (i2c-only drivers), it is advised that the labels are named
   exit and exit_free. For i2c+isa drivers, labels should be named
diff --git a/Documentation/i2c/writing-clients b/Documentation/i2c/writing-clients
--- a/Documentation/i2c/writing-clients
+++ b/Documentation/i2c/writing-clients
@@ -195,31 +195,28 @@ Probing classes (sensors)
 -------------------------
 
 If you write a `sensors' driver, you use a slightly different interface.
-As well as I2C addresses, we have to cope with ISA addresses. Also, we
-use a enum of chip types. Don't forget to include `sensors.h'.
+Also, we use a enum of chip types. Don't forget to include `sensors.h'.
 
 The following lists are used internally. They are all lists of integers.
 
-   normal_i2c: filled in by the module writer. Terminated by SENSORS_I2C_END.
+   normal_i2c: filled in by the module writer. Terminated by I2C_CLIENT_END.
      A list of I2C addresses which should normally be examined.
-   normal_isa: filled in by the module writer. Terminated by SENSORS_ISA_END.
-     A list of ISA addresses which should normally be examined.
-   probe: insmod parameter. Initialize this list with SENSORS_I2C_END values.
-     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second is the address. These
-     addresses are also probed, as if they were in the 'normal' list.
-   ignore: insmod parameter. Initialize this list with SENSORS_I2C_END values.
-     A list of pairs. The first value is a bus number (SENSORS_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second is the I2C address. These
-     addresses are never probed. This parameter overrules 'normal' and 
-     'probe', but not the 'force' lists.
+   probe: insmod parameter. Initialize this list with I2C_CLIENT_END values.
+     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
+     I2C bus), the second is the address. These addresses are also probed,
+     as if they were in the 'normal' list.
+   ignore: insmod parameter. Initialize this list with I2C_CLIENT_END values.
+     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
+     I2C bus), the second is the I2C address. These addresses are never
+     probed. This parameter overrules 'normal' and 'probe', but not the
+     'force' lists.
 
 Also used is a list of pointers to sensors_force_data structures:
    force_data: insmod parameters. A list, ending with an element of which
      the force field is NULL.
      Each element contains the type of chip and a list of pairs.
-     The first value is a bus number (SENSORS_ISA_BUS for the ISA bus, 
-     -1 for any I2C bus), the second is the address. 
+     The first value is a bus number (ANY_I2C_BUS for any I2C bus), the
+     second is the address.
      These are automatically translated to insmod variables of the form
      force_foo.
 
@@ -227,13 +224,11 @@ So we have a generic insmod variabled `f
 `force_CHIPNAME'.
 
 Fortunately, as a module writer, you just have to define the `normal_i2c' 
-and `normal_isa' parameters, and define what chip names are used. 
-The complete declaration could look like this:
+parameter, and define what chip names are used. The complete declaration
+could look like this:
   /* Scan i2c addresses 0x37, and 0x48 to 0x4f */
   static unsigned short normal_i2c[] = { 0x37, 0x48, 0x49, 0x4a, 0x4b, 0x4c,
                                          0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
-  /* Scan ISA address 0x290 */
-  static unsigned int normal_isa[] = {0x0290,SENSORS_ISA_END};
 
   /* Define chips foo and bar, as well as all module parameters and things */
   SENSORS_INSMOD_2(foo,bar);
diff --git a/drivers/hwmon/adm1021.c b/drivers/hwmon/adm1021.c
--- a/drivers/hwmon/adm1021.c
+++ b/drivers/hwmon/adm1021.c
@@ -34,7 +34,6 @@ static unsigned short normal_i2c[] = { 0
 					0x29, 0x2a, 0x2b,
 					0x4c, 0x4d, 0x4e, 
 					I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
diff --git a/drivers/hwmon/adm1025.c b/drivers/hwmon/adm1025.c
--- a/drivers/hwmon/adm1025.c
+++ b/drivers/hwmon/adm1025.c
@@ -62,7 +62,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/adm1026.c b/drivers/hwmon/adm1026.c
--- a/drivers/hwmon/adm1026.c
+++ b/drivers/hwmon/adm1026.c
@@ -36,7 +36,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(adm1026);
diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -61,7 +61,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_2(adm1030, adm1031);
diff --git a/drivers/hwmon/adm9240.c b/drivers/hwmon/adm9240.c
--- a/drivers/hwmon/adm9240.c
+++ b/drivers/hwmon/adm9240.c
@@ -54,8 +54,6 @@
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
 					I2C_CLIENT_END };
 
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-
 /* Insmod parameters */
 SENSORS_INSMOD_3(adm9240, ds1780, lm81);
 
diff --git a/drivers/hwmon/asb100.c b/drivers/hwmon/asb100.c
--- a/drivers/hwmon/asb100.c
+++ b/drivers/hwmon/asb100.c
@@ -56,9 +56,6 @@
 /* I2C addresses to scan */
 static unsigned short normal_i2c[] = { 0x2d, I2C_CLIENT_END };
 
-/* ISA addresses to scan (none) */
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
-
 /* Insmod parameters */
 SENSORS_INSMOD_1(asb100);
 I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
diff --git a/drivers/hwmon/atxp1.c b/drivers/hwmon/atxp1.c
--- a/drivers/hwmon/atxp1.c
+++ b/drivers/hwmon/atxp1.c
@@ -42,7 +42,6 @@ MODULE_AUTHOR("Sebastian Witt <se.witt@g
 #define ATXP1_GPIO1MASK	0x0f
 
 static unsigned short normal_i2c[] = { 0x37, 0x4e, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 SENSORS_INSMOD_1(atxp1);
 
diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
--- a/drivers/hwmon/ds1621.c
+++ b/drivers/hwmon/ds1621.c
@@ -34,7 +34,6 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(ds1621);
diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -40,7 +40,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/fscpos.c b/drivers/hwmon/fscpos.c
--- a/drivers/hwmon/fscpos.c
+++ b/drivers/hwmon/fscpos.c
@@ -43,7 +43,6 @@
  * Addresses to scan
  */
 static unsigned short normal_i2c[] = { 0x73, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/gl518sm.c b/drivers/hwmon/gl518sm.c
--- a/drivers/hwmon/gl518sm.c
+++ b/drivers/hwmon/gl518sm.c
@@ -47,7 +47,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_2(gl518sm_r00, gl518sm_r80);
diff --git a/drivers/hwmon/gl520sm.c b/drivers/hwmon/gl520sm.c
--- a/drivers/hwmon/gl520sm.c
+++ b/drivers/hwmon/gl520sm.c
@@ -38,7 +38,6 @@ MODULE_PARM_DESC(extra_sensor_type, "Typ
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(gl520sm);
diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -48,7 +48,6 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c, 0x2d,
 					0x2e, 0x2f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -53,7 +53,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x4c, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -32,7 +32,6 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm75);
diff --git a/drivers/hwmon/lm77.c b/drivers/hwmon/lm77.c
--- a/drivers/hwmon/lm77.c
+++ b/drivers/hwmon/lm77.c
@@ -36,7 +36,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm77);
diff --git a/drivers/hwmon/lm78.c b/drivers/hwmon/lm78.c
--- a/drivers/hwmon/lm78.c
+++ b/drivers/hwmon/lm78.c
@@ -34,7 +34,6 @@ static unsigned short normal_i2c[] = { 0
 					0x25, 0x26, 0x27, 0x28, 0x29,
 					0x2a, 0x2b, 0x2c, 0x2d, 0x2e,
 					0x2f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -33,7 +33,6 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x28, 0x29, 0x2a, 0x2b, 0x2c,
 					0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm80);
diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -47,7 +47,6 @@ static unsigned short normal_i2c[] = { 0
 					0x29, 0x2a, 0x2b,
 					0x4c, 0x4d, 0x4e,
 					I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -35,7 +35,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_6(lm85b, lm85c, adm1027, adt7463, emc6d100, emc6d102);
diff --git a/drivers/hwmon/lm87.c b/drivers/hwmon/lm87.c
--- a/drivers/hwmon/lm87.c
+++ b/drivers/hwmon/lm87.c
@@ -68,7 +68,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -91,7 +91,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x4c, 0x4d, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -52,7 +52,6 @@
    resulting in 4 possible addresses. */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b,
 				       I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(lm92);
diff --git a/drivers/hwmon/max1619.c b/drivers/hwmon/max1619.c
--- a/drivers/hwmon/max1619.c
+++ b/drivers/hwmon/max1619.c
@@ -39,7 +39,6 @@ static unsigned short normal_i2c[] = { 0
 					0x29, 0x2a, 0x2b,
 					0x4c, 0x4d, 0x4e,
 					I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
--- a/drivers/hwmon/w83781d.c
+++ b/drivers/hwmon/w83781d.c
@@ -50,7 +50,6 @@
 static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25,
 					0x26, 0x27, 0x28, 0x29, 0x2a, 0x2b,
 					0x2c, 0x2d, 0x2e, 0x2f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 static unsigned short isa_address = 0x290;
 
 /* Insmod parameters */
diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -49,7 +49,6 @@
  */
 
 static unsigned short normal_i2c[] = { 0x2e, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /*
  * Insmod parameters
diff --git a/drivers/i2c/chips/ds1337.c b/drivers/i2c/chips/ds1337.c
--- a/drivers/i2c/chips/ds1337.c
+++ b/drivers/i2c/chips/ds1337.c
@@ -39,7 +39,6 @@
  * Functions declaration
  */
 static unsigned short normal_i2c[] = { 0x68, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 SENSORS_INSMOD_1(ds1337);
 
diff --git a/drivers/i2c/chips/eeprom.c b/drivers/i2c/chips/eeprom.c
--- a/drivers/i2c/chips/eeprom.c
+++ b/drivers/i2c/chips/eeprom.c
@@ -38,7 +38,6 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x50, 0x51, 0x52, 0x53, 0x54,
 					0x55, 0x56, 0x57, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(eeprom);
diff --git a/drivers/i2c/chips/max6875.c b/drivers/i2c/chips/max6875.c
--- a/drivers/i2c/chips/max6875.c
+++ b/drivers/i2c/chips/max6875.c
@@ -36,7 +36,6 @@
 
 /* Do not scan - the MAX6875 access method will write to some EEPROM chips */
 static unsigned short normal_i2c[] = {I2C_CLIENT_END};
-static unsigned int normal_isa[] = {I2C_CLIENT_ISA_END};
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(max6875);
diff --git a/drivers/i2c/chips/pca9539.c b/drivers/i2c/chips/pca9539.c
--- a/drivers/i2c/chips/pca9539.c
+++ b/drivers/i2c/chips/pca9539.c
@@ -17,7 +17,6 @@
 
 /* Addresses to scan */
 static unsigned short normal_i2c[] = {0x74, 0x75, 0x76, 0x77, I2C_CLIENT_END};
-static unsigned int normal_isa[] = {I2C_CLIENT_ISA_END};
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(pca9539);
diff --git a/drivers/i2c/chips/pcf8574.c b/drivers/i2c/chips/pcf8574.c
--- a/drivers/i2c/chips/pcf8574.c
+++ b/drivers/i2c/chips/pcf8574.c
@@ -45,7 +45,6 @@
 static unsigned short normal_i2c[] = { 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
 					0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d, 0x3e, 0x3f,
 					I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_2(pcf8574, pcf8574a);
diff --git a/drivers/i2c/chips/pcf8591.c b/drivers/i2c/chips/pcf8591.c
--- a/drivers/i2c/chips/pcf8591.c
+++ b/drivers/i2c/chips/pcf8591.c
@@ -29,7 +29,6 @@
 /* Addresses to scan */
 static unsigned short normal_i2c[] = { 0x48, 0x49, 0x4a, 0x4b, 0x4c,
 					0x4d, 0x4e, 0x4f, I2C_CLIENT_END };
-static unsigned int normal_isa[] = { I2C_CLIENT_ISA_END };
 
 /* Insmod parameters */
 SENSORS_INSMOD_1(pcf8591);
diff --git a/include/linux/i2c-sensor.h b/include/linux/i2c-sensor.h
--- a/include/linux/i2c-sensor.h
+++ b/include/linux/i2c-sensor.h
@@ -27,11 +27,10 @@
    that place. If a specific chip is given, the module blindly assumes this
    chip type is present; if a general force (kind = 0) is given, the module
    will still try to figure out what type of chip is present. This is useful
-   if for some reasons the detect for SMBus or ISA address space filled
-   fails.
-   probe: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second is the address. 
+   if for some reasons the detect for SMBus address space filled fails.
+   probe: insmod parameter. Initialize this list with I2C_CLIENT_END values.
+     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
+     I2C bus), the second is the address.
    kind: The kind of chip. 0 equals any chip.
 */
 struct i2c_force_data {
@@ -40,25 +39,22 @@ struct i2c_force_data {
 };
 
 /* A structure containing the detect information.
-   normal_i2c: filled in by the module writer. Terminated by I2C_CLIENT_ISA_END.
+   normal_i2c: filled in by the module writer. Terminated by I2C_CLIENT_END.
      A list of I2C addresses which should normally be examined.
-   normal_isa: filled in by the module writer. Terminated by SENSORS_ISA_END.
-     A list of ISA addresses which should normally be examined.
-   probe: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second is the address. These
-     addresses are also probed, as if they were in the 'normal' list.
-   ignore: insmod parameter. Initialize this list with I2C_CLIENT_ISA_END values.
-     A list of pairs. The first value is a bus number (ANY_I2C_ISA_BUS for
-     the ISA bus, -1 for any I2C bus), the second is the I2C address. These
-     addresses are never probed. This parameter overrules 'normal' and 
-     'probe', but not the 'force' lists.
+   probe: insmod parameter. Initialize this list with I2C_CLIENT_END values.
+     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
+     I2C bus), the second is the address. These addresses are also probed,
+     as if they were in the 'normal' list.
+   ignore: insmod parameter. Initialize this list with I2C_CLIENT_END values.
+     A list of pairs. The first value is a bus number (ANY_I2C_BUS for any
+     I2C bus), the second is the I2C address. These addresses are never
+     probed. This parameter overrules 'normal' and  probe', but not the
+    'force' lists.
    force_data: insmod parameters. A list, ending with an element of which
      the force field is NULL.
 */
 struct i2c_address_data {
 	unsigned short *normal_i2c;
-	unsigned int *normal_isa;
 	unsigned short *probe;
 	unsigned short *ignore;
 	struct i2c_force_data *forces;
@@ -78,7 +74,6 @@ struct i2c_address_data {
                       "List of adapter,address pairs not to scan"); \
 	static struct i2c_address_data addr_data = {			\
 			.normal_i2c =		normal_i2c,		\
-			.normal_isa =		normal_isa,		\
 			.probe =		probe,			\
 			.ignore =		ignore,			\
 			.forces =		forces,			\
@@ -242,8 +237,7 @@ struct i2c_address_data {
 
 /* Detect function. It iterates over all possible addresses itself. For
    SMBus addresses, it will only call found_proc if some client is connected
-   to the SMBus (unless a 'force' matched); for ISA detections, this is not
-   done. */
+   to the SMBus (unless a 'force' matched). */
 extern int i2c_detect(struct i2c_adapter *adapter,
 		      struct i2c_address_data *address_data,
 		      int (*found_proc) (struct i2c_adapter *, int, int));
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -150,12 +150,9 @@ struct i2c_driver {
  */
 struct i2c_client {
 	unsigned int flags;		/* div., see below		*/
-	unsigned int addr;		/* chip address - NOTE: 7bit 	*/
+	unsigned short addr;		/* chip address - NOTE: 7bit 	*/
 					/* addresses are stored in the	*/
-					/* _LOWER_ 7 bits of this char	*/
-	/* addr: unsigned int to make lm_sensors i2c-isa adapter work
-	  more cleanly. It does not take any more memory space, due to
-	  alignment considerations */
+					/* _LOWER_ 7 bits		*/
 	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
 	struct i2c_driver *driver;	/* and our access routines	*/
 	int usage_count;		/* How many accesses currently  */
@@ -309,7 +306,6 @@ struct i2c_client_address_data {
 
 /* Internal numbers to terminate lists */
 #define I2C_CLIENT_END		0xfffeU
-#define I2C_CLIENT_ISA_END	0xfffefffeU
 
 /* The numbers to use to set I2C bus address */
 #define ANY_I2C_BUS		0xffff

