From: Sven Anders <anders@anduras.de>
Date: Mon, 17 Nov 2008 17:05:30 +0000
Subject: Re: [lm-sensors] ipmisensors to use or not to use?
Message-Id: <4921A45A.7010907@anduras.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3169429040193333737=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4918C638.7010202@anduras.de>
In-Reply-To: <4918C638.7010202@anduras.de>
To: lm-sensors@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============3169429040193333737==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig01987AA69575FDBEE98C8901"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig01987AA69575FDBEE98C8901
Content-Type: multipart/mixed; boundary="------------000405020809030206040907"

This is a multi-part message in MIME format.
--------------000405020809030206040907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Sven Anders schrieb:
>
> I'm running Linux kernel 2.6.26 and want to get sensor
> data from IPMI subsystem via lm-sensors.
>=20
> In the documentation I read I should use the ipmisensors
> modules (the successor of the bmcsensors module).
>=20
> The latest patch I found, does not compile clearly with
> newer kernels. I tried to fix the patch, but after that
> failed, I took a closer look and it seems I have to
> change too much. So here my question:
>=20
>  Is the patch still the way to go or should I use
>  any other way to get the data via lm-sensors (or
>  direct access to /sys)?

Hmm?!
Does nobody know or is nobody willing to answer?

I'm thinking of updating the patch for newer kernel, but
as my time is limited, I would only do this, if it's the
right way and it has a chance to be integrated in the
kernel.

Cheers
 Sven

--=20
 Sven Anders <anders@anduras.de>                 () Ascii Ribbon Campaign=

                                                 /\ Support plain text e-=
mail
 ANDURAS service solutions AG
 Innstra=C3=9Fe 71 - 94036 Passau - Germany
 Web: www.anduras.de - Tel: +49 (0)851-4 90 50-0 - Fax: +49 (0)851-4 90 5=
0-55

Rechtsform: Aktiengesellschaft - Sitz: Passau - Amtsgericht Passau HRB 60=
32
Mitglieder des Vorstands: Sven Anders, Marcus Junker
Vorsitzender des Aufsichtsrats: Mark Peters

--------------000405020809030206040907
Content-Type: text/x-vcard; charset=utf-8;
 name="anders.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="anders.vcf"

YmVnaW46dmNhcmQNCmZuOlN2ZW4gQW5kZXJzDQpuOkFuZGVycztTdmVuDQpvcmc6QU5EVVJB
UyBBRztSZXNlYXJjaCBhbmQgRGV2ZWxvcG1lbnQNCmFkcjtxdW90ZWQtcHJpbnRhYmxlOjs7
SW5uc3RyYT1DMz05RmUgNzE7UGFzc2F1O0JhdmFyaWE7OTQwMzY7R2VybWFueQ0KZW1haWw7
aW50ZXJuZXQ6YW5kZXJzQGFuZHVyYXMuZGUNCnRpdGxlOkRpcGwuIEluZi4NCnRlbDt3b3Jr
OisrNDkgKDApODUxIC8gNDkwIDUwIC0wDQp0ZWw7ZmF4OisrNDkgKDApODUxIC8gNTkwIDUw
IC0gNTUNCngtbW96aWxsYS1odG1sOkZBTFNFDQp1cmw6aHR0cDovL3d3dy5hbmR1cmFzLmRl
DQp2ZXJzaW9uOjIuMQ0KZW5kOnZjYXJkDQoNCg==
--------------000405020809030206040907--

--------------enig01987AA69575FDBEE98C8901
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFJIaRj5lKZ7Feg4EcRAkuUAJ9J2G1nSwTR3O6EcYH8jV6i1Qw8OwCeLJJp
0Cptj5NHdE1ed8cFOa0IvHg=
=jcx1
-----END PGP SIGNATURE-----

--------------enig01987AA69575FDBEE98C8901--


--===============3169429040193333737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3169429040193333737==--
