From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 16 Dec 2008 18:16:32 +0000
Subject: Re: [lm-sensors] F8000 support added to f71882fg driver,
Message-Id: <4947F080.9080009@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060601050106010001070407"
List-Id: <lm-sensors.vger.kernel.org>
References: <20081215180300.GA6612@rho>
In-Reply-To: <20081215180300.GA6612@rho>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601050106010001070407
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx2.redhat.com id
	mBGIHEfC024944



Jean Delvare wrote:
> On Tue, 16 Dec 2008 09:08:12 -0800, Chuan-kai Lin wrote:
>> On Tue, Dec 16, 2008 at 02:26:08PM +0100, Jean Delvare wrote:
>>> Please provide a dump of your F8000 chip:
>>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>> 00: ff 03 40 00 ff ff ff ff ff ff c1 00 55 4c 00 ff=20
>> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
>> 20: d2 d2 ca ff ff ff ff ff ff ff ff ff ff ff ff ff=20
>> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
>> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
>> 50: ff ff ff ff ff ff ff ff ff ff 05 08 10 19 34 ff=20
>> 60: 00 00 00 ff ff ff 00 01 65 ff ff ff ff ff ff 00=20
>> 70: 22 ff 08 ff 2b ff ff ff ff ff ff ff ff ff ff ff=20
>> 80: 46 3c 64 55 64 55 ff ff ff ff ff ff ff ff 2a ff=20
>> 90: 00 04 04 00 2a ff 15 ff aa 04 ff 2a 55 05 ff 0a=20
>> a0: 03 bd 00 66 03 b3 48 48 48 1c ff ff ff a7 66 3d=20
>> b0: 03 7b 00 5a 03 15 48 48 48 1c ff ff ff a0 5a 3d=20
>> c0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 a6 80 66 0c=20
>> d0: 0f ff ff ff ff ff ff ff ff ff ff ff ff ff ff 00
>       ^^^^^
>> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff=20
>> f0: 00 00 00 00 00 00 3b 3b 03 39 ff 00 ff ff ff ff=20
>>
>> f8000-isa-0a00
>> Adapter: ISA adapter
>> in0:         +1.68 V
>> in1:         +1.68 V
>> in2:         +1.62 V
>> fan1:       1567 RPM
>> fan2:       1683 RPM
>> fan3:          0 RPM  ALARM
>> fan4:       100000 RPM
>> temp1:       +34.0=B0C  (high =3D +70.0=B0C, hyst =3D +60.0=B0C) =20
>> temp2:        +8.0=B0C  (high =3D +100.0=B0C, hyst =3D +85.0=B0C)  sen=
sor =3D Intel PECI
>> temp3:       +43.0=B0C  (high =3D +100.0=B0C, hyst =3D +85.0=B0C) =20
>=20
> Just as I suspected. Hans, as you can see, fan4's speed is 0 in the
> chip. So it's not a hardware issue, but a bug in your driver. Which I
> presume the following patch would fix?
>=20
> Fix fan4 for the F8000.
>=20
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/f71882fg.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> --- linux-2.6.28-rc8.orig/drivers/hwmon/f71882fg.c	2008-12-16 17:42:05.=
000000000 +0100
> +++ linux-2.6.28-rc8/drivers/hwmon/f71882fg.c	2008-12-16 18:14:52.00000=
0000 +0100
> @@ -982,7 +982,7 @@ static struct f71882fg_data *f71882fg_up
> =20
>  		/* The f8000 can monitor 1 more fan, but has no pwm for it */
>  		if (data->type =3D=3D f8000)
> -			data->fan[3] =3D f71882fg_read8(data,
> +			data->fan[3] =3D f71882fg_read16(data,
>  						F71882FG_REG_FAN(3));
>  		if (data->type =3D=3D f71882fg)
>  			data->in_status =3D f71882fg_read8(data,
>=20

Good catch!

> Something to fold into hwmon/hwmon-f71882fg-13-add-f8000-support.patch
> I presume.
>=20

Yes,

Updated version attached

Regards,

Hans

--------------060601050106010001070407
Content-Type: text/plain; name="hwmon-f71882fg-13-add-f8000-support-v2.patch"
Content-Disposition: inline;
	filename="hwmon-f71882fg-13-add-f8000-support-v2.patch"
Content-Transfer-Encoding: 7bit

And (finally) the patch actually adding f8000 support

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
--- linux/drivers/hwmon/f71882fg.c.12-applied	2008-12-14 16:25:49.000000000 +0100
+++ linux/drivers/hwmon/f71882fg.c	2008-12-14 17:15:27.000000000 +0100
@@ -45,6 +45,7 @@
 #define SIO_FINTEK_ID		0x1934	/* Manufacturers ID */
 #define SIO_F71862_ID		0x0601	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
+#define SIO_F8000_ID		0x0581	/* Chipset ID */
 
 #define REGION_LENGTH		8
 #define ADDR_REG_OFFSET		5
@@ -90,11 +91,12 @@ static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-enum chips { f71862fg, f71882fg };
+enum chips { f71862fg, f71882fg, f8000 };
 
 static const char *f71882fg_names[] = {
 	"f71862fg",
 	"f71882fg",
+	"f8000",
 };
 
 static struct platform_device *f71882fg_pdev;
@@ -249,6 +251,7 @@ static struct platform_driver f71882fg_d
 
 static DEVICE_ATTR(name, S_IRUGO, show_name, NULL);
 
+/* Temp and in attr common to both the f71862fg and f71882fg */
 static struct sensor_device_attribute_2 f718x2fg_in_temp_attr[] = {
 	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
 	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
@@ -312,6 +315,7 @@ static struct sensor_device_attribute_2 
 	SENSOR_ATTR_2(temp3_fault, S_IRUGO, show_temp_fault, NULL, 0, 3),
 };
 
+/* Temp and in attr found only on the f71882fg */
 static struct sensor_device_attribute_2 f71882fg_in_temp_attr[] = {
 	SENSOR_ATTR_2(in1_max, S_IRUGO|S_IWUSR, show_in_max, store_in_max,
 		0, 1),
@@ -320,27 +324,51 @@ static struct sensor_device_attribute_2 
 	SENSOR_ATTR_2(in1_alarm, S_IRUGO, show_in_alarm, NULL, 0, 1),
 };
 
-static struct sensor_device_attribute_2 f718x2fg_fan_attr[] = {
+/* Temp and in attr for the f8000
+   Note on the f8000 temp_ovt (crit) is used as max, and temp_high (max)
+   is used as hysteresis value to clear alarms
+ */
+static struct sensor_device_attribute_2 f8000_in_temp_attr[] = {
+	SENSOR_ATTR_2(in0_input, S_IRUGO, show_in, NULL, 0, 0),
+	SENSOR_ATTR_2(in1_input, S_IRUGO, show_in, NULL, 0, 1),
+	SENSOR_ATTR_2(in2_input, S_IRUGO, show_in, NULL, 0, 2),
+	SENSOR_ATTR_2(temp1_input, S_IRUGO, show_temp, NULL, 0, 0),
+	SENSOR_ATTR_2(temp1_max, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 0),
+	SENSOR_ATTR_2(temp1_max_hyst, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 0),
+	SENSOR_ATTR_2(temp1_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 4),
+	SENSOR_ATTR_2(temp2_input, S_IRUGO, show_temp, NULL, 0, 1),
+	SENSOR_ATTR_2(temp2_max, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 1),
+	SENSOR_ATTR_2(temp2_max_hyst, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 1),
+	SENSOR_ATTR_2(temp2_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 5),
+	SENSOR_ATTR_2(temp2_type, S_IRUGO, show_temp_type, NULL, 0, 1),
+	SENSOR_ATTR_2(temp3_input, S_IRUGO, show_temp, NULL, 0, 2),
+	SENSOR_ATTR_2(temp3_max, S_IRUGO|S_IWUSR, show_temp_crit,
+		store_temp_crit, 0, 2),
+	SENSOR_ATTR_2(temp3_max_hyst, S_IRUGO|S_IWUSR, show_temp_max,
+		store_temp_max, 0, 2),
+	SENSOR_ATTR_2(temp3_alarm, S_IRUGO, show_temp_alarm, NULL, 0, 6),
+};
+
+/* Fan / PWM attr common to all models */
+static struct sensor_device_attribute_2 fxxxx_fan_attr[] = {
 	SENSOR_ATTR_2(fan1_input, S_IRUGO, show_fan, NULL, 0, 0),
 	SENSOR_ATTR_2(fan1_full_speed, S_IRUGO|S_IWUSR,
 		      show_fan_full_speed,
 		      store_fan_full_speed, 0, 0),
-	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 0),
 	SENSOR_ATTR_2(fan1_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 0),
 	SENSOR_ATTR_2(fan2_input, S_IRUGO, show_fan, NULL, 0, 1),
 	SENSOR_ATTR_2(fan2_full_speed, S_IRUGO|S_IWUSR,
 		      show_fan_full_speed,
 		      store_fan_full_speed, 0, 1),
-	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 1),
 	SENSOR_ATTR_2(fan2_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 1),
 	SENSOR_ATTR_2(fan3_input, S_IRUGO, show_fan, NULL, 0, 2),
 	SENSOR_ATTR_2(fan3_full_speed, S_IRUGO|S_IWUSR,
 		      show_fan_full_speed,
 		      store_fan_full_speed, 0, 2),
-	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
-		store_fan_beep, 0, 2),
 	SENSOR_ATTR_2(fan3_alarm, S_IRUGO, show_fan_alarm, NULL, 0, 2),
 
 	SENSOR_ATTR_2(pwm1, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 0),
@@ -361,9 +389,6 @@ static struct sensor_device_attribute_2 
 		      show_pwm_auto_point_channel,
 		      store_pwm_auto_point_channel, 0, 1),
 
