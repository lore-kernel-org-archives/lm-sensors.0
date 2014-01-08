From: "Seth Bardash" <seth@integratedsolutions.org>
Date: Wed, 08 Jan 2014 23:35:12 +0000
Subject: [lm-sensors] ASUS KGPE-D16 and CentOS 6.5
Message-Id: <E4175F3D57744A468314267E51135306@W710>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

First time on this list so please be gentle.

I am trying to get the sensors on an ASUS KGPE-D16 motherboard
working under CentOS.
I have 2 workstations running this motherboard with 64 GB DRAM,
and an 8 port LSI 9750-8i RAID controller.

A) The sensors work fine under opensuse 13.1 x86_64

The output from the opensuse 13.1 x86_64 sensors command looks
like this:

D6328-2:~ # sensors

fam15h_power-pci-00c4

Adapter: PCI adapter

power1:      101.81 W  (crit =3D 115.12 W)


fam15h_power-pci-00d4
Adapter: PCI adapter=20
power1:      102.47 W  (crit =3D 115.12 W)

k10temp-pci-00c3
Adapter: PCI adapter
temp1:        +29.5=B0C  (high =3D +70.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)

k10temp-pci-00cb
Adapter: PCI adapter
temp1:        +29.5=B0C  (high =3D +70.0=B0C)

k10temp-pci-00d3
Adapter: PCI adapter
temp1:        +29.4=B0C  (high =3D +70.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +67.0=B0C)

k10temp-pci-00db
Adapter: PCI adapter
temp1:        +29.5=B0C  (high =3D +70.0=B0C)

radeon-pci-0500
Adapter: PCI adapter
temp1:        +67.5=B0C =20

w83667hg-isa-0290
Adapter: ISA adapter
Vcore:         +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
in1:           +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
AVCC:          +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
+3.3V:         +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
in4:           +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
in5:           +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
in6:           +2.04 V  (min =3D  +2.04 V, max =3D  +2.04 V)  ALARM
3VSB:          +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
Vbat:          +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)  ALARM
fan1:            0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM    =20
fan2:            0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM    =20
fan3:            0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM    =20
fan4:            0 RPM  (min =3D    0 RPM, div =3D 128)  ALARM    =20
PECI Agent 4:   -1.0=B0C  (high =3D  -1.0=B0C, hyst =3D  -1.0=B0C)  ALARM
sensor =3D Intel PECI
PECI Agent 4:   +0.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM
sensor =3D Intel PECI
PECI Agent 4:   +0.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM
sensor =3D Intel PECI
cpu0_vid:     +0.000 V

intrusion0:   ALARM


w83795g-i2c-1-2f
Adapter: SMBus PIIX4 adapter at 0b00
in0:          +1.23 V  (min =3D  +0.65 V, max =3D  +1.51 V)
in1:          +1.25 V  (min =3D  +0.65 V, max =3D  +1.51 V)
in2:          +1.52 V  (min =3D  +1.20 V, max =3D  +1.70 V)
in3:          +1.52 V  (min =3D  +1.20 V, max =3D  +1.70 V)
in4:          +1.20 V  (min =3D  +0.70 V, max =3D  +1.40 V)
in5:          +1.17 V  (min =3D  +0.70 V, max =3D  +1.40 V)
in6:          +1.21 V  (min =3D  +0.89 V, max =3D  +1.39 V)
in7:          +1.82 V  (min =3D  +1.50 V, max =3D  +0.05 V)  ALARM
in8:          +1.21 V  (min =3D  +0.70 V, max =3D  +1.40 V)      =20
in9:          +1.11 V  (min =3D  +0.70 V, max =3D  +1.40 V)      =20
in10:         +1.59 V  (min =3D  +0.40 V, max =3D  +1.40 V)  ALARM
in11:         +0.74 V  (min =3D  +0.00 V, max =3D  +2.05 V)
+3.3V:        +3.23 V  (min =3D  +2.96 V, max =3D  +3.63 V)
3VSB:         +3.27 V  (min =3D  +2.96 V, max =3D  +3.63 V)
Vbat:         +3.12 V  (min =3D  +2.70 V, max =3D  +3.63 V)
in15:         +0.99 V  (min =3D  +0.56 V, max =3D  +0.91 V)  ALARM
in16:         +1.57 V  (min =3D  +0.40 V, max =3D  +1.40 V)  ALARM
fan1:        2616 RPM  (min =3D  400 RPM)
fan2:        2253 RPM  (min =3D  400 RPM)
fan3:        1923 RPM  (min =3D  400 RPM)
fan4:        3075 RPM  (min =3D  400 RPM)
fan5:        1912 RPM  (min =3D  400 RPM)
fan6:           0 RPM  (min =3D  400 RPM)  ALARM
fan7:           0 RPM  (min =3D  400 RPM)  ALARM
fan8:        1301 RPM  (min =3D  400 RPM)
temp1:        +49.5=B0C  (high =3D +60.0=B0C, hyst =3D +57.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +62.0=B0C)  sensor =3D
thermal diode
temp2:        -62.5=B0C  (high =3D +60.0=B0C, hyst =3D +57.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +62.0=B0C)  sensor =3D
thermistor
temp3:        -62.5=B0C  (high =3D +60.0=B0C, hyst =3D +57.0=B0C)
                       (crit =3D +65.0=B0C, hyst =3D +62.0=B0C)  sensor =3D
