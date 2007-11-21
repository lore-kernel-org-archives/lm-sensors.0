From: Moebius <moebius20@free.fr>
Date: Wed, 21 Nov 2007 18:49:13 +0000
Subject: [lm-sensors] how to choose the right sensor with an asus M2NPV-VM
Message-Id: <47447DA9.3090701@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Bonjour,
I've recently bought this config : athlon64 x2 4400+ and the asus=20
M2NPV-VM board.
There is 4 fan plugs on the board, but only two are connected, the cpu's=20
one and the power one (with just 2 wires)

Sensors-detect give me this output :

Driver `smartbatt' (should be inserted):
   Detects correctly:
   * Bus `NVIDIA i2c adapter '
     Busdriver `UNKNOWN', I2C address 0x0b
     Chip `Smart Battery' (confidence: 5)

Driver `it87' (should be inserted):
   Detects correctly:
   * ISA bus, address 0x290
     Chip `ITE IT8716F Super IO Sensors' (confidence: 9)

Driver `k8temp' (should be inserted):
   Detects correctly:
   * Chip `AMD K8 thermal sensors' (confidence: 9)

So I insert the two modules needed (it87 and k8temp)

I'm following an ubuntu tuto here (in french... ) :
http://doc.ubuntu-fr.org/materiel/sensors

Well, then I try pwmconfig and it become very difficult :

First, jit's not too bad :

Found the following devices:
    hwmon0/device is k8temp
    hwmon1/device is it8716

Found the following PWM controls:
    hwmon1/device/pwm1
    hwmon1/device/pwm2
    hwmon1/device/pwm3

Found the following fan sensors:
    hwmon1/device/fan1_input     current speed: 3082 RPM
    hwmon1/device/fan2_input     current speed: 0 ... skipping!
    hwmon1/device/fan3_input     current speed: 1646 RPM

But when I try the command sensors to see which are the cpu sensor, the=20
mb sensor ... I get something a bit confusing :

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:
               -6=B0C
Core0 Temp:
              -11=B0C
Core1 Temp:
               +5=B0C
Core1 Temp:
              -13=B0C

it8716-isa-0290
Adapter: ISA adapter
VCore:     +1.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
VDDR:      +3.31 V  (min =3D  +0.00 V, max =3D  +4.08 V)
+3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
+5V:       +4.84 V  (min =3D  +0.00 V, max =3D  +6.85 V)
+12V:     +11.46 V  (min =3D  +0.00 V, max =3D +16.32 V)
in5:       +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
in6:       +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
5VSB:      +4.73 V  (min =3D  +0.00 V, max =3D  +6.85 V)
VBat:      +2.90 V
fan1:     3096 RPM  (min =3D 3245 RPM)                   ALARM
fan2:        0 RPM  (min =3D 3245 RPM)                   ALARM
fan3:     1646 RPM  (min =3D    0 RPM)
temp1:       +16=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =3D=
 diode
temp2:       +31=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =3D=
=20
thermistor
temp3:       +25=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =3D=
=20
thermistor
vid:      +0.000 V

So I can't determine the sensor to assign the cpu fan, cause I can't see=20
which is the good cpu temperature.

I've tried to search in the list but find nothing really simple, nor in=20
the sensors.conf.eg

Well I'm a little confused, so if someone can help, it would be great

cordialement,



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
