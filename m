From: higuita <higuita@GMX.net>
Date: Thu, 05 Nov 2009 00:11:20 +0000
Subject: [lm-sensors] Lost CPU fan control in recent kernels. Case fan still
Message-Id: <20091105001120.2c94c3b5@Couracado.homelinux.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8011443895038551927=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8011443895038551927==
Content-Type: multipart/signed; boundary="Sig_/NSqWfWn8_zOouc67fJ8ha05";
 protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_/NSqWfWn8_zOouc67fJ8ha05
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all=20

I just found a problem... in the past, i could control the cpu fan speed wi=
th
fancontrol, now the speed is always the same, whatever pwm value i set.=20

Dont know exactly when it stop working, as the case fan speed
control always worked and its by far the nosiest of all.

I suspect it was the 2.6.3x kernel updates, or even the few last 2.6.2x=20
kernels. i suspect that the bios is locking up the fan speed someway,
as i dont have the reset=3D1 option anymore, i cant really test it

I just updated to the latest lm-sensors (svn version) and still dont
work.

The hardware is a Asus A8V deluxe with the w83627hf module, detected
with sensors-detect

Any tip? or should i try to find the latest kernel that still works=20
and open a kernel bug?   =20

Thanks in advance for the help
higuita
ps: please CC me, as i'm not in the list
--=20
Naturally the common people don't want war... but after all it is the
leaders of a country who determine the policy, and it is always a=20
simple matter to drag the people along, whether it is a democracy, or
a fascist dictatorship, or a parliament, or a communist dictatorship.
Voice or no voice, the people can always be brought to the bidding of
the leaders. That is easy. All you have to do is tell them they are=20
being attacked, and denounce the pacifists for lack of patriotism and
exposing the country to danger.  It works the same in every country.
           -- Hermann Goering, Nazi and war criminal, 1883-1946

--Sig_/NSqWfWn8_zOouc67fJ8ha05
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkryGCgACgkQrv1jazsMcrMufQCgr8AJsA2uNalDVpL09kYYYeSk
3xkAoIPurPGKwxJmDcrC+Q9JBFcEq3QT
=o184
-----END PGP SIGNATURE-----

--Sig_/NSqWfWn8_zOouc67fJ8ha05--


--===============8011443895038551927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8011443895038551927==--
