From: Daniel J Blueman <daniel.blueman@gmail.com>
Date: Sun, 20 Sep 2009 15:00:46 +0000
Subject: [lm-sensors] [PATCH] w83627ehf updates...
Message-Id: <6278d2220909200800y73eee132n83c83b08f9714d31@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Perhaps this [1] is eligible for the 2.6.32 merge window still? Let me
know if any further tweaking is needed.

Thanks,
  Daniel

--- [1]

Add control of fan minimum turn-on output levels, decoupling it from
the fan turn-off output level. Add control of rate of change of fan
output level. These in turn allow lower turn-off rotor speed and
smoother transitions for better thermal and acoustic control
authority. Add support for constant fan speed and
proportional-response operations modes.

Signed-off-by: Daniel J Blueman <daniel.blueman@gmail.com>

diff --git a/Documentation/hwmon/w83627ehf b/Documentation/hwmon/w83627ehf
index 02b7489..b7e42ec 100644
--- a/Documentation/hwmon/w83627ehf
+++ b/Documentation/hwmon/w83627ehf
@@ -81,8 +81,14 @@ pwm[1-4] - this file stores PWM duty cycle or DC
value (fan speed) in range:
=A0 =A0 =A0 =A0 =A0 0 (stop) to 255 (full)

=A0pwm[1-4]_enable - this file controls mode of fan/temperature control:
- =A0 =A0 =A0 * 1 Manual Mode, write to pwm file any value 0-255 (full spee=
d)
- =A0 =A0 =A0 * 2 Thermal Cruise
+ =A0 =A0 =A0 * 1 Manual mode, write to pwm file any value 0-255 (full spee=
d)
+ =A0 =A0 =A0 * 2 "Thermal Cruise" mode
+ =A0 =A0 =A0 * 3 "Fan Speed Cruise" mode
+ =A0 =A0 =A0 * 4 "Smart Fan III" mode
+
+pwm[1-4]_mode - controls if output is PWM or DC level
+ =A0 =A0 =A0 =A0* 0 DC output (0 - 12v)
+ =A0 =A0 =A0 =A0* 1 PWM output

=A0Thermal Cruise mode
=A0-------------------
diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 0e97469..ecfba13 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -5,6 +5,7 @@
=A0 =A0 Copyright (C) 2006 =A0Yuan Mu (Winbond),
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Rudolf Marek <r.marek@assem=
bler.cz>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 David Hubbard <david.c.hubb=
ard@gmail.com>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Daniel J Blueman <daniel.b=
lueman@gmail.com>

=A0 =A0 Shamelessly ripped from the w83627hf driver
=A0 =A0 Copyright (C) 2003 =A0Mark Studebaker
@@ -177,12 +178,15 @@ static const u16 W83627EHF_REG_TEMP_CONFIG[] =3D {
0x152, 0x252 };
=A0#define W83627EHF_REG_ALARM3 =A0 =A0 =A0 =A0 =A0 0x45B

=A0/* SmartFan registers */
+#define W83627EHF_REG_FAN_STEPUP_TIME 0x0f
+#define W83627EHF_REG_FAN_STEPDOWN_TIME 0x0e
+
=A0/* DC or PWM output fan configuration */
=A0static const u8 W83627EHF_REG_PWM_ENABLE[] =3D {
=A0 =A0 =A0 =A00x04, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* SYS FAN0 output=
 mode and PWM mode */
=A0 =A0 =A0 =A00x04, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CPU FAN0 output=
 mode and PWM mode */
=A0 =A0 =A0 =A00x12, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* AUX FAN mode */
- =A0 =A0 =A0 0x62, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CPU fan1 mode */
+ =A0 =A0 =A0 0x62, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* CPU FAN1 mode */
=A0};

=A0static const u8 W83627EHF_PWM_MODE_SHIFT[] =3D { 0, 1, 0, 6 };
@@ -193,10 +197,12 @@ static const u8 W83627EHF_REG_PWM[] =3D { 0x01,
0x03, 0x11, 0x61 };
=A0static const u8 W83627EHF_REG_TARGET[] =3D { 0x05, 0x06, 0x13, 0x63 };
=A0static const u8 W83627EHF_REG_TOLERANCE[] =3D { 0x07, 0x07, 0x14, 0x62 };

