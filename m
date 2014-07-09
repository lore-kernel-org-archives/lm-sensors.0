From: Simon Guinot <simon.guinot@sequanux.org>
Date: Wed, 09 Jul 2014 15:19:51 +0000
Subject: Re: [lm-sensors] [PATCH RFT] hwmon: (gpio-fan) Convert to devm_hwmon_device_register_with_groups
Message-Id: <20140709151950.GC15428@kw.sim.vm.gnt>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3585012464776243176=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1402728650.25269.1.camel@phoenix>
In-Reply-To: <1402728650.25269.1.camel@phoenix>
To: lm-sensors@vger.kernel.org


--===============3585012464776243176==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2014 at 06:26:00AM -0700, Guenter Roeck wrote:
> On 06/13/2014 11:50 PM, Axel Lin wrote:
> >This simplifies the code a bit and also ensures the attribute groups are
> >properly removed from sysfs when unload the module.
> >
> >Signed-off-by: Axel Lin <axel.lin@ingics.com>
>=20
> Hmm ... no idea why I did not use the devm_ function to start with. Appli=
ed to -next.
>=20
> On a side note, I wonder if the interrupt handler works on this one.
> Shared edge triggered interrupts used to be not supported, or my memory i=
s wrong.
> If I find some time, I may build a little test board to give this a try.

Hi Guenter,

Last time I checked it was OK with my ns2 Max board (DTS file
kirkwood-ns2max.dts).

Simon

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlO9XZYACgkQgtp0PDeOcDqb1wCcCoQzC8R4Zr98mDMA5X5HKZbI
MJsAnRaqLQU5uATwhmjFMSWj/UdII4sx
=9bmK
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--


--===============3585012464776243176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3585012464776243176==--
