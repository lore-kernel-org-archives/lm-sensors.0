From: Lukasz Majewski <l.majewski@majess.pl>
Date: Sun, 08 Feb 2015 20:52:43 +0000
Subject: Re: [lm-sensors] [PATCH v3 6/8] hwmon: pwm-fan: Extract __set_pwm() function to only modify PWM duty
Message-Id: <20150208215243.22085c97@jawa>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3012565945137461186=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
	<1423241948-31981-1-git-send-email-l.majewski@samsung.com>
	<1423241948-31981-7-git-send-email-l.majewski@samsung.com>
	<20150206182725.GA25410@roeck-us.net>
In-Reply-To: <20150206182725.GA25410@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>

--===============3012565945137461186==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/BPabe_PY5yHylU13fGbDcaU"; protocol="application/pgp-signature"

--Sig_/BPabe_PY5yHylU13fGbDcaU
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Feb 2015 10:27:25 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Feb 06, 2015 at 05:59:06PM +0100, Lukasz Majewski wrote:
> > It was necessary to decouple code handling writing to sysfs from
> > the one responsible for setting PWM of the fan.
> > Due to that, new __set_pwm() method was extracted, which is
> > responsible for only setting new PWM duty cycle.
> >=20
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> > Changes for v2:
> > - None
> > Changes for v3:
> > - The commit headline has been reedited.
> > ---
> >  drivers/hwmon/pwm-fan.c | 35 ++++++++++++++++++++++-------------
> >  1 file changed, 22 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > index 1991d903..870e100 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -33,21 +33,15 @@ struct pwm_fan_ctx {
> >  	unsigned char pwm_value;
> >  };
> > =20
> > -static ssize_t set_pwm(struct device *dev, struct device_attribute
> > *attr,
> > -		       const char *buf, size_t count)
> > +static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> >  {
> > -	struct pwm_fan_ctx *ctx =3D dev_get_drvdata(dev);
> > -	unsigned long pwm, duty;
> > -	ssize_t ret;
> > -
> > -	if (kstrtoul(buf, 10, &pwm) || pwm > MAX_PWM)
> > -		return -EINVAL;
> > -
> > -	mutex_lock(&ctx->lock);
> > +	unsigned long duty;
> > +	int ret;
> > =20
> >  	if (ctx->pwm_value =3D=3D pwm)
> > -		goto exit_set_pwm_no_change;
> > +		return 0;
> > =20
> Why did you move this check outside the lock ? With this change there=20
> is no guarantee that pwm_value wasn't changed while waiting for the
> lock.

Grrr. You are obviously right here. I will fix this. Thanks for spotting

Best regards,
Lukasz Majewski

>=20
> Guenter
>=20
> > +	mutex_lock(&ctx->lock);
> >  	if (pwm =3D=3D 0) {
> >  		pwm_disable(ctx->pwm);
> >  		goto exit_set_pwm;
> > @@ -66,13 +60,28 @@ static ssize_t set_pwm(struct device *dev,
> > struct device_attribute *attr,=20
> >  exit_set_pwm:
> >  	ctx->pwm_value =3D pwm;
> > -exit_set_pwm_no_change:
> > -	ret =3D count;
> >  exit_set_pwm_err:
> >  	mutex_unlock(&ctx->lock);
> >  	return ret;
> >  }
> > =20
> > +static ssize_t set_pwm(struct device *dev, struct device_attribute
> > *attr,
> > +		       const char *buf, size_t count)
> > +{
> > +	struct pwm_fan_ctx *ctx =3D dev_get_drvdata(dev);
> > +	unsigned long pwm;
> > +	int ret;
> > +
> > +	if (kstrtoul(buf, 10, &pwm) || pwm > MAX_PWM)
> > +		return -EINVAL;
> > +
> > +	ret =3D __set_pwm(ctx, pwm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return count;
> > +}
> > +
> >  static ssize_t show_pwm(struct device *dev,
> >  			struct device_attribute *attr, char *buf)
> >  {
> > --=20
> > 2.0.0.rc2
> >=20


--Sig_/BPabe_PY5yHylU13fGbDcaU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlTXzKEACgkQf9/hG2YwgjHPugCcCxRGEjB5x5p9qUUvPITaXmeO
hZMAoKxxfV0eHZqPvPfA1EPQ3mxFT2+r
=jamh
-----END PGP SIGNATURE-----

--Sig_/BPabe_PY5yHylU13fGbDcaU--


--===============3012565945137461186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3012565945137461186==--
