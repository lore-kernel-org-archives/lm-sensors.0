From: Wolfram Sang <w.sang@pengutronix.de>
Date: Wed, 02 Mar 2011 18:16:51 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon: Add support for Texas
Message-Id: <20110302181651.GA24054@pengutronix.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7896776257402210192=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20110224174807.41c7597f@endymion.delvare>
 <1298639897-26856-1-git-send-email-eibach@gdsys.de>
 <20110302185718.3c0e06dc@endymion.delvare>
In-Reply-To: <20110302185718.3c0e06dc@endymion.delvare>
To: Jean Delvare <khali@linux-fr.org>
Cc: Dirk Eibach <eibach@gdsys.de>, linux-kernel@vger.kernel.org, guenter.roeck@ericsson.com, lm-sensors@lm-sensors.org, rdunlap@xenotime.net, linux-doc@vger.kernel.org


--===============7896776257402210192==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +#ifdef CONFIG_OF
> > +	/* fallback on OF */
> > +	of_channels =3D of_get_property(np, "exported-channels",
> > +				      &of_channels_size);
> > +	if (of_channels && (of_channels_size =3D=3D sizeof(*of_channels)))
> > +		return be32_to_cpup(of_channels);
> > +#endif
>=20
> The be32 thing looks odd. I don't get the idea, but as I don't know
> much about devicetree, I'll trust you.

That's okay. The properties are be32 (coming from powerpc).

Still, there is a new property defined which _always_ needs

a) CCing devicetree-discuss (get_maintainer helps here)
b) Documentation in Documentation/devicetree/bindings

because it needs to be a lot more stable than platform_data.

(I already lost the original mail, so I sadly can't forward it)

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk1uiZMACgkQD27XaX1/VRuKVQCcCl2gktfLIVFlib1/uQi1yDpe
MLUAn238BQ+kPb+WCKpIDlQ05nypgZqG
=zf8L
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--


--===============7896776257402210192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7896776257402210192==--
