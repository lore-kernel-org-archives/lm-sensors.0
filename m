From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Nov 2012 18:12:08 +0000
Subject: Re: [lm-sensors] [PATCH 9/9] hwmon: (it87) Report thermal sensor type as Intel PECI if appropriate
Message-Id: <20121101191208.31e94e33@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
In-Reply-To: <1351448401-13985-10-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 1 Nov 2012 10:17:07 -0700, Guenter Roeck wrote:
> On Thu, Nov 01, 2012 at 05:37:57PM +0100, Jean Delvare wrote:
> > On an IT8720F chip with temp3 configured for PECI:
> >=20
> > temp1_offset: 0
> > temp2_offset: 0
> > temp3_offset: -128000
> >=20
> > I'm unsure how to interpret this -128000... This value is definitely
> > not neutral, doesn't sound very realistic. I would expect a positive
> > number for PECI. Maybe the offset register should be treated as
> > unsigned in PECI mode? Or maybe its value is irrelevant for the IT8720F
> > in PECI mode.
> >=20
> > # grep . /sys/class/hwmon/hwmon2/device/temp3*
> > /sys/class/hwmon/hwmon2/device/temp3_alarm:0
> > /sys/class/hwmon/hwmon2/device/temp3_beep:1
> > /sys/class/hwmon/hwmon2/device/temp3_input:25000
> > /sys/class/hwmon/hwmon2/device/temp3_max:70000
> > /sys/class/hwmon/hwmon2/device/temp3_min:127000
> > /sys/class/hwmon/hwmon2/device/temp3_offset:-128000
> > /sys/class/hwmon/hwmon2/device/temp3_type:6
> >=20
> > This is with an it87 driver including all your recent patches. It you
> > have ideas or theories, I'm interested.
> >=20
> Hi Jean,
>=20
> I agree. The alternative (+128 degrees C) sounds a bit high, though.
> Maybe there is another register on IT8720F to store Tjmax ? Did you check
> in the register map if there is a register value that happens to match it=
 ?

How would I know which value I am looking for? k10temp says this:
high =3D +70.0=B0C, crit =3D +90.0=B0C, hyst =3D +87.0=B0C
but the monitored value doesn't match it87's temp3.

> What happens if you change the offset register value to, say, 100 ?
> Does the reported temperature change as well ?

Yes it does.
temp3_offset =3D  120000 -> temp3_input =3D 14000
temp3_offset =3D  125000 -> temp3_input =3D 19000
temp3_offset =3D -128000 -> temp3_input =3D 22000
temp3_offset =3D -126000 -> temp3_input =3D 23000

This leads me to the conclusion that the offset registers are unsigned
in PECI mode.

> Another maybe dumb question - is this with Intel or AMD CPU ? Because
> if it is AMD, it would not be PECI but AMDSI (something to fix if someone
> has a system w/ IT87xx and AMD CPU).

It is AMD indeed, that's another issue I wanted to report. Do you
already know how to fix it?

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
