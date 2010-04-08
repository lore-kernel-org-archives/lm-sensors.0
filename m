From: Moofie <moofie@shaw.ca>
Date: Thu, 08 Apr 2010 23:50:41 +0000
Subject: Re: [lm-sensors] Soltek K8T800Pro (it87-isa-0290),
Message-Id: <4BBE6BD1.3050200@shaw.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <4BBA227C.7010205@shaw.ca>
In-Reply-To: <4BBA227C.7010205@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Moofie wrote:
> Hello list, this is my first time posting here, and I come with some=20
> questions about my server motherboard with the hopes that I configure=20
> sensors on it correctly.
>=20
> While this Soltek board is relatively old (as the company is no longer=20
> in business), I had never used it since the day that I bought it.  The=20
> board was recently installed into a server role and I hope to monitor=20
> its health from a distance.
>=20
> While sensors detects the correct chips installed on the board, the=20
> values are useless.
>=20
> I'm wondering if anyone can shed light on how to set the values=20
> correctly for this board.  Here's some pertinent info:
>=20
>=20
>=20
> ITE IT8712F, National LM90 (ISA 290h, SMBus 4Ch)
>=20
>=20
>=20
> acpitz-virtual-0
> Adapter: Virtual device
> temp1:       +40.0=B0C  (crit =3D +75.0=B0C)
>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:  +50.0=B0C
> Core1 Temp:  +42.0=B0C
>=20
> it87-isa-0290
> Adapter: ISA adapter
> in0:         +1.31 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in1:         +2.54 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in2:         +3.28 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in3:         +2.90 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in4:         +2.91 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in5:         +0.96 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in6:         +1.12 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> in7:         +2.94 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> Vbat:        +3.26 V
> fan1:       11250 RPM  (min =3D 3245 RPM)
> fan2:       4963 RPM  (min =3D    0 RPM)
> temp1:       +26.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
> thermistor
> temp2:       -86.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
> thermal diode
> temp3:       +14.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D=20
> thermistor
>=20
> lm90-i2c-0-4c
> Adapter: SMBus Via Pro adapter at 5000
> temp1:       +38.0=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)
>                       (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)
> temp2:       +63.1=B0C  (low  =3D  +0.0=B0C, high =3D +70.0=B0C)
>                       (crit =3D +85.0=B0C, hyst =3D +75.0=B0C)
>=20
>=20
> If I can provide more information, let me know.
>=20
> Thanks.
>=20
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>=20

OK, I give, what is the LM90 chip usually used for?  I understand that=20
temp1 is its own temperature.  Though is that basically the only use of=20
an lm90 chip?  To test one local and one remote temperature?

What have people used in real world examples for this chip?  Usually M/B=20
temp and CPU temp?  I see that temp2 jumps with the CPU temperature, I'm=20
going to assume it's correct as it matches the BIOS readings and I will=20
label it as such.

Though the k8 temps measure each core.  And... They're off by a few=20
degrees (12C in the above example) so which should I take as correct?=20
None of the above examples have compute lines so they seem to be as raw=20
as lm-sensors believes them to be.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
