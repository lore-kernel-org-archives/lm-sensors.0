From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 21 Oct 2009 07:00:13 +0000
Subject: Re: [lm-sensors] [PATCH] [hwmon] mc13783-adc: fix module unloading
Message-Id: <20091021090013.3ed71c71@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1256064398-27456-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1256064398-27456-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hallo Uwe,

On Tue, 20 Oct 2009 20:46:38 +0200, Uwe Kleine-K=F6nig wrote:
> The wrong device was passed to hwmon_device_unregister, resulting in
>=20
> 	mc13783 spi0.0: hwmon_device_unregister() failed: bad class ID!
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Cc: Luotao Fu <l.fu@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Eric Piel <eric.piel@tremplin-utc.net>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
> Hello Jean,
>=20
> can you either squash this into the commit you already took from me or
> take this, too?

Folded into hwmon-add-freescale-mc13783-adc-driver.patch, thanks.

>=20
> Best regards and thanks
> Uwe
>=20
>  drivers/hwmon/mc13783-adc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
> index 77eead2..e69ee81 100644
> --- a/drivers/hwmon/mc13783-adc.c
> +++ b/drivers/hwmon/mc13783-adc.c
> @@ -199,7 +199,7 @@ static int __devexit mc13783_adc_remove(struct platfo=
rm_device *pdev)
>  {
>  	struct mc13783_adc_priv *priv =3D platform_get_drvdata(pdev);
> =20
> -	hwmon_device_unregister(&pdev->dev);
> +	hwmon_device_unregister(priv->hwmon_dev);
> =20
>  	if (!(priv->mc13783->flags & MC13783_USE_TOUCHSCREEN))
>  		sysfs_remove_group(&pdev->dev.kobj, &mc13783_group_ts);


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
