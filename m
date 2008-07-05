From: Ken Milmore <ken@kenm.demon.co.uk>
Date: Sat, 05 Jul 2008 13:37:42 +0000
Subject: [lm-sensors] patch: asc7621 driver bug fixes
Message-Id: <486F7926.6000304@kenm.demon.co.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070602050306020506030205"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070602050306020506030205
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

George,

Here are some suggested bug fixes for the asc7621 driver source which 
you posted to lm_sensors on 29 May.
(http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023257.html)

Attached patch #1 contains the following fixes; I think these are 
relatively uncontroversial:

show_in10() : fix incorrect scaling of the 2 LSB of input voltages.

store_in8() : fix calculation overflow which was corrupting voltage limits.

store_temp62() : avoid compiler warning.

asc7621_params : correct fan1-fan4 alarm bit shifts

asc7621_params : correct wrong address for temp3_smoothing_enable

asc7621_update_device() : fix typos which were causing incorrect
scanning of the low priority registers.

Now for the more controversial bit:  I'm rather concerned about the 
asc7621_register_priorities array, which appears to be a kind of 
reverse-index by register address of what is in asc7621_params.  It 
contains information which is constant, and known at compile time so it 
would be better not to have to go through all the trouble of building it 
up in asc7621_init_client().  You might want to consider moving this 
work into the module start-up code, rather than the per-client 
initialisation; it only needs to happen once.  A better solution might 
be to remove it altogether.  I've tried to do this in the attached patch 
#2, which uses hard-coded register lists.  The result isn't exactly 
pretty, but doing it in a cleaner way will require a lot of rework on 
the rest of the module.  Anyway, see what you think.

BTW, IMHO the alarms should be read as high priority registers, and I've 
reflected this in the patch.

While I'm on, I'd like to say many thanks to you for taking the time and 
trouble to write this driver!  Given that Andigilog have provided such 
excellent documentation for these chips, it is a shame that there is 
still no support for them in the kernel and I hope that will soon be 
rectified.

Best wishes,

Ken.


--------------070602050306020506030205
Content-Type: text/plain;
 name="asc7621_patch1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asc7621_patch1.diff"

--- asc7621.c.orig	2008-07-04 20:33:09.000000000 +0100
+++ asc7621.c	2008-07-05 13:24:12.000000000 +0100
@@ -278,19 +278,16 @@
 static ssize_t show_in10(struct device *dev, struct device_attribute *attr,
                         char *buf)
 {
-       SETUP_SHOW_data_param(dev, attr);
+       u8 nr;
+       unsigned int regval;
 
-       u8 nr = sda->index;
-       u16 regval = (data->reg[param->msb[0]] * asc7621_in_scaling[nr]) / 256;
+       SETUP_SHOW_data_param(dev, attr);
 
-       /* The LSB value is a 2-bit scaling of the MSB's LSbit value.
-        * I.E.  If the maximim voltage for this input is 6640 millivolts then
-        * a MSB register value of 0 = 0mv and 255 = 6640mv.
-        * A 1 step change therefore represents 25.9mv (6640 / 256).
-        * The extra 2-bits therefore represent increments of 6.48mv.
-        */
-       regval += ((asc7621_in_scaling[nr] / 256) / 4) *
-           (data->reg[param->lsb[0]] >> 6);
+       nr = sda->index;
+       /* The LSB value is a 2-bit scaling of the MSB's LSbit value. */
+       regval = (data->reg[param->msb[0]] << 2) +
+                (data->reg[param->lsb[0]] >> 6);
+       regval = regval * asc7621_in_scaling[nr] / 256 / 4;
 
        return sprintf(buf, "%u\n", regval);
 }
