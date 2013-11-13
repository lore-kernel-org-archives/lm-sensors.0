From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Wed, 13 Nov 2013 12:17:12 +0000
Subject: Re: [lm-sensors] [PATCHv5 20/20] MAINTAINERS: add maintainer entry for thermal bindings
Message-Id: <52836DC8.8080702@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0769835412581907893=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1384285582-16933-1-git-send-email-eduardo.valentin@ti.com> <1384285582-16933-21-git-send-email-eduardo.valentin@ti.com> <CAOesGMiCh-nGPqJQd4NPz9st7mBT0JkZ9nEK1gfyF2RmnrXZog@mail.gmail.com> <52828C31.2050604@ti.com> <20131113094232.GB21713@e106331-lin.cambridge.arm.com>
In-Reply-To: <20131113094232.GB21713@e106331-lin.cambridge.arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Olof Johansson <olof@lixom.net>, Stephen Warren <swarren@wwwdotorg.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ian.campbell@citrix.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Guenter Roeck <linux@roeck-us.net>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "wni@nvidia.com" <wni@nvidia.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "durgadoss.r@intel.com" <durgadoss.r@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>

--===============0769835412581907893==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xj7vtLu5XQTwRUPwdGgl6qRw5hxGB2OUA"

--xj7vtLu5XQTwRUPwdGgl6qRw5hxGB2OUA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 13-11-2013 05:42, Mark Rutland wrote:
> Hi,
>=20
> On Tue, Nov 12, 2013 at 08:14:41PM +0000, Eduardo Valentin wrote:
>> On 12-11-2013 15:59, Olof Johansson wrote:
>>> On Tue, Nov 12, 2013 at 11:46 AM, Eduardo Valentin
>>> <eduardo.valentin@ti.com> wrote:
>>>> After discussion and agreement of thermal device tree bindings,
>>>> it is desirable to properly maintain thermal bindings for
>>>> existing and upcoming devices.
>>>>
>>>> As original author of thermal device tree bindings, I am
>>>> volunteering to maintain them.
>>>>
>>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>>> Cc: Pawel Moll <pawel.moll@arm.com>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Stephen Warren <swarren@wwwdotorg.org>
>>>> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
>>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>>> ---
>>>>  MAINTAINERS | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 3438384..94bfc46 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -6178,6 +6178,7 @@ M:        Pawel Moll <pawel.moll@arm.com>
>>>>  M:     Mark Rutland <mark.rutland@arm.com>
>>>>  M:     Stephen Warren <swarren@wwwdotorg.org>
>>>>  M:     Ian Campbell <ijc+devicetree@hellion.org.uk>
>>>> +M:     Eduardo Valentin <eduardo.valentin@ti.com>
>>>>  L:     devicetree@vger.kernel.org
>>>>  S:     Maintained
>>>>  F:     Documentation/devicetree/
>>>
>>> The number of device-tree maintainers is getting to be somewhat silly=
=2E
>>> You don't have to be a maintainer to be a reviewer, and the number is=

>>> getting large enough that it might get hard for one maintainer to kno=
w
>>> what another is doing.
>>>
>>> So, soft nack, but it's really up to the DT guys.
>>
>> Hello Olof,
>>
>> No issues on my side. As I stated in the patch description, I am
>> volunteering. The motivation comes from the fact that it's been hard t=
o
>> get DT maintainers attention, so I am assuming they are not having
>> enough bandwidth to pay attention to an extra class of bindings.
>>
>> I agree with you, this is up to the DT folks.
>=20
> When we discussed this in #devicetree, I was under the impression you
> meant adding a line like:
>=20
> F:      Documentation/devicetree/bindings/thermal/
>=20
> To your MAINTAINERS entry, rather than adding yourself to the general
> devicetree bindings MAINTAINERS entry. Sorry for the confusion regardin=
g
> this.
>=20
> Given we have enough difficulty organising ourselves at present, I agre=
e
> with Olof that it doesn't make much sense to throw more people into the=

> general devicetree bindings maintainer pile.
>=20
> However, we would certainly appreciate any review you'd be willing to
> provide.

No issues then folks. :-)

>=20
> Thanks,
> Mark.
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--xj7vtLu5XQTwRUPwdGgl6qRw5hxGB2OUA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlKDbcgACgkQCXcVR3XQvP3gAAEApfSAfk67eq22FJy/dY46cxCZ
1DhuZiTeUNPQYuLMkF8A/AkgSQAHK3nAzd3hGOmLOhbfElBIW4F8h0PU34gqqpZr
=xlBF
-----END PGP SIGNATURE-----

--xj7vtLu5XQTwRUPwdGgl6qRw5hxGB2OUA--


--===============0769835412581907893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0769835412581907893==--
