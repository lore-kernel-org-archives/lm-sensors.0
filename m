From: Nikola Pajkovsky <npajkovs@redhat.com>
Date: Tue, 06 Apr 2010 09:10:03 +0000
Subject: [lm-sensors] [PATCH 1/1] add FSCSYL to lm_sensors 2.10.8
Message-Id: <4BBAFA6B.3080508@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

diff -up lm_sensors-2.10.7/lib/chips.c.fscsyl lm_sensors-2.10.7/lib/chips.c
--- lm_sensors-2.10.7/lib/chips.c.fscsyl    2008-07-01
14:23:06.000000000 -0400
+++ lm_sensors-2.10.7/lib/chips.c    2009-12-09 10:05:57.000000000 -0500
@@ -6361,6 +6361,68 @@ static sensors_chip_feature fschmd_featu
     { { 0 }, 0 }
 };
 
+#define SENSORS_FSCSYL_IN_FEATURES(nr) \
+    { { SENSORS_FSCSYL_IN(nr), "in" #nr, \
+        NOMAP, NOMAP, R }, \
+        NOSYSCTL, VALUE(1), 3 }
+
+#define SENSORS_FSCSYL_TEMP_FEATURES(nr) \
+    { { SENSORS_FSCSYL_TEMP(nr), "temp" #nr, \
+        NOMAP, NOMAP, R }, \
+        NOSYSCTL, VALUE(2), 3 }, \
+    { { SENSORS_FSCSYL_TEMP_MAX(nr), "temp" #nr "_max", \
+        SENSORS_FSCSYL_TEMP(nr), SENSORS_FSCSYL_TEMP(nr), RW }, \
+        NOSYSCTL, VALUE(1), 3 }, \
+    { { SENSORS_FSCSYL_TEMP_ALARM(nr), "temp" #nr "_alarm", \
+        SENSORS_FSCSYL_TEMP(nr), NOMAP, R }, \
+        NOSYSCTL, VALUE(1), 0 }, \
+    { { SENSORS_FSCSYL_TEMP_FAULT(nr), "temp" #nr "_fault", \
+        SENSORS_FSCSYL_TEMP(nr), NOMAP, R }, \
+        NOSYSCTL, VALUE(1), 0 }
+
+#define SENSORS_FSCSYL_FAN_FEATURES(nr) \
+    { { SENSORS_FSCSYL_FAN(nr), "fan" #nr, \
+        NOMAP, NOMAP, R }, \
+        NOSYSCTL, VALUE(1), 0 }, \
+    { { SENSORS_FSCSYL_FAN_DIV(nr), "fan" #nr "_div", \
+        SENSORS_FSCSYL_FAN(nr), NOMAP, RW }, \
+        NOSYSCTL, VALUE(nr), 0 }, \
+    { { SENSORS_FSCSYL_FAN_ALARM(nr), "fan" #nr "_alarm", \
+        SENSORS_FSCSYL_FAN(nr), NOMAP, R }, \
+        NOSYSCTL, VALUE(1), 0 }, \
+    { { SENSORS_FSCSYL_FAN_FAULT(nr), "fan" #nr "_fault", \
+        SENSORS_FSCSYL_FAN(nr), NOMAP, R }, \
+        NOSYSCTL, VALUE(1), 0 }
+
+static sensors_chip_feature fscsyl_features[] +{
+    SENSORS_FSCSYL_IN_FEATURES(0),
+    SENSORS_FSCSYL_IN_FEATURES(1),
+    SENSORS_FSCSYL_IN_FEATURES(2),
+    SENSORS_FSCSYL_IN_FEATURES(3),
+    SENSORS_FSCSYL_IN_FEATURES(4),
+    SENSORS_FSCSYL_IN_FEATURES(5),
+    SENSORS_FSCSYL_TEMP_FEATURES(1),
+    SENSORS_FSCSYL_TEMP_FEATURES(2),
+    SENSORS_FSCSYL_TEMP_FEATURES(3),
+    SENSORS_FSCSYL_TEMP_FEATURES(4),
+    SENSORS_FSCSYL_TEMP_FEATURES(5),
+    SENSORS_FSCSYL_TEMP_FEATURES(6),
+    SENSORS_FSCSYL_TEMP_FEATURES(7),
+    SENSORS_FSCSYL_TEMP_FEATURES(8),
+    SENSORS_FSCSYL_TEMP_FEATURES(9),
+    SENSORS_FSCSYL_TEMP_FEATURES(10),
+    SENSORS_FSCSYL_TEMP_FEATURES(11),
+    SENSORS_FSCSYL_FAN_FEATURES(1),
+    SENSORS_FSCSYL_FAN_FEATURES(2),
+    SENSORS_FSCSYL_FAN_FEATURES(3),
+    SENSORS_FSCSYL_FAN_FEATURES(4),
+    SENSORS_FSCSYL_FAN_FEATURES(5),
+    SENSORS_FSCSYL_FAN_FEATURES(6),
+    SENSORS_FSCSYL_FAN_FEATURES(7),
+    { { 0 }, 0 }
+};
+
 static sensors_chip_feature fschrc_features[]  {
     SENSORS_FSCHMD_IN_FEATURES(0),
@@ -6496,5 +6558,6 @@ sensors_chip_features sensors_chip_featu
  { SENSORS_F71882FG_PREFIX, f71882fg_features },
  { SENSORS_FSCHMD_PREFIX, fschmd_features },
  { SENSORS_FSCHRC_PREFIX, fschrc_features },
+ { SENSORS_FSCSYL_PREFIX, fscsyl_features },
  { 0 }
 };
