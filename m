From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Mon, 18 Nov 2013 16:40:53 +0000
Subject: Re: [lm-sensors] [PATCHv5 06/20] hwmon: lm75: expose to thermal fw via DT nodes
Message-Id: <528A4315.8050706@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2603451223158183623=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-7-git-send-email-eduardo.valentin@ti.com> <20131115084354.656452b9@endymion.delvare> <528A23DD.2070406@ti.com> <20131118162532.GB15610@roeck-us.net>
In-Reply-To: <20131118162532.GB15610@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Jean Delvare <khali@linux-fr.org>, swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, rui.zhang@intel.com, wni@nvidia.com, grant.likely@linaro.org, durgadoss.r@intel.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

--===============2603451223158183623==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="enTlcPb90etLHFHuWqlPc41VStoaDm7qT"

--enTlcPb90etLHFHuWqlPc41VStoaDm7qT
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18-11-2013 12:25, Guenter Roeck wrote:
> On Mon, Nov 18, 2013 at 10:27:41AM -0400, Eduardo Valentin wrote:
>> On 15-11-2013 03:43, Jean Delvare wrote:
>>> Hi Eduardo,
>>>
>>
>> Hello Jean!
>>
>>> Sorry for joining the discussion a little late, I could never find th=
e
>>> time to look into this patch series so far.
>>
>> Well, better late than never, that's what it is said, isn't it? :-)
>> Thanks for arranging the time to look at these patches.
>>
>> The patch series have been looked and contributed by several people an=
d
>> a couple o maintainers now. Starts to be way better than the original
>> RFC. The core idea still holds though.
>>
>>>
>>> On Tue, 12 Nov 2013 15:46:08 -0400, Eduardo Valentin wrote:
>>>> This patch adds to lm75 temperature sensor the possibility
>>>> to expose itself as thermal zone device, registered on the
>>>> thermal framework.
>>>>
>>>> The thermal zone is built only if a device tree node
>>>> describing a thermal zone for this sensor is present
>>>> inside the lm75 DT node. Otherwise, the driver behavior
>>>> will be the same.
>>>>
>>>> Cc: Jean Delvare <khali@linux-fr.org>
>>>> Cc: lm-sensors@lm-sensors.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>
>> On HWMON side, I got Guenter's solid contributions, as you can see.
>>
> Not an argument. I am not perfect, and Jean has a number of valid point=
s.
>=20

In fact, this is not an argument, at least not on what Jean is bringing
now. The point here was just to mention that, even though he joined
late, you have already contributed on this patch series. ;-)

> Guenter
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--enTlcPb90etLHFHuWqlPc41VStoaDm7qT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKKQxUACgkQCXcVR3XQvP0VhwD9Ha6wMEij49UTBQR52C4NQZ2B
YtyILpxCdEKd3R4eN4UBAOXjV+lwp+sc2N9Czo6cjMmGitZLyA4ch2kkvYa5tWrg
=I64P
-----END PGP SIGNATURE-----

--enTlcPb90etLHFHuWqlPc41VStoaDm7qT--


--===============2603451223158183623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2603451223158183623==--
