From: christophe <christophe.dr@free.fr>
Date: Sun, 05 Aug 2007 08:18:52 +0000
Subject: Re: [lm-sensors] Hardware monitoring on Asus A6JM laptop
Message-Id: <200708051018.59944.christophe.dr@free.fr>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7826591079063576574=="
List-Id: <lm-sensors.vger.kernel.org>
References: <46B395DF.30504@free.fr>
In-Reply-To: <46B395DF.30504@free.fr>
To: lm-sensors@vger.kernel.org

--===============7826591079063576574==
Content-Type: multipart/signed; boundary="nextPart2114068.pGLb6gqGul";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2114068.pGLb6gqGul
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Le samedi 4 ao=FBt 2007 22:09, Rudolf Marek a =E9crit=A0:
> Hi all,
>
> I dont think it is a good idea to enable the SMbus when they disable it. =
It
> has the the chip ADT7463 which servers as thermal control for whole
> notebook. The chip is in automatic mode. Fan full at 90C. Fans stop at 55=
C.
>
> Perhaps ACPI methods poke with that chip too. First it must be check if
> they do! If so, the access must not be allowed!
>
> Rudolf


Yes it's almost the same chip on asus w1n laptop :
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-January/018672.html


=2D-=20
christophe

--nextPart2114068.pGLb6gqGul
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBGtYfz9+rt6ZuuXcARAhQmAKCGD2jHw1gjc/tVMcLYBEqcVfZ6ogCbBMU6
XbE3HYIs2RnNWmKTnwyT+7s=
=I4Yy
-----END PGP SIGNATURE-----

--nextPart2114068.pGLb6gqGul--


--===============7826591079063576574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7826591079063576574==--