diff -up lm_sensors-2.10.7/lib/chips.h.fscsyl lm_sensors-2.10.7/lib/chips.h
--- lm_sensors-2.10.7/lib/chips.h.fscsyl    2008-07-01
14:23:06.000000000 -0400
+++ lm_sensors-2.10.7/lib/chips.h    2009-12-09 10:05:57.000000000 -0500
@@ -2344,6 +2344,7 @@
 /* Fujitsu Siemens Computers Heimdal and Heracles */
 #define SENSORS_FSCHMD_PREFIX        "fschmd"
 #define SENSORS_FSCHRC_PREFIX        "fschrc"
+#define SENSORS_FSCSYL_PREFIX        "fscsyl"
 
 /* Note, we start with feature numbers of 60+ to not have any overlapping
    features with the old FSCPOS, FSCSCY and FSCHER feature lists, as the
@@ -2363,4 +2364,17 @@
 #define SENSORS_FSCHMD_TEMP_ALARM(n)        (130 + (n))
 #define SENSORS_FSCHMD_TEMP_FAULT(n)        (140 + (n))
 
+/* in n from 0 to 6 */
+#define SENSORS_FSCSYL_IN(n)            (60 + (n))
+/* fan n from 1 to 7 (7 for the syl) */
+#define SENSORS_FSCSYL_FAN(n)            (70 + (n))
+#define SENSORS_FSCSYL_FAN_DIV(n)        (80 + (n))
+#define SENSORS_FSCSYL_FAN_ALARM(n)        (90 + (n))
+#define SENSORS_FSCSYL_FAN_FAULT(n)        (100 + (n))
+/* temp n from 1 to 11 (11 for the syl) */
+#define SENSORS_FSCSYL_TEMP(n)            (110 + (n))
+#define SENSORS_FSCSYL_TEMP_MAX(n)        (130 + (n))
+#define SENSORS_FSCSYL_TEMP_ALARM(n)    (150 + (n))
+#define SENSORS_FSCSYL_TEMP_FAULT(n)    (170 + (n))
+
 #endif /* def LIB_SENSORS_CHIPS_H */
