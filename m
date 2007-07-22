From: Axel Thimm <Axel.Thimm@ATrpms.net>
Date: Sun, 22 Jul 2007 18:38:07 +0000
Subject: [lm-sensors] 2.10.4 fails on 2.4 platform (RHEL3)
Message-Id: <20070722183807.GA11686@puariko.nirvana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2771319743277723070=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--===============2771319743277723070==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

building the kernel modules parts for RHEL3 (kernel 2.4.21 based) the
build fails with the log below.

The 2.10.3 sources built OK and comparing the build logs doesn't
reveal anything striking. But 2.10.3 was carrying kernel/Module.mk
while 2.10.4 doesn't anymore. Perhaps removed in the wrong branch
(2.10.4 was still intended for 2.4 kmdl builds, or not?)

gcc -M -MG  -DMODVERSIONS -include /kernelsrc/el3-x86_64/2.4.21-50.EL-x86_6=
4/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomi
t-frame-pointer -I. -Ikernel/include -I/usr/include/i2c  -I/kernelsrc/el3-x=
86_64/2.4.21-50.EL-x86_64/include -nostdinc -I /usr/lib/gcc-lib/x86_64-re
dhat-linux/3.2.3/include -fno-strict-aliasing -fno-common -fomit-frame-poin=
ter -mno-red-zone -mcmodel=3Dkernel -fno-reorder-blocks -finline-limit=3D20=
00 -fno-strength-reduce -Wall -O2=20
 kernel/busses/i2c-ali15x3.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali15x3.d kernel/busses/i2c=
-ali15x3.o: Makefile '`dirname kernel/busses/i2c-ali15x3.d`/Module.mk' @' >=
 kernel/busses/i2c-ali15x3.d
gcc -M -MG  -DMODVERSIONS -include /kernelsrc/el3-x86_64/2.4.21-50.EL-x86_6=
4/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomi
t-frame-pointer -I. -Ikernel/include -I/usr/include/i2c  -I/kernelsrc/el3-x=
86_64/2.4.21-50.EL-x86_64/include -nostdinc -I /usr/lib/gcc-lib/x86_64-re
dhat-linux/3.2.3/include -fno-strict-aliasing -fno-common -fomit-frame-poin=
ter -mno-red-zone -mcmodel=3Dkernel -fno-reorder-blocks -finline-limit=3D20=
00 -fno-strength-reduce -Wall -O2=20
 kernel/busses/i2c-ali1535.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ali1535.d kernel/busses/i2c=
-ali1535.o: Makefile '`dirname kernel/busses/i2c-ali1535.d`/Module.mk' @' >=
 kernel/busses/i2c-ali1535.d
gcc -M -MG  -DMODVERSIONS -include /kernelsrc/el3-x86_64/2.4.21-50.EL-x86_6=
4/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomi
t-frame-pointer -I. -Ikernel/include -I/usr/include/i2c  -I/kernelsrc/el3-x=
86_64/2.4.21-50.EL-x86_64/include -nostdinc -I /usr/lib/gcc-lib/x86_64-re
dhat-linux/3.2.3/include -fno-strict-aliasing -fno-common -fomit-frame-poin=
ter -mno-red-zone -mcmodel=3Dkernel -fno-reorder-blocks -finline-limit=3D20=
00 -fno-strength-reduce -Wall -O2=20
 kernel/busses/i2c-ipmi.c | \
        sed -e 's@^\(.*\)\.o:@kernel/busses/i2c-ipmi.d kernel/busses/i2c-ip=
mi.o: Makefile '`dirname kernel/busses/i2c-ipmi.d`/Module.mk' @' > kernel/b=
usses/i2c-ipmi.d
make: *** No rule to make target `kernel/Module.mk'.  Stop.

--=20
Axel.Thimm at ATrpms.net

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFGo6QPQBVS1GOamfERAhvnAJ9jNs2vRC8Fb4Zwk2Q7gyJWoryHFgCeOAd7
E1gy++AEm2sgO8XrzKqNEHA=
=4DgT
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--


--===============2771319743277723070==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2771319743277723070==--
