From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Mon, 06 Jan 2014 14:53:42 +0000
Subject: Re: [lm-sensors] [PATCHv2 0/7] DRA7: DT thermal support
Message-Id: <52CAC376.9090904@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1294101667708512775=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1389011811-13004-1-git-send-email-eduardo.valentin@ti.com> <1389019601.5853.17.camel@rzhang1-mobl4>
In-Reply-To: <1389019601.5853.17.camel@rzhang1-mobl4>
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <eduardo.valentin@ti.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

--===============1294101667708512775==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w6hnwxrXBm0kRrQdU5k1tdEDS4bAT4JMd"

--w6hnwxrXBm0kRrQdU5k1tdEDS4bAT4JMd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06-01-2014 10:46, Zhang Rui wrote:
> On Mon, 2014-01-06 at 08:36 -0400, Eduardo Valentin wrote:
>> Hello all,
>>
>> Now that the basic thermal DT support is merged into Rui's tree,
>> I am resending this series, which introduces the DT node entries
>> for DRA7 thermal limits representation.
>>
>> The series adds two thermal zones, to represent IVA and DSPEVE,
>> respectively. It also adds the support to tmp102 and a corresponding
>> pcb thermal zone.
>>
>> There are only cosmetic changes from v1. A couple of spaces and tabula=
tions
>> have been fixed, and minor changes in sentences present in commit log.=

>> One difference from V1 is the fact that now bandgap is introduced unde=
r
>> OCP, which is also a minor diff.
>>
>> This patch series has been runtime tested on DRA7-evm.
>>
>> All best
>>
>> Eduardo Valentin (7):
>>   arm: dts: add dra7 DSPEVE thermal data
>>   arm: dts: add dra7 IVA thermal data
>>   arm: dts: dra7: add bandgap entry
>>   arm: dts: add cooling properties on dra7 cpu node
>>   arm: dts: dra7: add thermal data
>>   arm: dts: add tmp102 i2c sensor node on dra7-evm
>>   arm: dts: add thermal zones info on tmp102 for DRA7-EVM
>>
>>  arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 28 +++++++++++++++++++++=
+++++++
>>  arch/arm/boot/dts/dra7-evm.dts             | 22 +++++++++++++++++++++=
+
>>  arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 28 +++++++++++++++++++++=
+++++++
>>  arch/arm/boot/dts/dra7.dtsi                | 26 +++++++++++++++++++++=
+++++
>=20
> I'm okay with this patch set. But as long as this patch set does not
> change any code under drivers/thermal/, I prefer these patches to go to=

> your thermal-soc tree first.

No problem at all. I will be queuing them.

>=20
> thanks,
> rui
>>  4 files changed, 104 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
>>  create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi
>>
>=20
>=20
>=20
>=20


--=20
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin


--w6hnwxrXBm0kRrQdU5k1tdEDS4bAT4JMd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlLKw3YACgkQCXcVR3XQvP2/uAD/bZAlE/r1chLoSmSNEJwIKarW
hrXPyIVW/uSA8EzXbpQA/Ahtvyl+C33hCCSRuCntJXbU9LXHluIoieQOAJv0Ty45
=TlPi
-----END PGP SIGNATURE-----

--w6hnwxrXBm0kRrQdU5k1tdEDS4bAT4JMd--


--===============1294101667708512775==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1294101667708512775==--
