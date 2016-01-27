From: Guenter Roeck <patchwork@patchwork.roeck-us.net>
Date: Wed, 27 Jan 2016 02:03:43 +0000
Subject: [lm-sensors] [PATCH v3 19/25] hwmon: (it87) Use defines for array sizes and sensor counts
Message-Id: <1453860229-23614-20-git-send-email-patchwork@patchwork.roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Using array size defines makes it much easier to find errors
in index values and loop counts.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 58 ++++++++++++++++++++++++++++++------------------=
----
 1 file changed, 34 insertions(+), 24 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 0d6d106d53a2..118d4c756e40 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -260,6 +260,16 @@ static const u8 IT87_REG_VIN[]	=3D { 0x20, 0x21, 0x22,=
 0x23, 0x24, 0x25, 0x26,
=20
 #define IT87_REG_TEMP456_ENABLE	0x77
=20
+#define NUM_VIN			ARRAY_SIZE(IT87_REG_VIN)
+#define NUM_VIN_LIMIT		8
+#define NUM_TEMP		6
+#define NUM_TEMP_OFFSET		ARRAY_SIZE(IT87_REG_TEMP_OFFSET)
+#define NUM_TEMP_LIMIT		3
+#define NUM_FAN			ARRAY_SIZE(IT87_REG_FAN)
+#define NUM_FAN_DIV		3
+#define NUM_PWM			ARRAY_SIZE(IT87_REG_PWM)
+#define NUM_AUTO_PWM		ARRAY_SIZE(IT87_REG_PWM)
+
 struct it87_devices {
 	const char *name;
 	const char * const suffix;
@@ -484,14 +494,14 @@ struct it87_data {
 	u16 in_scaled;		/* Internal voltage sensors are scaled */
 	u16 in_internal;	/* Bitfield, internal sensors (for labels) */
 	u16 has_in;		/* Bitfield, voltage sensors enabled */
-	u8 in[13][3];		/* [nr][0]=3Din, [1]=3Dmin, [2]=3Dmax */
+	u8 in[NUM_VIN][3];		/* [nr][0]=3Din, [1]=3Dmin, [2]=3Dmax */
 	u8 has_fan;		/* Bitfield, fans enabled */
-	u16 fan[6][2];		/* Register values, [nr][0]=FAn, [1]=3Dmin */
+	u16 fan[NUM_FAN][2];	/* Register values, [nr][0]=FAn, [1]=3Dmin */
 	u8 has_temp;		/* Bitfield, temp sensors enabled */
-	s8 temp[6][4];		/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax, [3]=3Doffset */
+	s8 temp[NUM_TEMP][4];	/* [nr][0]=3Dtemp, [1]=3Dmin, [2]=3Dmax, [3]=3Doffs=
et */
 	u8 sensor;		/* Register value (IT87_REG_TEMP_ENABLE) */
 	u8 extra;		/* Register value (IT87_REG_TEMP_EXTRA) */
-	u8 fan_div[3];		/* Register encoding, shifted right */
+	u8 fan_div[NUM_FAN_DIV];/* Register encoding, shifted right */
 	bool has_vid;		/* True if VID supported */
 	u8 vid;			/* Register encoding, combined */
 	u8 vrm;
@@ -512,13 +522,13 @@ struct it87_data {
 	 * simple.
 	 */
 	u8 has_pwm;		/* Bitfield, pwm control enabled */
-	u8 pwm_ctrl[6];		/* Register value */
-	u8 pwm_duty[6];		/* Manual PWM value set by user */
-	u8 pwm_temp_map[6];	/* PWM to temp. chan. mapping (bits 1-0) */
+	u8 pwm_ctrl[NUM_PWM];	/* Register value */
+	u8 pwm_duty[NUM_PWM];	/* Manual PWM value set by user */
+	u8 pwm_temp_map[NUM_PWM];/* PWM to temp. chan. mapping (bits 1-0) */
=20
 	/* Automatic fan speed control registers */
-	u8 auto_pwm[3][4];	/* [nr][3] is hard-coded */
-	s8 auto_temp[3][5];	/* [nr][0] is point1_temp_hyst */
+	u8 auto_pwm[NUM_AUTO_PWM][4];	/* [nr][3] is hard-coded */
+	s8 auto_temp[NUM_AUTO_PWM][5];	/* [nr][0] is point1_temp_hyst */
 };
=20
 static int adc_lsb(const struct it87_data *data, int nr)
@@ -686,7 +696,7 @@ static struct it87_data *it87_update_device(struct devi=
ce *dev)
 			it87_write_value(data, IT87_REG_CONFIG,
 				it87_read_value(data, IT87_REG_CONFIG) | 0x40);
 		}
-		for (i =3D 0; i < ARRAY_SIZE(IT87_REG_VIN); i++) {
+		for (i =3D 0; i < NUM_VIN; i++) {
 			if (!(data->has_in & BIT(i)))
 				continue;
=20
@@ -694,7 +704,7 @@ static struct it87_data *it87_update_device(struct devi=
ce *dev)
 				it87_read_value(data, IT87_REG_VIN[i]);
=20
 			/* VBAT and AVCC don't have limit registers */
-			if (i >=3D 8)
+			if (i >=3D NUM_VIN_LIMIT)
 				continue;
=20
 			data->in[i][1] @@ -703,7 +713,7 @@ static struct it87_data *it87_update=
_device(struct device *dev)
 				it87_read_value(data, IT87_REG_VIN_MAX(i));
 		}
=20
-		for (i =3D 0; i < 6; i++) {
+		for (i =3D 0; i < NUM_FAN; i++) {
 			/* Skip disabled fans */
 			if (!(data->has_fan & BIT(i)))
 				continue;
@@ -720,24 +730,24 @@ static struct it87_data *it87_update_device(struct de=
vice *dev)
 						IT87_REG_FANX_MIN[i]) << 8;
 			}
 		}
-		for (i =3D 0; i < 6; i++) {
+		for (i =3D 0; i < NUM_TEMP; i++) {
 			if (!(data->has_temp & BIT(i)))
 				continue;
 			data->temp[i][0]  				it87_read_value(data, IT87_REG_TEMP(i));
=20
-			/* No limits/offset for additional sensors */
-			if (i >=3D 3)
+			if (has_temp_offset(data) && i < NUM_TEMP_OFFSET)
+				data->temp[i][3] +				  it87_read_value(data,
+						  IT87_REG_TEMP_OFFSET[i]);
+
+			if (i >=3D NUM_TEMP_LIMIT)
 				continue;
=20
 			data->temp[i][1]  				it87_read_value(data, IT87_REG_TEMP_LOW(i));
 			data->temp[i][2]  				it87_read_value(data, IT87_REG_TEMP_HIGH(i));
-			if (has_temp_offset(data))
-				data->temp[i][3] -				  it87_read_value(data,
-						  IT87_REG_TEMP_OFFSET[i]);
 		}
=20
 		/* Newer chips don't have clock dividers */
@@ -757,7 +767,7 @@ static struct it87_data *it87_update_device(struct devi=
ce *dev)
 		data->fan_main_ctrl =3D it87_read_value(data,
 				IT87_REG_FAN_MAIN_CTRL);
 		data->fan_ctl =3D it87_read_value(data, IT87_REG_FAN_CTL);
-		for (i =3D 0; i < 6; i++)
+		for (i =3D 0; i < NUM_PWM; i++)
 			it87_update_pwm_ctrl(data, i);
=20
 		data->sensor =3D it87_read_value(data, IT87_REG_TEMP_ENABLE);
@@ -2509,7 +2519,7 @@ static void it87_init_device(struct platform_device *=
pdev)
 	 * these have separate registers for the temperature mapping and the
 	 * manual duty cycle.
 	 */
-	for (i =3D 0; i < 3; i++) {
+	for (i =3D 0; i < NUM_AUTO_PWM; i++) {
 		data->pwm_temp_map[i] =3D i;
 		data->pwm_duty[i] =3D 0x7f;	/* Full speed */
 		data->auto_pwm[i][3] =3D 0x7f;	/* Full speed, hard-coded */
@@ -2522,12 +2532,12 @@ static void it87_init_device(struct platform_device=
 *pdev)
 	 * means -1 degree C, which surprisingly doesn't trigger an alarm,
 	 * but is still confusing, so change to 127 degrees C.
 	 */
-	for (i =3D 0; i < 8; i++) {
+	for (i =3D 0; i < NUM_VIN_LIMIT; i++) {
 		tmp =3D it87_read_value(data, IT87_REG_VIN_MIN(i));
 		if (tmp =3D 0xff)
 			it87_write_value(data, IT87_REG_VIN_MIN(i), 0);
 	}
-	for (i =3D 0; i < 3; i++) {
+	for (i =3D 0; i < NUM_TEMP_LIMIT; i++) {
 		tmp =3D it87_read_value(data, IT87_REG_TEMP_HIGH(i));
 		if (tmp =3D 0xff)
 			it87_write_value(data, IT87_REG_TEMP_HIGH(i), 127);
@@ -2620,7 +2630,7 @@ static int it87_check_pwm(struct device *dev)
 			int i;
 			u8 pwm[3];
=20
-			for (i =3D 0; i < 3; i++)
+			for (i =3D 0; i < ARRAY_SIZE(pwm); i++)
 				pwm[i] =3D it87_read_value(data,
 							 IT87_REG_PWM[i]);
=20
--=20
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
