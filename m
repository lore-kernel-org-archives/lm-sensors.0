From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Wed, 24 Aug 2011 13:28:24 +0000
Subject: [lm-sensors] [PATCH 5/6] hwmon/mc13783-adc: convert to mc13xxx API
Message-Id: <1314192505-23499-5-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110824132740.GA28197@pengutronix.de>
 <1314192505-23499-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1314192505-23499-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Samuel Ortiz <sameo@linux.intel.com>, Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, kernel@pengutronix.de, lm-sensors@lm-sensors.org

The mc13783_... functions are going to be removed, so switch to the
more generic API.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/mc13783-adc.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index d5226c9..ef65ab5 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -31,7 +31,7 @@
 #define MC13783_ADC_NAME	"mc13783-adc"
=20
 struct mc13783_adc_priv {
-	struct mc13783 *mc13783;
+	struct mc13xxx *mc13xxx;
 	struct device *hwmon_dev;
 };
=20
@@ -51,8 +51,8 @@ static int mc13783_adc_read(struct device *dev,
 	unsigned int sample[4];
 	int ret;
=20
-	ret =3D mc13783_adc_do_conversion(priv->mc13783,
-			MC13783_ADC_MODE_MULT_CHAN,
+	ret =3D mc13xxx_adc_do_conversion(priv->mc13xxx,
+			MC13XXX_ADC_MODE_MULT_CHAN,
 			channel, sample);
 	if (ret)
 		return ret;
@@ -147,9 +147,9 @@ static const struct attribute_group mc13783_group_ts =
=3D {
 static int mc13783_adc_use_touchscreen(struct platform_device *pdev)
 {
 	struct mc13783_adc_priv *priv =3D platform_get_drvdata(pdev);
-	unsigned flags =3D mc13783_get_flags(priv->mc13783);
+	unsigned flags =3D mc13xxx_get_flags(priv->mc13xxx);
=20
-	return flags & MC13783_USE_TOUCHSCREEN;
+	return flags & MC13XXX_USE_TOUCHSCREEN;
 }
=20
 static int __init mc13783_adc_probe(struct platform_device *pdev)
@@ -161,7 +161,7 @@ static int __init mc13783_adc_probe(struct platform_dev=
ice *pdev)
 	if (!priv)
 		return -ENOMEM;
=20
-	priv->mc13783 =3D dev_get_drvdata(pdev->dev.parent);
+	priv->mc13xxx =3D dev_get_drvdata(pdev->dev.parent);
=20
 	platform_set_drvdata(pdev, priv);
=20
--=20
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
