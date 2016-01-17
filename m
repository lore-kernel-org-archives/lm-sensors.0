From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Sun, 17 Jan 2016 16:51:33 +0000
Subject: Re: [lm-sensors] [PATCH] dell-smm: Blacklist Dell Studio XPS 8000
Message-Id: <201601171751.33737@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6457479094887212942=="
List-Id: <lm-sensors.vger.kernel.org>
References: <569BAD28.3060701@leemhuis.info>
In-Reply-To: <569BAD28.3060701@leemhuis.info>
To: lm-sensors@vger.kernel.org

--===============6457479094887212942==
Content-Type: multipart/signed;
  boundary="nextPart3998679.jYdiV9QCW7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart3998679.jYdiV9QCW7
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 17 January 2016 17:36:21 Guenter Roeck wrote:
> On 01/17/2016 07:03 AM, Thorsten Leemhuis wrote:
> > Since Linux 4.0 the CPU fan speed is going up and down on Dell
> > Studio XPS 8000 and 8100 for unknown reasons. The 8100 was already
> > blacklisted in Commit a4b45b25f1 This patch blacklists the XPS
> > 8000.
> >=20
> > Without further debugging on the affected machine, it is not
> > possible to find the problem. For more details see
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D100121
> >=20
> > Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> > Acked-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > Cc: stable@vger.kernel.org # v4.0+, will need backport
>=20
> Applied.
>=20
> Thanks,
> Guenter
>=20

Anyway, I would be more happy if somebody with that machine could debug=20
this issue or at least find part/code/function which cause this problem.

Adding another machine on blacklist is just hot-fix for this problem.=20
But as stated in commit message, it is really impossible to debug it=20
without that problematic machine...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart3998679.jYdiV9QCW7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlabxpUACgkQi/DJPQPkQ1LV+QCghK/m4QdMMJql9lWTw9BEEn6T
KW0An0/j6jxAbEilA45jApi8HnDHsCCO
=9558
-----END PGP SIGNATURE-----

--nextPart3998679.jYdiV9QCW7--


--===============6457479094887212942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6457479094887212942==--
