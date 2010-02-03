From: Forest Bond <forest@alittletooquiet.net>
Date: Wed, 03 Feb 2010 23:47:01 +0000
Subject: Re: [lm-sensors] sensors-detect: probing i2c sensors racy?
Message-Id: <20100203234701.GA27527@alittletooquiet.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0373743546285937750=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20091209153225.GA3947@alittletooquiet.net>
In-Reply-To: <20091209153225.GA3947@alittletooquiet.net>
To: lm-sensors@vger.kernel.org


--===============0373743546285937750==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 11, 2009 at 01:56:17PM +0100, Jean Delvare wrote:
> On Fri, 11 Dec 2009 07:05:22 -0500, Forest Bond wrote:
> > Hi,
> >=20
> > On Fri, Dec 11, 2009 at 09:56:47AM +0100, Jean Delvare wrote:
> > > Hi Forest,
> > >=20
> > > On Thu, 10 Dec 2009 22:31:58 -0500, Forest Bond wrote:
> > > > On Wed, Dec 09, 2009 at 05:11:48PM +0100, Jean Delvare wrote:
> > > > > give a try to the latest one:
> > > > > http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> > > >=20
> > > > This seems to work fine.  Thanks for the help.
> > >=20
> > > Without the extra patch? Hmm, then I don't know if I should apply it.
> > > On the one hand, why change the code if it works... OTOH, there may be
> > > cases where udev will still be too slow and the bug you've hit will
> > > resurface again.
> >=20
> > I only tested once.  I guess the race condition is more likely to fall =
the right
> > way with the new script (based on your comments, I assume the race still
> > exists).  Would it be helpful if I tested a few more times?
>=20
> If you can, yes please.
>=20
> > The patch seemed small enough that I wouldn't think it would cause prob=
lems.
>=20
> Well, I just would appreciate if you (or others) could test it, to make
> sure I didn't accidentally introduce a regression. I think I'll merge
> it then.

I finally got around to testing this.  As I mentioned before, svn revision =
5642
seems to solve my issue, but I see no regressions with your patch applied. =
 I
suspect the udev approach is less prone to races.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFLagr1RO4fQQdv5AwRArA5AJwPN33++EDTCn6pcmXf2WDG5tXjDwCfcNIE
jce/KOTq5MoyRsq3UT6XGSk=
=yfLd
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--


--===============0373743546285937750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0373743546285937750==--
