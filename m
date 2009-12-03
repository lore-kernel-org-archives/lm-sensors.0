From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Thu, 03 Dec 2009 21:00:14 +0000
Subject: [lm-sensors] [PATCH] [hwmon] mc13783-adc: handle failure of
Message-Id: <1259874014-14621-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

If reading the result of a channel fails pass the failure to userspace.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Luotao Fu <l.fu@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Eric Piel <eric.piel@tremplin-utc.net>
Cc: Jean Delvare <khali@linux-fr.org>
---
Hello Jean,

can you please squash this into the commit "hwmon: Add Freescale MC13783 ADC
driver" you already took?  Assuming it looks OK of course.

Best regards
Uwe

 drivers/hwmon/mc13783-adc.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index fafb193..4018757 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -40,27 +40,38 @@ static ssize_t mc13783_adc_show_name(struct device *dev=
, struct device_attribute
 	return sprintf(buf, "mc13783_adc\n");
 }
=20
-static unsigned int mc13783_adc_read(struct device *dev,
-		struct device_attribute *devattr)
+static int mc13783_adc_read(struct device *dev,
+		struct device_attribute *devattr, unsigned int *res)
 {
 	struct platform_device *pdev =3D to_platform_device(dev);
 	struct mc13783_adc_priv *priv =3D platform_get_drvdata(pdev);
 	struct sensor_device_attribute *attr =3D to_sensor_dev_attr(devattr);
 	unsigned int channel =3D attr->index;
 	unsigned int sample[4];
+	int ret;
=20
-	mc13783_adc_do_conversion(priv->mc13783, MC13783_ADC_MODE_MULT_CHAN,
+	ret =3D mc13783_adc_do_conversion(priv->mc13783,
+			MC13783_ADC_MODE_MULT_CHAN,
 			channel, sample);
=20
+	if (ret)
+		return ret;
+
 	channel &=3D 0x7;
=20
-	return (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
+	*res =3D (sample[channel % 4] >> (channel > 3 ? 14 : 2)) & 0x3ff;
+
+	return ret;
 }
=20
 static ssize_t mc13783_adc_read_bp(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
-	unsigned res =3D mc13783_adc_read(dev, devattr);
+	unsigned res;
+	int ret =3D mc13783_adc_read(dev, devattr, &res);
+
+	if (ret)
+		return ret;
=20
 	/*
 	 * BP (channel 2) reports with offset 2.4V to the actual value to fit
@@ -74,7 +85,11 @@ static ssize_t mc13783_adc_read_bp(struct device *dev,
 static ssize_t mc13783_adc_read_gp(struct device *dev,
 		struct device_attribute *devattr, char *buf)
 {
-	unsigned res =3D mc13783_adc_read(dev, devattr);
+	unsigned res;
+	int ret =3D mc13783_adc_read(dev, devattr, &res);
+
+	if (ret)
+		return ret;
=20
 	/*
 	 * input range is [0, 2.3V], res has 10 bits, so each bit
--=20
1.6.5.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
