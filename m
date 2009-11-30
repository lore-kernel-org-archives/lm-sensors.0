From: =?UTF-8?B?w4lyaWMgUGllbA==?= <eric.piel@tremplin-utc.net>
Date: Mon, 30 Nov 2009 15:12:26 +0000
Subject: Re: [lm-sensors] [PATCH v3 3/5] lis3: Sysfs entry for setting chip
Message-Id: <4B13E0DA.5030105@tremplin-utc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1258622842-23129-1-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-2-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-3-git-send-email-samu.p.onkalo@nokia.com> <1258622842-23129-4-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1258622842-23129-4-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Samu Onkalo <samu.p.onkalo@nokia.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Op 19-11-09 10:27, Samu Onkalo schreef:
> It is possible to read position information at the chip measurement
> rate via sysfs. This patch adds possibility to configure chip
> measurement rate.
>=20
Hi, it's only a slow path, so I suggest to use less variables and
compute them on the fly. Here is a new version of the patch.

Eric

8<--------------------------------------------------------
From: Samu Onkalo <samu.p.onkalo@nokia.com>
It is possible to read position information at the chip measurement
rate via sysfs. This patch adds possibility to configure chip
measurement rate.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/hwmon/lis3lv02d.c |   50 ++++++++++++++++++++++++++++++++++++++---=
---
 drivers/hwmon/lis3lv02d.h |    2 +
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index a953a54..61c1973 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -121,18 +121,34 @@ static void lis3lv02d_get_xyz(struct lis3lv02d *lis3,=
 int *x, int *y, int *z)
 static int lis3_12_rates[4] =3D {40, 160, 640, 2560};
 static int lis3_8_rates[2] =3D {100, 400};
=20
+/* ODR is Output Data Rate */
 static int lis3lv02d_get_odr(void)
 {
 	u8 ctrl;
-	int val;
+	int shift;
=20
 	lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
+	ctrl &=3D lis3_dev.odr_mask;
+	shift =3D ffs(lis3_dev.odr_mask) - 1;
+	return lis3_dev.odrs[(ctrl >> shift)];
+}
=20
-	if (lis3_dev.whoami =3D WAI_12B)
-		val =3D lis3_12_rates[(ctrl & (CTRL1_DF0 | CTRL1_DF1)) >> 4];
-	else
-		val =3D lis3_8_rates[(ctrl & CTRL1_DR) >> 7];
-	return val;
+static int lis3lv02d_set_odr(int rate)
+{
+	u8 ctrl;
+	int i, len, shift;
+
+	lis3_dev.read(&lis3_dev, CTRL_REG1, &ctrl);
+	ctrl &=3D ~lis3_dev.odr_mask;
+	len =3D 1 << hweight_long(lis3_dev.odr_mask); /* # of possible values */
+	shift =3D ffs(lis3_dev.odr_mask) - 1;
+
+	for (i =3D 0; i < len; i++)
+		if (lis3_dev.odrs[i] =3D rate) {
+			lis3_dev.write(&lis3_dev, CTRL_REG1, ctrl | (i << shift));
+			return 0;
+		}
+	return -EINVAL;
 }
=20
 static int lis3lv02d_selftest(struct lis3lv02d *lis3, s16 results[3])
@@ -438,9 +454,25 @@ static ssize_t lis3lv02d_rate_show(struct device *dev,
 	return sprintf(buf, "%d\n", lis3lv02d_get_odr());
 }
=20
+static ssize_t lis3lv02d_rate_set(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	unsigned long rate;
+
+	if (strict_strtoul(buf, 0, &rate))
+		return -EINVAL;
+
+	if (lis3lv02d_set_odr(rate))
+		return -EINVAL;
+
+	return count;
+}
+
 static DEVICE_ATTR(selftest, S_IRUSR, lis3lv02d_selftest_show, NULL);
 static DEVICE_ATTR(position, S_IRUGO, lis3lv02d_position_show, NULL);
-static DEVICE_ATTR(rate, S_IRUGO, lis3lv02d_rate_show, NULL);
+static DEVICE_ATTR(rate, S_IRUGO | S_IWUSR, lis3lv02d_rate_show,
+					    lis3lv02d_rate_set);
=20
 static struct attribute *lis3lv02d_attributes[] =3D {
 	&dev_attr_selftest.attr,
@@ -485,12 +517,16 @@ int lis3lv02d_init_device(struct lis3lv02d *dev)
 		dev->read_data =3D lis3lv02d_read_12;
 		dev->mdps_max_val =3D 2048;
 		dev->pwron_delay =3D LIS3_PWRON_DELAY_WAI_12B;
+		dev->odrs =3D lis3_12_rates;
+		dev->odr_mask =3D CTRL1_DF0 | CTRL1_DF1;
 		break;
 	case WAI_8B:
 		printk(KERN_INFO DRIVER_NAME ": 8 bits sensor found\n");
 		dev->read_data =3D lis3lv02d_read_8;
 		dev->mdps_max_val =3D 128;
 		dev->pwron_delay =3D LIS3_PWRON_DELAY_WAI_8B;
+		dev->odrs =3D lis3_8_rates;
+		dev->odr_mask =3D CTRL1_DR;
 		break;
 	default:
 		printk(KERN_ERR DRIVER_NAME
diff --git a/drivers/hwmon/lis3lv02d.h b/drivers/hwmon/lis3lv02d.h
index 1e9fb03..f73c786 100644
--- a/drivers/hwmon/lis3lv02d.h
+++ b/drivers/hwmon/lis3lv02d.h
@@ -208,6 +208,8 @@ struct lis3lv02d {
 	int (*write) (struct lis3lv02d *lis3, int reg, u8 val);
 	int (*read) (struct lis3lv02d *lis3, int reg, u8 *ret);
=20
+	int                     *odrs;     /* Supported output data rates */
+	u8                      odr_mask;  /* ODR bit mask */
 	u8			whoami;    /* indicates measurement precision */
 	s16 (*read_data) (struct lis3lv02d *lis3, int reg);
 	int			mdps_max_val;
--=20
1.6.5.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
