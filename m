From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 09 Mar 2011 19:57:14 +0000
Subject: [lm-sensors] [PATCH 08/10] hwmon/f71882fg: Add support for f71889ed
Message-Id: <1299700636-9699-9-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Note that this patch also makes 2 changes to the code paths for the f71889fg
to keep the code unified between the 2 (for simplicities sake). Both of these
are harmless for then f71889fg:

1) The first change is to always set the FAN_PROG_SEL bit to 0. This influences
   accesses to some banked fan / pwm registers. On the f71889fg no registers
   which we use are banked. On the f71889ed however some more fan registers
   have been banked including one which we use, by making the FAN_PROG_SEL bit
   0, address 0x96 will point to the right register.
2) The second change is to see a FANx_TEMP_SEL value of 0 as pointing to
   a PECI / AMDSI value, and thus disable our pwm related sysfs attr.
   This is correct for the f71889ed and on the f71889fg 0 is a reserved
   value, so we should never see it and if we do, disabling the pwm related
   sysfs attr is a sane thing to do.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/hwmon/f71882fg |   12 ++++++++----
 drivers/hwmon/f71882fg.c     |   38 +++++++++++++++++++++++++++-----------
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/Documentation/hwmon/f71882fg b/Documentation/hwmon/f71882fg
index a7952c2..9aa210c 100644
--- a/Documentation/hwmon/f71882fg
+++ b/Documentation/hwmon/f71882fg
@@ -17,6 +17,10 @@ Supported chips:
   * Fintek F71889FG
     Prefix: 'f71889fg'
     Addresses scanned: none, address read from Super I/O config space
+    Datasheet: Available from the Fintek website
+  * Fintek F71889ED
+    Prefix: 'f71889ed'
+    Addresses scanned: none, address read from Super I/O config space
     Datasheet: Should become available on the Fintek website soon
   * Fintek F8000
     Prefix: 'f8000'
@@ -29,9 +33,9 @@ Author: Hans de Goede <hdegoede@redhat.com>
 Description
 -----------
 
-Fintek F718xxFG/F8000 Super I/O chips include complete hardware monitoring
-capabilities. They can monitor up to 9 voltages (3 for the F8000), 4 fans and
-3 temperature sensors.
+Fintek F718xx/F8000 Super I/O chips include complete hardware monitoring
+capabilities. They can monitor up to 9 voltages, 4 fans and 3 temperature
+sensors.
 
 These chips also have fan controlling features, using either DC or PWM, in
 three different modes (one manual, two automatic).
@@ -99,5 +103,5 @@ Writing an unsupported mode will result in an invalid parameter error.
   The fan speed is regulated to keep the temp the fan is mapped to between
   temp#_auto_point2_temp and temp#_auto_point3_temp.
 
-Both of the automatic modes require that pwm1 corresponds to fan1, pwm2 to
+All of the automatic modes require that pwm1 corresponds to fan1, pwm2 to
 fan2 and pwm3 to fan3.
diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index 6d88aeb..29e9512 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -51,16 +51,17 @@
 #define SIO_F71862_ID		0x0601	/* Chipset ID */
 #define SIO_F71882_ID		0x0541	/* Chipset ID */
 #define SIO_F71889_ID		0x0723	/* Chipset ID */
+#define SIO_F71889E_ID		0x0909	/* Chipset ID */
 #define SIO_F8000_ID		0x0581	/* Chipset ID */
 
 #define REGION_LENGTH		8
 #define ADDR_REG_OFFSET		5
 #define DATA_REG_OFFSET		6
 
-#define F71882FG_REG_IN_STATUS		0x12 /* f71882fg only */
-#define F71882FG_REG_IN_BEEP		0x13 /* f71882fg only */
+#define F71882FG_REG_IN_STATUS		0x12 /* f7188x only */
+#define F71882FG_REG_IN_BEEP		0x13 /* f7188x only */
 #define F71882FG_REG_IN(nr)		(0x20  + (nr))
-#define F71882FG_REG_IN1_HIGH		0x32 /* f71882fg only */
+#define F71882FG_REG_IN1_HIGH		0x32 /* f7188x only */
 
 #define F71882FG_REG_FAN(nr)		(0xA0 + (16 * (nr)))
 #define F71882FG_REG_FAN_TARGET(nr)	(0xA2 + (16 * (nr)))
@@ -86,6 +87,7 @@
 
 #define F71882FG_REG_FAN_FAULT_T	0x9F
 #define F71882FG_FAN_NEG_TEMP_EN	0x20
+#define F71882FG_FAN_PROG_SEL		0x80
 
 #define F71882FG_REG_POINT_PWM(pwm, point)	(0xAA + (point) + (16 * (pwm)))
 #define F71882FG_REG_POINT_TEMP(pwm, point)	(0xA6 + (point) + (16 * (pwm)))
