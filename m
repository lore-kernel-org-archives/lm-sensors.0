From: SZENTE Balint <balint@szentedwg.ro>
Date: Wed, 24 Apr 2013 06:29:37 +0000
Subject: [lm-sensors] Configuration file for Intel DN2800MT mini-ITX board
Message-Id: <20130424092937.3fb1e7a4@obraro.integrasoft.ro>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/aY=ePk_kead9bFJzDWpfb=P"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--MP_/aY=ePk_kead9bFJzDWpfb=P
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello!


Attached you will find the configuration file for the Intel DN2800MT
mini-ITX Desktop Board. I disabled all the fans by default, because it
is a fanless system.

Output:

w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:        +0.85 V  (min =3D  +0.40 V, max =3D  +1.60 V)
+12V:        +12.10 V  (min =3D +10.18 V, max =3D +13.82 V)
AVCC:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:        +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+5V:          +5.04 V  (min =3D  +4.60 V, max =3D  +5.40 V)
Vdimm:        +1.50 V  (min =3D  +1.00 V, max =3D  +2.00 V)
PCH:          +1.07 V  (min =3D  +0.40 V, max =3D  +1.60 V)
3VSB:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:         +3.25 V  (min =3D  +2.70 V, max =3D  +3.63 V)
DIMM temp:    +55.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C) =
 sensor =3D CPU diode
VR temp:      +46.5=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C) =
 sensor =3D CPU diode

Please add it to the Wiki.

Regards,
Balint Szente

--MP_/aY=ePk_kead9bFJzDWpfb=P
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
    set     in0_min        0.40
    set     in0_max        1.60

    # +12.0V
    label   in1            "+12V"
    compute in1            12*@, @/12
    set     in1_min        10.20
    set     in1_max        13.80

    # +3.3V
    label   in3            "+3.3V"
    set     in3_min        3.00
    set     in3_max        3.60

    # +5.0V
    label   in4            "+5V"
    compute in4            5*@, @/5
    set     in4_min        4.60
    set     in4_max        5.40

    # Memory Vcc
    label   in5            "Vdimm"
    set     in5_min        1.00
    set     in5_max        2.00

    # PCH Vcc
    label   in6            "PCH"
    set     in6_min        0.40
    set     in6_max        1.60

    # +3.3V Standby
    label   in7            "3VSB"
    set     in7_min        3.00
    set     in7_max        3.60

# Fans (fanless system)

    ignore  fan1
    ignore  fan2
    ignore  fan3
    ignore  fan4
    ignore  fan5

# Temperatures

    # Memory Temperature
    label   temp1          "DIMM temp"
    set     temp1_max      80
    set     temp1_max_hyst 75

    # Always on 110.5
    ignore temp2

    # VR Temperature
    label   temp3          "VR temp"
    set     temp3_max      80
    set     temp3_max_hyst 75

--MP_/aY=ePk_kead9bFJzDWpfb=P
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/aY=ePk_kead9bFJzDWpfb=P--
