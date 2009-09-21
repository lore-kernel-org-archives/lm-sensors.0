From: Clive Messer <clive@vacuumtube.org.uk>
Date: Mon, 21 Sep 2009 11:56:24 +0000
Subject: [lm-sensors] Tyan S7025 (w83793g) how many sensors?
Message-Id: <200909211256.24038.clive@vacuumtube.org.uk>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_on2tKmb1BWyNOd4"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_on2tKmb1BWyNOd4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit


Hi,

I'm trying to figure this out, but it's beyond me. I have a Tyan S7025 
motherboard which has a w83793g. I've had a quick scan of the w83793 code and 
the datasheet and it seems that the chipset only supports 6 temp sensors and 
10 voltage sensors. So, I'm lost trying to figure out how Tyan have managed to 
squeeze 7 temp sensors and 13 voltage sensors out of it. I've attached my 
current sensors config, sensors readings and the bios screen readings. Do I 
have a later revision of the w83793? Or from where is the bios obtaining the 
extra sensors readings?

Regards

Clive
-- 
Clive Messer <clive@vacuumtube.org.uk>

--Boundary-00=_on2tKmb1BWyNOd4
Content-Type: text/plain;
  charset="UTF-8";
  name="S7025_bios_sensors.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="S7025_bios_sensors.txt"

01 CPU0 below Tmax  57C     OK
02 CPU1 below Tmax  59C     OK
05 RT3              74C     Alert
06 RT4              57C     OK
07 RT5              49C     OK
0A CPU0 VCORE       0.976V  OK
0B CPU1 VCORE       0.968V  OK
16 CPU0 VTT         1.152V  OK
15 CPU1 VTT         1.144V  OK
12 5V               4.872V  OK
11 5VSB             4.848V  OK
0F 12V             11.904V  OK
0E 3V               3.360V  OK
10 VBAT             3.136V  OK
0D IOH 1.1V         1.072V  OK
0C ICH 1.5V         1.504V  OK
14 CPU0 DDR3 1.5V   1.528V  OK
13 CPU1 DDR3 1.5V   1.528V  OK
20 CPU0 FAN           0RPM  OK
21 CPU1 FAN           0RPM  OK
26 REAR FAN1          0RPM  OK
23 REAR FAN2          0RPM  OK
22 FRONT FAN1      1440RPM  OK
24 FRONT FAN2         0RPM  OK
25 FRONT FAN3         0RPM  OK
50 POWER1             0W    Alert

--Boundary-00=_on2tKmb1BWyNOd4
Content-Type: text/plain;
  charset="EUC-KR";
  name="S7025_sensors.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="S7025_sensors.txt"

w83793-i2c-0-2f
Adapter: SMBus I801 adapter at 0400
VCoreA:      +0.91 V  (min =3D  +0.75 V, max =3D  +1.30 V)  =20
VCoreB:      +0.92 V  (min =3D  +0.75 V, max =3D  +1.30 V)  =20
in2:         +1.08 V  (min =3D  +0.00 V, max =3D  +2.05 V)  =20
in3:         +1.50 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
in4:         +1.07 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
+3.3V:       +3.36 V  (min =3D  +3.14 V, max =3D  +3.47 V)  =20
+12V:       +11.90 V  (min =3D +10.85 V, max =3D +13.25 V)  =20
+5V:         +5.02 V  (min =3D  +4.52 V, max =3D  +5.50 V)  =20
5VSB:        +5.00 V  (min =3D  +4.52 V, max =3D  +5.50 V)  =20
VBAT:        +3.14 V  (min =3D  +2.70 V, max =3D  +3.30 V)  =20
fan1:          0 RPM  (min =3D    0 RPM)
fan2:          0 RPM  (min =3D    0 RPM)
fan3:          0 RPM  (min =3D    0 RPM)
fan4:          0 RPM  (min =3D    0 RPM)
fan5:          0 RPM  (min =3D    0 RPM)
PS Fan:     1486 RPM  (min =3D    0 RPM)
fan7:          0 RPM  (min =3D    0 RPM)
fan8:          0 RPM  (min =3D    0 RPM)
fan9:          0 RPM  (min =3D    0 RPM)
fan10:         0 RPM  (min =3D    0 RPM)
fan11:         0 RPM  (min =3D    0 RPM)
fan12:         0 RPM  (min =3D    0 RPM)
CPU1 Temp:   +37.5=C2=B0C  (high =3D +100.0=C2=B0C, hyst =3D +95.0=C2=B0C) =
 sensor =3D Intel PECI
CPU2 Temp:   +37.8=C2=B0C  (high =3D +100.0=C2=B0C, hyst =3D +95.0=C2=B0C) =
 sensor =3D Intel PECI
temp5:       +77.0=C2=B0C  (high =3D +100.0=C2=B0C, hyst =3D +95.0=C2=B0C) =
 sensor =3D thermistor
temp6:       +57.0=C2=B0C  (high =3D +100.0=C2=B0C, hyst =3D +95.0=C2=B0C) =
 sensor =3D thermistor
beep_enable:disabled

--Boundary-00=_on2tKmb1BWyNOd4
Content-Type: text/plain;
  charset="UTF-8";
  name="w83793.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="w83793.conf"

##
## Tyan S7025
##
chip "w83793-*"

    label in0 "VCoreA"
    label in1 "VCoreB"
    label temp1 "CPU1 Temp"
    label temp2 "CPU2 Temp"

    label in5 "+3.3V"
    label in6 "+12V"
    label in7 "+5V"
    label in7 "+5VSB"
    label in9 "VBAT"

    label fan6 "PS Fan"

    compute in6 @*12,@/12

    set in0_min	0.75
    set in0_max	1.3
    set in1_min	0.75
    set in1_max	1.3
    set in5_min	3.3 * 0.95
    set in5_max	3.3 * 1.05
    set in6_min	12.0 * 0.9
    set in6_max	12.0 * 1.1
    set in7_min	5.0 * 0.95
    set in7_max	5.0 * 1.05
    set in8_min	5.0 * 0.95
    set in8_max	5.0 * 1.05

--Boundary-00=_on2tKmb1BWyNOd4
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_on2tKmb1BWyNOd4--
