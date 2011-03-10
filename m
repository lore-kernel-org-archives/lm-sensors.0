From: "Ian Dobson" <i.dobson@planet-ian.com>
Date: Thu, 10 Mar 2011 20:27:42 +0000
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan
Message-Id: <F596B5A3B9F8423184953BBD42AB7667@portable2>
List-Id: <lm-sensors.vger.kernel.org>
References: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
In-Reply-To: <BE6F61DB46364D4B839ED3F50CDFDFAB@portable2>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello Robert,

--------------------------------------------------
From: "Robert Kaiser" <kairo@kairo.at>
Sent: Thursday, March 10, 2011 9:08 PM
To: <lm-sensors@lm-sensors.org>
Subject: Re: [lm-sensors] RFC: nct6776f support in the w83627ehf and fan=20
RPMsignal de-bounce

> Robert Kaiser schrieb:
>> nct6775-isa-0290
>
>> in1: +1.11 V (min =3D +0.00 V, max =3D +0.00 V) ALARM
>> in4: +1.02 V (min =3D +0.00 V, max =3D +0.00 V) ALARM
>> in5: +1.05 V (min =3D +0.00 V, max =3D +0.00 V) ALARM
>> in6: +1.08 V (min =3D +0.00 V, max =3D +0.00 V) ALARM
>
> So I guess we don't know what they are and therefore they have the defaul=
t=20
> names and probably "bogus" values, right?
>

Any chance you can have a look in the BIOS and email the exact values you=20
see there. The chip can only handle 0-2.048volts so the 5 and 12 volts go=20
through a voltage divider before going to the chip. This voltage divider=20
information needs to be added to the sensors3.conf. What motherboard do you=
=20
have? Maybe the manufacturer has some documentation.

This is the configuration I'm using for my n6776f/asus board
chip "nct6775-*" "nct6776-*"
# nct6776 values for Asus p8p67 pro
    label in0 "Vcore"
    set in0_min  1 * 0.9
    set in0_max  1.2 * 1.05

    label in1 "+12V"
    compute in1 @ * 12, @ / 12
    set in1_min  12 * 0.90
    set in1_max  12 * 1.15

    label in2 "AVCC"
    set in2_min  3.3 * 0.90
    set in2_max  3.3 * 1.10

    label in3 "+3.3V"
    set in3_min  3.3 * 0.90
    set in3_max  3.3 * 1.10

    label in4 "+5V"
    compute in4 @ * 5, @ / 5
    set in4_min  5 * 0.90
    set in4_max  5 * 1.10

    ignore in5

    label in7 "3VSB"
    set in7_min  3.3 * 0.90
    set in7_max  3.3 * 1.10

    label in8 "Vbat"
    set in8_min  3.0 * 0.90
    set in8_max  3.0 * 1.15

Maybe something similar would be correct for your board. If you add this to=
=20
your config file

>> fan2: 1110 RPM (min =3D 0 RPM, div =3D 32) ALARM
>
> This is the CPU fan here, FWIW.
>
>> SYSTIN: +39.0=B0C (high =3D +0.0=B0C, hyst =3D +0.0=B0C) ALARM sensor =
=3D diode
>> CPUTIN: +38.0=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C) sensor =3D di=
ode
>> SMBUSMASTER 1: +54.0=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C) sensor=
 =3D diode
>> PCH_CHIP_CPU_MAX_TEMP: +65.0=B0C
>> SMBUSMASTER 2: +0.0=B0C (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
>
> What do those actually mean? Is there some doc about them that an=20
> non-wizard like me can understand?
>
> Robert Kaiser
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

Regards
Ian Dobson
=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