-
=A0/* Advanced Fan control, some values are common for all fans */
-static const u8 W83627EHF_REG_FAN_MIN_OUTPUT[] =3D { 0x08, 0x09, 0x15, 0x6=
4 };
-static const u8 W83627EHF_REG_FAN_STOP_TIME[] =3D { 0x0C, 0x0D, 0x17, 0x66=
 };
+static const u8 W83627EHF_REG_FAN_START_OUTPUT[] =3D { 0x0a, 0x0b, 0x16, 0=
x65 };
+static const u8 W83627EHF_REG_FAN_STOP_OUTPUT[] =3D { 0x08, 0x09, 0x15, 0x=
64 };
+static const u8 W83627EHF_REG_FAN_STOP_TIME[] =3D { 0x0c, 0x0d, 0x17, 0x66=
 };
+static const u8 W83627EHF_REG_FAN_MAX_OUTPUT[] =3D { 0xff, 0x67, 0xff, 0x6=
9 };
+static const u8 W83627EHF_REG_FAN_STEP_OUTPUT[] =3D { 0xff, 0x68, 0xff, 0x=
6a };

=A0/*
=A0* Conversions
@@ -295,14 +301,19 @@ struct w83627ehf_data {

=A0 =A0 =A0 =A0u8 pwm_mode[4]; /* 0->DC variable voltage, 1->PWM variable d=
uty cycle */
=A0 =A0 =A0 =A0u8 pwm_enable[4]; /* 1->manual
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02->thermal cruise =
(also called SmartFan I) */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A02->thermal cruise =
mode (also called SmartFan I)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A03->fan speed cruis=
e mode
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04->variable therma=
l cruise (also called
SmartFan III) */
=A0 =A0 =A0 =A0u8 pwm_num; =A0 =A0 =A0 =A0 =A0 =A0 /* number of pwm */
=A0 =A0 =A0 =A0u8 pwm[4];
=A0 =A0 =A0 =A0u8 target_temp[4];
=A0 =A0 =A0 =A0u8 tolerance[4];

- =A0 =A0 =A0 u8 fan_min_output[4]; /* minimum fan speed */
- =A0 =A0 =A0 u8 fan_stop_time[4];
+ =A0 =A0 =A0 u8 fan_start_output[4]; /* minimum fan speed when spinning up=
 */
+ =A0 =A0 =A0 u8 fan_stop_output[4]; /* minimum fan speed when spinning dow=
n */
+ =A0 =A0 =A0 u8 fan_stop_time[4]; /* time at minimum before disabling fan =
*/
+ =A0 =A0 =A0 u8 fan_max_output[4]; /* maximum fan speed */
+ =A0 =A0 =A0 u8 fan_step_output[4]; /* rate of change output value */

=A0 =A0 =A0 =A0u8 vid;
=A0 =A0 =A0 =A0u8 vrm;
@@ -529,8 +540,10 @@ static struct w83627ehf_data
*w83627ehf_update_device(struct device *dev)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0& 3) + 1;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->pwm[i] =3D w83627ehf_r=
ead_value(data,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0W83627EHF_REG_PWM[i]);
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_min_output[i] =3D w=
83627ehf_read_value(data,
-
W83627EHF_REG_FAN_MIN_OUTPUT[i]);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_start_output[i] =3D=
 w83627ehf_read_value(data,
+
W83627EHF_REG_FAN_START_OUTPUT[i]);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->fan_stop_output[i] =3D =
w83627ehf_read_value(data,
+
W83627EHF_REG_FAN_STOP_OUTPUT[i]);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->fan_stop_time[i] =3D w=
83627ehf_read_value(data,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0W83627EHF_REG_FAN_STOP_TIME[i]);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->target_temp[i] @@ -976=
,7 +989,7 @@ store_pwm_enable(struct device *dev, struct
device_attribute *attr,
=A0 =A0 =A0 =A0u32 val =3D simple_strtoul(buf, NULL, 10);
=A0 =A0 =A0 =A0u16 reg;

- =A0 =A0 =A0 if (!val || (val > 2)) =A0/* only modes 1 and 2 are supported=
 */
+ =A0 =A0 =A0 if (!val || (val > 4))
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
=A0 =A0 =A0 =A0mutex_lock(&data->update_lock);
=A0 =A0 =A0 =A0reg =3D w83627ehf_read_value(data, W83627EHF_REG_PWM_ENABLE[=
nr]);
@@ -1118,7 +1131,10 @@ store_##reg(struct device *dev, struct
device_attribute *attr, \
=A0 =A0 =A0 =A0return count; \
=A0}

