From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Sep 2011 15:51:21 +0000
Subject: Re: [lm-sensors] adjusting /etc/sensors.conf for a dual processor
Message-Id: <20110924175121.24ecac65@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
In-Reply-To: <1316867250.1306.YahooMailNeo@web36606.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

Please don't top-post.

On Sat, 24 Sep 2011 08:19:34 -0700 (PDT), Audio Phile wrote:
> Thank you for the suggestion, Guenter.=A0 Unfortunately, I think I lack t=
he imagination to turn this output into something useful.=A0 For example, c=
onsider below, the Cores are still numbers 0, 1, 9, 10 for the=20
> "coretemp-isa-0000" sensor and the same for the "coretemp-isa-0004" senso=
r.=A0 How can I renumber them so that:

Which 'output" are you talking about? Guenter gave you lines to put in
a configuration file.

> coretemp-isa-0000
> Core 0 --> Core 0
> Core1 --> Core 1
>=20
> Core 9 --> Core 2
>=20
> Core 10 --> Core 3
>=20
> coretemp-isa-0004
> Core 0 --> Core 4
>=20
> Core1 --> Core 5
>=20
> Core 9 --> Core 6
>=20
> Core 10 --> Core 7
>=20
> Does my question make sense?=A0 Thanks again!

The original core numbering is very odd to start with. Not the fact
that core numbers are reused, this is as expected. What's odd is the
jump from 1 to 9. I seem to remember a similar case being reported a
few weeks or months ago. Can you attach the contents of /proc/cpuinfo?

> $ sensors -u coretemp-isa-0000
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:
> =A0 temp2_input: 61.000
> =A0 temp2_max: 85.000
> =A0 temp2_crit: 95.000
> =A0 temp2_crit_alarm: 0.000
> Core 1:
> =A0 temp3_input: 61.000
> =A0 temp3_max: 85.000
> =A0 temp3_crit: 95.000
> =A0 temp3_crit_alarm: 0.000
> Core 9:
> =A0 temp11_input: 62.000
> =A0 temp11_max: 85.000
> =A0 temp11_crit: 95.000
> Core 10:
> =A0 temp12_input: 63.000
> =A0 temp12_max: 85.000
> =A0 temp12_crit: 95.000
>=20
> $ sensors -u coretemp-isa-0004
> coretemp-isa-0004
> Adapter: ISA adapter
> Core 0:
> =A0 temp2_input: 53.000
> =A0 temp2_max: 85.000
> =A0 temp2_crit: 95.000
> =A0 temp2_crit_alarm: 0.000
> Core 1:
> =A0 temp3_input: 54.000
> =A0 temp3_max: 85.000
> =A0 temp3_crit: 95.000
> =A0 temp3_crit_alarm: 0.000
> Core 9:
> =A0 temp11_input: 59.000
> =A0 temp11_max: 85.000
> =A0 temp11_crit: 95.000
> Core 10:
> =A0 temp12_input: 59.000
> =A0 temp12_max: 85.000
> =A0 temp12_crit: 95.000

As Guenter's advice was apparently not clear enough for you, I'll try
to be more expliti. Create file /etc/sensors.d/cores.conf and put the
following statements in it:

chip "coretemp-isa-0000"

    label temp2 "Core 0"
    label temp3 "Core 1"
    label temp11 "Core 2"
    label temp12 "Core 3"

chip "coretemp-isa-0004"

    label temp2 "Core 4"
    label temp3 "Core 5"
    label temp11 "Core 6"
    label temp12 "Core 7"

This should lead to the "sensors" output you expect (which makes little
sense to me but really that's up to you.)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
