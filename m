From: SZENTE Balint <balint@szentedwg.ro>
Date: Wed, 29 May 2013 12:04:40 +0000
Subject: [lm-sensors] Configuration file for Intel D2500CC mini-ITX board
Message-Id: <20130529150440.4e021553@obraro.integrasoft.ro>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/_NeDo8E+.JCEP2=W9xZQhN4"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--MP_/_NeDo8E+.JCEP2=W9xZQhN4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello!


Attached you will find the configuration file for the Intel D2500CC
mini-ITX Desktop Board.

Output:

w83627uhg-isa-0290
Adapter: ISA adapter
Vcore:        +1.19 V  (min =3D  +0.40 V, max =3D  +1.60 V)
+3.3V:        +3.30 V  (min =3D  +3.00 V, max =3D  +3.61 V)
AVCC:         +5.03 V  (min =3D  +4.49 V, max =3D  +5.49 V)
+5V:          +5.03 V  (min =3D  +4.49 V, max =3D  +5.51 V)
+12V:        +12.19 V  (min =3D +10.18 V, max =3D +13.82 V)
Vdimm:        +1.50 V  (min =3D  +1.00 V, max =3D  +2.00 V)
5VSB:         +5.03 V  (min =3D  +4.49 V, max =3D  +5.49 V)
Vbat:         +3.33 V  (min =3D  +2.69 V, max =3D  +3.64 V)
System Fan:  1562 RPM  (min =3D  251 RPM, div =3D 32)
DIMM temp:    +54.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C) =
 sensor =3D thermal diode
VR temp:      +42.0=C2=B0C  (high =3D +80.0=C2=B0C, hyst =3D +75.0=C2=B0C) =
 sensor =3D thermal diode

Please add it to the Wiki.

Regards,
Balint Szente

--MP_/_NeDo8E+.JCEP2=W9xZQhN4
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=d2500cc.conf

# Intel D2500CC based on BIOS values
#

chip "w83627uhg-*"

    ignore  intrusion0

# Voltages

    # Processor Vcc
    label   in0            "Vcore"
    set     in0_min        0.40
    set     in0_max        1.60

    # +3.3V
    label   in1            "+3.3V"
    compute in1            3.2*@, @/3.2
    set     in1_min        3.00
    set     in1_max        3.60

    # +5.0V
    label   in3            "+5V"
    set     in3_min        4.60
    set     in3_max        5.40

    # +12.0V
    label   in4            "+12V"
    compute in4            12*@, @/12
    set     in4_min        10.20
    set     in4_max        13.80

    # Memory Vcc
    label   in5            "Vdimm"
    set     in5_min        1.00
    set     in5_max        2.00

    # +5.0V Standby
    label   in7            "5VSB"
    set     in7_min        4.60
    set     in7_max        5.40

# Fans

    label   fan1           "System Fan"
    set     fan1_min       250
    ignore  fan2

# Temperatures

    # Memory Temperature
    label   temp1          "DIMM temp"
    set     temp1_max      80
    set     temp1_max_hyst 75

    # VR Temperature
    label   temp2          "VR temp"
    set     temp2_max      80
    set     temp2_max_hyst 75

--MP_/_NeDo8E+.JCEP2=W9xZQhN4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/_NeDo8E+.JCEP2=W9xZQhN4--
