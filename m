From: Audio Phile <da_audiophile@yahoo.com>
Date: Sat, 24 Sep 2011 15:19:34 +0000
Subject: Re: [lm-sensors] adjusting /etc/sensors.conf for a dual processor
Message-Id: <1316877574.64605.YahooMailNeo@web36606.mail.mud.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
In-Reply-To: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org



Thank you for the suggestion, Guenter.=A0 Unfortunately, I think I lack the=
 imagination to turn this output into something useful.=A0 For example, con=
sider below, the Cores are still numbers 0, 1, 9, 10 for the=20
"coretemp-isa-0000" sensor and the same for the "coretemp-isa-0004" sensor.=
=A0 How can I renumber them so that:

coretemp-isa-0000
Core 0 --> Core 0
Core1 --> Core 1

Core 9 --> Core 2

Core 10 --> Core 3

coretemp-isa-0004
Core 0 --> Core 4

Core1 --> Core 5

Core 9 --> Core 6

Core 10 --> Core 7

Does my question make sense?=A0 Thanks again!


$ sensors -u coretemp-isa-0000
coretemp-isa-0000
Adapter: ISA adapter
Core 0:
=A0 temp2_input: 61.000
=A0 temp2_max: 85.000
=A0 temp2_crit: 95.000
=A0 temp2_crit_alarm: 0.000
Core 1:
=A0 temp3_input: 61.000
=A0 temp3_max: 85.000
=A0 temp3_crit: 95.000
=A0 temp3_crit_alarm: 0.000
Core 9:
=A0 temp11_input: 62.000
=A0 temp11_max: 85.000
=A0 temp11_crit: 95.000
Core 10:
=A0 temp12_input: 63.000
=A0 temp12_max: 85.000
=A0 temp12_crit: 95.000

$ sensors -u coretemp-isa-0004
coretemp-isa-0004
Adapter: ISA adapter
Core 0:
=A0 temp2_input: 53.000
=A0 temp2_max: 85.000
=A0 temp2_crit: 95.000
=A0 temp2_crit_alarm: 0.000
Core 1:
=A0 temp3_input: 54.000
=A0 temp3_max: 85.000
=A0 temp3_crit: 95.000
=A0 temp3_crit_alarm: 0.000
Core 9:
=A0 temp11_input: 59.000
=A0 temp11_max: 85.000
=A0 temp11_crit: 95.000
Core 10:
=A0 temp12_input: 59.000
=A0 temp12_max: 85.000
=A0 temp12_crit: 95.000



________________________________
From: Guenter Roeck <guenter.roeck@ericsson.com>
To: Audio Phile <da_audiophile@yahoo.com>
Cc: "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>
Sent: Saturday, September 24, 2011 10:51 AM
Subject: Re: [lm-sensors] adjusting /etc/sensors.conf for a dual processor =
machine

On Sat, Sep 24, 2011 at 08:27:30AM -0400, Audio Phile wrote:
> I'd like to get my cores from the sensors output to be consistently numbe=
red
> (i.e. core0-core7) for a dual xeon motherboard (HP Z600 workstation). Her=
e is
> what the output looks like currently. Anyone have experience with this?
>=20
> $ sensors
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:=A0 =A0 =A0=A0=A0+65.0 C=A0 (high =3D +85.0 C, crit =3D +95.0 C)
> Core 1:=A0 =A0 =A0=A0=A0+65.0 C=A0 (high =3D +85.0 C, crit =3D +95.0 C)
> Core 9:=A0 =A0 =A0=A0=A0+66.0 C=A0 (high =3D +85.0 C, crit =3D +95.0 C)
> Core 10:=A0 =A0 =A0 +66.0 C=A0 (high =3D +85.0 C, crit =3D +95.0 C)
>=20
> coretemp-isa-0004
> Adapter: ISA adapter
> Core 0:=A0 =A0 =A0=A0=A0+54.0 C=A0 (high =3D +85.0 C, crit =3D +95.0 C)
> Core 1:=A0 =A0 =A0=A0=A0+56.0 C=A0 (high =3D +85.0 C, crit =3D +95.0 C)
> Core 9:=A0 =A0 =A0=A0=A0+60.0 C=A0 (high =3D +85.0 C, crit =3D +95.0 C)
> Core 10:=A0 =A0 =A0 +61.0 C=A0 (high =3D +85.0 C, crit =3D +95.0 C)
>=20
You can add information to /etc/sensors3.conf and pick any labels you like.
First use "sensors -u coretemp-isa-000" and "sensors -u coretemp-isa-004"
to get the attribute file names, then add something like the following to
/etc/sensors3.conf.

chip "coretemp-isa-000"

=A0=A0=A0 label temp2 mytemp
=A0=A0=A0 label temp3 yourtemp
=A0=A0=A0 label temp4 randomtemp

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
