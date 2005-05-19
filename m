From: jijo@free.net.ph (Federico Sevilla III)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: Follow-up for Ticket # 936 (Solved!)
Message-Id: <20020718043655.GG29090@leathercollection.ph>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi there,

This is regarding ticket # 936.

No, I did not load i2c-isa with via686a, but doing that worked. Attached
as [1] is the output of `lspci -n` (yes, 0x3057 is there), and as [2] is
the new output of `sensors`.

Thank you very much for the help. :)

 --> Jijo

[1] lspci -n

00:00.0 Class 0600: 1106:0305 (rev 03)
00:01.0 Class 0604: 1106:8305
00:07.0 Class 0601: 1106:0686 (rev 40)
00:07.1 Class 0101: 1106:0571 (rev 06)
00:07.2 Class 0c03: 1106:3038 (rev 1a)
00:07.3 Class 0c03: 1106:3038 (rev 1a)
00:07.4 Class 0680: 1106:3057 (rev 40)
00:09.0 Class 0401: 1274:1371 (rev 02)
00:0d.0 Class 0200: 1282:9102 (rev 31)
00:0f.0 Class 0200: 8086:1229 (rev 08)
01:00.0 Class 0300: 10de:002d (rev 15)


[2] `sensors`

max1617-i2c-0-18
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Board:       +12=B0C  (min =3D   +4=B0C, max =3D   +0=B0C)
CPU:          +0=B0C  (min =3D  +12=B0C, max =3D  +60=B0C)ALARM (N/A)

eeprom-i2c-0-52
Adapter: SMBus Via Pro adapter at 5000
Algorithm: Non-I2C SMBus adapter
Memory type:            SDRAM DIMM SPD
SDRAM Size (MB):        256

via686a-isa-6000
Adapter: ISA adapter
Algorithm: ISA algorithm
CPU core:  +1.54 V  (min =3D  +1.79 V, max =3D  +2.18 V)   ALARM
+2.5V:     +0.29 V  (min =3D  +2.24 V, max =3D  +2.74 V)   ALARM
I/O:       +3.33 V  (min =3D  +2.95 V, max =3D  +3.62 V)  =20
+5V:       +4.87 V  (min =3D  +4.47 V, max =3D  +5.49 V)  =20
+12V:     +11.86 V  (min =3D +10.79 V, max =3D +13.18 V)  =20
CPU Fan:  4821 RPM  (min =3D 3000 RPM, div =3D 2)         =20
P/S Fan:     0 RPM  (min =3D 3000 RPM, div =3D 2)         =20
SYS Temp:  +32.6=B0C  (limit =3D  +60=B0C, hysteresis =3D  +50=B0C)=20
CPU Temp:  +47.4=B0C  (limit =3D  +60=B0C, hysteresis =3D  +50=B0C)=20
SBr Temp:  +22.3=B0C  (limit =3D  +60=B0C, hysteresis =3D  +50=B0C)=20

--=20
Federico Sevilla III   :  <http://jijo.free.net.ph/>
Network Administrator  :  The Leather Collection, Inc.
GnuPG Key ID           :  0x93B746BE
