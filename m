From: Roman Mamedov <roman@rm.pp.ru>
Date: Sun, 28 Feb 2010 22:32:33 +0000
Subject: Re: [lm-sensors] ASUS CUSL2: sensors work with 2.6.30,
Message-Id: <20100301033233.66b4f25f@natsu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4117554754376000487=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4117554754376000487==
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/v4l4fjQRijRCXffJ.3jAm2="; protocol="application/pgp-signature"

--Sig_/v4l4fjQRijRCXffJ.3jAm2=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Mar 2010 03:25:08 +0500
Roman Mamedov <roman@rm.pp.ru> wrote:

> I have a Pentium III with ASUS CUSL2 motherboard. When it is booted into
> the kernel 2.6.30, the sensors are detected and work fine. But when the
> kernel is 2.6.33, no sensors are detected. I did not try any kernel versi=
ons
> in between for now. Any idea what could be the cause? Attaching
> sensors-detect outputs from under both kernels.

Hm, looking at the driver's history, I believe it is caused by the second
change in that commit:
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dblob=
diff;f=3Ddrivers/hwmon/w83781d.c;h=3Dd38b9ede3abd1851b72d47ba0088678d01ecff=
b4;hp=3De0fa7520400d8c565f0b7c77034a6c0e35cf4a1a;hb=3D6722feada7f6213ba06d5=
10ef853e57ddcd59dae;hpb=3D7fce084a0b3e2bb8caef919f8f36065953655bb5
(shorter URL in case the above one breaks: http://ur1.ca/nwxs )

--=20
With respect,
Roman

--Sig_/v4l4fjQRijRCXffJ.3jAm2=
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkuK7wEACgkQTLKSvz+PZwj6FwCfYWZA/JWjG7QkMfWlR6l1oKSg
KmsAmwXAMQdngPnJUnBCotyAAtfSzn6Z
=jqmQ
-----END PGP SIGNATURE-----

--Sig_/v4l4fjQRijRCXffJ.3jAm2=--


--===============4117554754376000487==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4117554754376000487==--
