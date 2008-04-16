From: Forest Bond <forest@alittletooquiet.net>
Date: Wed, 16 Apr 2008 13:23:48 +0000
Subject: Re: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <20080416132348.GB8208@storm.local.network>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3340884304234382525=="
List-Id: <lm-sensors.vger.kernel.org>
References: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
In-Reply-To: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
To: lm-sensors@vger.kernel.org


--===============3340884304234382525==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Content-Disposition: inline


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 16, 2008 at 03:09:51PM +0200, Jean Delvare wrote:
> On Wed, 16 Apr 2008 08:38:11 -0400, Forest Bond wrote:
> > Hi,
> >=20
> > On Tue, Apr 15, 2008 at 02:58:58PM +0200, Jean Delvare wrote:
> > > On Mon, 14 Apr 2008 23:51:03 +0800, Mini Stac wrote:
> > > > GNU bash, version 3.2.25(1)-release (i486-pc-linux-gnu)
> > > >=20
> > > > I am afraid I am not familiar with build, but if you can give me so=
me steps
> > > > or links to a tutorial I would be happy to try it out.
> > >=20
> > > If you're not used to building tools from source code, most packages =
you
> > > need (make, gcc, etc.) are probably not installed on your system so y=
ou
> > > won't be able to build bash yourself.
> > >=20
> > > On my end, I tried building bash 3.2 including all the patches ubuntu
> > > is using, but I was still not able to reproduce the bug you reported:
> > > pwmconfig worked OK for me. So I just don't know what is going on.
> > >=20
> > > You may want to try reporting the bug to the Ubuntu bash package
> > > maintainer (if there's anything like that) and see if he/she has an
> > > idea.
> >=20
> > You may want to check the shebang line on the script.  If it is /bin/sh=
, it is
> > actually being run by dash, not bash, as that is /bin/sh by default on =
Ubuntu.
> > If that is the case, the shebang line should be changed to /bin/bash
> >=20
> > You could also try running the script directly with bash like
> > `bash /usr/sbin/pwmconfig'.
>=20
> $ head -n 1 /usr/sbin/pwmconfig
> #!/bin/bash
> $

Well, right, I had already checked it on my system, but I wasn't sure if th=
ere
could be some sort of variation, for some very strange reason...

-Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIBf3kRO4fQQdv5AwRAg82AKDQOIg0uTpWD8zD7OtMMaJsxTDXrwCgsiIW
gYhiiheNhJrFRsLIX2NY1vg=
=WRyD
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--


--===============3340884304234382525==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3340884304234382525==--
