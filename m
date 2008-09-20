From: Craig Prescott <prescott@hpc.ufl.edu>
Date: Sat, 20 Sep 2008 00:51:58 +0000
Subject: [lm-sensors] SuperMicro X7DCU/Winbond 83627HF
Message-Id: <48D4492E.2050605@hpc.ufl.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi;

I've run CentOS 5.1's sensors-detect on a SuperMicro X7DCU
motherboard equipped with a Winbond 83627HF Super-IO chip.
At least that's what the docs say.  But my sensors output
on this machine looks screwy (see appended).  In particular,
the temperatures are all -48 degC for w83627hf-i2c-0-2d, and
either -1 or 0 degC for w83627hf-isa-0290.

I am most interested in the cpu and ambient temperatures on this=20
machine.  I hope someone can help steer me in the right direction
to achieve this.  Does anyone have a sensors.conf snippet for
SuperMicro X7DCU?

sensors-detect produced an /etc/sysconfig/lm_sensors that
contained:

MODULE_0=3Di2c-i801
MODULE_1=3Di2c-isa
MODULE_2=3Dw83781d
MODULE_3=3Dsmbus-arp
MODULE_4=3Dw83627hf

I see that all the modules are loaded.  The dmesg output
produced by loading the modules looks like so:

i2c /dev entries driver
w83627hf 9191-0290: Enabling temp2, readings might not make sense
w83627hf 9191-0290: Enabling temp3, readings might not make sense

The machine is running kernel 2.6.18-53.1.14.el5.  The lm_sensors
I am running at this point is the one that came with CentOS:

[root@torx ~]# rpm -q lm_sensors
lm_sensors-2.10.0-3.1.x86_64

Any suggestions appreciated.

Thanks,
Craig Prescott


[root@torx ~]# sensors
w83627hf-i2c-0-2d
Adapter: SMBus I801 adapter at 1100

VCore 1:   +4.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)       ALARM
VCore 2:   +4.08 V  (min =3D  +0.00 V, max =3D  +0.00 V)       ALARM
+3.3V:     +4.08 V  (min =3D  +3.14 V, max =3D  +3.46 V)       ALARM
+5V:       +5.19 V  (min =3D  +4.73 V, max =3D  +5.24 V)
+12V:     +11.80 V  (min =3D +10.82 V, max =3D +13.19 V)
-12V:      +1.13 V  (min =3D -13.18 V, max =3D -10.88 V)       ALARM
-5V:       +2.14 V  (min =3D  -5.25 V, max =3D  -4.75 V)       ALARM
V5SB:      +5.51 V  (min =3D  +4.73 V, max =3D  +5.24 V)       ALARM
VBat:      +0.08 V  (min =3D  +2.40 V, max =3D  +3.60 V)       ALARM
fan1:        0 RPM  (min =3D 2667 RPM, div =3D 2)              ALARM
fan2:        0 RPM  (min =3D    0 RPM, div =3D 2)
fan3:        0 RPM  (min =3D    0 RPM, div =3D 2)
temp1:       -48=B0C  (high =3D    -1=B0C, hyst =3D    -1=B0C)   sensor =3D=
=20
thermistor
temp2:     -48.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
=20
thermistor
temp3:     -48.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
=20
thermistor
vid:      +0.000 V  (VRM Version 8.2)
alarms:
beep_enable:
           Sound alarm enabled

w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM  (beep)
VCore 2:   +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM  (beep)
+3.3V:     +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM  (beep)
+5V:       +6.85 V  (min =3D  +6.85 V, max =3D  +6.85 V)       ALARM  (beep)
+12V:     +15.50 V  (min =3D +15.50 V, max =3D +15.50 V)       ALARM  (beep)
-12V:      +6.06 V  (min =3D  +6.06 V, max =3D  +6.06 V)       ALARM  (beep)
-5V:       +5.10 V  (min =3D  +5.10 V, max =3D  +5.10 V)       ALARM  (beep)
V5SB:      +6.85 V  (min =3D  +6.85 V, max =3D  +6.85 V)       ALARM  (beep)
VBat:      +4.08 V  (min =3D  +4.08 V, max =3D  +4.08 V)       ALARM  (beep)
fan1:        0 RPM  (min =3D    0 RPM, div =3D 128)              ALARM  (be=
ep)
fan2:        0 RPM  (min =3D    0 RPM, div =3D 128)              ALARM  (be=
ep)
fan3:        0 RPM  (min =3D    0 RPM, div =3D 128)              ALARM  (be=
ep)
temp1:        -1=B0C  (high =3D    -1=B0C, hyst =3D    -1=B0C)   sensor =3D=
 diode=20
ALARM   (beep)
temp2:      +0.0=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)   sensor =3D=
 diode=20
ALARM   (beep)
temp3:      +0.0=B0C  (high =3D    +0=B0C, hyst =3D    +0=B0C)   sensor =3D=
 diode=20
ALARM   (beep)
vid:      +0.000 V  (VRM Version 8.2)
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
           Sound alarm enabled



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