thermistor
temp7:        +29.5=B0C  (high =3D +70.0=B0C, hyst =3D +70.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +70.0=B0C)  sensor =3D
AMD AMDSI
temp8:        +29.2=B0C  (high =3D +70.0=B0C, hyst =3D +70.0=B0C)
                       (crit =3D +70.0=B0C, hyst =3D +70.0=B0C)  sensor =3D
AMD AMDSI
intrusion0:  ALARM
beep_enable: disabled

The temp1 is the SR5690 chip, temp7 and temp 8 are the processors.
The set up was done using sensors-detect and it detect what is
shown.

The CentOS based machine uses a much older kernel and libsensors
code.

(opensuse) 3.7.10-1.16-desktop versus (CentOS)
2.6.32-431.el6.x86_64

I downloaded the w83795 code and compiled it.
The loaded it with:

rmmod w83795
modprobe hwmon
modprobe hwmon-vid
modprobe i2c-core
insmod ./w83795.ko=20

But get an error of no hwmon found.
I even ran modprobe i2c-piix4 first then ran the commands above
but
there is no entry in dmesg and sensors -s then sensors does not
show anything.

I added the following to /etc/sensors3.conf:

chip "w83795-*" "w83795g-*" "w83795ag-*"
#chip "w83795g-*"

    label in0  "VCORE1   "
    label in1  "VCORE2   "
    label in2  "P1DDR3   "
    label in3  "P2DDR3   "
    label in4  "P1_+1.2V "
    label in5  "P2_+1.2V "
    label in6  "P1_VDDNB "
    label in7  "+1.8V    "
    label in8  "+1.2V    "
    label in9  "+1.1V    "
    label in10 "+5VSB    "
    label in12 "+3.3V    "
    label in13 "+3.3VSB  "
    label in14 "VBAT     "
    label in15 "+12V     "
    label in16 "+5V      "   =20
   =20
    label temp2 "TR1 Tempearture "
    label temp3 "TR2 Temperature "
    label temp7 "CPU1 Temperature"
    label temp8 "CPU2 Temperature"

    label fan1 "CPU_FAN1 "
    label fan2 "CPU_FAN2 "
    label fan3 "FRNT_FAN1"
    label fan4 "FRNT_FAN2"
    label fan5 "FRNT_FAN3"
    label fan6 "FRNT_FAN4"
    label fan7 "FRNT_FAN5"
    label fan8 "REAR_FAN1"
   =20
    compute in10 (3.2)*@ , @/(3.2)
    compute in15 (12)*@ , @/(12)
    compute in16 (3.2)*@ , @/(3.2)
   =20
# fan adjustments examples
    set in0_min 0.72
    set in0_max 1.43
    set in1_min 0.72
    set in1_max 1.43
    set in2_min 1.125
    set in2_max 1.625
    set in3_min 1.125
    set in3_max 1.625
    set in4_min 1.14
    set in4_max 1.26
    set in5_min 1.14
    set in5_max 1.26
    set in6_min 0.92
    set in6_max 1.21
    set in7_min 1.62
    set in7_max 1.98
    set in8_min 1.08
    set in8_max 1.32
    set in9_min 0.99
    set in9_max 1.21
    set in10_min 4.5
    set in10_max 5.5
    set in12_min 2.97
    set in12_max 3.63
    set in13_min 2.97
    set in13_max 3.63
    set in14_min 1.9
    set in14_max 3.6
    set in15_min 10.8
    set in15_max 13.2
    set in16_min 4.5
    set in16_max 5.5
   =20
    set fan1_min 700
    set fan2_min 700
    set fan3_min 700
    set fan4_min 700
    set fan5_min 700
    set fan6_min 700
    set fan7_min 700
    set fan8_min 700

# temp limits examples

# DO NOT add temp5_crit, temp5_crit_hyst, temp6_crit and
temp6_crit_hyst
# Because these features are configuration of smart fan.
#    set temp2_max       60
#    set temp2_max_hyst  55
#    set temp3_max       60
#    set temp3_max_hyst  55

# temp7_max and temp7_max_hyst are also features of temp8   =20
    set temp7_max       70
    set temp7_max_hyst  65

# ignore examples
#    ignore in11
    ignore beep_enable

Per an example from the lmsensors web site.

Not sure how to troubleshoot this next.

Any help in getting this running would be appreciated.

Seth Bardash

Integrated Solutions and Systems
1510 Old North Gate Road
Colorado Springs, CO 80921

719-495-5866 Shop
719-495-5870 Fax
719-337-4779 Cell

http://www.integratedsolutions.org

Failure can not cope with knowledge and perseverance!=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
