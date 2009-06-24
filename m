From: Konstantin Kletschke <konsti@ku-gbr.de>
Date: Wed, 24 Jun 2009 09:47:38 +0000
Subject: [lm-sensors] HowTo Asus P5Q, W83667HG vs ATK0110 - fancontrol
Message-Id: <20090624094735.GA16670@punzenstreichler.doom>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Folks!

Recently I wanted to add userspace control of my CPU fan on
my Asus P5Q and due to this not working, I stumbled upon this:

http://ubuntuforums.org/showpost.php?s=F2405c8983cbae7023fde7333fce3e05&ph1=
6455&postcount=3D6

The Chip on the Board is an W83667HG-A with id 0xa513 as sensors-detect
says:

Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0xa513
    (logical device B has address 0x290, could be sensors)

The effort done in=20

http://thread.gmane.org/gmane.linux.drivers.sensors/17253

Yields to an almost reasonable sensors output:

w83667hg-isa-0290
Adapter: ISA adapter
in0:         +1.02 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:         +1.76 V  (min =3D  +0.90 V, max =3D  +0.05 V)   ALARM
in2:         +3.31 V  (min =3D  +3.95 V, max =3D  +0.26 V)   ALARM
in3:         +3.28 V  (min =3D  +3.20 V, max =3D  +2.37 V)   ALARM
in4:         +1.69 V  (min =3D  +0.64 V, max =3D  +0.55 V)   ALARM
in5:         +2.04 V  (min =3D  +1.10 V, max =3D  +1.42 V)   ALARM
in7:         +3.39 V  (min =3D  +0.06 V, max =3D  +2.18 V)   ALARM
in8:         +3.28 V  (min =3D  +3.66 V, max =3D  +0.32 V)   ALARM
fan1:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
fan2:        534 RPM  (min =3D 2163 RPM, div =3D 16)  ALARM
fan3:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
fan4:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
fan5:          0 RPM  (min =3D 10546 RPM, div =3D 128)  ALARM
temp1:       +44.0=B0C  (high =3D -112.0=B0C, hyst =3D -123.0=B0C)  ALARM  =
sensor =3D thermistor
temp2:       +40.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
temp3:        +5.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
cpu0_vid:   +2.700 V

insmod:

w83627ehf: Found W83667HG chip at 0x290
w83627ehf w83627ehf.656: Increasing fan1 clock divider from 32 to 64
w83627ehf w83627ehf.656: Increasing fan1 clock divider from 64 to 128

It is not possible to change the pwm of the CPU fan. Changing the value
of pwm2 results in changing pwm1. May be this is only a little tiny
offset in the amounts of pwms or another tiny little bit missing.
Is there any change to get a datasheet of this chip or can somebody
provide one?

> cat pwm1 pwm2 pwm3
66
55
255

> echo "77" >> pwm2

> cat pwm1 pwm2 pwm3
77
55
255

On my investigation I discovered some sort of acpi based atk0110 driver
for the asus boards, which works fine so far.=20

ATK0110 ATK0110:00: adding...
ATK0110 ATK0110:00: board ID =3D P5Q
ATK0110 ATK0110:00: Using old hwmon interface
ATK0110 ATK0110:00: voltage: 0x6020000 Vcore Voltage [800-1600] enabled
ATK0110 ATK0110:00: voltage: 0x6020001  +3.3 Voltage [2970-3630] enabled
ATK0110 ATK0110:00: voltage: 0x6020002  +5 Voltage [4500-5500] enabled
ATK0110 ATK0110:00: voltage: 0x6020003  +12 Voltage [10200-13800] enabled
ATK0110 ATK0110:00: temperature: 0x6030000 CPU Temperature [600-950] enabled
ATK0110 ATK0110:00: temperature: 0x6030001 MB Temperature [450-950] enabled
ATK0110 ATK0110:00: fan: 0x6040000 CPU FAN Speed [600-7200] enabled
ATK0110 ATK0110:00: fan: 0x6040001 CHASSIS1 FAN Speed [600-7200] enabled
ATK0110 ATK0110:00: fan: 0x6040002 CHASSIS2 FAN Speed [600-7200] enabled
ATK0110 ATK0110:00: fan: 0x6040003 POWER FAN Speed [600-7200] enabled
ATK0110 ATK0110:00: registering hwmon device
ATK0110 ATK0110:00: populating sysfs directory

The readings from fan1_[input|label] are reasonable:

> cat fan1_input fan1_label
534
CPU FAN Speed

Can fan pwm value controlled with this driver?

Does lm_sensors-3.1.0 still need to be patched to acces this driver?

Kind Regards, Konsti



--=20
GPG KeyID EF62FCEF
Fingerprint: 13C9 B16B 9844 EC15 CC2E  A080 1E69 3FDA EF62 FCEF

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
