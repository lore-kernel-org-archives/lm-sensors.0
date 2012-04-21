From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 21 Apr 2012 14:49:59 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <20120421144959.GA15288@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Apr 21, 2012 at 05:38:54AM -0400, Martin Suchanek wrote:
> I have had in mind CPUTIN which is showing in lm-sensors -60 Celsius.
> (=A0 it is all described more detailed in my previous posts.)
> Just small info :-)
>=20
I understand, but since the chip supports variable sensor mapping it would =
help
to know the other readings in comparison.

... and please don't top-post.

Thanks,
Guenter

> On Fri, Apr 20, 2012 at 4:22 PM, Guenter Roeck <guenter.roeck@ericsson.co=
m>
> wrote:
>=20
>     On Fri, 2012-04-20 at 06:47 -0400, Martin Suchanek wrote:
>     > Hi,
>     >
>     > Add info:
>     > I have found software called open hardware monitor. I have been
>     > testing it in windows for couple of days and it works properly with
>     > Nuvoton NST6776F chip. I have been comparing results with AI Suite
>     > software coming from ASUS and results are corresponding and measuri=
ng
>     > is with big precise. So , you can have a look to source code and
>     > compare with your driver. This software should work on linux as well
>     > but I did not try it yet but I will.
>     >
>     > (I did not tried your experimental driver yet but I will)
>     >
>     Martin,
>=20
>     please don't top-post.
>=20
>     What is the output you get with open hardware monitor ? They report f=
our
>     temperatures, PECI_0, CPUTIN, AUXTIN, and SYSTIN.
>=20
>     Thanks,
>     Guenter
>=20
>     > Regards,
>     > Martin
>     >
>     >
>     > On Sat, Apr 14, 2012 at 2:09 PM, Martin Suchanek
>     > <martin.suc@googlemail.com> wrote:
>     > =A0 =A0 =A0 =A0 Hi,
>     >
>     > =A0 =A0 =A0 =A0 I have found for long time ago that CPUTIN temperat=
ure is not
>     > =A0 =A0 =A0 =A0 showed correctly by sensors command:
>     >
>     > =A0 =A0 =A0 =A0 coretemp-isa-0000
>     > =A0 =A0 =A0 =A0 Adapter: ISA adapter
>     > =A0 =A0 =A0 =A0 Physical id 0: =A0+34.0=B0C =A0(high =3D +80.0=B0C,=
 crit =3D +98.0=B0C)
>     > =A0 =A0 =A0 =A0 Core 0: =A0 =A0 =A0 =A0 +30.0=B0C =A0(high =3D +80.=
0=B0C, crit =3D +98.0=B0C)
>     > =A0 =A0 =A0 =A0 ...
>     > =A0 =A0 =A0 =A0 nct6776-isa-0290
>     > =A0 =A0 =A0 =A0 Adapter: ISA adapter
>     > =A0 =A0 =A0 =A0 ...
>     > =A0 =A0 =A0 =A0 CPUTIN: =A0 =A0 =A0 =A0-60.0=B0C =A0(high =3D +80.0=
=B0C, hyst =3D +75.0=B0C)
>     > =A0 =A0 =A0 =A0 sensor =3D diode
>     > =A0 =A0 =A0 =A0 ...
>     >
>     > =A0 =A0 =A0 =A0 I have cheked it in BIOS and in AI Suite in windows=
 7 64 bit
>     > =A0 =A0 =A0 =A0 and consulted it with ASUS technical support and ev=
erything is
>     > =A0 =A0 =A0 =A0 working properly.
>     > =A0 =A0 =A0 =A0 So , hardware is fine. Software in windows is fine.=
 Only linux
>     > =A0 =A0 =A0 =A0 software is not correct.
>     > =A0 =A0 =A0 =A0 I have tried to detect-sensor many times and it is =
still the
>     > =A0 =A0 =A0 =A0 same.
>     > =A0 =A0 =A0 =A0 If there is some kind of tweak in config please let=
 me know
>     > =A0 =A0 =A0 =A0 but it seems to me there is something wrong with lm=
-sensors
>     > =A0 =A0 =A0 =A0 3.3.1.
>     >
>     > =A0 =A0 =A0 =A0 ...
>     > =A0 =A0 =A0 =A0 Intel digital thermal sensor...
>     > =A0 =A0 =A0 =A0 Success!
>     > =A0 =A0 =A0 =A0 =A0 =A0 (driver `coretemp')
>     > =A0 =A0 =A0 =A0 ...
>     > =A0 =A0 =A0 =A0 Found `Nuvoton NCT6776F Super IO Sensors'
>     > =A0 =A0 =A0 =A0 Success!
>     > =A0 =A0 =A0 =A0 ...
>     > =A0 =A0 =A0 =A0 Driver `w83627ehf':
>     > =A0 =A0 =A0 =A0 =A0 * ISA bus, address 0x290
>     > =A0 =A0 =A0 =A0 =A0 =A0 Chip `Nuvoton NCT6776F Super IO Sensors' (c=
onfidence: 9)
>     >
>     > =A0 =A0 =A0 =A0 Driver `coretemp':
>     > =A0 =A0 =A0 =A0 =A0 * Chip `Intel digital thermal sensor' (confiden=
ce: 9)
>     > =A0 =A0 =A0 =A0 ...
>     >
>     > =A0 =A0 =A0 =A0 my /etc/modules:
>     > =A0 =A0 =A0 =A0 ...
>     > =A0 =A0 =A0 =A0 coretemp
>     > =A0 =A0 =A0 =A0 w83627ehf
>     > =A0 =A0 =A0 =A0 ...
>     >
>     > =A0 =A0 =A0 =A0 This error have appeared on maximus iv extreme moth=
erboard
>     > =A0 =A0 =A0 =A0 Revision 3 , BIOS from 1404 to 3202 (latest)
>     > =A0 =A0 =A0 =A0 linux ubuntu natty -> oneiric 64 bit kernel from 2.=
6.39 up to
>     > =A0 =A0 =A0 =A0 3.0.0-19 commercial version (tested on 3.3.1 compil=
ed by me)
>     >
>     > =A0 =A0 =A0 =A0 Could you please help me to solve it ?
>     >
>     > =A0 =A0 =A0 =A0 Thank you very much for any clue.
>     > =A0 =A0 =A0 =A0 Kind Regards,
>     > =A0 =A0 =A0 =A0 Martin
>     >
>     >
>=20
>=20
>=20
>=20

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
