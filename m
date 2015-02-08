From: Lukasz Majewski <l.majewski@majess.pl>
Date: Sun, 08 Feb 2015 21:36:40 +0000
Subject: Re: [lm-sensors] [PATCH v3 7/8] hwmon: pwm-fan: Read PWM FAN configuration from device tree
Message-Id: <20150208223640.2bcab3f4@jawa>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5966677313116798785=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
	<1423241948-31981-1-git-send-email-l.majewski@samsung.com>
	<1423241948-31981-8-git-send-email-l.majewski@samsung.com>
	<20150206183657.GB25410@roeck-us.net>
In-Reply-To: <20150206183657.GB25410@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Lukasz Majewski <l.majewski@samsung.com>, Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Kukjin Kim <kgene@kernel.org>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>

--===============5966677313116798785==
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/+hMmTFW8Us69PM6y8Y9dwAP"; protocol="application/pgp-signature"

--Sig_/+hMmTFW8Us69PM6y8Y9dwAP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Feb 2015 10:36:57 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Feb 06, 2015 at 05:59:07PM +0100, Lukasz Majewski wrote:
> > This patch provides code for reading PWM FAN configuration data via
> > device tree. The pwm-fan can work with full speed when configuration
> > is not provided. However, errors are propagated when wrong DT
> > bindings are found.
> > Additionally the struct pwm_fan_ctx has been extended.
> >=20
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> > Changes for v2:
> > - Rename pwm_fan_max_states to pwm_fan_cooling_levels
> > - Moving pwm_fan_of_get_cooling_data() call after setting end
> > enabling PWM FAN
> > - pwm_fan_of_get_cooling_data() now can fail - preserving old
> > behaviour
> > - Remove unnecessary dev_err() call
> > Changes for v3:
> > - Patch's headline has been reedited
> > - pwm_fan_of_get_cooling_data() return code is now being checked.
> > - of_property_count_elems_of_size() is now used instead
> > of_find_property()
> > - More verbose patch description added
> > ---
> >  drivers/hwmon/pwm-fan.c | 54
> > ++++++++++++++++++++++++++++++++++++++++++++++++- 1 file changed,
> > 53 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
> > index 870e100..f3f5843 100644
> > --- a/drivers/hwmon/pwm-fan.c
> > +++ b/drivers/hwmon/pwm-fan.c
> > @@ -30,7 +30,10 @@
> >  struct pwm_fan_ctx {
> >  	struct mutex lock;
> >  	struct pwm_device *pwm;
> > -	unsigned char pwm_value;
> > +	unsigned int pwm_value;
> > +	unsigned int pwm_fan_state;
> > +	unsigned int pwm_fan_max_state;
> > +	unsigned int *pwm_fan_cooling_levels;
> >  };
> > =20
> >  static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
> > @@ -100,6 +103,50 @@ static struct attribute *pwm_fan_attrs[] =3D {
> > =20
> >  ATTRIBUTE_GROUPS(pwm_fan);
> > =20
> > +int pwm_fan_of_get_cooling_data(struct device *dev, struct
> > pwm_fan_ctx *ctx) +{
> > +	struct device_node *np =3D dev->of_node;
> > +	int num, i, ret;
> > +
> > +	ret =3D of_property_count_elems_of_size(np, "cooling-levels",
> > +					      sizeof(u32));
> > +
> > +	if (ret =3D=3D -EINVAL) {
> > +		dev_err(dev, "Property 'cooling-levels' not
> > found\n");
> > +		return 0;
>=20
> Returning 0 is obviously not an error, otherwise you would not return
> 0 here. So dev_err is wrong.

pr_info would be more appropriate here.

> Also, the message itself is wrong; the
> property may well be there but have a wrong size.

As fair as I remember the -EINVAL is set only when the property is not
defined. Such situation is correct and our pwm-fan driver should work
with or without it.

>=20
> > +	}
> > +
> > +	if (ret <=3D 0) {
> > +		dev_err(dev, "Wrong data!\n");
> > +		return ret;
> > +	}
>=20
> This will result in the driver failing to load if devicetree is not
> configured (of_property_count_elems_of_size will return -ENOSYS).

As you pointed out in the comment to v2:

It is OK if the "cooling-levels" is not defined in DT. However, if it
has broken definition, then we should return error. This is what we do
here.

> This is not acceptable. Also, if the call returns 0 you don't return
> an error but display a "Wrong data!" error message. Either it is an
> error or it is not, but not both.

This is an error. "cooling-levels" with zero elements is regarded as a
broken property.

>=20
> Guenter

Best regards,
Lukasz Majewski

--Sig_/+hMmTFW8Us69PM6y8Y9dwAP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlTX1u0ACgkQf9/hG2YwgjHNCwCgmdzCrtrrTrc04aWadFadgw0U
6xkAn02yLnUrvgoGRrwd1YaewWk6yRfL
=livi
-----END PGP SIGNATURE-----

--Sig_/+hMmTFW8Us69PM6y8Y9dwAP--


--===============5966677313116798785==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5966677313116798785==--
