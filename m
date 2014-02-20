From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 20 Feb 2014 13:49:14 +0000
Subject: Re: [lm-sensors] Need help setting up sensors on Gigabye GA-945GCM-S2L (IT8718F)
Message-Id: <20140220144914.1e9ca57e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392865158.7385.YahooMailNeo@web160501.mail.bf1.yahoo.com>
In-Reply-To: <1392865158.7385.YahooMailNeo@web160501.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Ian,

On Wed, 19 Feb 2014 18:59:18 -0800 (PST), ianp wrote:
> I wish to share some more configurations as I set them up. Now I'm trying=
 to configure my sensors on a Gigabyte GA-945GCM-S2L, running Linux 3.2.
>=20
>=20
> $ dmesg | grep it87
> it87: Found IT8718F chip at 0x290, revision 4
> it87: Beeping is supported
> (...)
> For +12V scaling, and seeing that in4 is the only unscaled input sensor t=
hat is not at 4.080V, which is the maximum range for this Super-I/O chip, I=
 decided to go ahead with the computation even with just two sample voltage=
s that I have personally observed in the BIOS:
>=20
> +12V BIOS samples: 12.302, 12.365
>=20
> 12.365 - 12.302 =3D 0.063
>=20
> 12.302 / (63/16) =3D 3.12431746
>=20
> which is very close to in4 (3.120). At one time it read:
>=20
> in4:
> =A0 in4_input: 3.140

There's something weird here: 3.140 isn't a integer multiple of 0.016,
so it is not possible that the IT8718F sensed that voltage value. Are
you sure this is the exact value reported by "sensors"? Or is it a copy
and paste error?

> =A0 in4_min: 2.896
> =A0 in4_max: 3.200
> =A0 in4_alarm: 0.000
> =A0 in4_beep: 0.000
>=20
> 12.365 / (63/16) =3D 3.14031746
>=20
> and still as close as it gets to in4 (3.140). So my compute statement for=
 +12V scaling is:
>=20
> =A0=A0 compute=A0 in4=A0 @*(63/16), @/(63/16)

I have found a BIOS screenshot on the web (was hard to find):
http://img155.imageshack.us/img155/5831/dsc00004kz6.jpg

Sample value there is 12.175 V.

12.302 - 12.175 =3D 0.127
12.365 - 12.175 =3D 0.190

The would suggests that the scaling factor isn't exactly 63/16 (3.9375)
but closer to 190/48 (3.9583.) However 190/48 doesn't map raw values to
BIOS values so that can't be it.

Your original assumption was that 12.302 in the BIOS was 3.120 in
"sensors". I think actually 12.365 in the BIOS was 3.120 in "sensors".
If you put some load on the CPU, you may be able to collect another in4
value from "sensors" (presumably 3.104) that would match the 12.302 in
the BIOS.

If I'm right then a scaling factor that would work would be somewhere
between 12.302/3.104 and 12.365/3.120, i.e. 3.9633. Note that this
isn't the first time this strange scaling factors shows up for Gigabyte
boards:
http://jdelvare.nerim.net/devel/lm-sensors/config/sensors3-Gigabyte-7N400-P=
ro2.conf
http://jdelvare.nerim.net/devel/lm-sensors/config/sensors3-Gigabyte-890GPA-=
UD3H.conf
http://www.lm-sensors.org/wiki/Configurations/Gigabyte/EX38-DS4

So I would go with:

   compute=A0 in4=A0 @*3.9633, @/3.9633

It maps the values seen in the BIOS with actual register values:

192 * 0.016 * 3.9633 =3D 12.175
194 * 0.016 * 3.9633 =3D 12.302
195 * 0.016 * 3.9633 =3D 12.365

> Here's the sensors output, using my configuration thus far:
>=20
> $ sensors
>=20
> it8718-isa-0290
> Adapter: ISA adapter
> Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.18 V=A0 (min =3D=A0 +0.85 V, max =3D=A0 +1=
.36 V)
> Vram:=A0=A0=A0=A0=A0=A0=A0=A0 +1.84 V=A0 (min =3D=A0 +1.71 V, max =3D=A0 =
+1.89 V)
> +3.3V:=A0=A0=A0=A0=A0=A0=A0 +3.39 V=A0 (min =3D=A0 +3.14 V, max =3D=A0 +3=
.47 V)
> in3:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.08 V=A0 (min =3D=A0 +0.00 V, max =3D=
=A0 +4.08 V)=A0 ALARM
> +12V:=A0=A0=A0=A0=A0=A0=A0 +12.29 V=A0 (min =3D +11.40 V, max =3D +12.60 =
V)
> in5:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.08 V=A0 (min =3D=A0 +0.00 V, max =3D=
=A0 +4.08 V)=A0 ALARM
> in6:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.08 V=A0 (min =3D=A0 +0.00 V, max =3D=
=A0 +4.08 V)=A0 ALARM
> in7:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.08 V=A0 (min =3D=A0 +0.00 V, max =3D=
=A0 +4.08 V)=A0 ALARM
> Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.06 V=A0=20
> CPU Fan:=A0=A0=A0=A0 1721 RPM=A0 (min =3D=A0 900 RPM)
> CHA Fan:=A0=A0=A0=A0 2096 RPM=A0 (min =3D=A0=A0=A0 0 RPM)
> temp1:=A0=A0=A0=A0=A0=A0=A0 -55.0=B0C=A0 (low=A0 =3D +20.0=B0C, high =3D =
+55.0=B0C)=A0 sensor =3D thermistor
> temp2:=A0=A0=A0=A0=A0=A0=A0=A0 -2.0=B0C=A0 (low=A0 =3D +20.0=B0C, high =
=3D +55.0=B0C)=A0 sensor =3D thermistor
> temp3:=A0=A0=A0=A0=A0=A0=A0 +41.0=B0C=A0 (low=A0 =3D +127.0=B0C, high =3D=
 +60.0=B0C)=A0 sensor =3D thermal diode
> cpu0_vid:=A0=A0=A0 +3.500 V
> intrusion0:=A0 ALARM
>=20
>=20
> I'm now faced with the problem of determining +5V scaling, which is not e=
ven present in the BIOS monitoring section. Even if it were present, how co=
uld I determine which unscaled sensor input to match it up if in3, in5, in6=
, and in7 are all 4.080V?

You can't. All evidence indicates that +5V is not monitored on this
motherboard.

> Regarding temperatures, temp1 and temp2 don't look right. How can this in=
valid reading be rectified if=A0 possible?

The BIOS shows a single temperature, so I'm afraid temp3 is the CPU
temperature and temp1 and temp2 aren't connected.

--=20
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
