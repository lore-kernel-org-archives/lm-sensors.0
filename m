From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Date: Mon, 09 Jun 2014 16:23:31 +0000
Subject: Re: [lm-sensors] [PATCH] sensord: do not fail if some sensor does not return data
Message-Id: <201406091823.31743@pali>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4469120782357899946=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4469120782357899946==
Content-Type: multipart/signed;
  boundary="nextPart1810333.KdIiV8SdDh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1810333.KdIiV8SdDh
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Saturday 17 May 2014 22:02:12 Pali Roh=C3=A1r wrote:
> Hello,
>=20
> I see very annoying bug in sensord. When some hwmon driver
> returns -EINVAL (for any reason), sensord daemon will stop
> reading next sensors values. This means if first hwmon device
> fail to return value, sensord daemon will not log anything.
>=20
> Returning -EINVAL from kernel driver is normal (e.g. when
> graphic card with has internal temperature sensor is turned
> off) and sensord should not fail on this.
>=20
> Program sensors already handling this problem and will print
> N/A if there is reading error.
>=20
> I'm sending simple patch which just report NaN value when
> kernel report error. And also sensord will continue to
> reading next hwmon interfaces.
>=20
> Without this patch I see only these lines logged:
>=20
> sensord: Chip: radeon-pci-0100
> sensord: Adapter: PCI adapter
> sensord: Error getting sensor data: radeon/#0: Can't read
> sensord: sensor read error (-1)
>=20
> And all other sensors are ignored and nothing more is logged.
>=20
> After my patch all hwmon sensors data are logged:
>=20
> sensord: Chip: radeon-pci-0100
> sensord: Adapter: PCI adapter
> sensord:   temp1: nan C
> sensord: Chip: i8k-virtual-0
> sensord: Adapter: Virtual device
> sensord:   Left Fan: 2685 RPM
> sensord:   CPU: 49.0 C
> sensord:   temp2: 55.0 C
> sensord:   temp3: 39.0 C
> sensord: Chip: coretemp-isa-0000
> sensord: Adapter: ISA adapter
> sensord:   Physical id 0: 50.0 C
> sensord:   Core 0: 47.0 C
> sensord:   Core 1: 50.0 C

BUMP!

Can somebody review my patch?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1810333.KdIiV8SdDh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlOV34MACgkQi/DJPQPkQ1IaTQCghxoZnl4YGplACB/4BiWnVLWn
JhYAnRvHc/tkwPd83IQr+KTtHlNNWcP3
=Qygg
-----END PGP SIGNATURE-----

--nextPart1810333.KdIiV8SdDh--


--===============4469120782357899946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4469120782357899946==--
