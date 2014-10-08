From: Mark Brown <broonie@kernel.org>
Date: Wed, 08 Oct 2014 20:21:17 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/4] hwmon: ltc2978: device tree bindings documentation
Message-Id: <20141008202117.GN4609@sirena.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1214733464127881331=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1412275071-6417-1-git-send-email-atull@opensource.altera.com>
 <1412275071-6417-2-git-send-email-atull@opensource.altera.com>
 <20141006172845.GA21902@roeck-us.net>
 <alpine.DEB.2.02.1410081103110.18439@atx-linux-37>
 <20141008201254.GA21065@roeck-us.net>
In-Reply-To: <20141008201254.GA21065@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: atull <atull@opensource.altera.com>, jdelvare@suse.de, lm-sensors@lm-sensors.org, lgirdwood@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, delicious.quinoa@gmail.com, dinguyen@opensource.altera.com, yvanderv@opensource.altera.com


--===============1214733464127881331==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AS/cuf48TUvH8DlA"
Content-Disposition: inline


--AS/cuf48TUvH8DlA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2014 at 01:12:54PM -0700, Guenter Roeck wrote:
> On Wed, Oct 08, 2014 at 11:12:29AM -0500, atull wrote:

> > > if not specified. We'll have to sort out with the regulator core how this should
> > > be handled.

> Followup on this: Since the regulator core considers the property to be
> mandatory (which I guess makes some sense for a presumed regulator),
> you'll have to check in the calling code and ensure that a 'regulators'
> entry is there prior to calling the regulator code.

We could just lower the severity of the message, it's not mandatory at
all but rather there so that users can figure out what's going wrong if
we fail to parse.

--AS/cuf48TUvH8DlA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNZy8AAoJECTWi3JdVIfQT5EH/j3iZPvZxXMCDdVD8lbUegvx
/DQN/OfQ6ObVZJ/O4449Dcm1N2SowEhR+nJ+pLOaKSmMYfN9OcWBbTbF0WjRvkLD
OxjPfEQOQBhgtSDN9PBa18GM+LSVVV25T5o1qiNcEy+2ZW2kZg6Co5ojsyRS3wrk
LfxGR4XmmeaYFKDYkjfWK4TM2eGAppK+Rc85kbZJ2gvZHSU2DmSmA9UARMxNjm1W
MDy62VrioRJAGdJmvQhzFidY1s8bs0ZxgRgQ+YvsrWNFWxG0+0+2IHhnxKpV6TLw
dvTi8LSVV7qhpE53nHd8KVVLxdcGm4t0WCSTTheV/srxO9G0Sg8w7pY9/ksB5VU=
=jWVj
-----END PGP SIGNATURE-----

--AS/cuf48TUvH8DlA--


--===============1214733464127881331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1214733464127881331==--
