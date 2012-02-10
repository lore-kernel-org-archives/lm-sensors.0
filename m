From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Date: Fri, 10 Feb 2012 10:47:36 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon/mc13xxx-adc: add support for the MC13892 PMIC
Message-Id: <20120210104736.GA14173@pengutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327939078-4906-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1327939078-4906-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,

On Fri, Feb 10, 2012 at 10:40:35AM +0100, Jean Delvare wrote:
> On Mon, 30 Jan 2012 16:57:58 +0100, Uwe Kleine-K=F6nig wrote:
> > -	if (!mc13783_adc_use_touchscreen(pdev)) {
> > -		ret =3D sysfs_create_group(&pdev->dev.kobj, &mc13783_group_ts);
> > +	if (id->driver_data & MC13783_ADC_16CHANS) {
> > +		ret =3D sysfs_create_group(&pdev->dev.kobj,
> > +				&mc13783_group_16chans);
> >  		if (ret)
> > -			goto out_err_create2;
> > +			goto out_err_create_16chans;
> > +
> > +		if (!mc13783_adc_use_touchscreen(pdev)) {
> > +			ret =3D sysfs_create_group(&pdev->dev.kobj,
> > +					&mc13783_group_ts);
> > +			if (ret)
> > +				goto out_err_create_ts;
> > +		}
> >  	}
>=20
> Hmm, this means that the touchscreen inputs are _never_ exposed for the
> MC13892, even though the documentation says these inputs exist on that
> chip. Is this an oversight, or is there a good reason to not expose
> these inputs on the MC13892?
No, that's correct. The mc13782's touchscreen inputs can be used for
touch (in that case they are not used in the mc13783-adc driver) or as
general purpose input (in which case mc13783_group_ts is used). For the
mc13892 the touch lines are dedicated for touch and there is no general
purpose functionallity, so on mc13892 mc13783_group_ts is never
instantiated.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
