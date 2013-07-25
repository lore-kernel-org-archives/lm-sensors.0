From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Thu, 25 Jul 2013 17:21:35 +0000
Subject: Re: [lm-sensors] RFC: device thermal limits represented in device tree nodes
Message-Id: <51F15E9F.1080600@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0384520169954463932=="
List-Id: <lm-sensors.vger.kernel.org>
References: <51ED40E3.5020703@ti.com> <51EF3186.9060001@wwwdotorg.org>  <1374664745.25700.118.camel@hornet> <51EFED19.5090900@ti.com>  <1374768928.3213.31.camel@hornet> <1374770294.3213.35.camel@hornet>
In-Reply-To: <1374770294.3213.35.camel@hornet>
To: Pawel Moll <pawel.moll@arm.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Mark Rutland <Mark.Rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Guenter Roeck <linux@roeck-us.net>, Durgadoss R <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Wei Ni <wni@nvidia.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--===============0384520169954463932==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ips3dcRL1pdEAAfT61g678Mknhi9Kp4Ar"

--Ips3dcRL1pdEAAfT61g678Mknhi9Kp4Ar
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 25-07-2013 12:38, Pawel Moll wrote:
> On Thu, 2013-07-25 at 17:15 +0100, Pawel Moll wrote:
>>> Another way, as I mentioned in the original RFC, an option would be t=
o
>>> have the thermal_zone node not embedded in any device node. But them,=
 we
>>> would need to firmly link it to other device nodes, to describe what =
is
>>> monitored and what is used for monitoring.=20
>>
>> You mean the zone nodes would live at the top level of the tree? To my=

>> mind the root represents the device (the board, whatever you call it),=

>=20
> What I wanted to say was: ... so the zone would still be embedded in a
> device node :-)
>

ahh ok.. I see.


> Pawel
>=20
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--Ips3dcRL1pdEAAfT61g678Mknhi9Kp4Ar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlHxXp8ACgkQCXcVR3XQvP3SJwD/Q43Alhj39BctflLwzOkAlYsP
ohwpftfjiAOnOKgRmiMBAIBeRddeMk1TEg6FSQagfW5y+lLZgBGCfZO+XKLdYshr
=/SSk
-----END PGP SIGNATURE-----

--Ips3dcRL1pdEAAfT61g678Mknhi9Kp4Ar--


--===============0384520169954463932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0384520169954463932==--
