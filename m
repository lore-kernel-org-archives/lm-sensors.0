From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sun, 18 May 2014 08:36:16 +0000
Subject: Re: [lm-sensors] Dell Latitude E6440 & i8k
Message-Id: <201405181036.16704@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6762703188879992539=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20140518101910.35059ee7@endymion.delvare>
In-Reply-To: <20140518101910.35059ee7@endymion.delvare>
To: lm-sensors@vger.kernel.org

--===============6762703188879992539==
Content-Type: multipart/signed;
  boundary="nextPart280083472.T4ZWy06Ems";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart280083472.T4ZWy06Ems
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 18 May 2014 10:19:10 Jean Delvare wrote:
> Please leave the list in Cc.
>=20

Sorry I forgot, but after that I resent original message to list.

> On Sun, 18 May 2014 00:52:13 +0200, Pali Roh=C3=A1r wrote:
> > Do you know if there is any way to extract BIOS SMM code? Or
> > it is something which is not possible to do from OS/kernel
> > side?
>=20
> If you download a BIOS update for your laptop from Dell, the
> SMM code is certainly somewhere in the binary blob which gets
> flashed to the EEPROM. But extracting that code from there
> would certainly be challenge.

Yes extracting it from bios flashing image was only idea which I=20
got and I doubt I can do it... (specially when dell bios is=20
compressed and image itself contains flashing program...)

What I now found is this table of SMM commands:
https://lkml.org/lkml/2008/12/18/44

So it looks like SMM data are in some NBSVC.MDM binary. Do you=20
know something more about it?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart280083472.T4ZWy06Ems
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlN4cQAACgkQi/DJPQPkQ1JkxACcDmYy7Nf0ZX42f+S0vuSiNeU/
7/kAoL/X2r7xw6XELqYru/wq1ztlDPOL
=Q49W
-----END PGP SIGNATURE-----

--nextPart280083472.T4ZWy06Ems--


--===============6762703188879992539==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6762703188879992539==--
