From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 01 Dec 2009 08:33:39 +0000
Subject: [lm-sensors] [PATCH v4 2/5] LIS3LV02D: Remove calibaration
Message-Id: <1259656422-7697-3-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1259656422-7697-1-git-send-email-samu.p.onkalo@nokia.com>
 <1259656422-7697-2-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1259656422-7697-2-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: eric.piel@tremplin-utc.net
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Chip is calibrated by the manufacturer. There is no need to calibarate
it at driver level. If the chip is used as a joystick, calibaration can
be done using joystick device calibration mechanism.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/hwmon/lis3lv02d.c |   32 +++-----------------------------
 drivers/hwmon/lis3lv02d.h |    3 ---
 2 files changed, 3 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index 55ec883..02ac5fa 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -350,19 +350,12 @@ static void lis3lv02d_joystick_poll(struct input_poll=
ed_dev *pidev)
 	int x, y, z;
=20
 	lis3lv02d_get_xyz(&lis3_dev, &x, &y, &z);
-	input_report_abs(pidev->input, ABS_X, x - lis3_dev.xcalib);
-	input_report_abs(pidev->input, ABS_Y, y - lis3_dev.ycalib);
-	input_report_abs(pidev->input, ABS_Z, z - lis3_dev.zcalib);
+	input_report_abs(pidev->input, ABS_X, x);
+	input_report_abs(pidev->input, ABS_Y, y);
+	input_report_abs(pidev->input, ABS_Z, z);
 	input_sync(pidev->input);
 }
=20
-
-static inline void lis3lv02d_calibrate_joystick(void)
-{
-	lis3lv02d_get_xyz(&lis3_dev,
-		&lis3_dev.xcalib, &lis3_dev.ycalib, &lis3_dev.zcalib);
-}
-
 int lis3lv02d_joystick_enable(void)
 {
 	struct input_dev *input_dev;
@@ -379,8 +372,6 @@ int lis3lv02d_joystick_enable(void)
 	lis3_dev.idev->poll_interval =3D MDPS_POLL_INTERVAL;
 	input_dev =3D lis3_dev.idev->input;
=20
-	lis3lv02d_calibrate_joystick();
-
 	input_dev->name       =3D "ST LIS3LV02DL Accelerometer";
 	input_dev->phys       =3D DRIVER_NAME "/input0";
 	input_dev->id.bustype =3D BUS_HOST;
@@ -436,20 +427,6 @@ static ssize_t lis3lv02d_position_show(struct device *=
dev,
 	return sprintf(buf, "(%d,%d,%d)\n", x, y, z);
 }
=20
-static ssize_t lis3lv02d_calibrate_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "(%d,%d,%d)\n", lis3_dev.xcalib, lis3_dev.ycalib, lis=
3_dev.zcalib);
-}
-
-static ssize_t lis3lv02d_calibrate_store(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
-{
-	lis3lv02d_calibrate_joystick();
-	return count;
-}
-
 static ssize_t lis3lv02d_rate_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -458,14 +435,11 @@ static ssize_t lis3lv02d_rate_show(struct device *dev,
=20
 static DEVICE_ATTR(selftest, S_IRUSR, lis3lv02d_selftest_show, NULL);
 static DEVICE_ATTR(position, S_IRUGO, lis3lv02d_position_show, NULL);
-static DEVICE_ATTR(calibrate, S_IRUGO|S_IWUSR, lis3lv02d_calibrate_show,
-	lis3lv02d_calibrate_store);
 static DEVICE_ATTR(rate, S_IRUGO, lis3lv02d_rate_show, NULL);
=20
 static struct attribute *lis3lv02d_attributes[] =3D {
 	&dev_attr_selftest.attr,
 	&dev_attr_position.attr,
-	&dev_attr_calibrate.attr,
 	&dev_attr_rate.attr,
 	NULL
 };
diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index 166794c..1e9fb03 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -216,9 +216,6 @@ struct lis3lv02d {
 	struct input_polled_dev	*idev;     /* input device */
 	struct platform_device	*pdev;     /* platform device */
 	atomic_t		count;     /* interrupt count after last read */
-	int			xcalib;    /* calibrated null value for x */
-	int			ycalib;    /* calibrated null value for y */
-	int			zcalib;    /* calibrated null value for z */
 	struct axis_conversion	ac;        /* hw -> logical axis */
=20
 	u32			irq;       /* IRQ number */
--=20
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
