From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Mon, 15 Oct 2007 17:44:25 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <20071015174425.GC373@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6219172379874573897=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
To: lm-sensors@vger.kernel.org


--===============6219172379874573897==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DSayHWYpDlRfCAAQ"
Content-Disposition: inline


--DSayHWYpDlRfCAAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 15, 2007 at 11:35:54AM -0600, David Hubbard wrote:
> > > $ git clone http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.=
6.git
> > > hwmon.git

> > Looks more like a broken URL, where did you get the above? The correct
> > one is:
> > git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git
> >
> > HTH
>=20
> I can't connect to any git servers on the git port. Can you please
> look at the http url?

There is no http URL and the git server/port is working - I just checked
again. Try

nmap -sT -p9418 lm-sensors.org
--=20
Axel.Thimm at ATrpms.net

--DSayHWYpDlRfCAAQ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHE6b4QBVS1GOamfERAkxEAKCPFO7AOxm43Y5hZJT52R7ACblgrACfYEda
rddYJiBa1xa3PyS/a87CRc8=
=49Ln
-----END PGP SIGNATURE-----

--DSayHWYpDlRfCAAQ--


--===============6219172379874573897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6219172379874573897==--
