From: Stefan Sassenberg <stefan.sassenberg@gmx.de>
Date: Wed, 05 Mar 2008 10:31:30 +0000
Subject: Re: [lm-sensors] No sensors found >2.6.21, w83627hf, ICH6
Message-Id: <47CE7682.9090106@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <47CD5B89.1070302@gmx.de>
In-Reply-To: <47CD5B89.1070302@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Stefan,
>=20
> On Tue, 04 Mar 2008 15:24:09 +0100, Stefan Sassenberg wrote:
>> I have a problem making lm-sensors work on my system. It's a slightly=20
>> old debian where I updated some packages and now use sensors and=20
>> libsensors of version 2.9.1. I used to run a 2.6.21 kernel where sensors=
=20
>> finds some chip and also shows fan speed and temperature values.
>=20
> "some chip" doesn't tell us much... Can you please provide the complete
> output of "sensors"?
w83627thf-isa-0290
Adapter: ISA adapter
VCore:     +1.24 V  (min =3D  +0.70 V, max =3D  +1.87 V)
+12V:     +11.98 V  (min =3D  +6.51 V, max =3D  +9.18 V)       ALARM
+3.3V:     +3.38 V  (min =3D  +0.26 V, max =3D  +0.19 V)       ALARM
+5V:       +5.04 V  (min =3D  +2.72 V, max =3D  +3.28 V)       ALARM
-12V:     -12.20 V  (min =3D  +3.27 V, max =3D -14.75 V)       ALARM
V5SB:      +5.05 V  (min =3D  +4.27 V, max =3D  +1.61 V)       ALARM
VBat:      +3.22 V  (min =3D  +3.04 V, max =3D  +3.92 V)
fan1:        0 RPM  (min =3D 1035 RPM, div =3D 8)              ALARM
CPU Fan:     0 RPM  (min =3D 1171 RPM, div =3D 8)              ALARM
fan3:        0 RPM  (min =3D 3183 RPM, div =3D 8)              ALARM
M/B Temp:    -48=B0C  (high =3D   +29=B0C, hyst =3D   +14=B0C)   sensor =3D=
=20
thermistor
CPU Temp: +108.5=B0C  (high =3D  +120=B0C, hyst =3D  +115=B0C)   sensor =3D=
 diode=20

temp3:     -48.0=B0C  (high =3D  +120=B0C, hyst =3D  +115=B0C)   sensor =3D=
=20
thermistor
alarms:   Chassis intrusion detection                      ALARM
beep_enable:
           Sound alarm enabled

The values are nonsens, of course, but I wanted to do first things first.
>=20
>> Then I upgraded the kernel to a 2.6.23 and always get the error message =

>> "No sensors found". The board is an MSI board and it has an 82801 ICH6=20
>> chipset.
>=20
> What is the exact motherboard model?
"Hetis 915 A7137IMS V1.3 02/10/06"

>=20
>> sensors-detect advises me to modprobe w83627hf, which I do, but the=20
>> result is the above.
>=20
> Any message in the kernel logs when you modprobe w83627hf? Does the
> modprobe itself fail or succeed? If it fails, what's the error message?
When I modprobe, a line is added to /var/log/dmesg:
w83627hf: Found W83627THF chip at 0x290
There's no message on stdout or stderr.
>=20
>> I installed a gentoo on the same machine, where it worked, and made an=20
>> lsmod, which showed w83627hf, hwmod and hwmon_vid. I took the kernel=20
>> config file and applied it to the kernel from kernel.org to build the=20
>> same kernel for my debian. I modprobed the very same modules but failed.=
=20
>=20
> What kernel is your gentoo system running?
2.6.23-r9 (the latest "not-masked" 2.6.23)
>=20
>> What can I do to find the solution?
>=20
> Please compare /proc/ioports between a system where the w83627hf driver
> works for you and a system where it doesn't. I'd suspect a resource
> conflict.
Using the 2.6.21.5 kernel:
0295-0296 : pnp 00:09
   0295-0296 : w83627hf

Using the 2.6.23.14 kernel:
Before modprobing:
...
0295-0296 : pnp 00:09
...

After modprobing:
...
0295-0296 : w83627hf
   0295-0296 : pnp 00:09
     0295-0296 : w83627hf
...


Stefan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