-fan_functions(fan_min_output, FAN_MIN_OUTPUT)
+fan_functions(fan_start_output, FAN_START_OUTPUT)
+fan_functions(fan_stop_output, FAN_STOP_OUTPUT)
+fan_functions(fan_max_output, FAN_MAX_OUTPUT)
+fan_functions(fan_step_output, FAN_STEP_OUTPUT)

=A0#define fan_time_functions(reg, REG) \
=A0static ssize_t show_##reg(struct device *dev, struct device_attribute *a=
ttr, \
@@ -1161,8 +1177,14 @@ static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
=A0static struct sensor_device_attribute sda_sf3_arrays_fan4[] =3D {
=A0 =A0 =A0 =A0SENSOR_ATTR(pwm4_stop_time, S_IWUSR | S_IRUGO, show_fan_stop=
_time,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0store_fan_stop_time, 3),
- =A0 =A0 =A0 SENSOR_ATTR(pwm4_min_output, S_IWUSR | S_IRUGO, show_fan_min_=
output,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_min_output, 3),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm4_start_output, S_IWUSR | S_IRUGO, show_fan_st=
art_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_start_output, 3),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm4_stop_output, S_IWUSR | S_IRUGO, show_fan_sto=
p_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_stop_output, 3),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm4_max_output, S_IWUSR | S_IRUGO, show_fan_max_=
output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_max_output, 3),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm4_step_output, S_IWUSR | S_IRUGO, show_fan_ste=
p_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_step_output, 3),
=A0};

=A0static struct sensor_device_attribute sda_sf3_arrays[] =3D {
@@ -1172,12 +1194,24 @@ static struct sensor_device_attribute
sda_sf3_arrays[] =3D {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0store_fan_stop_time, 1),
=A0 =A0 =A0 =A0SENSOR_ATTR(pwm3_stop_time, S_IWUSR | S_IRUGO, show_fan_stop=
_time,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0store_fan_stop_time, 2),
- =A0 =A0 =A0 SENSOR_ATTR(pwm1_min_output, S_IWUSR | S_IRUGO, show_fan_min_=
output,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_min_output, 0),
- =A0 =A0 =A0 SENSOR_ATTR(pwm2_min_output, S_IWUSR | S_IRUGO, show_fan_min_=
output,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_min_output, 1),
- =A0 =A0 =A0 SENSOR_ATTR(pwm3_min_output, S_IWUSR | S_IRUGO, show_fan_min_=
output,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_min_output, 2),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm1_start_output, S_IWUSR | S_IRUGO, show_fan_st=
art_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_start_output, 0),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm2_start_output, S_IWUSR | S_IRUGO, show_fan_st=
art_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_start_output, 1),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm3_start_output, S_IWUSR | S_IRUGO, show_fan_st=
art_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_start_output, 2),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm1_stop_output, S_IWUSR | S_IRUGO, show_fan_sto=
p_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_stop_output, 0),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm2_stop_output, S_IWUSR | S_IRUGO, show_fan_sto=
p_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_stop_output, 1),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm3_stop_output, S_IWUSR | S_IRUGO, show_fan_sto=
p_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_stop_output, 2),
+
+ =A0 =A0 =A0 /* pwm1 and pwm3 don't support max and step settings */
+ =A0 =A0 =A0 SENSOR_ATTR(pwm2_max_output, S_IWUSR | S_IRUGO, show_fan_max_=
output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_max_output, 1),
+ =A0 =A0 =A0 SENSOR_ATTR(pwm2_step_output, S_IWUSR | S_IRUGO, show_fan_ste=
p_output,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 store_fan_step_output, 1),
=A0};

=A0static ssize_t
--
Daniel J Blueman

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
