From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Date: Mon, 01 Mar 2010 13:47:17 +0000
Subject: Re: [lm-sensors] Activate WD chip on Tyan S7025?
Message-Id: <201003011447.19635.carsten.aulbert@aei.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <201003011345.55821.carsten.aulbert@aei.mpg.de>
In-Reply-To: <201003011345.55821.carsten.aulbert@aei.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi

On Monday 01 March 2010 14:19:35 Jean Delvare wrote:
> Yes there is, but in 99% of the cases, disabled sensors in Super-I/O
> chips are disabled because they are not used, so enabling them will no
> lead you anywhere. You can load the w83627ehf driver and it will enable
> the sensors for you, but chances are that the output of "sensors" will
> be full of zeroes or otherwise meaningless values.

Ah ok, I just should have tried it then:

# modprobe w83627ehf
# dmesg|tail
[...]
[22940.891889] w83627ehf: Forcibly enabling Super-I/O. Sensor is probably=20
unusable.=20
[22940.932286] w83627ehf: Found W83627DHG-P chip at 0xa10=20
# sensors -s
# sensors=20
coretemp-isa-0000=20
Adapter: ISA adapter
Core 0:      +39.0=B0C  (high =3D +90.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +33.0=B0C  (high =3D +90.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +39.0=B0C  (high =3D +90.0=B0C, crit =3D +100.0=B0C) =20

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +34.0=B0C  (high =3D +90.0=B0C, crit =3D +100.0=B0C) =20

w83627dhg-isa-0a10
Adapter: ISA adapter
Vcore:       +0.00 V  (min =3D  +0.00 V, max =3D  +1.74 V)  =20
in1:         +0.00 V  (min =3D  +1.68 V, max =3D  +1.22 V)   ALARM
AVCC:        +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)       =20
VCC:         +3.34 V  (min =3D  +2.98 V, max =3D  +3.63 V)       =20
in4:         +1.54 V  (min =3D  +2.02 V, max =3D  +1.22 V)   ALARM
in5:         +0.00 V  (min =3D  +1.54 V, max =3D  +1.54 V)   ALARM
in6:         +1.15 V  (min =3D  +1.58 V, max =3D  +0.29 V)   ALARM
3VSB:        +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:        +3.26 V  (min =3D  +2.70 V, max =3D  +3.30 V)
fan1:          0 RPM  (min =3D 5273 RPM, div =3D 4)  ALARM
fan2:          0 RPM  (min =3D 21093 RPM, div =3D 4)  ALARM
fan3:          0 RPM  (min =3D 3590 RPM, div =3D 4)  ALARM
fan4:          0 RPM  (min =3D 61363 RPM, div =3D 2)  ALARM
fan5:          0 RPM  (min =3D 56250 RPM, div =3D 2)  ALARM
temp1:       +28.0=B0C  (high =3D +62.0=B0C, hyst =3D +34.0=B0C)  sensor =
=3D thermistor
temp2:      +127.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM  se=
nsor =3D diode
temp3:       +31.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
cpu0_vid:   +2.050 V


Looks, ok-ish but not perfect ;)

We'll see what we can make from this.

Thanks a lot!

Carsten

PS:=20
ipmitool still lacks any reading,=20

# ipmitool sdr
CPU0 below Tmax  | no reading        | ns
CPU1 below Tmax  | disabled          | ns
RT3              | no reading        | ns
RT4              | no reading        | ns
RT5              | no reading        | ns
CPU0 VCORE       | no reading        | ns
CPU1 VCORE       | disabled          | ns
CPU0 VTT         | no reading        | ns
CPU1 VTT         | disabled          | ns
5V               | no reading        | ns
5V SB            | no reading        | ns
12V              | no reading        | ns
3V               | no reading        | ns
VBAT             | no reading        | ns
IOH 1.1V         | no reading        | ns
ICH 1.5V         | no reading        | ns
CPU0 DDR3 1.5V   | no reading        | ns
CPU1 DDR3 1.5V   | disabled          | ns
CPU0 FAN         | no reading        | ns
CPU1 FAN         | disabled          | ns
REAR FAN1        | no reading        | ns
REAR FAN2        | no reading        | ns
FRONT FAN1       | no reading        | ns
FRONT FAN2       | no reading        | ns
FRONT FAN3       | no reading        | ns
Power1           | no reading        | ns


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
