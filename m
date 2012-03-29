From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Thu, 29 Mar 2012 19:46:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for  IT8781F, IT8782F, IT8783E/F
Message-Id: <59C1832D-DAB3-4EE0-9781-32AE23035B35@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
In-Reply-To: <6.2.5.6.2.20120324091434.02773d68@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

Am 28.03.2012 um 01:28 schrieb Guenter Roeck:
> On Tue, Mar 27, 2012 at 03:21:35PM -0400, Bj=F6rn Gerhart wrote:
>> Hi Jean,
>>=20
>> Am 26.03.2012 um 19:01 schrieb Jean Delvare:
>>> [..]
>>>> If actually it is the job of the module to do such calculations, I wou=
ld offer to create an it87 patch for IT8783 fixing this - analog to an exis=
ting module with a similar behavior (if you know one).
>>>=20
>>> You assume that the PECI value always refers to the CPU. I do not think
>>> this is true, other parts (e.g. north bridge) could report their
>>> temperature through PECI as well.
>>>=20
>>> And if it is the CPU temperature, we already have the coretemp driver
>>> providing the same information, so there's little point in implementing
>>> the same in it87. The only benefit of handling PECI sensors in it87 and
>>> the like would be so that they can be used as sources for automatic fan
>>> speed control, but if the chip itself has no idea about the absolute
>>> value of the temperature then I doubt it can use it for automatic fan
>>> speed control.
>>>=20
>> Yes, with the coretemp driver even both core temperatures are displayed =
correctly. So I agree, it's nonsense to implement our special design into t=
he generic driver  ;-)
>=20
> Depends. As Jean mentioned, it would make sense if the temperature can be=
 used for
> automatic fan control.
>=20
That's right, for instance the BIOS on our mainboard controls the fan RPM t=
hrough that PECI value.

> The PECI specification says (I qoute Wikipedia) "PECI reports a negative =
value expressing
> the difference between the current temperature and the thermal throttle p=
oint (at which
> the CPU reduces speed or shuts down to prevent damage due to overheating)=
 instead of the
> absolute temperature". So the negative value and slope is to be expected.
>=20
> Question is if there is a way to tell the chip the how to calculate the r=
eal temperature
> from the raw value reported by PECI. The Nuvoton chips have a set of regi=
sters for that
> purpose.
>=20
> Since the raw PECI value is not very useful, it might well be that it is =
possible
> to program the ITE chip to adust its readings. No idea how to do that, th=
ough.
> If your HW folks have a contact at ITE, maybe you could ask them to try t=
o find out.
> Or maybe there is some BIOS code available from ITE and/or from BIOS vend=
ors.
>=20
My HW colleagues don't have deeper knowledge about PECI. I'll try to get th=
e ITE contact address to ask ITE directly..
As far as I know, our BIOS simply uses the intel CPU register to calculate =
the real temperature.

> Alternatively, it might be possible to program fan control to take the ne=
gative slope
> into account; at least Wikipedia suggests that as possibility (to have th=
e fan run faster
> as the reported temperature approaches zero from below). No idea how to d=
o that either,
> though.
>=20
> There is also register 0x0a, bits 4-6. Is that set to PECI on your board ?
>=20
Yes, in our design on Index Register 0x0A, bits 6-4 are set to 110, which a=
lso means that PECI is enabled.


However, on our mainboard we have PECI mode enabled but at the same time we=
 can use UART6. There is a trick to disable the parallel port and therefore=
 enable COM6 on the parallel port's pins:
When PECI mode is enabled, UART6 is not necessarily disabled. It depends on=
 the wiring. When JP4 (pin 1) is set to 0, the parallel port on pins 100..1=
06 gets disabled. Therefore, on these pins UART6 can be used instead (see c=
hapter "Power On Strapping Options").

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