diff -up lm_sensors-2.10.7/prog/detect/sensors-detect.fscsyl
lm_sensors-2.10.7/prog/detect/sensors-detect
--- lm_sensors-2.10.7/prog/detect/sensors-detect.fscsyl    2009-12-09
10:05:57.000000000 -0500
+++ lm_sensors-2.10.7/prog/detect/sensors-detect    2009-12-09
10:05:57.000000000 -0500
@@ -1148,6 +1148,12 @@ use vars qw(@pci_adapters_sis5595 @pci_a
        i2c_detect => sub { fschmd_detect(@_); },
      },
      {
+       name => "FSC Syleus",
+       driver => "fschmd",
+       i2c_addrs => [0x73],
+       i2c_detect => sub { fscsyl_detect(@_); },
+     },
+     {
        name => "FSC Heracles",
        driver => "fschmd",
        i2c_addrs => [0x73],
@@ -2527,6 +2533,7 @@ use constant SMBUS_WORD_DATA    => 3;
 
 use constant I2C_FUNC_SMBUS_QUICK    => 0x00010000;
 use constant I2C_FUNC_SMBUS_READ_BYTE    => 0x00020000;
+use constant I2C_FUNC_SMBUS_READ_BYTE_DATA      => 0x00080000;
 
 # Get the i2c adapter's functionalities
 # $_[0]: Reference to an opened filehandle
@@ -2650,6 +2657,14 @@ sub i2c_probe($$$)
     # their page protection address.
     return 0 unless ($funcs & I2C_FUNC_SMBUS_READ_BYTE);
     return i2c_smbus_access($file, SMBUS_READ, 0, SMBUS_BYTE, $data);
+  }
+  elsif ($addr = 0x73) {
+    # Special case for FSC chips, as at least the Syleus locks
+    # up with our regular probe code. Note that to our current
+    # knowledge only FSC chips live on this address, and for them
+    # this probe method is safe.
+    return 0 unless ($funcs & I2C_FUNC_SMBUS_READ_BYTE_DATA);
+    return i2c_smbus_access($file, SMBUS_READ, 0, SMBUS_BYTE_DATA, $data);
   } else {
     return 0 unless ($funcs & I2C_FUNC_SMBUS_QUICK);
     return i2c_smbus_access($file, SMBUS_WRITE, 0, SMBUS_QUICK, $data);
@@ -4979,6 +4994,27 @@ sub fschmd_detect
 # $_[1]: Address
 # Returns: undef if not detected, (8) if detected.
 # Registers used:
+#   0x00-0x02: Identification ('S', 'Y', 'L')
+sub fscsyl_detect
+{
+  my ($file, $addr) = @_;
+  # check the first 3 registers
+  if (i2c_smbus_read_byte_data($file, 0x00) != 0x53) {
+      return;
+  }
+  if (i2c_smbus_read_byte_data($file, 0x01) != 0x59) {
+      return;
+  }
+  if (i2c_smbus_read_byte_data($file, 0x02) != 0x4c) {
+      return;
+  }
+  return (8);
+}
+
+# $_[0]: A reference to the file descriptor to access this chip.
+# $_[1]: Address
+# Returns: undef if not detected, (8) if detected.
+# Registers used:
 #   0x00-0x02: Identification ('H', 'R', 'C')
 sub fschrc_detect
 {
diff -up lm_sensors-2.10.7/prog/sensors/chips.c.fscsyl
lm_sensors-2.10.7/prog/sensors/chips.c
--- lm_sensors-2.10.7/prog/sensors/chips.c.fscsyl    2008-07-01
14:23:07.000000000 -0400
+++ lm_sensors-2.10.7/prog/sensors/chips.c    2009-12-09
10:09:09.000000000 -0500
@@ -6416,6 +6416,89 @@ void print_fschmd(const sensors_chip_nam
                       SENSORS_FSCHMD_TEMP_MAX(i));
 }
 
+static void print_fscsyl_in(const sensors_chip_name *name, int i,
+  int in_feature)
+{
+  char *label;
+  double cur;
+  int valid;
+
+  if (!sensors_get_label_and_valid(*name, in_feature, &label, &valid) &&
+      !sensors_get_feature(*name, in_feature, &cur)) {
+    if (valid) {
+      print_label(label, 10);
+      printf("%+6.2f V\n", cur);
+    }
+  }
+  free(label);
+}
+
+static void print_fscsyl_fan(const sensors_chip_name *name, int i,
+  int fan_feature, int fan_div_feature)
+{
+  char *label;
+  double cur, fdiv, alarm, fault;
+  int valid;
+
+  if (!sensors_get_label_and_valid(*name, fan_feature, &label, &valid) &&
+      !sensors_get_feature(*name, fan_feature, &cur) &&
+      !sensors_get_feature(*name, fan_div_feature, &fdiv) &&
+      !sensors_get_feature(*name, SENSORS_FSCSYL_FAN_ALARM(i), &alarm) &&
+      !sensors_get_feature(*name, SENSORS_FSCSYL_FAN_FAULT(i), &fault)) {
+    if (valid) {
+      print_label(label, 10);
+      if (fault)
+        printf("   FAULT\n");
+      else
+        printf("%4.0f RPM  (div = %1.0f)  %s\n", cur, fdiv,
+               alarm ? "ALARM" : "");
+    }
+  }
+  free(label);
+}
+
+static void print_fscsyl_temp(const sensors_chip_name *name, int i,
+  int temp_feature, int temp_max_feature)
+{
+  char *label;
+  double cur, max, alarm, fault;
+  int valid;
+
+  if (!sensors_get_label_and_valid(*name, temp_feature, &label, &valid) &&
+      !sensors_get_feature(*name, temp_feature, &cur) &&
+      (!temp_max_feature ||
+       !sensors_get_feature(*name, temp_max_feature, &max)) &&
+      !sensors_get_feature(*name, SENSORS_FSCSYL_TEMP_ALARM(i), &alarm) &&
+      !sensors_get_feature(*name, SENSORS_FSCSYL_TEMP_FAULT(i), &fault)) {
+    if (valid) {
+      print_label(label, 10);
+      if (fault)
+        printf("   FAULT\n");
+      else {
+        print_temp_info(cur, max, 0, MAXONLY, 1, 1);
+        printf("%s\n", alarm ? "ALARM" : "");
+      }
+    }
+  }
+  free(label);
+}
+
+void print_fscsyl(const sensors_chip_name *name)
+{
+  int i;
+
+  for (i = 0; i <= 5; i++)
+    print_fscsyl_in(name, i, SENSORS_FSCSYL_IN(i));
+
+  for (i = 1; i <= 7; i++)
+    print_fscsyl_fan(name, i, SENSORS_FSCSYL_FAN(i),
+                     SENSORS_FSCSYL_FAN_DIV(i));
+
+  for (i = 1; i <= 11; i++)
+    print_fscsyl_temp(name, i, SENSORS_FSCSYL_TEMP(i),
+                      SENSORS_FSCSYL_TEMP_MAX(i));
+}
+
 void print_fscpos_fschmd(const sensors_chip_name *name)
 {
   int i;
diff -up lm_sensors-2.10.7/prog/sensors/chips.h.fscsyl
lm_sensors-2.10.7/prog/sensors/chips.h
--- lm_sensors-2.10.7/prog/sensors/chips.h.fscsyl    2008-07-01
14:23:07.000000000 -0400
+++ lm_sensors-2.10.7/prog/sensors/chips.h    2009-12-09
10:05:57.000000000 -0500
@@ -85,5 +85,5 @@ extern void print_fschmd(const sensors_c
 extern void print_fscpos_fschmd(const sensors_chip_name *name);
 extern void print_fscscy_fschmd(const sensors_chip_name *name);
 extern void print_fscher_fschmd(const sensors_chip_name *name);
-
+extern void print_fscsyl(const sensors_chip_name *name);
 #endif /* def PROG_SENSORS_CHIPS_H */
diff -up lm_sensors-2.10.7/prog/sensors/main.c.fscsyl
lm_sensors-2.10.7/prog/sensors/main.c
--- lm_sensors-2.10.7/prog/sensors/main.c.fscsyl    2008-07-01
14:23:07.000000000 -0400
+++ lm_sensors-2.10.7/prog/sensors/main.c    2009-12-09
10:05:57.000000000 -0500
@@ -433,6 +433,7 @@ static struct match matches[] = {
     { "adm1022", print_thmc50 },
     { "fschmd", print_fschmd },
     { "fschrc", print_fschmd },
+    { "fscsyl", print_fscsyl },
     { NULL, NULL }
 };

-- 
Nikola


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
