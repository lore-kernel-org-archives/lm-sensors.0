From: brix@gentoo.org (Henrik Brix Andersen)
Date: Mon, 15 Aug 2005 18:41:18 +0000
Subject: [lm-sensors] Re: [PATCH] Add pc87360 to sensord
Message-Id: <1124124060.20576.16.camel@sponge.fungus>
List-Id: <lm-sensors.vger.kernel.org>
References: <1124042888.13656.32.camel@sponge.fungus>
In-Reply-To: <1124042888.13656.32.camel@sponge.fungus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2005-08-14 at 20:08 +0200, Henrik Brix Andersen wrote:
> Here's a patch for adding information about the PC8736x family of chips
> to sensord.

Jean Delvare reviewed my patch and we discussed a few things on IRC.
Here's an updated patch for inclusion.


Signed-off-by: Henrik Brix Andersen


Index: prog/sensord/chips.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/chips.c,v
retrieving revision 1.17
diff -u -p -r1.17 chips.c
--- prog/sensord/chips.c	16 Jun 2005 15:32:46 -0000	1.17
+++ prog/sensord/chips.c	15 Aug 2005 16:22:27 -0000
@@ -1051,6 +1051,93 @@ static const ChipDescriptor eeprom_chip 
   eeprom_names, eeprom_features, 0, 0
 };
 
+/** PC87360 **/
+
+static const char *
+fmtTemps_PC87360_0
+(const double values[], int alarm, int beep) {
+  sprintf (buff, "%.0f C (min = %.0f C, max = %.0f, crit = %.0f C)",
+	   values[0], values[1], values[2], values[3]);
+  return fmtExtra (alarm, beep);
+}
+
+static const char *
+fmtTemps_PC87360_1
+(const double values[], int alarm, int beep) {
+  sprintf (buff, "%.1f C (min = %.1f C, max = %.1f, crit = %.1f C)",
+	   values[0], values[1], values[2], values[3]);
+  return fmtExtra (alarm, beep);
+}
+
+static const char *pc87360_names[] = {
+  SENSORS_PC87360_PREFIX,
+  SENSORS_PC87363_PREFIX,
+  SENSORS_PC87364_PREFIX,
+  SENSORS_PC87365_PREFIX,
+  SENSORS_PC87366_PREFIX,
+  NULL
+};
+
+static const FeatureDescriptor pc87360_features[] = {
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_PC87360_FAN1, SENSORS_PC87360_FAN1_MIN, SENSORS_PC87360_FAN1_DIV, -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_PC87360_FAN2, SENSORS_PC87360_FAN2_MIN, SENSORS_PC87360_FAN2_DIV, -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, 0, 0,
+    { SENSORS_PC87360_FAN3, SENSORS_PC87360_FAN3_MIN, SENSORS_PC87360_FAN3_DIV, -1 } },
+
+  { fmtTemps_PC87360_0, rrdF0, DataType_temperature, SENSORS_PC87360_ALARMS_TEMP, 0,
+    { SENSORS_PC87360_TEMP1, SENSORS_PC87360_TEMP1_MIN, SENSORS_PC87360_TEMP1_MAX,
+      SENSORS_PC87360_TEMP1_CRIT, -1 } },
+  { fmtTemps_PC87360_0, rrdF0, DataType_temperature, SENSORS_PC87360_ALARMS_TEMP, 0,
+    { SENSORS_PC87360_TEMP2, SENSORS_PC87360_TEMP2_MIN, SENSORS_PC87360_TEMP2_MAX,
+      SENSORS_PC87360_TEMP2_CRIT, -1 } },
+  { fmtTemps_PC87360_0, rrdF0, DataType_temperature, SENSORS_PC87360_ALARMS_TEMP, 0,
+    { SENSORS_PC87360_TEMP3, SENSORS_PC87360_TEMP3_MIN, SENSORS_PC87360_TEMP3_MAX,
+      SENSORS_PC87360_TEMP3_CRIT, -1 } },
+  { fmtTemps_PC87360_1, rrdF1, DataType_temperature, SENSORS_PC87360_ALARMS_TEMP, 0,
+    { SENSORS_PC87360_TEMP4, SENSORS_PC87360_TEMP4_MIN, SENSORS_PC87360_TEMP4_MAX,
+      SENSORS_PC87360_TEMP4_CRIT, -1 } },
+  { fmtTemps_PC87360_1, rrdF1, DataType_temperature, SENSORS_PC87360_ALARMS_TEMP, 0,
+    { SENSORS_PC87360_TEMP5, SENSORS_PC87360_TEMP5_MIN, SENSORS_PC87360_TEMP5_MAX,
+      SENSORS_PC87360_TEMP5_CRIT, -1 } },
+  { fmtTemps_PC87360_1, rrdF1, DataType_temperature, SENSORS_PC87360_ALARMS_TEMP, 0,
+    { SENSORS_PC87360_TEMP6, SENSORS_PC87360_TEMP6_MIN, SENSORS_PC87360_TEMP6_MAX,
+      SENSORS_PC87360_TEMP6_CRIT, -1 } },
+
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN0, SENSORS_PC87360_IN0_MIN, SENSORS_PC87360_IN0_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN1, SENSORS_PC87360_IN1_MIN, SENSORS_PC87360_IN1_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN2, SENSORS_PC87360_IN2_MIN, SENSORS_PC87360_IN2_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN3, SENSORS_PC87360_IN3_MIN, SENSORS_PC87360_IN3_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN4, SENSORS_PC87360_IN4_MIN, SENSORS_PC87360_IN4_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN5, SENSORS_PC87360_IN5_MIN, SENSORS_PC87360_IN5_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN6, SENSORS_PC87360_IN6_MIN, SENSORS_PC87360_IN6_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN7, SENSORS_PC87360_IN7_MIN, SENSORS_PC87360_IN7_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN8, SENSORS_PC87360_IN8_MIN, SENSORS_PC87360_IN8_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN9, SENSORS_PC87360_IN9_MIN, SENSORS_PC87360_IN9_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, SENSORS_PC87360_ALARMS_IN, 0,
+    { SENSORS_PC87360_IN10, SENSORS_PC87360_IN10_MIN, SENSORS_PC87360_IN10_MAX, -1 } },
+
+  { fmtVolt_3, rrdF3, DataType_voltage, 0, 0,
+    { SENSORS_PC87360_VID, -1 } },
+  { NULL }
+};
+
+static const ChipDescriptor pc87360_chip = {
+  /* No room for SENSORS_PC87360_ALARMS_TEMP */
+  pc87360_names, pc87360_features, SENSORS_PC87360_ALARMS_IN, 0
+};
+
 /** ALL **/
 
 const ChipDescriptor * const knownChips[] = {
@@ -1074,5 +1161,6 @@ const ChipDescriptor * const knownChips[
   &w83697hf_chip,
   &it87_chip,
   &asb100_chip,
+  &pc87360_chip,
   NULL
 };

-- 
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Metadistribution | Mobile computing herd
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050815/344cdfe1/attachment-0001.bin
