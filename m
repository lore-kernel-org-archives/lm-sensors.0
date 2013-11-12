From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Tue, 12 Nov 2013 20:14:41 +0000
Subject: Re: [lm-sensors] [PATCHv5 20/20] MAINTAINERS: add maintainer entry for thermal bindings
Message-Id: <52828C31.2050604@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4148527946498572892=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-21-git-send-email-eduardo.valentin@ti.com> <CAOesGMiCh-nGPqJQd4NPz9st7mBT0JkZ9nEK1gfyF2RmnrXZog@mail.gmail.com>
In-Reply-To: <CAOesGMiCh-nGPqJQd4NPz9st7mBT0JkZ9nEK1gfyF2RmnrXZog@mail.gmail.com>
To: Olof Johansson <olof@lixom.net>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Stephen Warren <swarren@wwwdotorg.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Rob Herring <rob.herring@calxeda.com>, Guenter Roeck <linux@roeck-us.net>, rui.zhang@intel.com, wni@nvidia.com, Grant Likely <grant.likely@linaro.org>, durgadoss.r@intel.com, linux-pm@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lm-sensors@lm-sensors.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>

--===============4148527946498572892==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="f56BqfqqbEW80qud7ROafavhrG6UELiBc"

--f56BqfqqbEW80qud7ROafavhrG6UELiBc
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12-11-2013 15:59, Olof Johansson wrote:
> On Tue, Nov 12, 2013 at 11:46 AM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
>> After discussion and agreement of thermal device tree bindings,
>> it is desirable to properly maintain thermal bindings for
>> existing and upcoming devices.
>>
>> As original author of thermal device tree bindings, I am
>> volunteering to maintain them.
>>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Pawel Moll <pawel.moll@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3438384..94bfc46 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6178,6 +6178,7 @@ M:        Pawel Moll <pawel.moll@arm.com>
>>  M:     Mark Rutland <mark.rutland@arm.com>
>>  M:     Stephen Warren <swarren@wwwdotorg.org>
>>  M:     Ian Campbell <ijc+devicetree@hellion.org.uk>
>> +M:     Eduardo Valentin <eduardo.valentin@ti.com>
>>  L:     devicetree@vger.kernel.org
>>  S:     Maintained
>>  F:     Documentation/devicetree/
>=20
> The number of device-tree maintainers is getting to be somewhat silly.
> You don't have to be a maintainer to be a reviewer, and the number is
> getting large enough that it might get hard for one maintainer to know
> what another is doing.
>=20
> So, soft nack, but it's really up to the DT guys.

Hello Olof,

No issues on my side. As I stated in the patch description, I am
volunteering. The motivation comes from the fact that it's been hard to
get DT maintainers attention, so I am assuming they are not having
enough bandwidth to pay attention to an extra class of bindings.

I agree with you, this is up to the DT folks.


>=20
>=20
> -Olof
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--f56BqfqqbEW80qud7ROafavhrG6UELiBc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKCjD4ACgkQCXcVR3XQvP2MdwD/SEGaGTglYxEMz7+GH81ShNQ9
/80YSr5UHanZY02HA7oA/R+SZ8lrWwyGFUYWzziqk4zsFmJseZciL7A7mmMgZtDf
=TWz8
-----END PGP SIGNATURE-----

--f56BqfqqbEW80qud7ROafavhrG6UELiBc--


--===============4148527946498572892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4148527946498572892==--
