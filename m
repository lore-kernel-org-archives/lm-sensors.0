From: Christian Krafft <krafft@de.ibm.com>
Date: Sat, 12 Apr 2008 16:42:10 +0000
Subject: Re: [lm-sensors] [Patch] lm-sensors crash on non x86 hardware
Message-Id: <20080412184210.57cbd233@de.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0838822982482933422=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20080410171111.3f275bcb@de.ibm.com>
In-Reply-To: <20080410171111.3f275bcb@de.ibm.com>
To: lm-sensors@vger.kernel.org

--===============0838822982482933422==
Content-Type: multipart/signed; boundary="Sig_/yqAApdIE.jEMHk1kQcoS5fN";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/yqAApdIE.jEMHk1kQcoS5fN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jean,

On Thu, 10 Apr 2008 18:14:46 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> Hi Christian,
>=20
> On Thu, 10 Apr 2008 17:11:11 +0200, Christian Krafft wrote:
> > Hi,
> >=20
> > Please consider this tiny patch for inclusion.
> > It provides the user with more precise info.
> >=20
> > Index: lm_sensors-2.10.0/prog/detect/sensors-detect
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- lm_sensors-2.10.0.orig/prog/detect/sensors-detect
> > +++ lm_sensors-2.10.0/prog/detect/sensors-detect
>=20
> 2.10.0 is old...

Ups, Next time I'll check before posting ;-)

>=20
> > @@ -5153,7 +5153,7 @@ sub main
> > =20
> >    print "\nSome chips are also accessible through the ISA bus. ISA pro=
bes
> > are\n". "typically a bit more dangerous, as we have to write to I/O por=
ts
> > to do\n".
> > -        "this. This is usually safe though.\n\n";
> > +        "this. This is usually safe on x86 acrhitecture.\n\n";
> >    if ($> !=3D 0) {
> >      print "As you are not root, we shall skip this step.\n";
> >    } else {
> > @@ -5167,7 +5167,7 @@ sub main
> > =20
> >    print "\nSome Super I/O chips may also contain sensors. Super I/O pr=
obes
> > are\n". "typically a bit more dangerous, as we have to write to I/O por=
ts
> > to do\n".
> > -        "this. This is usually safe though.\n\n";
> > +        "this. This is usually safe on x86 acrhitecture.\n\n";
> >    if ($> !=3D 0) {
> >      print "As you are not root, we shall skip this step.\n";
> >    } else {
>=20
> We already skip these probes on PPC:
> http://www.lm-sensors.org/changeset/5125
> Isn't it sufficient?
>=20

Thats perfect, more than I expected. Thanks!

--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294

--Sig_/yqAApdIE.jEMHk1kQcoS5fN
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFIAOcg6rqK4qDx+dcRAhj1AKCdyA3Bebv5F697sKGO2wJ04LqcfwCgjCPW
ACBp5+wpVGgNJH1R90ZxHso=
=rTzO
-----END PGP SIGNATURE-----

--Sig_/yqAApdIE.jEMHk1kQcoS5fN--


--===============0838822982482933422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0838822982482933422==--
