From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 14 Apr 2012 21:58:12 +0000
Subject: Re: [lm-sensors] sensor 3.3.1 and previous do not properly detect/show CPUTIN temperature - maximus
Message-Id: <20120414215812.GA9319@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
In-Reply-To: <CAGqf2i+bMvvWyELKn5ApTL+XUQ_s7x-eMCSV4DdNGhpfuHy6nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Apr 14, 2012 at 09:09:59AM -0400, Martin Suchanek wrote:
> Hi,
>=20
> I have found for long time ago that CPUTIN temperature is not showed corr=
ectly
> by sensors command:
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:=A0 +34.0=B0C=A0 (high =3D +80.0=B0C, crit =3D +98.0=B0C)
> Core 0:=A0=A0=A0=A0=A0=A0=A0=A0 +30.0=B0C=A0 (high =3D +80.0=B0C, crit =
=3D +98.0=B0C)
> ...
> nct6776-isa-0290
> Adapter: ISA adapter
> ...
> CPUTIN:=A0=A0=A0=A0=A0=A0=A0 -60.0=B0C=A0 (high =3D +80.0=B0C, hyst =3D +=
75.0=B0C)=A0 sensor =3D diode
> ...
>=20
> I have cheked it in BIOS and in AI Suite in windows 7 64 bit and consulte=
d it
> with ASUS technical support and everything is working properly.
> So , hardware is fine. Software in windows is fine. Only linux software i=
s not
> correct.
> I have tried to detect-sensor many times and it is still the same.
> If there is some kind of tweak in config please let me know but it seems =
to me
> there is something wrong with lm-sensors 3.3.1.
>=20
> ...
> Intel digital thermal sensor...=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Success!
> =A0=A0=A0 (driver `coretemp')
> ...
> Found `Nuvoton NCT6776F Super IO Sensors'=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 Success!
> ...
> Driver `w83627ehf':
> =A0 * ISA bus, address 0x290
> =A0=A0=A0 Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
>=20
> Driver `coretemp':
> =A0 * Chip `Intel digital thermal sensor' (confidence: 9)
> ...
>=20
> my /etc/modules:
> ...
> coretemp
> w83627ehf
> ...
>=20
> This error have appeared on maximus iv extreme motherboard Revision 3 , B=
IOS
> from 1404 to 3202 (latest)
> linux ubuntu natty -> oneiric 64 bit kernel from 2.6.39 up to 3.0.0-19
> commercial version (tested on 3.3.1 compiled by me)
>=20
> Could you please help me to solve it ?
>=20
CPUTIN with NCT6776F is kind of problematic. It shows up wrong on many (but=
 not all) boards.
On some boards, the displayed temperature even decreases as the CPU tempera=
ture increases.
There may be some magic configuration setting which need to be fixed, but I=
 have not been=20
able to find out what those would be.

I have a new experimental driver for NCT6775F and NCT6776F at https://githu=
b.com/groeck/nct6775,
in case you want to give it a try. With this driver, it is possible to set =
the temperature sensor type
(1, 3, or 4). It doesn't help with my P8H67-V board for any of the possible=
 settings, but maybe
you are more lucky.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
