From: Simon Guinot <simon.guinot@sequanux.org>
Date: Mon, 23 Feb 2015 14:34:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) allow to use alarm support alone from DT
Message-Id: <20150223143416.GT1509@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7595887841644775996=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696334-14767-1-git-send-email-simon.guinot@sequanux.org>
 <54EB33D4.1000804@roeck-us.net>
In-Reply-To: <54EB33D4.1000804@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org


--===============7595887841644775996==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m3EZO/+NOdcYnaJL"
Content-Disposition: inline


--m3EZO/+NOdcYnaJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 06:06:12AM -0800, Guenter Roeck wrote:
> On 02/23/2015 04:58 AM, Simon Guinot wrote:
> >On some boards, such as the LaCie 2Big Network v2 or 2Big NAS (based on
> >Marvell Kirkwood SoCs), an I2C fan controller is used but the alarm
> >signal is wired to a separate GPIO. Unfortunately, the gpio-fan driver
> >can't be used to handle GPIO alarm alone from DT: an error is returned
> >if the "gpios" DT property is missing.
> >
> >This patch allows to use the gpio-fan driver even if the "alarm-gpios"
> >DT property is defined alone.
> >
>=20
> That is the wrong solution. The gpio alarm signal should be handled
> by the fan controller driver.

Hi Guenter,

Sure it should, but unfortunately it is not the case. I have several
boards using this mechanism (ie: a separate fan alarm GPIO). I think the
idea was to reduce the board cost...

Then this means I need a way to support this alarm signal and I can't
find a better one than using gpio-fan. Note that this was possible with
the original gpio-fan implementation (before the DT binding addition).

Let me know what you think.

Simon

>=20
> Guenter
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--m3EZO/+NOdcYnaJL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlTrOmgACgkQgtp0PDeOcDomNwCfeQzJ7Hq0cJk0/5by9WePg//c
zuAAoJhBrAuC08nE4RQOGwySfo+UOFyx
=KLyA
-----END PGP SIGNATURE-----

--m3EZO/+NOdcYnaJL--


--===============7595887841644775996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7595887841644775996==--
