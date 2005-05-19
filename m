From: robs@multiplayer.it (Roberto Sebastiano)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: kernel 2.6.0test10 and sensors 2.8.1 CVS wrong temperature
Message-Id: <1069871084.1646.9.camel@newdeal>
List-Id: <lm-sensors.vger.kernel.org>
References: <1069852347.3fc4a6bb69deb@webmail.multiplayer.it>
In-Reply-To: <1069852347.3fc4a6bb69deb@webmail.multiplayer.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Il mer, 2003-11-26 alle 17:13, Mark Studebaker ha scritto:
> the temps are 10x too low.
> fixed in CVS late yesterday.

newdeal:/usr/src/sensors/lm_sensors2# sensors
eeprom-i2c-0-51
Adapter: SMBus nForce2 adapter at 5000
Algorithm: Unavailable from sysfs
ERROR: data 1

as99127f-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5500
Algorithm: Unavailable from sysfs
VCore 1:   +1.71 V  (min =3D  +1.49 V, max =3D  +1.81 V)             =20
VCore 2:   +1.71 V  (min =3D  +1.49 V, max =3D  +1.81 V)             =20
+3.3V:     +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)             =20
+5V:       +4.95 V  (min =3D  +4.52 V, max =3D  +5.48 V)             =20
+12V:     +11.61 V  (min =3D +10.82 V, max =3D +13.13 V)             =20
-12V:     -12.14 V  (min =3D  -0.00 V, max =3D  -0.00 V)             =20
-5V:       -4.60 V  (min =3D  -0.00 V, max =3D  -0.00 V)             =20
fan1:     4753 RPM  (min =3D 3000 RPM, div =3D 2)                    =20
fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)                    =20
fan3:        0 RPM  (min =3D 3000 RPM, div =3D 2)                    =20
M/B Temp:    +46?C  (high =3D  +127?C, hyst =3D   +60?C)         =20
CPU Temp:  +33.4?C  (high =3D  +120?C, hyst =3D  +100?C)         =20
temp3:    +255.4?C  (high =3D  +100?C, hyst =3D  +100?C)         =20
vid:      +1.650 V
alarms:  =20
beep_enable:
          Sound alarm enabled

Segmentation fault

M/B and CPU Temp are swapped
temp3 should be disabled
also, high and hyst value doesn't make sense I think

The backtrace:
Program received signal SIGSEGV, Segmentation fault.
0x400bba6b in free () from /lib/tls/libc.so.6
(gdb) bt
#0  0x400bba6b in free () from /lib/tls/libc.so.6
#1  0x4017f8c0 in __after_morecore_hook () from /lib/tls/libc.so.6
#2  0x080683c0 in ?? ()
#3  0x40047a98 in __JCR_LIST__ () from /usr/local/lib/libsensors.so.3
#4  0x40047c64 in completed.1 () from /usr/local/lib/libsensors.so.3
#5  0xbffff8c0 in ?? ()
#6  0x4002f67a in free_bus () from /usr/local/lib/libsensors.so.3
#7  0x4002f584 in sensors_cleanup () from /usr/local/lib/libsensors.so.3
#8  0x080492a8 in main ()



--=20
Roberto Sebastiano <robs@multiplayer.it>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Questa parte del messaggio =3D?ISO-8859-1?Q?=E8?=3D firmata
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031126=
/e30452fa/attachment.bin
