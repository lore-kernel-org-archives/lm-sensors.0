From: Nikola Pajkovsky <npajkovs@redhat.com>
Date: Tue, 06 Apr 2010 09:12:08 +0000
Subject: [lm-sensors] [PATCH 1/1] add FSCHDS to lm_sensors-2.10.8
Message-Id: <4BBAFAE8.30505@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

diff -up lm_sensors-2.10.7/lib/chips.c.fschds lm_sensors-2.10.7/lib/chips.c
--- lm_sensors-2.10.7/lib/chips.c.fschds    2009-12-07
10:04:23.000000000 -0500
+++ lm_sensors-2.10.7/lib/chips.c    2009-12-07 10:04:23.000000000 -0500
@@ -6423,6 +6423,24 @@ static sensors_chip_feature fscsyl_featu
     { { 0 }, 0 }
 };
 
+static sensors_chip_feature fschds_features[] +{
+    SENSORS_FSCHMD_IN_FEATURES(0),
+    SENSORS_FSCHMD_IN_FEATURES(1),
+    SENSORS_FSCHMD_IN_FEATURES(2),
+    SENSORS_FSCHMD_TEMP_FEATURES(1),
+    SENSORS_FSCHMD_TEMP_FEATURES(2),
+    SENSORS_FSCHMD_TEMP_FEATURES(3),
+    SENSORS_FSCHMD_TEMP_FEATURES(4),
+    SENSORS_FSCHMD_TEMP_FEATURES(5),
+    SENSORS_FSCHMD_FAN_FEATURES(1),
+    SENSORS_FSCHMD_FAN_FEATURES(2),
+    SENSORS_FSCHMD_FAN_FEATURES(3),
+    SENSORS_FSCHMD_FAN_FEATURES(4),
+    SENSORS_FSCHMD_FAN_FEATURES(5),
+    { { 0 }, 0 }
+};
+
 static sensors_chip_feature fschrc_features[]  {
     SENSORS_FSCHMD_IN_FEATURES(0),
@@ -6559,5 +6577,6 @@ sensors_chip_features sensors_chip_featu
  { SENSORS_FSCHMD_PREFIX, fschmd_features },
  { SENSORS_FSCHRC_PREFIX, fschrc_features },
  { SENSORS_FSCSYL_PREFIX, fscsyl_features },
+ { SENSORS_FSCHDS_PREFIX, fschds_features },
  { 0 }
 };
diff -up lm_sensors-2.10.7/lib/chips.h.fschds lm_sensors-2.10.7/lib/chips.h
--- lm_sensors-2.10.7/lib/chips.h.fschds    2009-12-07
10:04:23.000000000 -0500
+++ lm_sensors-2.10.7/lib/chips.h    2009-12-07 10:04:23.000000000 -0500
@@ -2345,6 +2345,7 @@
 #define SENSORS_FSCHMD_PREFIX        "fschmd"
 #define SENSORS_FSCHRC_PREFIX        "fschrc"
 #define SENSORS_FSCSYL_PREFIX        "fscsyl"
+#define SENSORS_FSCHDS_PREFIX        "fschds"
 
 /* Note, we start with feature numbers of 60+ to not have any overlapping
    features with the old FSCPOS, FSCSCY and FSCHER feature lists, as the
diff -up lm_sensors-2.10.7/prog/detect/sensors-detect.fschds
lm_sensors-2.10.7/prog/detect/sensors-detect
--- lm_sensors-2.10.7/prog/detect/sensors-detect.fschds    2009-12-07
10:04:23.000000000 -0500
+++ lm_sensors-2.10.7/prog/detect/sensors-detect    2009-12-07
10:04:23.000000000 -0500
@@ -1154,6 +1154,12 @@ use vars qw(@pci_adapters_sis5595 @pci_a
        i2c_detect => sub { fscsyl_detect(@_); },
      },
      {
+       name => "FSC Hades",
+       driver => "fschmd",
+       i2c_addrs => [0x73],
+       i2c_detect => sub { fschds_detect(@_); },
+     },
+     {
        name => "FSC Heracles",
        driver => "fschmd",
        i2c_addrs => [0x73],
@@ -5015,6 +5021,27 @@ sub fscsyl_detect
 # $_[1]: Address
 # Returns: undef if not detected, (8) if detected.
 # Registers used:
+#   0x00-0x02: Identification ('H', 'D', 'S')
+sub fschds_detect
+{
+  my ($file, $addr) = @_;
+  # check the first 3 registers
+  if (i2c_smbus_read_byte_data($file, 0x00) != 0x48) {
+      return;
+  }
+  if (i2c_smbus_read_byte_data($file, 0x01) != 0x44) {
+      return;
+  }
+  if (i2c_smbus_read_byte_data($file, 0x02) != 0x53) {
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
diff -up lm_sensors-2.10.7/prog/sensors/chips.c.fschds
lm_sensors-2.10.7/prog/sensors/chips.c
--- lm_sensors-2.10.7/prog/sensors/chips.c.fschds    2009-12-07
10:04:23.000000000 -0500
+++ lm_sensors-2.10.7/prog/sensors/chips.c    2009-12-07
10:04:23.000000000 -0500
@@ -6505,6 +6505,22 @@ void print_fscsyl(const sensors_chip_nam
                       SENSORS_FSCSYL_TEMP_MAX(i));
 }
 
+void print_fschds(const sensors_chip_name *name)
+{
+  int i;
+
+  for (i = 0; i <= 2; i++)
+    print_fschmd_in(name, i, SENSORS_FSCHMD_IN(i));
+
+  for (i = 1; i <= 5; i++)
+    print_fschmd_fan(name, i, SENSORS_FSCHMD_FAN(i),
+                     SENSORS_FSCHMD_FAN_DIV(i));
+
+  for (i = 1; i <= 5; i++)
+    print_fschmd_temp(name, i, SENSORS_FSCHMD_TEMP(i),
+                      SENSORS_FSCHMD_TEMP_MAX(i));
+}
+
 void print_fscpos_fschmd(const sensors_chip_name *name)
 {
   int i;
diff -up lm_sensors-2.10.7/prog/sensors/chips.h.fschds
lm_sensors-2.10.7/prog/sensors/chips.h
--- lm_sensors-2.10.7/prog/sensors/chips.h.fschds    2009-12-07
10:04:23.000000000 -0500
+++ lm_sensors-2.10.7/prog/sensors/chips.h    2009-12-07
10:04:23.000000000 -0500
@@ -86,4 +86,5 @@ extern void print_fscpos_fschmd(const se
 extern void print_fscscy_fschmd(const sensors_chip_name *name);
 extern void print_fscher_fschmd(const sensors_chip_name *name);
 extern void print_fscsyl(const sensors_chip_name *name);
+extern void print_fschds(const sensors_chip_name *name);
 #endif /* def PROG_SENSORS_CHIPS_H */
diff -up lm_sensors-2.10.7/prog/sensors/main.c.fschds
lm_sensors-2.10.7/prog/sensors/main.c
--- lm_sensors-2.10.7/prog/sensors/main.c.fschds    2009-12-07
10:04:23.000000000 -0500
+++ lm_sensors-2.10.7/prog/sensors/main.c    2009-12-07
10:04:57.000000000 -0500
@@ -434,6 +434,7 @@ static struct match matches[] = {
     { "fschmd", print_fschmd },
     { "fschrc", print_fschmd },
     { "fscsyl", print_fscsyl },
+    { "fschds", print_fschds },
     { NULL, NULL }
 };
 

-- 
Nikola


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
