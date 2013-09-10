From: Mark Brown <broonie@kernel.org>
Date: Tue, 10 Sep 2013 10:09:39 +0000
Subject: Re: [lm-sensors] [PATCH v3 1/2] hwmon: (lm90) Add power control
Message-Id: <20130910100939.GW29403@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5357230689541308807=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1378722552-10357-2-git-send-email-wni@nvidia.com>
 <20130909111242.GW29403@sirena.org.uk>
 <522DB253.6000707@roeck-us.net>
 <20130909135022.GZ29403@sirena.org.uk>
 <20130909155043.GA18975@roeck-us.net>
 <522E9059.3070305@nvidia.com>
 <522E93D6.2010304@roeck-us.net>
 <522E94AE.7000804@wwwdotorg.org>
 <522E97CE.4070300@roeck-us.net>
 <522E9C84.9070405@wwwdotorg.org>
In-Reply-To: <522E9C84.9070405-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org" <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, "lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org" <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


--===============5357230689541308807==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c8/nVrK+l7NVnhuJ"
Content-Disposition: inline


--c8/nVrK+l7NVnhuJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 09, 2013 at 10:13:56PM -0600, Stephen Warren wrote:
> On 09/09/2013 09:53 PM, Guenter Roeck wrote:

> > Earlier comments suggest that this is not the intended use case for
> > regulator_get_optional().

That's right.

> Isn't the issue only whether the optional aspect of the regulator is
> implemented by:

> a) regulator_get_optional() returning failure, then the driver having to
> check for that and either using or not-using the regulator.

> b) regulator_get_optional() returning a dummy regulator automatically
> when none is specified in DT or the regulator lookup table, and hence
> the driver can always call regulator_enable/disable on the returned value.

No.  There are a couple of issues here.  One is that we don't want to
litter all drivers with conditional code to check if they actually got
the regulator and so on, that's just pointless make work on the part of
consumers.  The other is that just ignoring errors is generally terrible
practice which we don't want to encourage - ignoring the specific case
where nothing is provided and the system has control of that is one
thing but just ignoring any error is another.

--c8/nVrK+l7NVnhuJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSLu/gAAoJELSic+t+oim9st0QAIBzYhygWAp1nFT6aRIQ/hiV
NsT7q+hxwz2ckZJ6X+Mkdh2eO5yJoB4gjNhpBFJBBwW6OWk3R1qpvFWZm9aQPO6p
9IFoRaR7f6ypm46QnfVqTZwhx/AT4drOyUvO9NRTks7NILtpdSGyhS9AJfhQ/t7Z
03Ru9UgQOujp+fNM30Fqe1QlMTUd4IY3pV+BXPn8XY1sND00uWK9eQBRejXX35Cq
eSG+nczTr+j+flFCZI3PZ5chb8/cZiTptG07dL0hipilV6Fo3+TFmlsq5K6yxMXi
DMdDzfSz8GHlDAftDZUxFGGI9yNturEoUPWs4j6ZEf7qvzlkZEZ97FNDrNAOrofY
WuYIIW1Bhy7QI8fJqB6SepLQjkPkXJGsO5mkhZgR4mXcxv7oll9Up0uyT5vZxv/S
4x1MpwUZWT5jBCyZyZ6hQKcZ5HFTapvm2GqZhrqXAq81Iv5o+qb14jZq+rDhrMDR
En+pDheuLf0FvYXIwLV4emdUjc6n9jxJdEqkNihPj5SqZxuBbLREC3Xhh9/0wMnO
uRoem2XUpQSo6g2unL1q5ofPvxc7iUYNg2IoTszrgiX8o/4hZXSAuyiu2hQpkqQn
sXzW9C4arxrS2OwpCLC5igu33ZwfAN13d2nE+MQM1tKzFJgDIeSGxcf7ACoW+wn0
5uCsP2/9UrK8w+aUuhv9
=BrDQ
-----END PGP SIGNATURE-----

--c8/nVrK+l7NVnhuJ--


--===============5357230689541308807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5357230689541308807==--