@@ -101,37 +103,41 @@ static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f8000 };
+enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f71889ed, f8000 };
 
 static const char *f71882fg_names[] = {
 	"f71858fg",
 	"f71862fg",
 	"f71882fg",
 	"f71889fg",
+	"f71889ed",
 	"f8000",
 };
 
-static const char f71882fg_has_in[5][F71882FG_MAX_INS] = {
+static const char f71882fg_has_in[6][F71882FG_MAX_INS] = {
 	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f71858fg */
 	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71862fg */
 	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71882fg */
 	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71889fg */
+	{ 1, 1, 1, 1, 1, 1, 1, 1, 1 }, /* f71889ed */
 	{ 1, 1, 1, 0, 0, 0, 0, 0, 0 }, /* f8000 */
 };
 
-static const char f71882fg_has_in1_alarm[5] = {
+static const char f71882fg_has_in1_alarm[6] = {
 	0, /* f71858fg */
 	0, /* f71862fg */
 	1, /* f71882fg */
 	1, /* f71889fg */
+	1, /* f71889ed */
 	0, /* f8000 */
 };
 
-static const char f71882fg_has_beep[5] = {
+static const char f71882fg_has_beep[6] = {
 	0, /* f71858fg */
 	1, /* f71862fg */
 	1, /* f71882fg */
 	1, /* f71889fg */
+	1, /* f71889ed */
 	0, /* f8000 */
 };
 
@@ -510,7 +516,7 @@ static struct sensor_device_attribute_2 fxxxx_fan_beep_attr[] = {
 };
 
 /* PWM attr for the f71862fg, fewer pwms and fewer zones per pwm than the
-   f71858fg / f71882fg / f71889fg */
+   standard models */
 static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[] = {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
@@ -579,7 +585,7 @@ static struct sensor_device_attribute_2 f71862fg_auto_pwm_attr[] = {
 		      show_pwm_auto_point_temp_hyst, NULL, 3, 2),
 };
 
-/* PWM attr common to the f71858fg, f71882fg and f71889fg */
+/* PWM attr for the standard models */
 static struct sensor_device_attribute_2 fxxxx_auto_pwm_attr[4][14] = { {
 	SENSOR_ATTR_2(pwm1_auto_channels_temp, S_IRUGO|S_IWUSR,
 		      show_pwm_auto_point_channel,
@@ -2024,9 +2030,13 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 	if (start_reg & 0x02) {
 		switch (data->type) {
 		case f71889fg:
+		case f71889ed:
 			reg = f71882fg_read8(data, F71882FG_REG_FAN_FAULT_T);
 			if (reg & F71882FG_FAN_NEG_TEMP_EN)
 				data->auto_point_temp_signed = 1;
+			/* Ensure banked pwm registers point to right bank */
+			reg &= ~F71882FG_FAN_PROG_SEL;
+			f71882fg_write8(data, F71882FG_REG_FAN_FAULT_T, reg);
 			break;
 		default:
 			break;
@@ -2048,6 +2058,7 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 			break;
 		case f71882fg:
 		case f71889fg:
+		case f71889ed:
 			err = 0;
 			break;
 		case f8000:
@@ -2076,11 +2087,13 @@ static int __devinit f71882fg_probe(struct platform_device *pdev)
 
 		switch (data->type) {
 		case f71889fg:
+		case f71889ed:
 			for (i = 0; i < nr_fans; i++) {
 				data->pwm_auto_point_mapping[i]  					f71882fg_read8(data,
 						F71882FG_REG_POINT_MAPPING(i));
-				if (data->pwm_auto_point_mapping[i] & 0x80)
+				if ((data->pwm_auto_point_mapping[i] & 0x80) ||
+				    (data->pwm_auto_point_mapping[i] & 3) = 0)
 					break;
 			}
 			if (i != nr_fans) {
@@ -2220,7 +2233,7 @@ static int f71882fg_remove(struct platform_device *pdev)
 					f8000_auto_pwm_attr,
 					ARRAY_SIZE(f8000_auto_pwm_attr));
 			break;
-		default: /* f71858fg / f71882fg / f71889fg */
+		default:
 			f71882fg_remove_sysfs_files(pdev,
 				&fxxxx_auto_pwm_attr[0][0],
 				ARRAY_SIZE(fxxxx_auto_pwm_attr[0]) * nr_fans);
@@ -2261,6 +2274,9 @@ static int __init f71882fg_find(int sioaddr, unsigned short *address,
 	case SIO_F71889_ID:
 		sio_data->type = f71889fg;
 		break;
+	case SIO_F71889E_ID:
+		sio_data->type = f71889ed;
+		break;
 	case SIO_F8000_ID:
 		sio_data->type = f8000;
 		break;
-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
