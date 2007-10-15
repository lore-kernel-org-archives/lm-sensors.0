From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Mon, 15 Oct 2007 15:13:42 +0000
Subject: Re: [lm-sensors] [ patch .24-rc0 5/5 ] SuperIO locks coordinator -
Message-Id: <20071015151342.GB373@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8531274194647089466=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4712F66F.8040806@gmail.com>
In-Reply-To: <4712F66F.8040806@gmail.com>
To: lm-sensors@vger.kernel.org


--===============8531274194647089466==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Content-Disposition: inline


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2007 at 11:34:11PM -0700, David Hubbard wrote:
> Hi Jim, Axel,
>=20
> On 10/14/07, David Hubbard <david.c.hubbard@gmail.com> wrote:
> > Hi Jim,
> >
> > On 10/14/07, Jim Cromie <jim.cromie@gmail.com> wrote:
> > > 05 - use superio-locks in rest of drivers/hwmon/*.c
> > >
> > > this patch is compile-tested only, please review for sanity before you
> > > try running them.  Things to look for - missing superio_release(),
> > > opportunities to use superio_devid(), superio_inw(), etc.
> > >
> > >
> > > Signed-off-by:  Jim Cromie <jim.cromie@gmail.com>
> > > ---
> > > hwmon-superio-others
> > >  Kconfig      |    6 +++
> > >  f71805f.c    |   86 +++++++++++++++-------------------------------
> > >  it87.c       |   80 +++++++++++++++---------------------------
> > >  smsc47b397.c |   63 ++++++++++++---------------------
> > >  smsc47m1.c   |   69 +++++++++++++------------------------
> > >  vt1211.c     |   70 +++++++++++++------------------------
> > >  w83627ehf.c  |  110 +++++++++++++++++++++++++-----------------------=
-----------
> >
> > I'll test on w83627ehf hardware and report.
> >
> > David
>=20
> This appears to be pasted in and needs to be updated:
> printk(KERN_WARNING "pc87360: superio port not detected, "
>=20
> I am unable to clone the hwmon.git repository. I believe the git port
> is blocked by my ISP, and I may be able to get it opened, but I tried
> cloning this way, and failed:
>=20
> $ git clone http://lm-sensors.org/kernel?p=3Dkernel/mhoffman/hwmon-2.6.git
> hwmon.git
> Initialized empty Git repository in hwmon.git/.git/
> Cannot get remote repository information.
> Perhaps git-update-server-info needs to be run there?
>=20
> Axel, is this something easy to fix on the server side?

Looks more like a broken URL, where did you get the above? The correct
one is:
git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git

HTH
--=20
Axel.Thimm at ATrpms.net

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHE4OmQBVS1GOamfERAqydAKCWFDDb2XyYqEiHdXY14mIEJDgQ6gCeNthV
zndByUu3KfL1eEy0dHSA9mQ=
=nTWN
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--


--===============8531274194647089466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8531274194647089466==--
