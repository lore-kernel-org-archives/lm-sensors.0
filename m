From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Thu, 05 Apr 2007 20:31:59 +0000
Subject: Re: [lm-sensors] Checking out and comitting to the libsensors-3.x
Message-Id: <20070405203159.GE16463@neu.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2045618199312885832=="
List-Id: <lm-sensors.vger.kernel.org>
References: <4610BC25.8050507@hhs.nl>
In-Reply-To: <4610BC25.8050507@hhs.nl>
To: lm-sensors@vger.kernel.org


--===============2045618199312885832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a+b56+3nqLzpiR9O"
Content-Disposition: inline


--a+b56+3nqLzpiR9O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 05, 2007 at 10:15:04PM +0200, Jean Delvare wrote:
> Hi Axel,
>=20
> Sorry for the delay.
>=20
> On Wed, 4 Apr 2007 21:43:17 +0200, Axel Thimm wrote:
> > Hi,
> >=20
> > On Wed, Apr 04, 2007 at 09:29:10PM +0200, Jean Delvare wrote:
> > > BTW, lm-sensors.org's trac looks broken to me, it spits python errors
> > > at me for every page but the main page.
> >=20
> > That's bad, can you give me a failing URL? I can't seem to be
> > (un)lucky enough to find one. :/
>=20
> http://www.lm-sensors.org/wiki/Devices
>=20
> Oops=E2=80=A6
> Trac detected an internal error:
>=20
> If you think this really should work and you can reproduce it, you should=
 consider reporting this problem to the Trac team.
>=20
> Go to http://trac.edgewall.org/ and create a new ticket where you describ=
e the problem, how to reproduce it. Don't forget to include the Python trac=
eback found below.
>=20
> TracGuide =E2=80=94 The Trac User and Administration Guide
> Python Traceback
>=20
> Traceback (most recent call last):
>   File "/usr/lib/python2.4/site-packages/trac/web/main.py", line 387, in =
dispatch_request
>     dispatcher.dispatch(req)
>   File "/usr/lib/python2.4/site-packages/trac/web/main.py", line 191, in =
dispatch
>     chosen_handler =3D self._pre_process_request(req, chosen_handler)
>   File "/usr/lib/python2.4/site-packages/trac/web/main.py", line 263, in =
_pre_process_request
>     chosen_handler =3D f.pre_process_request(req, chosen_handler)
>   File "/usr/lib/python2.4/site-packages/trac/versioncontrol/api.py", lin=
e 73, in pre_process_request
>     self.get_repository(req.authname) # triggers a sync if applicable
>   File "/usr/lib/python2.4/site-packages/trac/versioncontrol/api.py", lin=
e 101, in get_repository
>     repos =3D self._connector.get_repository(rtype, rdir, authname)
>   File "/usr/lib/python2.4/site-packages/trac/versioncontrol/svn_fs.py", =
line 259, in get_repository
>     repos =3D SubversionRepository(dir, None, self.log)
>   File "/usr/lib/python2.4/site-packages/trac/versioncontrol/svn_fs.py", =
line 281, in __init__
>     self.pool =3D Pool()
>   File "/usr/lib/python2.4/site-packages/trac/versioncontrol/svn_fs.py", =
line 158, in __init__
>     self._pool =3D core.svn_pool_create(self._parent_pool())
>   File "/usr/lib64/python2.4/site-packages/svn/core.py", line 177, in svn=
_pool_create
>     return Pool(parent_pool)
>   File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 1080, in=
 svn_pool_create
>     return apply(_core.svn_pool_create, args)
>   File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 3081, in=
 _wrap
>     obj.set_parent_pool(self)
>   File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 2994, in=
 set_parent_pool
>     self._parent_pool =3D parent_pool or application_pool
>   File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 2982, in=
 <lambda>
>     __setattr__ =3D lambda self, name, value: _swig_setattr(self, apr_poo=
l_t, name, value)
>   File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 22, in _=
swig_setattr
>     return _swig_setattr_nondynamic(self,class_type,name,value,0)
>   File "/usr/lib64/python2.4/site-packages/libsvn/core.py", line 17, in _=
swig_setattr_nondynamic
>     self.__dict__[name] =3D value
> RuntimeError: instance.__dict__ not accessible in restricted mode
>=20
> It's an intermittent error, sometimes I get it, sometimes I don't.

That's the errors one loves. Looks like it's a known issue for more
than a year:

http://trac.edgewall.org/ticket/3371

--=20
Axel.Thimm at ATrpms.net

--a+b56+3nqLzpiR9O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGFVy+QBVS1GOamfERAg95AJ99YlzDvH7tx9XxfGdVV/+O1CaX3gCfYmv4
B3nuLLJoFl9UhdZPGLZRSy8=
=ytcr
-----END PGP SIGNATURE-----

--a+b56+3nqLzpiR9O--


--===============2045618199312885832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2045618199312885832==--
