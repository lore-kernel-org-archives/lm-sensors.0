From: Udo van den Heuvel <udovdh@xs4all.nl>
Date: Fri, 14 Dec 2007 14:33:45 +0000
Subject: Re: [lm-sensors] k8temp weirdness, it8716 questions
Message-Id: <47629449.1050604@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <475FFF23.2070800@xs4all.nl>
In-Reply-To: <475FFF23.2070800@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Wed, 12 Dec 2007 16:32:51 +0100, Udo van den Heuvel wrote:
>> I am running Fedora 8 on a Gigabyte m56s-s3 board with an AMD X2 BE-2350.
>> Running sensors gives me:
>>
>> # sensors
>> k8temp-pci-00c3
>> Adapter: PCI adapter
>> temp1:        -9=B0C
>> temp2:       -20=B0C
>> temp3:       -18=B0C
>> temp4:       -14=B0C
>>
>> it8716-isa-0290
(.....)
>> in5:       +3.18 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> in6:       +0.10 V  (min =3D  +0.00 V, max =3D  +4.08 V)
>> 5VSB:      +4.92 V  (min =3D  +0.00 V, max =3D  +6.85 V)
>> VBat:      +3.07 V
>> fan1:      805 RPM  (min =3D    0 RPM)
>> fan2:        0 RPM  (min =3D    0 RPM)
>> temp1:       +38=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   sensor =
=3D thermistor
>> temp2:       +35=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   sensor =
=3D thermistor
>> temp3:       +25=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   sensor =
=3D diode
>> vid:      +1.000 V (yes, throttled down)
>>
>> As you can see the k8temp info is slightly off-target.
>> Is this a known issue? How could it be corrected?
>=20
> The rumor says that most recent K8 CPUs have broken thermal sensors and
> there's nothing you can do about that. My hope is that we can blacklist
> them in the k8temp driver directly, but I don't know which models are
> affected exactly.

No software compensation possible?

>> What are in5 and in6 on this board?
>=20
> It's motherboard-specific, so we can't tell for sure. in6 is too low to
> be anything real, so my guess is that it isn't wired at all (so you can
> add "ignore in6" in your configuration file. in5 seems to be real, it
> could be 3VSB. Only the motherboard manufacturer can tell for sure.

I will ask Gigabyte support.

>> What are temp2 and temp3?
>=20
> Did temp3 ever change?=20

Yes.

> Gigabyte are famous for their thermal sensors
> that read 25 degrees C all the time (even though there are typically
> thermistors, not thermal diodes.) These are unconnected thermal inputs
> which you can just ignore.

When temp3 is changed to thermistor it reads 89 degrees versis 24 as
diode. (temp1/2 are 34 now)

> This leaves temp1 and temp2 for the CPU and system temperatures, or
> vice-versa.=20

I'll fidn out which is which.

> If you come up with a good configuration file for that board, please
> submit it and we'll add it to our collection.

It will still be part guesswork but I'll let you know.

Udo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
