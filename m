From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: ADM1030/ADM1031 user-space support
Message-Id: <20040520153855.5a29739c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040517100022.54fae886.khali@linux-fr.org>
In-Reply-To: <20040517100022.54fae886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Alexandre,

Here are my comments about your latest 2.4 and user-space code (from
your website, *not* from the previous post).

diff -urN -x CVS lm_sensors2/doc/chips/adm1031 lm_sensors2_mine/doc/chips/a=
dm1031
--- lm_sensors2/doc/chips/adm1031	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2_mine/doc/chips/adm1031	2004-05-18 12:59:57.000000000 +0200
@@ -0,0 +1,100 @@
+Kernel driver `adm1031.o'
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Please extend the underline as needed.

+Status: User space support and preliminary 2.4 driver.=20

The status is supposed to be about the 2.4 driver. User-space support is
almost mandatory anyway. "Preliminary, untested" is probably fine (for
now).

+Supported chips:=20
+  * Analog Devices ADM1030
+    Prefix: `adm1030'
+    Addresses scanned: I2C 0x2c 0x2e
+    Datasheet: Publicly available at the Analog Devices website
+               http://products.analog.com/products/info.asp?product=ADM1030
+
+  * Analog Devices ADM1031
+    Prefix: `adm1031'
+    Addresses scanned: I2C 0x2c 0x2e
+    Datasheet: Publicly available at the Analog Devices website
+               http://products.analog.com/products/info.asp?product=ADM1031

Please express the fact that this is the range from 0x2c to 0x2e, not
only these two addresses.

+ADM1030 and ADM1031 are digital temperature sensors and fan controllers.
+They senses their own temperature as well as the temperature of up to two
+ external diodes.

No indentation please.

+Each sensor has its own high and low limits, plus a critical limit.

This only applies to temperature sensors. Fan sensors only have a low limit.

+LABEL                 LABEL CLASS           COMPUTE CLASS          MODE  M=
AGN
+temp1                 -                     -                       R-    =
 0
+temp1_high            temp1                 temp1                   RW    =
 0
+temp1_low             temp1                 temp1                   RW    =
 0
+temp1_crit
+temp2                 -                     -                       R-    =
 1
+temp2_high            temp2                 temp2                   RW    =
 1
+temp2_low             temp2                 temp2                   RW    =
 1
+temp2_crit

Data missing for critical limits.

The driver seems to export all temperatures with a magnitude of 3, not 0
and 1 as documented above.

(Same for adm1031.)

--- lm_sensors2/kernel/chips/Module.mk	2004-04-07 19:27:50.000000000 +0200
+++ lm_sensors2_mine/kernel/chips/Module.mk	2004-05-18 12:35:11.000000000 +=
0200
@@ -39,6 +39,7 @@
 KERNELCHIPSTARGETS +=3D $(MODULE_DIR)/w83627hf.o
 KERNELCHIPSTARGETS +=3D $(MODULE_DIR)/w83l785ts.o
 KERNELCHIPSTARGETS +=3D $(MODULE_DIR)/xeontemp.o
+KERNELCHIPSTARGETS +=3D $(MODULE_DIR)/adm1031.o

Please respect the alphabetical order.
=20
diff -urN -x CVS lm_sensors2/kernel/chips/adm1031.c lm_sensors2_mine/kernel=
/chips/adm1031.c
--- lm_sensors2/kernel/chips/adm1031.c	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2_mine/kernel/chips/adm1031.c	2004-05-18 20:17:06.000000000 +=
0200
(...)
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c-proc.h>

Please include "version.h" as well, and use it. This is very helpful for
helping users.

+/* Following macros takes channel parameter starting from 0 to 2 */
+#define ADM1031_REG_FAN_SPEED(nr)       (0x08 + (nr))
+
+#define ADM1031_REG_FAN_DIV(nr)         (0x20  + (nr))
+#define ADM1031_REG_PWM                 (0x22)
+#define ADM1031_REG_FAN_MIN(nr)         (0x10 + (nr))

These are from 0 to 1 only. Maybe "starting from 0" would be enough.

+#define ADM1031_CONF2_PWM1_ENABLE       0x01
+#define	ADM1031_CONF2_PWM2_ENABLE       0x02

Indentation. Btw, you are supposed to align constants using tabs, not
spaces.

+#define ADM1031_SYSCTL_FAN1        1230
+#define ADM1031_SYSCTL_FAN1_MIN    1231
+#define ADM1031_SYSCTL_FAN1_DIV    1233
+#define ADM1031_SYSCTL_FAN2        1240
+#define ADM1031_SYSCTL_FAN2_MIN    1241
+#define ADM1031_SYSCTL_FAN2_DIV    1242

Strange choices for fan divisors. Shouldn't ADM1031_SYSCTL_FAN2_DIV be
1243?

+static ctl_table adm1031_dir_table_template[] =3D {
+	{ADM1031_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_temp},
+	{ADM1031_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_temp},
+	{ADM1031_SYSCTL_TEMP3, "temp3", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_temp},
+	{ADM1031_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_fan},
+	{ADM1031_SYSCTL_FAN1_DIV, "fan1_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_fan_div},
+	{ADM1031_SYSCTL_FAN2, "fan2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_fan},
+	{ADM1031_SYSCTL_FAN2_DIV, "fan2_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_fan_div},
+	{ADM1031_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_alarms},
+};
+
+static ctl_table adm1030_dir_table_template[] =3D {
+	{ADM1031_SYSCTL_TEMP1, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_temp},
+	{ADM1031_SYSCTL_TEMP2, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_temp},
+	{ADM1031_SYSCTL_FAN1, "fan1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_fan},
+	{ADM1031_SYSCTL_FAN1_DIV, "fan1_div", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_fan_div},
+	{ADM1031_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1031_alarms},
+};

Both tables miss their trailing {0}. As a result, I am seeing both lists
of files for my ADM1031. This means that some files appear twice in the
procfs directory, which is no good.

+/* Each client has this additional data */
+struct adm1031_data {
+	struct i2c_client client;
+        int sysctl_id;

Indentation.

+	/* The chan_select_table contains the possible configurations for
+	 * auto fan control.
+	 */

Comment is irrelevant for this version of the driver.

+	s8 temp[3];
+	u8 ext_temp[3];

I'm a bit surprised. Wouldn't it be easier to store these temperatures
in a 16-bit integer?

+#define TEMP_TO_REG(val)                ((val < 0 ? ((val - 500) / 1000) &=
 0xff : \
+					  ((val + 500) / 1000) & 0xff))

The "& 0xff" is completely irrelevant. It doesn't limit the value. If
the user selects a value outside of the allowed range (which by the way
is probably -55,+127, not -128,+127) he/she will get some random value.
This is no good.

+#define TEMP_FROM_REG(val)              (val * 1000)
+
+#define TEMP_FROM_REG_EXT(val, ext)     (TEMP_FROM_REG(val) + (ext) * 125)
+
+#define FAN_FROM_REG(reg, div)          ((reg) ? (11250 * 60) / ((reg) * (=
div)) : 0)
+
+#define FAN_TO_REG(reg, div)            FAN_FROM_REG(SENSORS_LIMIT(reg, 0,=
 65535), div)

You parameter name choices are confusing. You should use reg for
FROM_REG macros, and val for TO_REG ones. BTW, don't forget to surround
the parameters with parentheses each time you use them.

+#define FAN_DIV_TO_REG(val)          \
+            val =3D 8 ? 0xc0 :        \
+            val =3D 4 ? 0x80 :        \
+            val =3D 2 ? 0x40 :        \
+            val =3D 1 ? 0x00 :  0xFF

You don't handle 0xFF specially in your code. So you should just default
to some value (2).

+#ifdef DEBUG
+				oldh +				    adm1031_read_value(client,
+						       ADM1031_REG_TEMP(chan));
+
+				/* oldh is actually newer */
+				if (newh !=3D oldh)
+					dev_warn(&client->dev,
+						 "Remote temperature may be "
+						 "wrong.\n");
+#endif

I don't think that dev_warn exists in 2.4.

+		if (data->chip_type =3D adm1031) {
+			data->alarms +			    (adm1031_read_value(client, ADM1031_REG_STATUS(0))=
 &
+			     0xff) |
+			    ((adm1031_read_value(client, ADM1031_REG_STATUS(1))
+			      << 8) & 0xff00);
+		} else if (data->chip_type =3D adm1030) {
+			data->alarms +			    (adm1031_read_value(client, ADM1031_REG_STATUS(0))=
 &
+			     0xff) |
+			    ((adm1031_read_value(client, ADM1031_REG_STATUS(1))
+			      << 8) & 0xc000);
+		}

You probably can simplify this. For one thing, & 0xff and & 0xff00 are
useless. Second, you can read both registers regardless of the chip
type, and mask the result afterwards.

+
+		data->fan_div[0] +		    adm1031_read_value(client, ADM1031_REG_FAN_DIV(0=
));
+		data->fan_min[0] +		    adm1031_read_value(client, ADM1031_REG_FAN_MIN(0=
));
+		data->fan[0] +		    adm1031_read_value(client, ADM1031_REG_FAN_SPEED(0));
+
+		data->conf1 =3D adm1031_read_value(client, ADM1031_REG_CONF1);
+
+		data->conf2 =3D adm1031_read_value(client, ADM1031_REG_CONF2);
+
+		if (data->chip_type =3D adm1031) {
+			data->fan_div[1] +			    adm1031_read_value(client, ADM1031_REG_FAN_DIV=
(1));
+			data->fan_min[1] +			    adm1031_read_value(client, ADM1031_REG_FAN_MIN=
(1));
+			data->fan[1] +			    adm1031_read_value(client,
+					       ADM1031_REG_FAN_SPEED(1));

Please merge fan codes. Same as for temperatures, do a for look those
upper limit depends on the chip type.

+static void adm1031_temp(struct i2c_client *client, int operation, int ctl=
_name,
+		int *nrels_mag, long *results)
+{
+	int ext;
+	struct adm1031_data * data =3D client->data;
+	int nr =3D (ctl_name - ADM1031_SYSCTL_TEMP1) / 10;=09

This is not clever. You are free to chose the SYSCTL constants as you
want, so pick them in such a way that values sharing the same callback
function have consecutive numbers.

+		if (*nrels_mag >=3D2) {
+			data->temp_crit[nr] =3D TEMP_TO_REG(results[2]);
+			adm1031_write_value(client, ADM1031_REG_TEMP_CRIT(nr), data->temp_crit[=
nr]);
+		}

Bug, this should be >=3D 3.

+	else if (operation =3D SENSORS_PROC_REAL_READ) {
+		adm1031_update_client(client);
+		results[0] =3D FAN_FROM_REG(data->fan_min[nr], FAN_DIV_FROM_REG(data->fa=
n_div[nr]));
+		results[1] =3D FAN_FROM_REG(data->fan[nr], FAN_DIV_FROM_REG(data->fan_di=
v[nr]));
+	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {

Bug, you forget to set *nrels_mag to 2.

+	else if (operation =3D SENSORS_PROC_REAL_READ) {
+		adm1031_update_client(client);
+		results[0] =3D FAN_DIV_FROM_REG(data->fan_min[nr]);
+	} else if (operation =3D SENSORS_PROC_REAL_WRITE) {

Same problem here.

+	if(operation =3D SENSORS_PROC_REAL_INFO)
+		*nrels_mag =3D 1;

No, magnitude for fan divisors is 0.

+		if (*nrels_mag >=3D 1) {
+		    int old_div =3D FAN_DIV_FROM_REG(data->fan_div[nr]);
+		    data->fan_div[nr] =3D FAN_DIV_TO_REG(results[0]);
+		    adm1031_write_value(client, ADM1031_REG_FAN_DIV(nr), data->fan_div[n=
r]);
+		    data->fan_min[nr] =3D data->fan_min[nr] * old_div / data->fan_div[nr=
];

I think there's a problem there. old_div contains a real divider value
(1 to 8), while data->fan_div[nr] contains a "packed" value (0 to 3). So
the new fan_min value you compute promises to be bogus.

diff -urN -x CVS lm_sensors2/lib/chips.c lm_sensors2_mine/lib/chips.c
--- lm_sensors2/lib/chips.c	2004-04-24 10:10:48.000000000 +0200
+++ lm_sensors2_mine/lib/chips.c	2004-05-18 20:08:18.000000000 +0200
+    { SENSORS_ADM1031_FAN1, "fan1", NOMAP,=20
+                              NOMAP, R,=20
+                              ADM1031_SYSCTL_FAN1, VALUE(2), 0 },
+    { SENSORS_ADM1031_FAN1_MIN, "fan1_min", SENSORS_ADM1031_FAN1,=20
+                              SENSORS_ADM1031_FAN1, RW,=20
+                              ADM1031_SYSCTL_FAN1_MIN, VALUE(1), 0 },
+    { SENSORS_ADM1031_FAN1_DIV, "fan1_div", SENSORS_ADM1031_FAN1,=20
+                              SENSORS_ADM1031_FAN1, RW,=20
+                              ADM1031_SYSCTL_FAN1_DIV, VALUE(1), 0 },
+    { SENSORS_ADM1031_FAN2, "fan2", NOMAP,=20
+                              NOMAP, R,=20
+                              ADM1031_SYSCTL_FAN2, VALUE(2), 0 },
+    { SENSORS_ADM1031_FAN2_MIN, "fan2_min", SENSORS_ADM1031_FAN2,=20
+                              SENSORS_ADM1031_FAN2, RW,=20
+                              ADM1031_SYSCTL_FAN2_MIN, VALUE(1), 0 },
+    { SENSORS_ADM1031_FAN2_DIV, "fan2_div", SENSORS_ADM1031_FAN2,=20
+                              SENSORS_ADM1031_FAN2, RW,=20
+                              ADM1031_SYSCTL_FAN2_DIV, VALUE(1), 0 },

Not quite. In 2.4, there is a single fan_div file, with as many values
as fans.


diff -urN -x CVS lm_sensors2/prog/sensors/chips.c lm_sensors2_mine/prog/sen=
sors/chips.c
--- lm_sensors2/prog/sensors/chips.c	2004-05-08 14:24:16.000000000 +0200
+++ lm_sensors2_mine/prog/sensors/chips.c	2004-05-18 20:09:40.000000000 +02=
00
(...)
+  } else
+      printf("ERROR: Can't get temp1 temperature data!\n");
+  free_the_label(&label);

Please use different error messages for temp1 problems and temp1_crit
problems.

Also, please print fan information before temperatures, this is how
other drivers do.

I also have a problem with the 2.4 driver. I can't seem to get the
limits values. sensors -u displays the readings OK, but there's an error
on each limit. No idea what the problem is. Reading the procfs files
directly is OK.

Thanks.

--=20
Jean Delvare
http://khali.linux-fr.org/
