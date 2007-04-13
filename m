From: Jake Briggs <jake@coretech.co.nz>
Date: Fri, 13 Apr 2007 04:29:48 +0000
Subject: [lm-sensors] can't get tempurature readings!
Message-Id: <461F073C.3020400@coretech.co.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi All

I have lm_sensors-2.8.7-2.40.3 installed, with kernel 2.6.9-11.ELsmp,=20
installed on a CentOS 4.1 machine. sensors-detect seems to work fine,=20
the modules it suggests are loading, but when I run sensors, the=20
temperature readings are wrong!

The temperatures seem to be stuck at +127=B0C - and never waiver, very=20
odd. My machine cannot be running that high! Also, 127 is kinda half of=20
256, but that may be a coincidence. Still raises my suspicions that the=20
reading is faulty somehow....

Here is the output of sensors :

[root@seker ~]# sensors
w83627hf-isa-0290
Adapter: ISA adapter
VCore 1:   +0.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)
VCore 2:   +1.18 V  (min =3D  +0.00 V, max =3D  +0.00 V)
+3.3V:     +3.34 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:       +5.00 V  (min =3D  +4.76 V, max =3D  +5.24 V)
+12V:     +12.04 V  (min =3D +10.82 V, max =3D +13.19 V)
-12V:      +1.37 V  (min =3D -13.18 V, max =3D -10.80 V)
-5V:       +0.48 V  (min =3D  -5.25 V, max =3D  -4.75 V)
V5SB:      +5.59 V  (min =3D  +4.76 V, max =3D  +5.24 V)
VBat:      +1.02 V  (min =3D  +2.40 V, max =3D  +3.60 V)
fan1:        0 RPM  (min =3D 3443 RPM, div =3D 2)
fan2:        0 RPM  (min =3D 225000 RPM, div =3D 2)
fan3:        0 RPM  (min =3D 14062 RPM, div =3D 8)
temp1:      +127=B0C  (high =3D  -124=B0C, hyst =3D   +49=B0C)   sensor =3D=
 thermistor
temp2:    +127.5=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
=20
PII/Celeron diode   ALARM
temp3:    +127.0=B0C  (high =3D   +80=B0C, hyst =3D   +75=B0C)   sensor =3D=
=20
thermistor   ALARM
ERROR: Can't get VID data!
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
          Sound alarm disabled

eeprom-i2c-0-53
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-52
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-51
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

eeprom-i2c-0-50
Adapter: SMBus I801 adapter at 0400
Memory type:            DDR SDRAM DIMM
Memory size (MB):       512

[root@seker ~]#


--=20
Jacob Briggs
Systems Engineer

Core Technology Limited
Level 1, NZX Centre
11 Cable Street
Wellington
Phone +64 4 801 2252

--

object doAnythingConceivable(string whatToDo, object whatToDoItWith) { .....



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
