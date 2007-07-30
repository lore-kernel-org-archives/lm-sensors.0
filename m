From: Florian Echtler <echtler@in.tum.de>
Date: Mon, 30 Jul 2007 13:34:28 +0000
Subject: Re: [lm-sensors] w83627dhg and coretemp temperature mismatch?
Message-Id: <1185802468.23876.97.camel@pancake>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2561395182127817237=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1185800852.23876.91.camel@pancake>
In-Reply-To: <1185800852.23876.91.camel@pancake>
To: lm-sensors@vger.kernel.org


--===============2561395182127817237==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-nnVGtXMQFfMHDlF0m7fh"


--=-nnVGtXMQFfMHDlF0m7fh
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: quoted-printable

> > As I have a passively-cooled CPU, I am a bit nervous about temperatures=
,
> > so I'm curious if somebody can explain the difference (and which one is
> > closer to reality ;-).
> The w83627dhg chip reads the temperature from a sensors which is put
> somewhere near (under?) the socket of the CPU. coretemp reads the two
> sensors inside the CPU.
Thanks - I suspected something along these lines. But why is the
external sensor then giving a higher temperature reading than the
internal sensors? Is there some sort of compensation built in, because
the mainboard manufacturer wants to stay on the safe side? (The
difference seems to be around 4-5 =C2=B0C).

Yours, Florian

--=-nnVGtXMQFfMHDlF0m7fh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGrejh7CzyshGvatgRAj8DAKCEoSU5V3p0QkYJsWWMDanwcaJ8VwCfVCfv
/dJFicNqWotS0RcdDlMguK4=
=k/AI
-----END PGP SIGNATURE-----

--=-nnVGtXMQFfMHDlF0m7fh--



--===============2561395182127817237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2561395182127817237==--

