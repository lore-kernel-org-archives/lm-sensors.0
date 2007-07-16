From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 16 Jul 2007 20:28:08 +0000
Subject: Re: [lm-sensors] [PATCH] v1 Intel FB-DIMM AMB temperature sensor
Message-Id: <20070716202807.GD2619@tree.beaverton.ibm.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0800608688540638836=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713014814.GS3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713014814.GS3435@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org


--===============0800608688540638836==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Content-Disposition: inline


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Attempting to separate the i5k_amb and adt7470 discussions.]

Vadim Zeitlin wrote:
> On Sat, 14 Jul 2007 18:19:22 +0200 Hans de Goede <j.w.r.degoede@hhs.nl> w=
rote:
>=20
> HdG> > and the AMB sensors 2 and 3 were not being taken into account. Wit=
hout knowing
> HdG> > anything about libsensors I thought it was because the file names =
in
> HdG> > /sys/devices/platform/i5k_amb.0 were named {temp0,temp16,temp32,te=
mp48}_xxx and
> HdG> > not temp[1234] as usual
> HdG>=20
> HdG> Yes, thats a rather severe violation of the hwmon sysfs standard. I =
do not see=20

Oops. :)

The reason for the sparse numbering is that I wanted an easy way to map the
sensor number to the memory channel/DIMM socket.  Easy to do if the
tempX numbers are sparse (i.e. 16 is always Ch1 DIMM0), not so easy if
the identifer can change around.  That said, I could create another
attribute such as tempX_dimm or something that would export the real
number for label matching purposes... if anyone cares.  It's most likely
to be the case that temp x =3D=3D DIMM x anyway.

>  Hello again,
>=20
>  I've tested this driver with kernel 2.6.20 with Tyan i5000XT motherboard
> and it seems to work fine for me:o

Excellent!

--D

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGm9TXa6vRYYgWQuURAr6EAJ9dQdTQVp5GNP46usJ/5MDWcjYJBgCfVYwF
1CbAq1jAI/YL7uTooecGjoM=
=NmXI
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--


--===============0800608688540638836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0800608688540638836==--
