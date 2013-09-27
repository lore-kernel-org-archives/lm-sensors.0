From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Fri, 27 Sep 2013 13:42:49 +0000
Subject: Re: [lm-sensors] [PATCHv4 11/18] arm: dts: add omap4430 thermal data
Message-Id: <52458B59.8070703@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5394010357316513761=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1380251605-3804-1-git-send-email-eduardo.valentin@ti.com> <1380251605-3804-12-git-send-email-eduardo.valentin@ti.com> <20130927122439.GA8360@kahuna> <5245861F.7000109@ti.com> <CAGo_u6p3pp2EBo_fJE_RJOdrc05OHM-QFgCZFBUW+duhPgOYpw@mail.gmail.com>
In-Reply-To: <CAGo_u6p3pp2EBo_fJE_RJOdrc05OHM-QFgCZFBUW+duhPgOYpw@mail.gmail.com>
To: Nishanth Menon <nm@ti.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, Mark Rutland <mark.rutland@arm.com>, dt list <devicetree@vger.kernel.org>, wni@nvidia.com, durgadoss.r@intel.com, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-pm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Grant Likely <grant.likely@linaro.org>, Russell King <linux@arm.linux.org.uk>, rui.zhang@intel.com, linux-omap <linux-omap@vger.kernel.org>, linux@roeck-us.net

--===============5394010357316513761==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="okDvHLNIenjhDREDRe2cvg6qUKECOqodL"

--okDvHLNIenjhDREDRe2cvg6qUKECOqodL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 27-09-2013 09:26, Nishanth Menon wrote:
> On Fri, Sep 27, 2013 at 8:20 AM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
>> On 27-09-2013 08:24, Nishanth Menon wrote:
>>> On 23:13-20130926, Eduardo Valentin wrote:
>>>> This patch changes the dtsi entry on omap4430 to contain
>>>> the thermal data. This data will enable the passive
>>>> cooling with CPUfreq cooling device at 100C and the
>>>> system will do a thermal shutdown at 125C.
>>>>
>>>> Cc: "Beno=EEt Cousson" <bcousson@baylibre.com>
>>>> Cc: Tony Lindgren <tony@atomide.com>
>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>> Cc: linux-omap@vger.kernel.org
>>>> Cc: devicetree-discuss@lists.ozlabs.org
>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
>>>> ---
>>>>  arch/arm/boot/dts/omap443x.dtsi | 10 ++++++++--
>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/oma=
p443x.dtsi
>>>> index bcf455e..e9c97d6 100644
>>>> --- a/arch/arm/boot/dts/omap443x.dtsi
>>>> +++ b/arch/arm/boot/dts/omap443x.dtsi
>>>> @@ -12,7 +12,7 @@
>>>>
>>>>  / {
>>>>      cpus {
>>>> -            cpu@0 {
>>>> +            cpu0: cpu@0 {
>>>>                      /* OMAP443x variants OPP50-OPPNT */
>>>>                      operating-points =3D <
>>>>                              /* kHz    uV */
>>>> @@ -25,9 +25,15 @@
>>>>              };
>>>>      };
>>>>
>>>> -    bandgap {
>>>> +    thermal-zones{
>>>> +            #include "omap4-cpu-thermal.dtsi"
>>>> +    };
>>>> +
>>>> +    bandgap: bandgap {
>>>>              reg =3D <0x4a002260 0x4
>>>>                     0x4a00232C 0x4>;
>>>>              compatible =3D "ti,omap4430-bandgap";
>>>> +
>>>> +            #thermal-sensor-cells =3D <0>;
>>> 2 cents:
>>> we might want to move bandgap under ocp?
>>>
>>
>> Yes, agreed. But I don't think this change is related to this patch or=

>> to this series.
>=20
> Correct - this comment is not related to the current patch, hence my 2
> cents ;) - will be nice to have it cleaned up though..

Yes, it will be cleaned. ;-) Tks.

>=20
> Regards,
> Nishanth Menon
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--okDvHLNIenjhDREDRe2cvg6qUKECOqodL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlJFi1kACgkQCXcVR3XQvP0QoAEA4MfbQt5xnfzUFjwU/nzb4Ahg
nKZcdTIocqE6yVs/mg0A+wejPt8TOxTb8Gxy4/HJfD3MgfnLul13qlpnMBWID75d
=J34r
-----END PGP SIGNATURE-----

--okDvHLNIenjhDREDRe2cvg6qUKECOqodL--


--===============5394010357316513761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5394010357316513761==--
