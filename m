From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Mon, 13 Jan 2014 21:29:44 +0000
Subject: Re: [lm-sensors] [PATCHv9 02/20] thermal: introduce device tree parser
Message-Id: <52D45AC8.1010607@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8116122669345485204=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-3-git-send-email-eduardo.valentin@ti.com> <52C4D612.2090808@nvidia.com> <52C5A6CE.5060904@nvidia.com> <20140106135145.GD21906@e106331-lin.cambridge.arm.com> <52CAC3AF.9020401@ti.com> <52CB69FA.9080903@nvidia.com>
In-Reply-To: <52CB69FA.9080903@nvidia.com>
To: Wei Ni <wni@nvidia.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Mark Rutland <mark.rutland@arm.com>, Matthew Longnecker <MLongnecker@nvidia.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, Pawel Moll <Pawel.Moll@arm.com>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "linux@roeck-us.net" <linux@roeck-us.net>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

--===============8116122669345485204==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BcHIXGgKPN3KOsf4Pahsrt4VtRMfLhVLN"

--BcHIXGgKPN3KOsf4Pahsrt4VtRMfLhVLN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Wei,

On 06-01-2014 22:44, Wei Ni wrote:
> On 01/06/2014 10:54 PM, Eduardo Valentin wrote:
>> * PGP Signed by an unknown key
>>
>> On 06-01-2014 09:51, Mark Rutland wrote:
>>> On Thu, Jan 02, 2014 at 05:50:06PM +0000, Matthew Longnecker wrote:
>>>>
>>>>> I think the platform driver may set governor for the thermal zone,
>>>>> so how about to add a property named as "governor",
>>>>> and parse it to tzp->governor_name,
>>>>> something like:
>>>>>                  ret =3D of_property_read_string(child, "governor",=
 &str);
>>>>>                  if (ret =3D=3D 0)
>>>>>                          if (strlen(str) < THERMAL_NAME_LENGTH)
>>>>>                                  strcpy(tzp->governor_name, str);
>>>>>
>>>>> Thanks.
>>>>> Wei.
>>>>
>>>> DT is supposed to describe the hardware, right? The governor isn't=20
>>>> hardware -- it's a software control policy. On the other hand, that =

>>>> control policy must be tuned according to the behaviors of the platf=
orm=20
>>>> hardware otherwise the system will be unstable.
>>>>
>>>> Is it appropriate to be naming the governor in DT? If so, is it equa=
lly=20
>>>> appropriate to describe any governor-specific parameters in DT (even=
=20
>>>> though they are pure software constructs)?
>>>
>>> The dt should be relatively static -- if the hardware doesn't change =
the
>>> dt shouldn't have to.
>>>
>>> The governers are not static. We can introduce new ones and throw awa=
y
>>> old ones at any time. Tuning parameters can also change at any time.
>>>
>>> I'd prefer to not have governer details described in the dt, and the
>>> choice of governer and configuration of its tuning parameters should =
be
>>> made at runtime somehow.
>>
>> Agreed.
>=20
> Yes, I think so, but the of-thermal driver handle the
> thermal_zone_device_register, and pass the "tzp" without governor_name,=


In fact, it will fall into the default governor, which is step_wise, by
default config.

> so the created thermal_zone's governor will be NULL, then it can't run
> into the governor->throttle() if needed. And currently there have no

Actually, no, the tz will be set to default governor, and its throttle
call will be called.

> interface to support updating governor and configuration at runtime.
> I think it's better to initialize the governor_name when register the
> thermal zone device in the of-thermal driver.

Still, why would you need to change the governor from a in kernel
decision? There is an ABI to change the thermal zone policy based on
user(land) request. If you need to change the policy from within the
kernel, which seams to be what you are trying to propose, you need to
explain why you need it, say, by giving at least one user of this API or
explaining its use case.

>=20
> Thanks.
>=20
>>
>>>
>>> Thanks,
>>> Mark.
>>>
>>>
>>
>>
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--BcHIXGgKPN3KOsf4Pahsrt4VtRMfLhVLN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLUWsgACgkQCXcVR3XQvP1orAEAialtk3Aps/1oTiWfB2foDt96
3h1Tq5XY7wTnht9Q61cBALCe0wBWAO3KHbJYKNgDeHcMid5INnBMshA76ABfWOtd
=F2o/
-----END PGP SIGNATURE-----

--BcHIXGgKPN3KOsf4Pahsrt4VtRMfLhVLN--


--===============8116122669345485204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8116122669345485204==--
