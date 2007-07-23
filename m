From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 23 Jul 2007 18:16:49 +0000
Subject: Re: [lm-sensors] [patch] AMB FB DIMM driver
Message-Id: <20070723181649.GA19586@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6620327692950915187=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070523000559.GA7009@jgarrett.org>
In-Reply-To: <20070523000559.GA7009@jgarrett.org>
To: lm-sensors@vger.kernel.org


--===============6620327692950915187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 17, 2007 at 05:24:00PM +0200, Rudolf Marek wrote:
> Hi all,
>=20
> I'm leaving soon for two weeks to the summer camp. I will be offline ther=
e=20
> so I cant resolve this soon. Maybe others will help?
>=20
> It seems we have two drivers now... So question is what now? Let win bett=
er=20
> one ;) ?

Mr. Garrett's driver looks fine to me... except that the driver ought to
be a bit clearer that it's for Intel chipsets only--perhaps call it
'intel-ambtemp' to avoid confusion if/when other chipset designers
expose the AMB registers via different methods.

--D

--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGpPCRa6vRYYgWQuURAp2oAJ4/IWWPfYoCGRc5Nbch6QQmZi2nygCfS9Wp
XnsojsOZMi4oqddJnYOHQH8=
=uer3
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--


--===============6620327692950915187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6620327692950915187==--