-	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
-	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
-		      store_pwm_enable, 0, 2),
 	SENSOR_ATTR_2(pwm3_interpolate, S_IRUGO|S_IWUSR,
 		      show_pwm_interpolate, store_pwm_interpolate, 0, 2),
 	SENSOR_ATTR_2(pwm3_auto_channels_temp, S_IRUGO|S_IWUSR,
@@ -371,7 +396,16 @@ static struct sensor_device_attribute_2 
 		      store_pwm_auto_point_channel, 0, 2),
 };
 
+/* Fan / PWM attr for the f71862fg, less pwms and less zones per pwm then the
+   f71882fg */
 static struct sensor_device_attribute_2 f71862fg_fan_attr[] = {
+	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 0),
+	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 1),
+	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 2),
+
 	SENSOR_ATTR_2(pwm1_auto_point1_pwm, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
 		      1, 0),
@@ -411,7 +445,14 @@ static struct sensor_device_attribute_2 
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
 };
 
+/* Fan / PWM attr for the f71882fg */
 static struct sensor_device_attribute_2 f71882fg_fan_attr[] = {
+	SENSOR_ATTR_2(fan1_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 0),
+	SENSOR_ATTR_2(fan2_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 1),
+	SENSOR_ATTR_2(fan3_beep, S_IRUGO|S_IWUSR, show_fan_beep,
+		store_fan_beep, 0, 2),
 	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
 	SENSOR_ATTR_2(fan4_full_speed, S_IRUGO|S_IWUSR,
 		      show_fan_full_speed,
@@ -496,6 +537,9 @@ static struct sensor_device_attribute_2 
 	SENSOR_ATTR_2(pwm2_auto_point4_temp_hyst, S_IRUGO,
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
 
+	SENSOR_ATTR_2(pwm3, S_IRUGO|S_IWUSR, show_pwm, store_pwm, 0, 2),
+	SENSOR_ATTR_2(pwm3_enable, S_IRUGO|S_IWUSR, show_pwm_enable,
+		      store_pwm_enable, 0, 2),
 	SENSOR_ATTR_2(pwm3_auto_point1_pwm, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
 		      0, 2),
@@ -581,6 +625,128 @@ static struct sensor_device_attribute_2 
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 3),
 };
 
+/* Fan / PWM attr for the f8000, zones mapped to temp instead of to pwm!
+   Also the register block at offset A0 maps to TEMP1 (so our temp2, as the
+   F8000 starts counting temps at 0), B0 maps the TEMP2 and C0 maps to TEMP0 */
+static struct sensor_device_attribute_2 f8000_fan_attr[] = {
+	SENSOR_ATTR_2(fan4_input, S_IRUGO, show_fan, NULL, 0, 3),
+
+	SENSOR_ATTR_2(pwm3, S_IRUGO, show_pwm, NULL, 0, 2),
+
+	SENSOR_ATTR_2(temp1_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 2),
+	SENSOR_ATTR_2(temp1_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 2),
+	SENSOR_ATTR_2(temp1_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 2),
+	SENSOR_ATTR_2(temp1_auto_point4_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 2),
+	SENSOR_ATTR_2(temp1_auto_point5_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 2),
+	SENSOR_ATTR_2(temp1_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 2),
+	SENSOR_ATTR_2(temp1_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 2),
+	SENSOR_ATTR_2(temp1_auto_point3_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 2),
+	SENSOR_ATTR_2(temp1_auto_point4_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 2),
+	SENSOR_ATTR_2(temp1_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 2),
+	SENSOR_ATTR_2(temp1_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 2),
+	SENSOR_ATTR_2(temp1_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 2),
+	SENSOR_ATTR_2(temp1_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
+
+	SENSOR_ATTR_2(temp2_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 0),
+	SENSOR_ATTR_2(temp2_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 0),
+	SENSOR_ATTR_2(temp2_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 0),
+	SENSOR_ATTR_2(temp2_auto_point4_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 0),
+	SENSOR_ATTR_2(temp2_auto_point5_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 0),
+	SENSOR_ATTR_2(temp2_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 0),
+	SENSOR_ATTR_2(temp2_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 0),
+	SENSOR_ATTR_2(temp2_auto_point3_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 0),
+	SENSOR_ATTR_2(temp2_auto_point4_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 0),
+	SENSOR_ATTR_2(temp2_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 0),
+	SENSOR_ATTR_2(temp2_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 0),
+	SENSOR_ATTR_2(temp2_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 0),
+	SENSOR_ATTR_2(temp2_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 0),
+
+	SENSOR_ATTR_2(temp3_auto_point1_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      0, 1),
+	SENSOR_ATTR_2(temp3_auto_point2_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      1, 1),
+	SENSOR_ATTR_2(temp3_auto_point3_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      2, 1),
+	SENSOR_ATTR_2(temp3_auto_point4_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      3, 1),
+	SENSOR_ATTR_2(temp3_auto_point5_pwm, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_pwm, store_pwm_auto_point_pwm,
+		      4, 1),
+	SENSOR_ATTR_2(temp3_auto_point1_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      0, 1),
+	SENSOR_ATTR_2(temp3_auto_point2_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      1, 1),
+	SENSOR_ATTR_2(temp3_auto_point3_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      2, 1),
+	SENSOR_ATTR_2(temp3_auto_point4_temp, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp, store_pwm_auto_point_temp,
+		      3, 1),
+	SENSOR_ATTR_2(temp3_auto_point1_temp_hyst, S_IRUGO|S_IWUSR,
+		      show_pwm_auto_point_temp_hyst,
+		      store_pwm_auto_point_temp_hyst,
+		      0, 1),
+	SENSOR_ATTR_2(temp3_auto_point2_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 1, 1),
+	SENSOR_ATTR_2(temp3_auto_point3_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 2, 1),
+	SENSOR_ATTR_2(temp3_auto_point4_temp_hyst, S_IRUGO,
+		      show_pwm_auto_point_temp_hyst, NULL, 3, 1),
+};
 
 /* Super I/O functions */
 static inline int superio_inb(int base, int reg)
@@ -666,8 +832,10 @@ static void f71882fg_write16(struct f718
 static struct f71882fg_data *f71882fg_update_device(struct device *dev)
 {
 	struct f71882fg_data *data = dev_get_drvdata(dev);
-	int nr, reg, reg2;
-	int nr_fans = (data->type == f71862fg) ? 3 : 4;
+	int nr, reg = 0, reg2;
+	int nr_fans = (data->type == f71882fg) ? 4 : 3;
+	int nr_ins = (data->type == f8000) ? 3 : 9;
+	int temp_start = (data->type == f8000) ? 0 : 1;
 
 	mutex_lock(&data->update_lock);
 
@@ -682,35 +850,36 @@ static struct f71882fg_data *f71882fg_up
 		}
 
 		/* Get High & boundary temps*/
-		for (nr = 1; nr < 4; nr++) {
+		for (nr = temp_start; nr < 3 + temp_start; nr++) {
 			data->temp_ovt[nr] = f71882fg_read8(data,
 						F71882FG_REG_TEMP_OVT(nr));
 			data->temp_high[nr] = f71882fg_read8(data,
 						F71882FG_REG_TEMP_HIGH(nr));
 		}
 
-		/* hyst */
-		data->temp_hyst[0] =
-			f71882fg_read8(data, F71882FG_REG_TEMP_HYST(0));
-		data->temp_hyst[1] =
-			f71882fg_read8(data, F71882FG_REG_TEMP_HYST(1));
-
-		/* Have to hardcode type, because temp1 is special */
-		reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
+		if (data->type != f8000) {
+			data->fan_beep = f71882fg_read8(data,
+						F71882FG_REG_FAN_BEEP);
+			data->temp_beep = f71882fg_read8(data,
+						F71882FG_REG_TEMP_BEEP);
+			data->temp_hyst[0] = f71882fg_read8(data,
+						F71882FG_REG_TEMP_HYST(0));
+			data->temp_hyst[1] = f71882fg_read8(data,
+						F71882FG_REG_TEMP_HYST(1));
+			/* Have to hardcode type, because temp1 is special */
+			reg  = f71882fg_read8(data, F71882FG_REG_TEMP_TYPE);
+			data->temp_type[2] = (reg & 0x04) ? 2 : 4;
+			data->temp_type[3] = (reg & 0x08) ? 2 : 4;
+		}
 		reg2 = f71882fg_read8(data, F71882FG_REG_PECI);
 		if ((reg2 & 0x03) == 0x01)
 			data->temp_type[1] = 6 /* PECI */;
 		else if ((reg2 & 0x03) == 0x02)
 			data->temp_type[1] = 5 /* AMDSI */;
-		else
+		else if (data->type != f8000)
 			data->temp_type[1] = (reg & 0x02) ? 2 : 4;
-
-		data->temp_type[2] = (reg & 0x04) ? 2 : 4;
-		data->temp_type[3] = (reg & 0x08) ? 2 : 4;
-
-		data->temp_beep = f71882fg_read8(data, F71882FG_REG_TEMP_BEEP);
-
-		data->fan_beep = f71882fg_read8(data, F71882FG_REG_FAN_BEEP);
+		else
+			data->temp_type[1] = 2; /* F8000 only supports BJT */
 
 		data->pwm_enable = f71882fg_read8(data,
 						  F71882FG_REG_PWM_ENABLE);
@@ -724,7 +893,7 @@ static struct f71882fg_data *f71882fg_up
 			    f71882fg_read8(data,
 					   F71882FG_REG_POINT_MAPPING(nr));
 
-			if (data->type == f71882fg) {
+			if (data->type != f71862fg) {
 				int point;
 				for (point = 0; point < 5; point++) {
 					data->pwm_auto_point_pwm[nr][point] =
@@ -766,7 +935,7 @@ static struct f71882fg_data *f71882fg_up
 						F71882FG_REG_TEMP_STATUS);
 		data->temp_diode_open = f71882fg_read8(data,
 						F71882FG_REG_TEMP_DIODE_OPEN);
-		for (nr = 1; nr < 4; nr++)
+		for (nr = temp_start; nr < 3 + temp_start; nr++)
 			data->temp[nr] = f71882fg_read8(data,
 						F71882FG_REG_TEMP(nr));
 
@@ -784,10 +953,14 @@ static struct f71882fg_data *f71882fg_up
 			    f71882fg_read8(data, F71882FG_REG_PWM(nr));
 		}
 
+		/* The f8000 can monitor 1 more fan, but has no pwm for it */
+		if (data->type == f8000)
+			data->fan[3] = f71882fg_read16(data,
+						F71882FG_REG_FAN(3));
 		if (data->type == f71882fg)
 			data->in_status = f71882fg_read8(data,
 						F71882FG_REG_IN_STATUS);
-		for (nr = 0; nr < 9; nr++)
+		for (nr = 0; nr < nr_ins; nr++)
 			data->in[nr] = f71882fg_read8(data,
 						F71882FG_REG_IN(nr));
 
@@ -1181,6 +1354,11 @@ static ssize_t store_pwm(struct device *
 
 	mutex_lock(&data->update_lock);
 	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
+	if ((data->type == f8000 && ((data->pwm_enable >> 2 * nr) & 3) != 2) ||
+	    (data->type != f8000 && !((data->pwm_enable >> 2 * nr) & 2))) {
+		count = -EROFS;
+		goto leave;
+	}
 	if (data->pwm_enable & (1 << (2 * nr))) {
 		/* PWM mode */
 		f71882fg_write8(data, F71882FG_REG_PWM(nr), val);
@@ -1195,6 +1373,7 @@ static ssize_t store_pwm(struct device *
 		data->fan_target[nr] = target;
 		data->fan_full_speed[nr] = full_speed;
 	}
+leave:
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -1203,14 +1382,25 @@ static ssize_t store_pwm(struct device *
 static ssize_t show_pwm_enable(struct device *dev,
 			       struct device_attribute *devattr, char *buf)
 {
-	int result;
+	int result = 0;
 	struct f71882fg_data *data = f71882fg_update_device(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
 
-	if (data->pwm_enable & (2 << (2 * nr)))
-		result = 1;
-	else
-		result = 2;
+	switch ((data->pwm_enable >> 2 * nr) & 3) {
+	case 0:
+	case 1:
+		result = 2; /* Normal auto mode */
+		break;
+	case 2:
+		result = 1; /* Manual mode */
+		break;
+	case 3:
+		if (data->type == f8000)
+			result = 3; /* Thermostat mode */
+		else
+			result = 1; /* Manual mode */
+		break;
+	}
 
 	return sprintf(buf, "%d\n", result);
 }
@@ -1221,20 +1411,37 @@ static ssize_t store_pwm_enable(struct d
 	struct f71882fg_data *data = dev_get_drvdata(dev);
 	int nr = to_sensor_dev_attr_2(devattr)->index;
 	long val = simple_strtol(buf, NULL, 10);
-	if (val < 1 || val > 2)
-		return -EINVAL;
 
 	mutex_lock(&data->update_lock);
 	data->pwm_enable = f71882fg_read8(data, F71882FG_REG_PWM_ENABLE);
-	switch (val) {
-	case 1:
-		data->pwm_enable |= 2 << (2 * nr);
-		break;		/* Manual */
-	case 2:
-		data->pwm_enable &= ~(2 << (2 * nr));
-		break;		/* Temperature ctrl */
+	/* Special case for F8000 auto PWM mode / Thermostat mode */
+	if (data->type == f8000 && ((data->pwm_enable >> 2 * nr) & 1)) {
+		switch (val) {
+		case 2:
+			data->pwm_enable &= ~(2 << (2 * nr));
+			break;		/* Normal auto mode */
+		case 3:
+			data->pwm_enable |= 2 << (2 * nr);
+			break;		/* Thermostat mode */
+		default:
+			count = -EINVAL;
+			goto leave;
+		}
+	} else {
+		switch (val) {
+		case 1:
+			data->pwm_enable |= 2 << (2 * nr);
+			break;		/* Manual */
+		case 2:
+			data->pwm_enable &= ~(2 << (2 * nr));
+			break;		/* Normal auto mode */
+		default:
+			count = -EINVAL;
+			goto leave;
+		}
 	}
 	f71882fg_write8(data, F71882FG_REG_PWM_ENABLE, data->pwm_enable);
+leave:
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -1516,34 +1723,51 @@ static int __devinit f71882fg_probe(stru
 		goto exit_unregister_sysfs;
 
 	if (start_reg & 0x01) {
-		err = f71882fg_create_sysfs_files(pdev, f718x2fg_in_temp_attr,
-					ARRAY_SIZE(f718x2fg_in_temp_attr));
-		if (err)
-			goto exit_unregister_sysfs;
-
-		if (data->type == f71882fg) {
+		switch (data->type) {
+		case f71882fg:
 			err = f71882fg_create_sysfs_files(pdev,
 					f71882fg_in_temp_attr,
 					ARRAY_SIZE(f71882fg_in_temp_attr));
 			if (err)
 				goto exit_unregister_sysfs;
+			/* fall through! */
+		case f71862fg:
+			err = f71882fg_create_sysfs_files(pdev,
+					f718x2fg_in_temp_attr,
+					ARRAY_SIZE(f718x2fg_in_temp_attr));
+			break;
+		case f8000:
+			err = f71882fg_create_sysfs_files(pdev,
+					f8000_in_temp_attr,
+					ARRAY_SIZE(f8000_in_temp_attr));
+			break;
 		}
+		if (err)
+			goto exit_unregister_sysfs;
 	}
 
 	if (start_reg & 0x02) {
-		err = f71882fg_create_sysfs_files(pdev, f718x2fg_fan_attr,
-					ARRAY_SIZE(f718x2fg_fan_attr));
+		err = f71882fg_create_sysfs_files(pdev, fxxxx_fan_attr,
+					ARRAY_SIZE(fxxxx_fan_attr));
 		if (err)
 			goto exit_unregister_sysfs;
 
-		if (data->type == f71862fg) {
+		switch (data->type) {
+		case f71862fg:
 			err = f71882fg_create_sysfs_files(pdev,
 					f71862fg_fan_attr,
 					ARRAY_SIZE(f71862fg_fan_attr));
-		} else {
+			break;
+		case f71882fg:
 			err = f71882fg_create_sysfs_files(pdev,
 					f71882fg_fan_attr,
 					ARRAY_SIZE(f71882fg_fan_attr));
+			break;
+		case f8000:
+			err = f71882fg_create_sysfs_files(pdev,
+					f8000_fan_attr,
+					ARRAY_SIZE(f8000_fan_attr));
+			break;
 		}
 		if (err)
 			goto exit_unregister_sysfs;
@@ -1575,6 +1799,8 @@ static int f71882fg_remove(struct platfo
 	if (data->hwmon_dev)
 		hwmon_device_unregister(data->hwmon_dev);
 
+	/* Note we are not looping over all attr arrays we have as the ones
+	   below are supersets of the ones skipped. */
 	device_remove_file(&pdev->dev, &dev_attr_name);
 
 	for (i = 0; i < ARRAY_SIZE(f718x2fg_in_temp_attr); i++)
@@ -1585,15 +1811,15 @@ static int f71882fg_remove(struct platfo
 		device_remove_file(&pdev->dev,
 					&f71882fg_in_temp_attr[i].dev_attr);
 
-	for (i = 0; i < ARRAY_SIZE(f718x2fg_fan_attr); i++)
-		device_remove_file(&pdev->dev, &f718x2fg_fan_attr[i].dev_attr);
-
-	for (i = 0; i < ARRAY_SIZE(f71862fg_fan_attr); i++)
-		device_remove_file(&pdev->dev, &f71862fg_fan_attr[i].dev_attr);
+	for (i = 0; i < ARRAY_SIZE(fxxxx_fan_attr); i++)
+		device_remove_file(&pdev->dev, &fxxxx_fan_attr[i].dev_attr);
 
 	for (i = 0; i < ARRAY_SIZE(f71882fg_fan_attr); i++)
 		device_remove_file(&pdev->dev, &f71882fg_fan_attr[i].dev_attr);
 
+	for (i = 0; i < ARRAY_SIZE(f8000_fan_attr); i++)
+		device_remove_file(&pdev->dev, &f8000_fan_attr[i].dev_attr);
+
 	kfree(data);
 
 	return 0;
@@ -1621,6 +1847,9 @@ static int __init f71882fg_find(int sioa
 	case SIO_F71882_ID:
 		sio_data->type = f71882fg;
 		break;
+	case SIO_F8000_ID:
+		sio_data->type = f8000;
+		break;
 	default:
 		printk(KERN_INFO DRVNAME ": Unsupported Fintek device\n");
 		goto exit;

--------------060601050106010001070407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060601050106010001070407--
