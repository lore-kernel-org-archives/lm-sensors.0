From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Sun, 11 Nov 2007 23:05:17 +0000
Subject: Re: [lm-sensors] 2.10.5 on 2.4 kernel requires sysfs/libsysfs.h?
Message-Id: <20071111230517.GA28829@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4553232848711892815=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20071110095638.GA29181@puariko.nirvana>
In-Reply-To: <20071110095638.GA29181@puariko.nirvana>
To: lm-sensors@vger.kernel.org


--===============4553232848711892815==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 11, 2007 at 11:25:39PM +0100, Jean Delvare wrote:
> Hi Axel,
>=20
> On Sat, 10 Nov 2007 11:56:38 +0200, Axel Thimm wrote:
> > up to 2.10.4 sysfsutils was only required for 2.6 kernels. Now the
> > build fails on 2.4 kernel system w/o sysfsutils with
> >=20
> > make: *** No rule to make target `sysfs/libsysfs.h', needed by `lib/sys=
fs.ad'.
> >=20
> > Is that a bug in the Makefiles or is sysfsutils now really required
> > for 2.4. kernels as well?
> >=20
> > (I hit this while building rpms for RHEL3).
>=20
> No, sysfsutils is still not required for 2.4 kernels.
>=20
> The only change in 2.10.5 that could cause this problem is this one:
> http://www.lm-sensors.org/changeset/4738

I see, I will probably need to divert KERNELVERSION.

> But I tested this with a 2.4 kernel and it works as intended.
>=20
> Hmmm, maybe I see what's going on. Are you cross-building the RHEL3
> package, on a system itself running a 2.6 kernel?

Yes.

> And how are you pointing the build system to the right kernel tree
> to build against in this case?

Something along
make LINUX=3D/srv/atrpms.net/atrpms/kernelsrc/el3-x86_64/2.4.21-52.EL-x86_6=
4 I2C_HEADERS=3D/usr/include/i2c COMPILE_KERNEL=3D0

I'll add an KERNELVERSION=3D2.4.21-52.EL for good measure ;)
--=20
Axel.Thimm at ATrpms.net

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHN4qtQBVS1GOamfERAklOAJ9vWF6UyYVaRQauzeuCppKXE8OljACeOvrZ
wxAOvfSSxB/l2Am+QCMPi9E=
=im+J
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--


--===============4553232848711892815==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4553232848711892815==--
