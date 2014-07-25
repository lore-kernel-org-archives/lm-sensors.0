From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 25 Jul 2014 07:31:04 +0000
Subject: Re: [lm-sensors] Sensors configuration for Intel D201GLY2 motherboard
Message-Id: <20140725093104.0e0af2b8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
In-Reply-To: <CAKWkBZiTFXYvuq8jH8y2+HzxtY2GdJD17_c=3k9PZBLvoFcSNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Eric,

On Wed, 23 Jul 2014 11:08:14 +0200, =C9ric Le Bras wrote:
> Here is the configuration I made for the Intel D201GLY2 motherboard. I us=
ed
> BIOS values read from my system and on the Internet to find voltages labe=
ls
> and scaling factors.
>=20
> Only the configurations specific to the board and not found in
> sensors3.conf for w83627dhg have been kept.
>=20
> # libsensors configuration file
> # -----------------------------
> #
> # Configuration file for Intel D201GLY2 motherboard
> # Hardware monitor subsystem controlled by Winbond W83627DHG-B I/O
> controller.
> # Created using information from BIOS and board documentation.
>=20
> chip "w83627dhg-*"
>=20
>     label in1 "+12.0V"
>     label in6 "+1.5V"
>=20
> # in4 and in5 report values, oviously one of the two is for the +5V, howe=
ver
> # none of them is reported by the BIOS.

Odd :(

>     ignore in4
>     ignore in5
>=20
>     compute in1 @*(55/8),@/(55/8)
>=20
>     set in1_min 12.0 * 0.90
>     set in1_max 12.0 * 1.10

The ATX standard says +12V is +/- 5%.

>     set in6_min  1.5 * 0.90
>     set in6_max  1.5 * 1.10
>=20
>     label fan1 "Chassis fan"
>     label fan2 "CPU fan"
>=20
> # By default the D201GLY2 has a passive heatsink. If the optional active
> # heatsink is present, then one of the following lines is to be commented=
 out
> # (very likely fan2, though not tried).
>     ignore fan2
>     ignore fan3
>     ignore fan4
>=20
>     label temp1 "Sys temp"
>     label temp2 "unknown"
>     label temp3 "unknown"

If you don't know, just don't put labels, "unknown" doesn't add much
value. One of these is most certainly the CPU temperature, I'm
surprised it's not obvious. What does the output of "sensors
-c /dev/null" say?

>=20
>     ignore intrusion0
>=20
>=20

Thanks for your contribution, I've added it as:

http://www.lm-sensors.org/wiki/Configurations/Intel/D201GLY2

--=20
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
