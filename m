From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Sun, 12 Feb 2012 10:05:34 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon/mc13xxx-adc: add support for the MC13892 PMIC
Message-Id: <20120212100534.GD14173@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327939078-4906-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1327939078-4906-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Jean,

On Sat, Feb 11, 2012 at 09:54:31PM +0100, Jean Delvare wrote:
> On Sat, 11 Feb 2012 21:15:13 +0100, Uwe Kleine-K=F6nig wrote:
> > On Fri, Feb 10, 2012 at 08:46:20PM +0100, Jean Delvare wrote:
> > > From the MC13892 datasheet:
> > >=20
> > > "TSX1 AND TSX2, TSY1 AND TSY2 (...)
> > >=20
> > > Touch Screen Interfaces X1 and X2, Y1 and Y2. The touch screen X plate
> > > is connected to TSX1 and TSX2, while the Y plate is connected to Y1 a=
nd
> > > Y2. **In inactive mode, these pins can also be used as general purpose
> > > ADC inputs.** They are respectively mapped on ADC channels 4, 5, 6, a=
nd
> > > 7. In interrupt mode, a voltage is applied to the X-plate (TSX2) via a
> > > weak current source to VCORE, while the Y-plate is connected to ground
> > > (TSY1)."
> > >=20
> > > So this doesn't seem to be fundamentally different from the MC13783, =
hm?
> >
> > Hmm, it seems you're right and either my memory doesn't serve me right
> > or I never understood it correctly.
> >=20
> > If you ask me it's OK to implement that when the first machine is using
> > that.
>=20
> I am working for someone who has such a machine. That was the reason
> why I asked.
Ah, an I already wondered (positively) about you checking the hardware
manual that carefully. :-)
=20
> > And moreover I don't currently have a machine at hand with an
> > mc13892, so I couldn't test these inputs in an eventual v5 patch.
> >=20
> > Is it OK for you to take the patch as is, too?
>=20
> It is OK, but I would at least add a comment in the code to clarify.
>=20
> That being said, the fix seems to be as simple as moving 3 lines of
> code out of a conditional, so why not just do that?
Yeah, that and a corresponding change in the error handling and the
remove callback.

I will follow up with a patch that introduces the following diff
compared to v4:

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index e9a7659d..10f18dd 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -202,12 +202,13 @@ static int __init mc13783_adc_probe(struct platform_d=
evice *pdev)
 		if (ret)
 			goto out_err_create_16chans;
=20
-		if (!mc13783_adc_use_touchscreen(pdev)) {
-			ret =3D sysfs_create_group(&pdev->dev.kobj,
-					&mc13783_group_ts);
-			if (ret)
-				goto out_err_create_ts;
-		}
+	}
+
+	if (!mc13783_adc_use_touchscreen(pdev)) {
+		ret =3D sysfs_create_group(&pdev->dev.kobj,
+				&mc13783_group_ts);
+		if (ret)
+			goto out_err_create_ts;
 	}
=20
 	priv->hwmon_dev =3D hwmon_device_register(&pdev->dev);
@@ -222,13 +223,12 @@ static int __init mc13783_adc_probe(struct platform_d=
evice *pdev)
=20
 out_err_register:
=20
-	if (id->driver_data & MC13783_ADC_16CHANS) {
-		if (!mc13783_adc_use_touchscreen(pdev))
-			sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
+	if (!mc13783_adc_use_touchscreen(pdev))
+		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
 out_err_create_ts:
=20
+	if (id->driver_data & MC13783_ADC_16CHANS)
 		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_16chans);
-	}
 out_err_create_16chans:
=20
 	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
@@ -247,12 +247,11 @@ static int __devexit mc13783_adc_remove(struct platfo=
rm_device *pdev)
=20
 	hwmon_device_unregister(priv->hwmon_dev);
=20
-	if (driver_data & MC13783_ADC_16CHANS) {
-		if (!mc13783_adc_use_touchscreen(pdev))
-			sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
+	if (!mc13783_adc_use_touchscreen(pdev))
+		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);
=20
+	if (driver_data & MC13783_ADC_16CHANS)
 		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_16chans);
-	}
=20
 	sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_base);
=20
Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
