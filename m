From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Wed, 02 Oct 2013 01:27:26 +0000
Subject: Re: [lm-sensors] [PATCH 1/7] arm: dts: add dra7 DSPEVE thermal data
Message-Id: <524B767E.9070906@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2923192615265700701=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com> <1380652344-18819-2-git-send-email-eduardo.valentin@ti.com> <20131001223703.GB11451@kahuna>
In-Reply-To: <20131001223703.GB11451@kahuna>
To: Nishanth Menon <nm@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, grant.likely@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

--===============2923192615265700701==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="A8Lpu5T6CM67kuBfFlIjXgkUEfsITOtUA"

--A8Lpu5T6CM67kuBfFlIjXgkUEfsITOtUA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01-10-2013 18:37, Nishanth Menon wrote:
> On 14:32-20131001, Eduardo Valentin wrote:
>> This patch changes a dtsi file to contain the thermal data
> 	     ^^ introduces?
>> for DSPEVE domain on DRA7 and later SoCs. This data will
>> enable a thermal shutdown at 125C.
>>
>> This thermal data can be reused across TI SoC devices.
>>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>  arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 28 +++++++++++++++++++++=
+++++++
>>  1 file changed, 28 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
>>
>> diff --git a/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi b/arch/arm/boo=
t/dts/dra7-dspeve-thermal.dtsi
>> new file mode 100644
>> index 0000000..f8b9051
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
>> @@ -0,0 +1,28 @@
>> +/*
>> + * Device Tree Source for DRA7 SoC DSPEVE thermal
>> + *
>> + * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.=
com/
>> + * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
>> + *
>> + * This file is licensed under the terms of the GNU General Public Li=
cense
>> + * version 2.  This program is licensed "as is" without any warranty =
of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +#include <dt-bindings/thermal/thermal.h>
>> +
>> +dspeve_thermal: dspeve_thermal {
>> +	polling-delay-passive =3D <250>; /* milliseconds */
>> +	polling-delay =3D <1000>; /* milliseconds */
>> +
>> +		/* sensor       ID */
> ^^
>> +	thermal-sensors =3D <&bandgap     3>;
> ^^ tab control a bit? ;)

check answer on IVA patch.

>> +
>> +	trips {
>> +		dspeve_crit: dspeve_crit {
>> +			temperature =3D <125000>; /* milliCelsius */
>> +			hysteresis =3D <2000>; /* milliCelsius */
>> +			type =3D THERMAL_TRIP_CRITICAL;
>> +		};
>> +	};
>> +};
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--A8Lpu5T6CM67kuBfFlIjXgkUEfsITOtUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJLdn4ACgkQCXcVR3XQvP1fVwEA4a4KFN2g8PAaYI4xxj00GGRB
hvDHowoMAIcNU+xRz3UBANgsua4vWnWCCFvjpZD1/HEjA7rKXSctoHF7ZJzK5OTx
=Bk8h
-----END PGP SIGNATURE-----

--A8Lpu5T6CM67kuBfFlIjXgkUEfsITOtUA--


--===============2923192615265700701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2923192615265700701==--
