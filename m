From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 01 Nov 2012 20:54:04 +0000
Subject: Re: [lm-sensors] [PATCH 9/9] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <20121101205404.GA2974@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, Nov 01, 2012 at 07:12:08PM +0100, Jean Delvare wrote:
> On Thu, 1 Nov 2012 10:17:07 -0700, Guenter Roeck wrote:
> > On Thu, Nov 01, 2012 at 05:37:57PM +0100, Jean Delvare wrote:
> > > On an IT8720F chip with temp3 configured for PECI:
> > >=20
> > > temp1_offset: 0
> > > temp2_offset: 0
> > > temp3_offset: -128000
> > >=20
> > > I'm unsure how to interpret this -128000... This value is definitely
> > > not neutral, doesn't sound very realistic. I would expect a positive
> > > number for PECI. Maybe the offset register should be treated as
> > > unsigned in PECI mode? Or maybe its value is irrelevant for the IT872=
0F
> > > in PECI mode.
> > >=20
> > > # grep . /sys/class/hwmon/hwmon2/device/temp3*
> > > /sys/class/hwmon/hwmon2/device/temp3_alarm:0
> > > /sys/class/hwmon/hwmon2/device/temp3_beep:1
> > > /sys/class/hwmon/hwmon2/device/temp3_input:25000
> > > /sys/class/hwmon/hwmon2/device/temp3_max:70000
> > > /sys/class/hwmon/hwmon2/device/temp3_min:127000
> > > /sys/class/hwmon/hwmon2/device/temp3_offset:-128000
> > > /sys/class/hwmon/hwmon2/device/temp3_type:6
> > >=20
> > > This is with an it87 driver including all your recent patches. It you
> > > have ideas or theories, I'm interested.
> > >=20
> > Hi Jean,
> >=20
> > I agree. The alternative (+128 degrees C) sounds a bit high, though.
> > Maybe there is another register on IT8720F to store Tjmax ? Did you che=
ck
> > in the register map if there is a register value that happens to match =
it ?
>=20
> How would I know which value I am looking for? k10temp says this:
> high =3D +70.0=B0C, crit =3D +90.0=B0C, hyst =3D +87.0=B0C
> but the monitored value doesn't match it87's temp3.
>=20
> > What happens if you change the offset register value to, say, 100 ?
> > Does the reported temperature change as well ?
>=20
> Yes it does.
> temp3_offset =3D  120000 -> temp3_input =3D 14000
> temp3_offset =3D  125000 -> temp3_input =3D 19000
> temp3_offset =3D -128000 -> temp3_input =3D 22000
> temp3_offset =3D -126000 -> temp3_input =3D 23000
>=20
> This leads me to the conclusion that the offset registers are unsigned
> in PECI mode.
>=20
If so, then only for AMD, or it is is a chip dependent.

On Intel (with IT8728F):

temp3_offset =3D -20000:	temp3_input =3D -96000
temp3_offset =3D -10000:	temp3_input =3D -87000
temp3_offset =3D 0:	temp3_input =3D -76000
temp3_offset =3D 10000:	temp3_input =3D -67000
temp3_offset =3D 20000:	temp3_input =3D -56000
temp3_offset =3D 105000:	temp3_input =3D 28000 (matches Tjmax / coretemp)

I don't know what AMD uses as equivalent of Tjmax - maybe they
use a fixed value of 128=B0C.

> > Another maybe dumb question - is this with Intel or AMD CPU ? Because
> > if it is AMD, it would not be PECI but AMDSI (something to fix if someo=
ne
> > has a system w/ IT87xx and AMD CPU).
>=20
> It is AMD indeed, that's another issue I wanted to report. Do you
> already know how to fix it?
>=20
Yes, I think so, at least I have an idea. Give me a couple of days.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
