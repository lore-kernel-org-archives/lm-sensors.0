From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Mon, 25 Jun 2007 17:23:55 +0000
Subject: Re: [lm-sensors] Downloaded patches text format
Message-Id: <20070625172355.GB11289@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8575053815706323131=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070625190625.71477f2b@hyperion.delvare>
In-Reply-To: <20070625190625.71477f2b@hyperion.delvare>
To: lm-sensors@vger.kernel.org


--===============8575053815706323131==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 25, 2007 at 07:06:25PM +0200, Jean Delvare wrote:
> When downloading patches from trac's source tree browser, I get files
> in DOS (CR+LF) text format, instead of the expected UNIX (LF) text
> format. "patch" complains about that. Is it possible to tweak trac to
> provide the patches in UNIX text format directly?

Hm, it looks like it's hardcoded :(

               req.write('--- %s (revision %s)' % old_node_info + CRLF)

--=20
Axel.Thimm at ATrpms.net

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGf/orQBVS1GOamfERAvUTAJ9XfkTGY43gm2y2J3xGUdZyaIrvhQCgmkqs
Ld1ZgoQS/K0+m3UMEXqIPMs=
=NRQF
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--


--===============8575053815706323131==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8575053815706323131==--
