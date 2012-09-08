From: Andreas Hartmann <andihartmann@01019freenet.de>
Date: Sat, 08 Sep 2012 19:26:11 +0000
Subject: Re: [lm-sensors] Strange temperature of AMD FX4100 cpu and power consumption
Message-Id: <504B9BD3.7020605@01019freenet.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <504B7388.8020102@01019freenet.de>
In-Reply-To: <504B7388.8020102@01019freenet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Guenter Roeck wrote:
> On Sat, Sep 08, 2012 at 06:34:16PM +0200, Andreas Hartmann wrote:
>> Hello,
>>=20
>> I'm getting this temperature after more than one hour of
>> activity (mostly idle, load of the machine is: 0,11, 0,17,
>> 0,21):
>>=20
>> sensors k10temp-pci-00c3 Adapter: PCI adapter temp1:
>> +14.5=B0C  (high =3D +70.0=B0C) (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)
>>=20
>> 14.5=B0C is completely impossible as the surrounding temperature
>> is
>>> 20=B0C.
>>=20
>>=20
>> fam15h_power-pci-00c4 Adapter: PCI adapter power1:       85.74 W
>>=20
>> I read about this value, which would be the power consumption of
>> the CPU. If this would be correct, my cpu wouldn't be a cpu but a
>> light bulb :-) and the fan would most probably run on maximum
>> speed non stop (which it doesn't do - it's running on minimum).
>>=20
> If they have a built-in AC unit, both temperature and power
> consumption would make sense. Hmm ... maybe I should apply for a
> patent on that idea :).

Yeah, that's true! Nice idea! Unfortunately, there isn't any built in
AC unit :-(


Regards,
Andreas

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
