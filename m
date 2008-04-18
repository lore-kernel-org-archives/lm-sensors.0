From: Laurent Pinchart <laurentp@cse-semaphore.com>
Date: Fri, 18 Apr 2008 15:35:19 +0000
Subject: Re: [lm-sensors] [PATCH] lm75: Fix lm75a detection
Message-Id: <200804181735.22748.laurentp@cse-semaphore.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2122978541639749649=="
List-Id: <lm-sensors.vger.kernel.org>
References: <200804161334.10533.laurentp@cse-semaphore.com>
In-Reply-To: <200804161334.10533.laurentp@cse-semaphore.com>
To: lm-sensors@vger.kernel.org

--===============2122978541639749649==
Content-Type: multipart/signed; boundary="nextPart8224495.Eq7dZ51jv1";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart8224495.Eq7dZ51jv1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jean,

On Friday 18 April 2008 16:10, Jean Delvare wrote:
> Hello Laurent,
>=20
> On Wed, 16 Apr 2008 13:34:09 +0200, Laurent Pinchart wrote:
> > Philips LM75A temperature sensors don't pass the current detection check
> > as they return 0xffff when reading unimplemented registers instead of t=
he
> > last read value. This patch modifies device detection to accept 0xffff =
as
> > valid values when reading registers 0x04-0x07.
>=20
> In fact almost no LM75 clone mimics the original behavior perfectly so
> they all need to be forced with a module parameter at the moment. I
> have always been reluctant to update the detection code to support them
> all, as this would weaken it to a point where about any device at any
> of the 8 supported I2C addresses would be picked.
>
> May I ask on which system you have the Philips LM75A chip? If that's an
> embedded system where you will end up using the new-style lm75 driver,
> then I'd rather focus on getting this new-style driver ready, instead
> of updating the detection code.

This is indeed an embedded system. I'm fine with focussing on getting the
new-style driver ready.

Do you have more comments on David's patches ? He mentionned receiving no=20
feedback on his smbalert# patch.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart8224495.Eq7dZ51jv1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBICL+68y9gWxC9vpcRApcbAJ9DhHIR5JV7d4FXHUG344pq42orCwCeNsWU
HByDugTrMiJH+9kAuhe4SjE=
=IEI7
-----END PGP SIGNATURE-----

--nextPart8224495.Eq7dZ51jv1--


--===============2122978541639749649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2122978541639749649==--
