From: Klaus Dahlke <klaus.dahlke@gmx.de>
Date: Mon, 01 Oct 2012 20:56:56 +0000
Subject: [lm-sensors] Temperature reading too high for it87
Message-Id: <20121001225656.0e964dbe.klaus.dahlke@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Dear all,
I just put together a new PC with the following components:
mainboard: Gigabyte GA-A75M-UD2H, newest BIOS (beta)
CPU: AMD A8-3850 APU

Using lm_sensors, one temperature of the APU via it87 is shown far too high=
. The BIOS/PC Health Status (after reboot) reports basically 34=B0C and 34=
=B0C which were also the usual temparatures at my old PC when just surfing =
or doing some office stuff. But for teh new PC lm_sensors shows now for the=
 CPU a temperature of 59=B0C which is about the sum of the first temperatur=
e and the temperature in the case/housing (case has an own thermocouple). I=
t is the same behaviour with the kernel module as well as the driver from y=
our download page.

I would be happy if you could investigate a bit further to get also a corre=
ct temperature reading.

Thanks,
Klaus

Here some further details:

mb40 etc # uname -a
Linux mb40 3.4.9-gentoo #4 SMP Sun Sep 30 16:57:03 CEST 2012 x86_64 AMD A8-=
3850 APU with Radeon(tm) HD Graphics AuthenticAMD GNU/Linux

Here is the relevant output of 'sensor-detect':

Do you want to probe the I2C/SMBus adapters now? (YES/no):=20
Using driver `i2c-piix4' for device 0000:00:14.0: AMD Hudson-2 SMBus

Next adapter: SMBus PIIX4 adapter at 0b00 (i2c-0)
Do you want to scan it? (yes/NO/selectively): yes
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `it87':
  * ISA bus, address 0x228
    Chip `ITE IT8720F Super IO Sensors' (confidence: 9)

Driver `k10temp' (autoloaded):
  * Chip `AMD Family 12h and 14h thermal sensors' (confidence: 9)



sensor3.conf for it87 is
chip "it87-*" "it8712-*" "it8716-*" "it8718-*" "it8720-*"

    set temp1_type 4
    set temp2_type 4
    set temp3_type 4
    label in8 "Vbat"



output for 'sensors'
mb40 sbin # sensors -v
sensors version 3.3.2 with libsensors version 3.3.2


$ sensors
k10temp-pci-00c3
Adapter: PCI adapter
temp1:         +3.8=B0C  (high =3D +70.0=B0C)

it8720-isa-0228
Adapter: ISA adapter
in0:          +1.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in1:          +1.49 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in2:          +3.34 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+5V:          +3.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in4:          +3.09 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in5:          +2.13 V  (min =3D  +0.00 V, max =3D  +4.08 V)
in6:          +2.13 V  (min =3D  +0.00 V, max =3D  +4.08 V)
5VSB:         +2.99 V  (min =3D  +0.00 V, max =3D  +4.08 V)
Vbat:      +3.07 V =20
fan1:        1115 RPM  (min =3D   10 RPM)
fan2:        1147 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
temp1:        +34.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
temp2:        +59.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
temp3:        +13.0=B0C  (low  =3D +127.0=B0C, high =3D +70.0=B0C)  sensor =
=3D thermistor
cpu0_vid:    +0.000 V

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