@@ -311,12 +308,15 @@
 static ssize_t store_in8(struct device *dev, struct device_attribute *attr,
                         const char *buf, size_t count)
 {
+       u8 nr;
+       unsigned int reqval;
+
        SETUP_STORE_data_param(dev, attr);
 
-       u8 nr = sda->index;
-       u8 reqval = simple_strtoul(buf, NULL, 10);
-       reqval =
-           SENSORS_LIMIT(((reqval * 256) / asc7621_in_scaling[nr]), 0, 255);
+       nr = sda->index;
+       reqval = simple_strtoul(buf, NULL, 10);
+       reqval = reqval * 256 / asc7621_in_scaling[nr];
+       reqval = SENSORS_LIMIT(reqval, 0, 255);
 
        mutex_lock(&data->update_lock);
        data->reg[param->msb[0]] = reqval;
@@ -385,12 +385,14 @@
                            struct device_attribute *attr, const char *buf,
                            size_t count)
 {
+       s32 reqval;
+       s32 i, f;
+       s8 temp;
+
        SETUP_STORE_data_param(dev, attr);
 
-       s32 reqval = simple_strtol(buf, NULL, 10);
+       reqval = simple_strtol(buf, NULL, 10);
        reqval = SENSORS_LIMIT(reqval, -32000, 31750);
-       s32 i, f;
-       s8 temp;
        i = reqval / 1000;
        f = reqval - (i * 1000);
        temp = i << 2;
@@ -853,10 +855,10 @@
        PWRITE(fan3_min, 2, PRI_LOW, 0x59, 0x58, 0, 0, fan16),
        PWRITE(fan4_min, 3, PRI_LOW, 0x5b, 0x5a, 0, 0, fan16),
 
-       PREAD(fan1_alarm, 0, PRI_LOW, 0x42, 0, 0x01, 0, bitmask),
-       PREAD(fan2_alarm, 1, PRI_LOW, 0x42, 0, 0x01, 1, bitmask),
-       PREAD(fan3_alarm, 2, PRI_LOW, 0x42, 0, 0x01, 2, bitmask),
-       PREAD(fan4_alarm, 3, PRI_LOW, 0x42, 0, 0x01, 3, bitmask),
+       PREAD(fan1_alarm, 0, PRI_LOW, 0x42, 0, 0x01, 2, bitmask),
+       PREAD(fan2_alarm, 1, PRI_LOW, 0x42, 0, 0x01, 3, bitmask),
+       PREAD(fan3_alarm, 2, PRI_LOW, 0x42, 0, 0x01, 4, bitmask),
+       PREAD(fan4_alarm, 3, PRI_LOW, 0x42, 0, 0x01, 5, bitmask),
 
        PREAD(temp1_input, 0, PRI_HIGH, 0x25, 0x10, 0, 0, temp10),
        PREAD(temp2_input, 1, PRI_HIGH, 0x26, 0x15, 0, 0, temp10),
@@ -911,7 +913,7 @@
 
        PWRITE(temp1_smoothing_enable, 0, PRI_LOW, 0x62, 0, 0x01, 3, bitmask),
        PWRITE(temp2_smoothing_enable, 1, PRI_LOW, 0x63, 0, 0x01, 7, bitmask),
-       PWRITE(temp3_smoothing_enable, 2, PRI_LOW, 0x64, 0, 0x01, 3, bitmask),
+       PWRITE(temp3_smoothing_enable, 2, PRI_LOW, 0x63, 0, 0x01, 3, bitmask),
        PWRITE(temp4_smoothing_enable, 3, PRI_LOW, 0x3c, 0, 0x01, 3, bitmask),
 
        PWRITE(temp1_smoothing_time, 0, PRI_LOW, 0x62, 0, 0x07, 0, temp_st),
@@ -1047,9 +1049,9 @@
        /* Read all the low priority registers. */
 
        if (!data->valid ||
-           time_after(jiffies, data->last_high_reading + INTERVAL_LOW)) {
+           time_after(jiffies, data->last_low_reading + INTERVAL_LOW)) {
 
-               for (i = 0; i < ARRAY_SIZE(asc7621_params); i++) {
+               for (i = 0; i < ARRAY_SIZE(asc7621_register_priorities); i++) {
                        if (asc7621_register_priorities[i] == PRI_LOW) {
                                data->reg[i] =
                                    i2c_smbus_read_byte_data(client, i) & 0xff;

--------------070602050306020506030205
Content-Type: text/plain;
 name="asc7621_patch2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asc7621_patch2.diff"

--- asc7621_patch1.c	2008-07-05 13:18:01.000000000 +0100
+++ asc7621.c	2008-07-05 13:28:29.000000000 +0100
@@ -121,7 +121,6 @@
 */
 struct asc7621_param {
        struct sensor_device_attribute sda;
-       u8 priority;
        u8 msb[3];
        u8 lsb[3];
        u8 mask[3];
@@ -130,12 +129,6 @@
        char *label;
 };
 
-/*
- * This is the map that ultimately indicates whether we'll be
- * retrieving a register value or not, and at what frequency.
- */
-static u8 asc7621_register_priorities[255];
-
 static struct asc7621_data *asc7621_update_device(struct device *dev);
 
 #define read_byte(reg) (i2c_smbus_read_byte_data(client, reg) & 0xff)
@@ -783,38 +776,38 @@
  */
 #define VAA(args...) {args}
 
-#define PREAD(name, n, pri, rm, rl, m, s, r) \
+#define PREAD(name, n, rm, rl, m, s, r) \
        {.sda = SENSOR_ATTR(name, S_IRUGO, show_##r, NULL, n), \
-         .priority = pri,.msb[0] = rm, .lsb[0] = rl, .mask[0] = m, \
+         .msb[0] = rm, .lsb[0] = rl, .mask[0] = m, \
          .shift[0] = s,}
 
-#define PWRITE(name, n, pri, rm, rl, m, s, r) \
+#define PWRITE(name, n, rm, rl, m, s, r) \
        {.sda = SENSOR_ATTR(name, S_IRUGO | S_IWUSR, show_##r, store_##r, n), \
-         .priority = pri,.msb[0] = rm, .lsb[0] = rl, .mask[0] = m, \
+         .msb[0] = rm, .lsb[0] = rl, .mask[0] = m, \
          .shift[0] = s,}
 
 /*
  * PWRITEM assumes that the initializers for the .msb, .lsb, .mask and .shift
  * were created using the VAA macro.
  */
-#define PWRITEM(name, n, pri, rm, rl, m, s, r) \
+#define PWRITEM(name, n, rm, rl, m, s, r) \
        {.sda = SENSOR_ATTR(name, S_IRUGO | S_IWUSR, show_##r, store_##r, n), \
-         .priority = pri,.msb = rm, .lsb = rl, .mask = m, .shift = s,}
+         .msb = rm, .lsb = rl, .mask = m, .shift = s,}
 
 #define PCONST(name, n, v) \
        {.sda = SENSOR_ATTR(name, S_IRUGO, show_const, NULL, n), \
-         .priority = PRI_LOW, .value = v,}
+         .value = v,}
 
 #define PLABEL(name, n, v) \
        {.sda = SENSOR_ATTR(name, S_IRUGO, show_label, NULL, n), \
-         .priority = PRI_LOW, .label = v,}
+         .label = v,}
 
 static struct asc7621_param asc7621_params[] = {
-       PREAD(in0_input, 0, PRI_HIGH, 0x20, 0x13, 0, 0, in10),
-       PREAD(in1_input, 1, PRI_HIGH, 0x21, 0x18, 0, 0, in10),
-       PREAD(in2_input, 2, PRI_HIGH, 0x22, 0x11, 0, 0, in10),
-       PREAD(in3_input, 3, PRI_HIGH, 0x23, 0x12, 0, 0, in10),
-       PREAD(in4_input, 4, PRI_HIGH, 0x24, 0x14, 0, 0, in10),
+       PREAD(in0_input, 0, 0x20, 0x13, 0, 0, in10),
+       PREAD(in1_input, 1, 0x21, 0x18, 0, 0, in10),
+       PREAD(in2_input, 2, 0x22, 0x11, 0, 0, in10),
+       PREAD(in3_input, 3, 0x23, 0x12, 0, 0, in10),
+       PREAD(in4_input, 4, 0x24, 0x14, 0, 0, in10),
 
        PLABEL(in0_label, 0, "in0"),
        PLABEL(in1_label, 1, "in1"),
@@ -822,52 +815,52 @@
        PLABEL(in3_label, 3, "in3"),
        PLABEL(in4_label, 4, "in4"),
 
-       PWRITE(in0_min, 0, PRI_LOW, 0x44, 0, 0, 0, in8),
-       PWRITE(in1_min, 1, PRI_LOW, 0x46, 0, 0, 0, in8),
-       PWRITE(in2_min, 2, PRI_LOW, 0x48, 0, 0, 0, in8),
-       PWRITE(in3_min, 3, PRI_LOW, 0x4a, 0, 0, 0, in8),
-       PWRITE(in4_min, 4, PRI_LOW, 0x4c, 0, 0, 0, in8),
-
-       PWRITE(in0_max, 0, PRI_LOW, 0x45, 0, 0, 0, in8),
-       PWRITE(in1_max, 1, PRI_LOW, 0x47, 0, 0, 0, in8),
-       PWRITE(in2_max, 2, PRI_LOW, 0x49, 0, 0, 0, in8),
-       PWRITE(in3_max, 3, PRI_LOW, 0x4b, 0, 0, 0, in8),
-       PWRITE(in4_max, 4, PRI_LOW, 0x4d, 0, 0, 0, in8),
-
-       PREAD(in0_alarm, 0, PRI_LOW, 0x41, 0, 0x01, 0, bitmask),
-       PREAD(in1_alarm, 1, PRI_LOW, 0x41, 0, 0x01, 1, bitmask),
-       PREAD(in2_alarm, 2, PRI_LOW, 0x41, 0, 0x01, 2, bitmask),
-       PREAD(in3_alarm, 3, PRI_LOW, 0x41, 0, 0x01, 3, bitmask),
-       PREAD(in4_alarm, 4, PRI_LOW, 0x42, 0, 0x01, 0, bitmask),
-
-       PREAD(fan1_input, 0, PRI_HIGH, 0x29, 0x28, 0, 0, fan16),
-       PREAD(fan2_input, 1, PRI_HIGH, 0x2b, 0x2a, 0, 0, fan16),
-       PREAD(fan3_input, 2, PRI_HIGH, 0x2d, 0x2c, 0, 0, fan16),
-       PREAD(fan4_input, 3, PRI_HIGH, 0x2f, 0x2e, 0, 0, fan16),
+       PWRITE(in0_min, 0, 0x44, 0, 0, 0, in8),
+       PWRITE(in1_min, 1, 0x46, 0, 0, 0, in8),
+       PWRITE(in2_min, 2, 0x48, 0, 0, 0, in8),
+       PWRITE(in3_min, 3, 0x4a, 0, 0, 0, in8),
+       PWRITE(in4_min, 4, 0x4c, 0, 0, 0, in8),
+
+       PWRITE(in0_max, 0, 0x45, 0, 0, 0, in8),
+       PWRITE(in1_max, 1, 0x47, 0, 0, 0, in8),
+       PWRITE(in2_max, 2, 0x49, 0, 0, 0, in8),
+       PWRITE(in3_max, 3, 0x4b, 0, 0, 0, in8),
+       PWRITE(in4_max, 4, 0x4d, 0, 0, 0, in8),
+
+       PREAD(in0_alarm, 0, 0x41, 0, 0x01, 0, bitmask),
+       PREAD(in1_alarm, 1, 0x41, 0, 0x01, 1, bitmask),
+       PREAD(in2_alarm, 2, 0x41, 0, 0x01, 2, bitmask),
+       PREAD(in3_alarm, 3, 0x41, 0, 0x01, 3, bitmask),
+       PREAD(in4_alarm, 4, 0x42, 0, 0x01, 0, bitmask),
+
+       PREAD(fan1_input, 0, 0x29, 0x28, 0, 0, fan16),
+       PREAD(fan2_input, 1, 0x2b, 0x2a, 0, 0, fan16),
+       PREAD(fan3_input, 2, 0x2d, 0x2c, 0, 0, fan16),
+       PREAD(fan4_input, 3, 0x2f, 0x2e, 0, 0, fan16),
 
        PLABEL(fan1_label, 0, "fan1"),
        PLABEL(fan2_label, 1, "fan2"),
        PLABEL(fan3_label, 2, "fan3"),
        PLABEL(fan4_label, 3, "fan4"),
 
-       PWRITE(fan1_min, 0, PRI_LOW, 0x55, 0x54, 0, 0, fan16),
-       PWRITE(fan2_min, 1, PRI_LOW, 0x57, 0x56, 0, 0, fan16),
-       PWRITE(fan3_min, 2, PRI_LOW, 0x59, 0x58, 0, 0, fan16),
-       PWRITE(fan4_min, 3, PRI_LOW, 0x5b, 0x5a, 0, 0, fan16),
-
-       PREAD(fan1_alarm, 0, PRI_LOW, 0x42, 0, 0x01, 2, bitmask),
-       PREAD(fan2_alarm, 1, PRI_LOW, 0x42, 0, 0x01, 3, bitmask),
-       PREAD(fan3_alarm, 2, PRI_LOW, 0x42, 0, 0x01, 4, bitmask),
-       PREAD(fan4_alarm, 3, PRI_LOW, 0x42, 0, 0x01, 5, bitmask),
-
-       PREAD(temp1_input, 0, PRI_HIGH, 0x25, 0x10, 0, 0, temp10),
-       PREAD(temp2_input, 1, PRI_HIGH, 0x26, 0x15, 0, 0, temp10),
-       PREAD(temp3_input, 2, PRI_HIGH, 0x27, 0x16, 0, 0, temp10),
-       PREAD(temp4_input, 3, PRI_HIGH, 0x33, 0x17, 0, 0, temp10),
-       PREAD(temp5_input, 4, PRI_HIGH, 0xf7, 0xf6, 0, 0, temp10),
-       PREAD(temp6_input, 5, PRI_HIGH, 0xf9, 0xf8, 0, 0, temp10),
-       PREAD(temp7_input, 6, PRI_HIGH, 0xfb, 0xfa, 0, 0, temp10),
-       PREAD(temp8_input, 7, PRI_HIGH, 0xfd, 0xfc, 0, 0, temp10),
+       PWRITE(fan1_min, 0, 0x55, 0x54, 0, 0, fan16),
+       PWRITE(fan2_min, 1, 0x57, 0x56, 0, 0, fan16),
+       PWRITE(fan3_min, 2, 0x59, 0x58, 0, 0, fan16),
+       PWRITE(fan4_min, 3, 0x5b, 0x5a, 0, 0, fan16),
+
+       PREAD(fan1_alarm, 0, 0x42, 0, 0x01, 2, bitmask),
+       PREAD(fan2_alarm, 1, 0x42, 0, 0x01, 3, bitmask),
+       PREAD(fan3_alarm, 2, 0x42, 0, 0x01, 4, bitmask),
+       PREAD(fan4_alarm, 3, 0x42, 0, 0x01, 5, bitmask),
+
+       PREAD(temp1_input, 0, 0x25, 0x10, 0, 0, temp10),
+       PREAD(temp2_input, 1, 0x26, 0x15, 0, 0, temp10),
+       PREAD(temp3_input, 2, 0x27, 0x16, 0, 0, temp10),
+       PREAD(temp4_input, 3, 0x33, 0x17, 0, 0, temp10),
+       PREAD(temp5_input, 4, 0xf7, 0xf6, 0, 0, temp10),
+       PREAD(temp6_input, 5, 0xf9, 0xf8, 0, 0, temp10),
+       PREAD(temp7_input, 6, 0xfb, 0xfa, 0, 0, temp10),
+       PREAD(temp8_input, 7, 0xfd, 0xfc, 0, 0, temp10),
 
        PCONST(temp1_type, 0, 1),
        PCONST(temp2_type, 1, 3),
@@ -887,134 +880,176 @@
        PLABEL(temp7_label, 6, "peci 3"),
        PLABEL(temp8_label, 7, "peci 4"),
 
-       PWRITE(temp1_min, 0, PRI_LOW, 0x4e, 0, 0, 0, temp8),
-       PWRITE(temp2_min, 1, PRI_LOW, 0x50, 0, 0, 0, temp8),
-       PWRITE(temp3_min, 2, PRI_LOW, 0x52, 0, 0, 0, temp8),
-       PWRITE(temp4_min, 3, PRI_LOW, 0x34, 0, 0, 0, temp8),
-
-       PWRITE(temp1_max, 0, PRI_LOW, 0x4f, 0, 0, 0, temp8),
-       PWRITE(temp2_max, 1, PRI_LOW, 0x51, 0, 0, 0, temp8),
-       PWRITE(temp3_max, 2, PRI_LOW, 0x53, 0, 0, 0, temp8),
-       PWRITE(temp4_max, 3, PRI_LOW, 0x35, 0, 0, 0, temp8),
-
-       PREAD(temp1_alarm, 0, PRI_LOW, 0x41, 0, 0x01, 4, bitmask),
-       PREAD(temp2_alarm, 1, PRI_LOW, 0x41, 0, 0x01, 5, bitmask),
-       PREAD(temp3_alarm, 2, PRI_LOW, 0x41, 0, 0x01, 6, bitmask),
-       PREAD(temp4_alarm, 3, PRI_LOW, 0x43, 0, 0x01, 0, bitmask),
-
-       PWRITE(temp1_source, 0, PRI_LOW, 0x02, 0, 0x07, 4, bitmask),
-       PWRITE(temp2_source, 1, PRI_LOW, 0x02, 0, 0x07, 0, bitmask),
-       PWRITE(temp3_source, 2, PRI_LOW, 0x03, 0, 0x07, 4, bitmask),
-       PWRITE(temp4_source, 3, PRI_LOW, 0x03, 0, 0x07, 0, bitmask),
+       PWRITE(temp1_min, 0, 0x4e, 0, 0, 0, temp8),
+       PWRITE(temp2_min, 1, 0x50, 0, 0, 0, temp8),
+       PWRITE(temp3_min, 2, 0x52, 0, 0, 0, temp8),
+       PWRITE(temp4_min, 3, 0x34, 0, 0, 0, temp8),
+
+       PWRITE(temp1_max, 0, 0x4f, 0, 0, 0, temp8),
+       PWRITE(temp2_max, 1, 0x51, 0, 0, 0, temp8),
+       PWRITE(temp3_max, 2, 0x53, 0, 0, 0, temp8),
+       PWRITE(temp4_max, 3, 0x35, 0, 0, 0, temp8),
+
+       PREAD(temp1_alarm, 0, 0x41, 0, 0x01, 4, bitmask),
+       PREAD(temp2_alarm, 1, 0x41, 0, 0x01, 5, bitmask),
+       PREAD(temp3_alarm, 2, 0x41, 0, 0x01, 6, bitmask),
+       PREAD(temp4_alarm, 3, 0x43, 0, 0x01, 0, bitmask),
+
+       PWRITE(temp1_source, 0, 0x02, 0, 0x07, 4, bitmask),
+       PWRITE(temp2_source, 1, 0x02, 0, 0x07, 0, bitmask),
+       PWRITE(temp3_source, 2, 0x03, 0, 0x07, 4, bitmask),
+       PWRITE(temp4_source, 3, 0x03, 0, 0x07, 0, bitmask),
        PCONST(temp5_source, 4, 4),
        PCONST(temp6_source, 5, 5),
        PCONST(temp7_source, 6, 6),
        PCONST(temp8_source, 7, 7),
 
-       PWRITE(temp1_smoothing_enable, 0, PRI_LOW, 0x62, 0, 0x01, 3, bitmask),
-       PWRITE(temp2_smoothing_enable, 1, PRI_LOW, 0x63, 0, 0x01, 7, bitmask),
-       PWRITE(temp3_smoothing_enable, 2, PRI_LOW, 0x63, 0, 0x01, 3, bitmask),
-       PWRITE(temp4_smoothing_enable, 3, PRI_LOW, 0x3c, 0, 0x01, 3, bitmask),
-
-       PWRITE(temp1_smoothing_time, 0, PRI_LOW, 0x62, 0, 0x07, 0, temp_st),
-       PWRITE(temp2_smoothing_time, 1, PRI_LOW, 0x63, 0, 0x07, 4, temp_st),
-       PWRITE(temp3_smoothing_time, 2, PRI_LOW, 0x63, 0, 0x07, 0, temp_st),
-       PWRITE(temp4_smoothing_time, 3, PRI_LOW, 0x3c, 0, 0x07, 0, temp_st),
+       PWRITE(temp1_smoothing_enable, 0, 0x62, 0, 0x01, 3, bitmask),
+       PWRITE(temp2_smoothing_enable, 1, 0x63, 0, 0x01, 7, bitmask),
+       PWRITE(temp3_smoothing_enable, 2, 0x63, 0, 0x01, 3, bitmask),
+       PWRITE(temp4_smoothing_enable, 3, 0x3c, 0, 0x01, 3, bitmask),
+
+       PWRITE(temp1_smoothing_time, 0, 0x62, 0, 0x07, 0, temp_st),
+       PWRITE(temp2_smoothing_time, 1, 0x63, 0, 0x07, 4, temp_st),
+       PWRITE(temp3_smoothing_time, 2, 0x63, 0, 0x07, 0, temp_st),
+       PWRITE(temp4_smoothing_time, 3, 0x3c, 0, 0x07, 0, temp_st),
 
-       PWRITE(temp1_auto_point1_temp_hyst, 0, PRI_LOW, 0x6d, 0, 0x0f, 4,
+       PWRITE(temp1_auto_point1_temp_hyst, 0, 0x6d, 0, 0x0f, 4,
               bitmask),
-       PWRITE(temp2_auto_point1_temp_hyst, 1, PRI_LOW, 0x6d, 0, 0x0f, 0,
+       PWRITE(temp2_auto_point1_temp_hyst, 1, 0x6d, 0, 0x0f, 0,
               bitmask),
-       PWRITE(temp3_auto_point1_temp_hyst, 2, PRI_LOW, 0x6e, 0, 0x0f, 4,
+       PWRITE(temp3_auto_point1_temp_hyst, 2, 0x6e, 0, 0x0f, 4,
               bitmask),
-       PWRITE(temp4_auto_point1_temp_hyst, 3, PRI_LOW, 0x6e, 0, 0x0f, 0,
+       PWRITE(temp4_auto_point1_temp_hyst, 3, 0x6e, 0, 0x0f, 0,
               bitmask),
 
-       PREAD(temp1_auto_point2_temp_hyst, 0, PRI_LOW, 0x6d, 0, 0x0f, 4,
+       PREAD(temp1_auto_point2_temp_hyst, 0, 0x6d, 0, 0x0f, 4,
              bitmask),
-       PREAD(temp2_auto_point2_temp_hyst, 1, PRI_LOW, 0x6d, 0, 0x0f, 0,
+       PREAD(temp2_auto_point2_temp_hyst, 1, 0x6d, 0, 0x0f, 0,
              bitmask),
-       PREAD(temp3_auto_point2_temp_hyst, 2, PRI_LOW, 0x6e, 0, 0x0f, 4,
+       PREAD(temp3_auto_point2_temp_hyst, 2, 0x6e, 0, 0x0f, 4,
              bitmask),
-       PREAD(temp4_auto_point2_temp_hyst, 3, PRI_LOW, 0x6e, 0, 0x0f, 0,
+       PREAD(temp4_auto_point2_temp_hyst, 3, 0x6e, 0, 0x0f, 0,
              bitmask),
 
-       PWRITE(temp1_auto_point1_temp, 0, PRI_LOW, 0x67, 0, 0, 0, temp8),
-       PWRITE(temp2_auto_point1_temp, 1, PRI_LOW, 0x68, 0, 0, 0, temp8),
-       PWRITE(temp3_auto_point1_temp, 2, PRI_LOW, 0x69, 0, 0, 0, temp8),
-       PWRITE(temp4_auto_point1_temp, 3, PRI_LOW, 0x3b, 0, 0, 0, temp8),
+       PWRITE(temp1_auto_point1_temp, 0, 0x67, 0, 0, 0, temp8),
+       PWRITE(temp2_auto_point1_temp, 1, 0x68, 0, 0, 0, temp8),
+       PWRITE(temp3_auto_point1_temp, 2, 0x69, 0, 0, 0, temp8),
+       PWRITE(temp4_auto_point1_temp, 3, 0x3b, 0, 0, 0, temp8),
 
-       PWRITEM(temp1_auto_point2_temp, 0, PRI_LOW, VAA(0x5f, 0x67), VAA(0),
+       PWRITEM(temp1_auto_point2_temp, 0, VAA(0x5f, 0x67), VAA(0),
                VAA(0x0f), VAA(4), ap2_temp),
-       PWRITEM(temp2_auto_point2_temp, 1, PRI_LOW, VAA(0x60, 0x68), VAA(0),
+       PWRITEM(temp2_auto_point2_temp, 1, VAA(0x60, 0x68), VAA(0),
                VAA(0x0f), VAA(4), ap2_temp),
-       PWRITEM(temp3_auto_point2_temp, 2, PRI_LOW, VAA(0x61, 0x69), VAA(0),
+       PWRITEM(temp3_auto_point2_temp, 2, VAA(0x61, 0x69), VAA(0),
                VAA(0x0f), VAA(4), ap2_temp),
-       PWRITEM(temp4_auto_point2_temp, 3, PRI_LOW, VAA(0x3c, 0x3b), VAA(0),
+       PWRITEM(temp4_auto_point2_temp, 3, VAA(0x3c, 0x3b), VAA(0),
                VAA(0x0f), VAA(4), ap2_temp),
 
-       PWRITE(temp1_crit, 0, PRI_LOW, 0x6a, 0, 0, 0, temp8),
-       PWRITE(temp2_crit, 1, PRI_LOW, 0x6b, 0, 0, 0, temp8),
-       PWRITE(temp3_crit, 2, PRI_LOW, 0x6c, 0, 0, 0, temp8),
-       PWRITE(temp4_crit, 3, PRI_LOW, 0x3d, 0, 0, 0, temp8),
-
-       PWRITE(temp5_enable, 4, PRI_LOW, 0x0e, 0, 0x01, 0, bitmask),
-       PWRITE(temp6_enable, 5, PRI_LOW, 0x0e, 0, 0x01, 1, bitmask),
-       PWRITE(temp7_enable, 6, PRI_LOW, 0x0e, 0, 0x01, 2, bitmask),
-       PWRITE(temp8_enable, 7, PRI_LOW, 0x0e, 0, 0x01, 3, bitmask),
-
-       PWRITE(remote1_offset, 0, PRI_LOW, 0x1c, 0, 0, 0, temp62),
-       PWRITE(remote2_offset, 1, PRI_LOW, 0x1d, 0, 0, 0, temp62),
-
-       PWRITE(pwm1, 0, PRI_HIGH, 0x30, 0, 0, 0, u8),
-       PWRITE(pwm2, 1, PRI_HIGH, 0x31, 0, 0, 0, u8),
-       PWRITE(pwm3, 2, PRI_HIGH, 0x32, 0, 0, 0, u8),
-
-       PWRITE(pwm1_invert, 0, PRI_LOW, 0x5c, 0, 0x01, 4, bitmask),
-       PWRITE(pwm2_invert, 1, PRI_LOW, 0x5d, 0, 0x01, 4, bitmask),
-       PWRITE(pwm3_invert, 2, PRI_LOW, 0x5e, 0, 0x01, 4, bitmask),
+       PWRITE(temp1_crit, 0, 0x6a, 0, 0, 0, temp8),
+       PWRITE(temp2_crit, 1, 0x6b, 0, 0, 0, temp8),
+       PWRITE(temp3_crit, 2, 0x6c, 0, 0, 0, temp8),
+       PWRITE(temp4_crit, 3, 0x3d, 0, 0, 0, temp8),
+
+       PWRITE(temp5_enable, 4, 0x0e, 0, 0x01, 0, bitmask),
+       PWRITE(temp6_enable, 5, 0x0e, 0, 0x01, 1, bitmask),
+       PWRITE(temp7_enable, 6, 0x0e, 0, 0x01, 2, bitmask),
+       PWRITE(temp8_enable, 7, 0x0e, 0, 0x01, 3, bitmask),
+
+       PWRITE(remote1_offset, 0, 0x1c, 0, 0, 0, temp62),
+       PWRITE(remote2_offset, 1, 0x1d, 0, 0, 0, temp62),
+
+       PWRITE(pwm1, 0, 0x30, 0, 0, 0, u8),
+       PWRITE(pwm2, 1, 0x31, 0, 0, 0, u8),
+       PWRITE(pwm3, 2, 0x32, 0, 0, 0, u8),
+
+       PWRITE(pwm1_invert, 0, 0x5c, 0, 0x01, 4, bitmask),
+       PWRITE(pwm2_invert, 1, 0x5d, 0, 0x01, 4, bitmask),
+       PWRITE(pwm3_invert, 2, 0x5e, 0, 0x01, 4, bitmask),
 
-       PWRITEM(pwm1_enable, 0, PRI_LOW, VAA(0x5c, 0x5c, 0x62), VAA(0, 0, 0),
+       PWRITEM(pwm1_enable, 0, VAA(0x5c, 0x5c, 0x62), VAA(0, 0, 0),
                VAA(0x07, 0x01, 0x01), VAA(5, 3, 5), pwm_enable),
-       PWRITEM(pwm2_enable, 1, PRI_LOW, VAA(0x5d, 0x5d, 0x62), VAA(0, 0, 0),
+       PWRITEM(pwm2_enable, 1, VAA(0x5d, 0x5d, 0x62), VAA(0, 0, 0),
                VAA(0x07, 0x01, 0x01), VAA(5, 3, 6), pwm_enable),
-       PWRITEM(pwm3_enable, 2, PRI_LOW, VAA(0x5e, 0x5e, 0x62), VAA(0, 0, 0),
+       PWRITEM(pwm3_enable, 2, VAA(0x5e, 0x5e, 0x62), VAA(0, 0, 0),
                VAA(0x07, 0x01, 0x01), VAA(5, 3, 7), pwm_enable),
 
-       PWRITEM(pwm1_auto_channels, 0, PRI_LOW, VAA(0x5c, 0x5c), VAA(0, 0),
+       PWRITEM(pwm1_auto_channels, 0, VAA(0x5c, 0x5c), VAA(0, 0),
                VAA(0x07, 0x01), VAA(5, 3), pwm_ac),
-       PWRITEM(pwm2_auto_channels, 1, PRI_LOW, VAA(0x5d, 0x5d), VAA(0, 0),
+       PWRITEM(pwm2_auto_channels, 1, VAA(0x5d, 0x5d), VAA(0, 0),
                VAA(0x07, 0x01), VAA(5, 3), pwm_ac),
-       PWRITEM(pwm3_auto_channels, 2, PRI_LOW, VAA(0x5e, 0x5e), VAA(0, 0),
+       PWRITEM(pwm3_auto_channels, 2, VAA(0x5e, 0x5e), VAA(0, 0),
                VAA(0x07, 0x01), VAA(5, 3), pwm_ac),
 
-       PWRITE(pwm1_auto_point1_pwm, 0, PRI_LOW, 0x64, 0, 0, 0, u8),
-       PWRITE(pwm2_auto_point1_pwm, 1, PRI_LOW, 0x65, 0, 0, 0, u8),
-       PWRITE(pwm3_auto_point1_pwm, 2, PRI_LOW, 0x66, 0, 0, 0, u8),
-
-       PWRITE(pwm1_auto_point2_pwm, 0, PRI_LOW, 0x38, 0, 0, 0, u8),
-       PWRITE(pwm2_auto_point2_pwm, 1, PRI_LOW, 0x39, 0, 0, 0, u8),
-       PWRITE(pwm3_auto_point2_pwm, 2, PRI_LOW, 0x3a, 0, 0, 0, u8),
-
-       PWRITE(pwm1_freq, 0, PRI_LOW, 0x5f, 0, 0x0f, 0, pwm_freq),
-       PWRITE(pwm2_freq, 1, PRI_LOW, 0x60, 0, 0x0f, 0, pwm_freq),
-       PWRITE(pwm3_freq, 2, PRI_LOW, 0x61, 0, 0x0f, 0, pwm_freq),
-
-       PREAD(pwm1_auto_zone_assigned, 0, PRI_LOW, 0, 0, 0x03, 2, bitmask),
-       PREAD(pwm2_auto_zone_assigned, 1, PRI_LOW, 0, 0, 0x03, 4, bitmask),
-       PREAD(pwm3_auto_zone_assigned, 2, PRI_LOW, 0, 0, 0x03, 6, bitmask),
-
-       PWRITE(pwm1_auto_spinup_time, 0, PRI_LOW, 0x5c, 0, 0x07, 0, pwm_ast),
-       PWRITE(pwm2_auto_spinup_time, 1, PRI_LOW, 0x5d, 0, 0x07, 0, pwm_ast),
-       PWRITE(pwm3_auto_spinup_time, 2, PRI_LOW, 0x5e, 0, 0x07, 0, pwm_ast),
-
-       PWRITE(peci_enable, 0, PRI_LOW, 0x40, 0, 0x01, 4, bitmask),
-       PWRITE(peci_avg, 0, PRI_LOW, 0x36, 0, 0x07, 0, bitmask),
-       PWRITE(peci_domain, 0, PRI_LOW, 0x36, 0, 0x01, 3, bitmask),
-       PWRITE(peci_legacy, 0, PRI_LOW, 0x36, 0, 0x01, 4, bitmask),
-       PWRITE(peci_diode, 0, PRI_LOW, 0x0e, 0, 0x07, 4, bitmask),
-       PWRITE(peci_4domain, 0, PRI_LOW, 0x0e, 0, 0x01, 4, bitmask),
+       PWRITE(pwm1_auto_point1_pwm, 0, 0x64, 0, 0, 0, u8),
+       PWRITE(pwm2_auto_point1_pwm, 1, 0x65, 0, 0, 0, u8),
+       PWRITE(pwm3_auto_point1_pwm, 2, 0x66, 0, 0, 0, u8),
+
+       PWRITE(pwm1_auto_point2_pwm, 0, 0x38, 0, 0, 0, u8),
+       PWRITE(pwm2_auto_point2_pwm, 1, 0x39, 0, 0, 0, u8),
+       PWRITE(pwm3_auto_point2_pwm, 2, 0x3a, 0, 0, 0, u8),
+
+       PWRITE(pwm1_freq, 0, 0x5f, 0, 0x0f, 0, pwm_freq),
+       PWRITE(pwm2_freq, 1, 0x60, 0, 0x0f, 0, pwm_freq),
+       PWRITE(pwm3_freq, 2, 0x61, 0, 0x0f, 0, pwm_freq),
+
+       PREAD(pwm1_auto_zone_assigned, 0, 0, 0, 0x03, 2, bitmask),
+       PREAD(pwm2_auto_zone_assigned, 1, 0, 0, 0x03, 4, bitmask),
+       PREAD(pwm3_auto_zone_assigned, 2, 0, 0, 0x03, 6, bitmask),
+
+       PWRITE(pwm1_auto_spinup_time, 0, 0x5c, 0, 0x07, 0, pwm_ast),
+       PWRITE(pwm2_auto_spinup_time, 1, 0x5d, 0, 0x07, 0, pwm_ast),
+       PWRITE(pwm3_auto_spinup_time, 2, 0x5e, 0, 0x07, 0, pwm_ast),
+
+       PWRITE(peci_enable, 0, 0x40, 0, 0x01, 4, bitmask),
+       PWRITE(peci_avg, 0, 0x36, 0, 0x07, 0, bitmask),
+       PWRITE(peci_domain, 0, 0x36, 0, 0x01, 3, bitmask),
+       PWRITE(peci_legacy, 0, 0x36, 0, 0x01, 4, bitmask),
+       PWRITE(peci_diode, 0, 0x0e, 0, 0x07, 4, bitmask),
+       PWRITE(peci_4domain, 0, 0x0e, 0, 0x01, 4, bitmask),
+
+};
 
+/* List of registers to poll at high priority: */
+static const u8 asc7621_reglist_high[] = {
+    0x10, 0x25,                          /* temp1_input */
+    0x15, 0x26,                          /* temp2_input */
+    0x16, 0x27,                          /* temp3_input */
+    0x17, 0x33,                          /* temp4_input */
+    0x13, 0x20,                          /* in0_input */
+    0x18, 0x21,                          /* in1_input */
+    0x11, 0x22,                          /* in2_input */
+    0x12, 0x23,                          /* in3_input */
+    0x14, 0x24,                          /* in4_input */
+    0x28, 0x29,                          /* fan1_input */
+    0x2a, 0x2b,                          /* fan2_input */
+    0x2c, 0x2d,                          /* fan3_input */
+    0x2e, 0x2f,                          /* fan4_input */
+    0x30, 0x31, 0x32,                    /* pwm1-pwm3 */
+    0x41, 0x42, 0x43,                    /* alarms */
+    0xf6, 0xf7,                          /* temp5_input */
+    0xf8, 0xf9,                          /* temp6_input */
+    0xfa, 0xfb,                          /* temp7_input */
+    0xfc, 0xfd,                          /* temp8_input */
+};
+
+/* List of registers to poll at low priority: */
+static const u8 asc7621_reglist_low[] = {
+    0x02,                                /* temp1-temp4 source */
+    0x0e,                                /* temp5-temp8 enable, peci ctrl */
+    0x1c, 0x1d,                          /* remote1-remote2 offset */
+    0x34, 0x35,                          /* temp4 min/max */
+    0x36,                                /* peci */
+    0x38, 0x39, 0x3a, 0x3b, 0x3c, 0x3d,  /* pwm control/smoothing */
+    0x40,                                /* peci_enable */
+    0x44, 0x45, 0x46, 0x47, 0x48, 0x49,  /* in0-in2 min/max */
+    0x4a, 0x4b, 0x4c, 0x4d,              /* in3-in4 min/max */
+    0x4e, 0x4f, 0x50, 0x51, 0x52, 0x53,  /* temp1-temp3 min/max */
+    0x54, 0x55, 0x56, 0x57, 0x58, 0x59, 0x5a, 0x5b, /* fan1-fan4 min */
+    0x5c, 0x5d, 0x5e, 0x5f, 0x60, 0x61,  /* pwm control */
+    0x62, 0x63, 0x64, 0x65, 0x66,        /* pwm control/smoothing */
+    0x67, 0x68, 0x69, 0x6a, 0x6b, 0x6c,  /* pwm control */
+    0x6d, 0x6e,                          /* temp1-temp4 hyst */
 };
 
 static struct asc7621_data *asc7621_update_device(struct device *dev)
@@ -1022,43 +1057,38 @@
        struct i2c_client *client = to_i2c_client(dev);
        struct asc7621_data *data = i2c_get_clientdata(client);
        int i;
+       u8 adr;
 
 /*
  * The asc7621 chips guarantee consistent reads of multi-byte values
  * regardless of the order of the reads.  No special logic is needed
  * so we can just read the registers in whatever  order they appear
- * in the asc7621_params array.
+ * in asc7621_reglist_high / asc7621_reglist_low.
  */
 
        mutex_lock(&data->update_lock);
 
        /* Read all the high priority registers */
 
-       if (!data->valid ||
-           time_after(jiffies, data->last_high_reading + INTERVAL_HIGH)) {
-
-               for (i = 0; i < ARRAY_SIZE(asc7621_register_priorities); i++) {
-                       if (asc7621_register_priorities[i] == PRI_HIGH) {
-                               data->reg[i] =
-                                   i2c_smbus_read_byte_data(client, i) & 0xff;
-                       }
-               }
-               data->last_high_reading = jiffies;
-       };                      /* last_reading */
-
-       /* Read all the low priority registers. */
+        if (!data->valid ||
+            time_after(jiffies, data->last_high_reading + INTERVAL_HIGH)) {
+                for (i = 0; i < ARRAY_SIZE(asc7621_reglist_high); i++) {
+                        adr = asc7621_reglist_high[i];
+                        data->reg[adr] =
+                            i2c_smbus_read_byte_data(client, adr) & 0xff;
+                }
+                data->last_high_reading = jiffies;
+        }
 
-       if (!data->valid ||
+        if (!data->valid ||
            time_after(jiffies, data->last_low_reading + INTERVAL_LOW)) {
-
-               for (i = 0; i < ARRAY_SIZE(asc7621_register_priorities); i++) {
-                       if (asc7621_register_priorities[i] == PRI_LOW) {
-                               data->reg[i] =
-                                   i2c_smbus_read_byte_data(client, i) & 0xff;
-                       }
-               }
-               data->last_low_reading = jiffies;
-       };                      /* last_reading */
+                for (i = 0; i < ARRAY_SIZE(asc7621_reglist_low); i++) {
+                       adr = asc7621_reglist_low[i];
+                       data->reg[adr] =
+                           i2c_smbus_read_byte_data(client, adr) & 0xff;
+                }
+                data->last_low_reading = jiffies;
+        };
 
        data->valid = 1;
 
@@ -1087,7 +1117,7 @@
 
 static void asc7621_init_client(struct i2c_client *client)
 {
-       int value, i, j;
+       int value;
 
        dev_dbg(&client->dev, "Initializing device\n");
 
@@ -1114,22 +1144,6 @@
        dev_dbg(&client->dev, "Setting READY to: 0x%02x\n", value);
        write_byte(0x40, value & 0xff);
 
-       dev_dbg(&client->dev, "Loading register arrays.\n");
-
-       /*
-        * Collect all the registers needed into a single array.
-        * This way, if a register isn't actually used for anything,
-        * we don't retrieve it.
-        */
-
-       for (i = 0; i < ARRAY_SIZE(asc7621_params); i++) {
-               for (j = 0; j < ARRAY_SIZE(asc7621_params[i].msb); j++)
-                       asc7621_register_priorities[asc7621_params[i].msb[j]] =
-                           asc7621_params[i].priority;
-               for (j = 0; j < ARRAY_SIZE(asc7621_params[i].lsb); j++)
-                       asc7621_register_priorities[asc7621_params[i].lsb[j]] =
-                           asc7621_params[i].priority;
-       }
 }
 
 static struct i2c_driver asc7621_driver;

--------------070602050306020506030205
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070602050306020506030205--
