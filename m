From: SZENTE Balint <balint@szentedwg.ro>
Date: Thu, 30 May 2013 13:15:24 +0000
Subject: Re: [lm-sensors] Configuration file for Intel DN2800MT mini-ITX board
Message-Id: <20130530161524.0c7a7ded@obraro.integrasoft.ro>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/sgNHMaICZBPnglFFzbD6TK5"
List-Id: <lm-sensors.vger.kernel.org>
References: <20130424092937.3fb1e7a4@obraro.integrasoft.ro>
In-Reply-To: <20130424092937.3fb1e7a4@obraro.integrasoft.ro>
To: lm-sensors@vger.kernel.org

--MP_/sgNHMaICZBPnglFFzbD6TK5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Jean!


Please find attached the configuration file, that has corrected voltage
limits. The motherboard has a soldered Intel Atom N2800.

I checked the followings:
 1. Intrusion is missing from the motherboard
 2. Vcore for N2800. It has Speedstep, so the Lowest Frequency Mode
    voltage is 0.75V (see my previous mail with D2500)

The motherboard has two Fan connectors: CPU & System. The system that I
have is completely fanless, so I could not identify the corresponding
fan inputs, so I let the 5 fan inputs as they are by default.

Please add this motherboard as well to the Wiki. Thank you.

Regards,
Balint

On Wed, 24 Apr 2013 09:29:37 +0300
SZENTE Balint <balint@szentedwg.ro> wrote:

> Hello!
>=20
>=20
> Attached you will find the configuration file for the Intel DN2800MT
> mini-ITX Desktop Board. I disabled all the fans by default, because it
> is a fanless system.
>=20
> Output:
>=20
> w83627dhg-isa-0290
> Adapter: ISA adapter
> Vcore:        +0.85 V  (min =3D  +0.40 V, max =3D  +1.60 V)
> +12V:        +12.10 V  (min =3D +10.18 V, max =3D +13.82 V)
> AVCC:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:        +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +5V:          +5.04 V  (min =3D  +4.60 V, max =3D  +5.40 V)
> Vdimm:        +1.50 V  (min =3D  +1.00 V, max =3D  +2.00 V)
> PCH:          +1.07 V  (min =3D  +0.40 V, max =3D  +1.60 V)
> 3VSB:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:         +3.25 V  (min =3D  +2.70 V, max =3D  +3.63 V)
> DIMM temp:    +55.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C=
)  sensor =3D CPU
> diode VR temp:      +46.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=
=C2=B0C)  sensor
> =3D CPU diode
>=20
> Please add it to the Wiki.
>=20
> Regards,
> Balint Szente


--MP_/sgNHMaICZBPnglFFzbD6TK5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=dn2800mt.conf

# Intel DN2800MT based on BIOS values
#

chip "w83627dhg-*"

    ignore  cpu0_vid
    ignore  intrusion0

# Voltages

    # Processor Vcc
    label   in0            "Vcore"
    set     in0_min        0.75
    set     in0_max        1.21

    # +12.0V
    label   in1            "+12V"
    compute in1            12*@, @/12
    set     in1_min        12 * 0.95
    set     in1_max        13 * 1.05

    # +3.3V
    label   in3            "+3.3V"
    set     in3_min        3.3 * 0.95
    set     in3_max        3.3 * 1.05

    # +5.0V
    label   in4            "+5V"
    compute in4            5*@, @/5
    set     in4_min        5.0 * 0.95
    set     in4_max        5.0 * 1.05

    # Memory Vcc
    label   in5            "Vdimm"
    set     in5_min        1.5 * 0.95
    set     in5_max        1.5 * 1.05

    # PCH Vcc
    label   in6            "PCH"
    set     in6_min        1.05 * 0.95
    set     in6_max        1.05 * 1.05

    # +3.3V Standby
    label   in7            "3VSB"
    set     in7_min        3.3 * 0.95
    set     in7_max        3.3 * 1.05

# Temperatures

    # Memory Temperature
    label   temp1          "DIMM temp"
    set     temp1_max      80
    set     temp1_max_hyst 75

    # Always on 110.5
    ignore  temp2

    # VR Temperature
    label   temp3          "VR temp"
    set     temp3_max      80
    set     temp3_max_hyst 75

--MP_/sgNHMaICZBPnglFFzbD6TK5
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/sgNHMaICZBPnglFFzbD6TK5--
