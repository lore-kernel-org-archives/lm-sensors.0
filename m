From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Mon, 06 Jan 2014 14:54:39 +0000
Subject: Re: [lm-sensors] [PATCHv9 02/20] thermal: introduce device tree parser
Message-Id: <52CAC3AF.9020401@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4513208862481276531=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-3-git-send-email-eduardo.valentin@ti.com> <52C4D612.2090808@nvidia.com> <52C5A6CE.5060904@nvidia.com> <20140106135145.GD21906@e106331-lin.cambridge.arm.com>
In-Reply-To: <20140106135145.GD21906@e106331-lin.cambridge.arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Matthew Longnecker <mlongnecker@nvidia.com>, Wei Ni <wni@nvidia.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, Pawel Moll <Pawel.Moll@arm.com>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--===============4513208862481276531==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HemHAM6TDENViXwlV0JfG3QCrj3ptvQ4w"

--HemHAM6TDENViXwlV0JfG3QCrj3ptvQ4w
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06-01-2014 09:51, Mark Rutland wrote:
> On Thu, Jan 02, 2014 at 05:50:06PM +0000, Matthew Longnecker wrote:
>>
>>> I think the platform driver may set governor for the thermal zone,
>>> so how about to add a property named as "governor",
>>> and parse it to tzp->governor_name,
>>> something like:
>>>                  ret =3D of_property_read_string(child, "governor", &=
str);
>>>                  if (ret =3D=3D 0)
>>>                          if (strlen(str) < THERMAL_NAME_LENGTH)
>>>                                  strcpy(tzp->governor_name, str);
>>>
>>> Thanks.
>>> Wei.
>>
>> DT is supposed to describe the hardware, right? The governor isn't=20
>> hardware -- it's a software control policy. On the other hand, that=20
>> control policy must be tuned according to the behaviors of the platfor=
m=20
>> hardware otherwise the system will be unstable.
>>
>> Is it appropriate to be naming the governor in DT? If so, is it equall=
y=20
>> appropriate to describe any governor-specific parameters in DT (even=20
>> though they are pure software constructs)?
>=20
> The dt should be relatively static -- if the hardware doesn't change th=
e
> dt shouldn't have to.
>=20
> The governers are not static. We can introduce new ones and throw away
> old ones at any time. Tuning parameters can also change at any time.
>=20
> I'd prefer to not have governer details described in the dt, and the
> choice of governer and configuration of its tuning parameters should be=

> made at runtime somehow.

Agreed.

>=20
> Thanks,
> Mark.
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--HemHAM6TDENViXwlV0JfG3QCrj3ptvQ4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLKw68ACgkQCXcVR3XQvP0v5AD/U+wQ8Mvydjvc9EysY14REF44
KKKk8WVNU19Isgnw22oA/j7sBLySG7jp7kbNwn1NF32olLyIT+0GD6Jicf3Igv31
=L2Gl
-----END PGP SIGNATURE-----

--HemHAM6TDENViXwlV0JfG3QCrj3ptvQ4w--


--===============4513208862481276531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4513208862481276531==--
