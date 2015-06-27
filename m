From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sat, 27 Jun 2015 16:21:00 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (dell-smm-hwon) Use a valid name attribute
Message-Id: <201506271821.00991@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1360871632432164268=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1435411325-27428-1-git-send-email-gabriele.mzt@gmail.com> <558EB58D.5080003@roeck-us.net>
In-Reply-To: <558EB58D.5080003@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Gabriele Mazzotta <gabriele.mzt@gmail.com>, jdelvare@suse.de, gregkh@linuxfoundation.org, arnd@arndb.de, stevenhoneyman@gmail.com, Valdis.Kletnieks@vt.edu, jochen@penguin-breeder.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

--===============1360871632432164268==
Content-Type: multipart/signed;
  boundary="nextPart2022195.lQrnMa8flK";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2022195.lQrnMa8flK
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 27 June 2015 16:39:09 Guenter Roeck wrote:
> On 06/27/2015 06:22 AM, Gabriele Mazzotta wrote:
> > As per Documentation/hwmon/sysfs-interface, hwmon name attributes
> > must not include '-', so replace 'dell-smm' with 'dell_smm'.
> >=20
> > Fixes: 039ae58503f3 ("hwmon: Allow to compile dell-smm-hwmon driver
> > without /proc/i8k") Signed-off-by: Gabriele Mazzotta
> > <gabriele.mzt@gmail.com>
>=20
> Applied.
>=20
> Pali, would be great if you can send me an Acked-by: before I send
> the pull request to Linus.
>=20
> Thanks,
> Guenter

It's ok,

Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2022195.lQrnMa8flK
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlWOzWwACgkQi/DJPQPkQ1Jl4gCeM4x99mLWyGV6BLwmxaCoVyVs
JgEAoLf17EFxTK/hyrN2eLQEcNpxgJOF
=wX7v
-----END PGP SIGNATURE-----

--nextPart2022195.lQrnMa8flK--


--===============1360871632432164268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1360871632432164268==--
