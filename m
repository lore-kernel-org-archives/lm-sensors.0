From: dplatt@radagast.org (Dave Platt)
Date: Thu, 04 Jan 2007 01:39:12 +0000
Subject: [lm-sensors] W83627EHF and K8 support patch
Message-Id: <courier.459C5AC6.00006D6A@radagast.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, all.  After buying an MSI K8MM3-V motherboard and Sempron
CPU, I found it expedient to add some additional support to the
sensors package in order to monitor things properly.

The attached patch updates the lib/chips.c file in the 2.10.1 
distribution, adding support for the W83627EHF voltage-sensing inputs, 
and adding support for the "k8temp" PCI-bus temperature sensor
(which I assume is actually a sense diode on the K8 CPU itself...
it reacts very quickly indeed to CPU-load changes).

It's entirely possible that these changes duplicate or conflict
with changes someone else has made since 2.10.1 was shipped...
I haven't checked.

Also attached are the relevant parts of my /etc/sensors.conf
file.

With these changes in place, sensord is capable of logging
and round-robin'ing all three of this motherboard's temperature
sensors, both fan speeds, and all of the voltages.

-------------- next part --------------
diff -u -r lm_sensors-2.10.1/prog/sensord/chips.c lm_sensors-2.10.1-k8/prog/sensord/chips.c
--- lm_sensors-2.10.1/prog/sensord/chips.c	2006-09-24 15:30:10.000000000 -0700
+++ lm_sensors-2.10.1-k8/prog/sensord/chips.c	2007-01-03 15:52:36.000000000 -0800
@@ -83,6 +83,13 @@
 }
 
 static const char *
+fmtTemp_only
+(const double values[], int alarm, int beep) {
+  sprintf (buff, "%.1f C", values[0]);
+  return fmtExtra (alarm, beep);
+}
+
+static const char *
 fmtTemps_minmax_0
 (const double values[], int alarm, int beep) {
  sprintf (buff, "%.0f C (min = %.0f C, max = %.0f C)", values[0], values[1], values[2]);
@@ -1116,6 +1123,26 @@
     { SENSORS_W83627EHF_TEMP2, SENSORS_W83627EHF_TEMP2_OVER, SENSORS_W83627EHF_TEMP2_HYST, -1 } },
   { fmtTemps_1, rrdF1, DataType_temperature, 0, 0,
     { SENSORS_W83627EHF_TEMP3, SENSORS_W83627EHF_TEMP3_OVER, SENSORS_W83627EHF_TEMP3_HYST, -1 } },
+   /* dplatt added the following by cribbing from the pc87360 definitions... */
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83627EHF_IN0, SENSORS_W83627EHF_IN0_MIN, SENSORS_W83627EHF_IN0_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83627EHF_IN1, SENSORS_W83627EHF_IN1_MIN, SENSORS_W83627EHF_IN1_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83627EHF_IN2, SENSORS_W83627EHF_IN2_MIN, SENSORS_W83627EHF_IN2_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83627EHF_IN3, SENSORS_W83627EHF_IN3_MIN, SENSORS_W83627EHF_IN3_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83627EHF_IN4, SENSORS_W83627EHF_IN4_MIN, SENSORS_W83627EHF_IN4_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83627EHF_IN5, SENSORS_W83627EHF_IN5_MIN, SENSORS_W83627EHF_IN5_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83627EHF_IN6, SENSORS_W83627EHF_IN6_MIN, SENSORS_W83627EHF_IN6_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83627EHF_IN7, SENSORS_W83627EHF_IN7_MIN, SENSORS_W83627EHF_IN7_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, 0, 0,
+    { SENSORS_W83627EHF_IN8, SENSORS_W83627EHF_IN8_MIN, SENSORS_W83627EHF_IN8_MAX, -1 } },
+   
   { NULL }
 };
 
@@ -1168,6 +1195,22 @@
   f71805f_names, f71805f_features, SENSORS_F71805F_ALARMS_TEMP, 0
 };
 
+/** k8temp **/
+
+static const char *k8temp_names[] = {
+  SENSORS_K8TEMP_PREFIX, NULL
+};
+
+static const FeatureDescriptor k8temp_features[] = {
+  { fmtTemp_only, rrdF0, DataType_temperature, 0, 0,
+    { SENSORS_K8TEMP_TEMP1, SENSORS_K8TEMP_TEMP1, SENSORS_K8TEMP_TEMP1, -1 } },
+  { NULL }
+};
+
+static const ChipDescriptor k8temp_chip = {
+  k8temp_names, k8temp_features, 0, 0
+};
+
 /** ALL **/
 
 const ChipDescriptor * const knownChips[] = {
@@ -1193,5 +1236,6 @@
   &pc87360_chip,
   &w83627ehf_chip,
   &f71805f_chip,
+  &k8temp_chip,
   NULL
 };
-------------- next part --------------


-------------- next part --------------
# Winbond W83627EHF configuration originally contributed by Leon Moonen 
# This is for an Asus P5P800, voltages for A8V-E SE. 
chip "w83627ehf-*" 
 
    label in0 "VCore"
    label in1 "12V"
    label in2 "AVCC" 
    label in3 "3VCC"
    label in6 "5V"
    label in7 "VSB" 
    label in8 "VBAT" 

# +12V is in1 and +5V is in6 as recommended by datasheet  
    compute in1 @*(1+(56/10)),  @/(1+(56/10)) 
    compute in6 @*(1+(22/10)),  @/(1+(22/10)) 
    set in1_min   12.0*0.9 
    set in1_max   12.0*1.1 
    set in6_min   5.0*0.95 
    set in6_max   5.0*1.05 
 
# Set the 3.3V 
    set in2_min   3.3*0.95 
    set in2_max   3.3*1.05 
    set in3_min   3.3*0.95 
    set in3_max   3.3*1.05 
    set in7_min   3.3*0.95 
    set in7_max   3.3*1.05 
    set in8_min   3.3*0.95 
    set in8_max   3.3*1.05
    
    ignore in4
    ignore in5
    ignore in9

# Fans 
   label fan1      "Case Fan" 
   label fan2      "CPU Fan" 
   label fan3      "Aux Fan"
   ignore fan3
   ignore fan4
   ignore fan5
   
# Both fans are PWM-controlled - the front fan by the fancontrol
# daemon, and the CPU fan by the ACPI BIOS.

   set fan1_min 800
   set fan2_min 1500

   label temp1     "Sys Temp" 
   label temp2     "CPU Temp" 
   label temp3     "AUX Temp"
   
   ignore temp3 
   set temp1_over  55
   set temp1_hyst  50 

#  set temp2_over  45 
#  set temp2_hyst  40 

chip "k8temp-pci-*"

   label temp1     "Chip temp"
   ignore temp2
   ignore temp3
   ignore temp4
   
-------------- next part --------------


