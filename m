From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Dec 2007 10:41:14 +0000
Subject: Re: [lm-sensors] how to choose the right sensor with an asus
Message-Id: <20071202114114.7cf42951@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47447DA9.3090701@free.fr>
In-Reply-To: <47447DA9.3090701@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, 21 Nov 2007 19:49:13 +0100, Moebius wrote:
> Bonjour,
> I've recently bought this config : athlon64 x2 4400+ and the asus=20
> M2NPV-VM board.
> There is 4 fan plugs on the board, but only two are connected, the cpu's =

> one and the power one (with just 2 wires)
>=20
> Sensors-detect give me this output :
>=20
> Driver `smartbatt' (should be inserted):
>    Detects correctly:
>    * Bus `NVIDIA i2c adapter '
>      Busdriver `UNKNOWN', I2C address 0x0b
>      Chip `Smart Battery' (confidence: 5)
>=20
> Driver `it87' (should be inserted):
>    Detects correctly:
>    * ISA bus, address 0x290
>      Chip `ITE IT8716F Super IO Sensors' (confidence: 9)
>=20
> Driver `k8temp' (should be inserted):
>    Detects correctly:
>    * Chip `AMD K8 thermal sensors' (confidence: 9)
>=20
> So I insert the two modules needed (it87 and k8temp)
>=20
> I'm following an ubuntu tuto here (in french... ) :
> http://doc.ubuntu-fr.org/materiel/sensors
>=20
> Well, then I try pwmconfig and it become very difficult :
>=20
> First, jit's not too bad :
>=20
> Found the following devices:
>     hwmon0/device is k8temp
>     hwmon1/device is it8716
>=20
> Found the following PWM controls:
>     hwmon1/device/pwm1
>     hwmon1/device/pwm2
>     hwmon1/device/pwm3
>=20
> Found the following fan sensors:
>     hwmon1/device/fan1_input     current speed: 3082 RPM
>     hwmon1/device/fan2_input     current speed: 0 ... skipping!
>     hwmon1/device/fan3_input     current speed: 1646 RPM
>=20
> But when I try the command sensors to see which are the cpu sensor, the=20
> mb sensor ... I get something a bit confusing :

You're doing things the wrong way around: you should first check the
values returned by "sensors", and only when you have made sense out of
them, try to play with pwmconfig. You just can't configure fan speed
control properly it you don't know what temperature values can be
trusted and what they correspond to.

>=20
> k8temp-pci-00c3
> Adapter: PCI adapter
> Core0 Temp:
>                -6=B0C
> Core0 Temp:
>               -11=B0C
> Core1 Temp:
>                +5=B0C
> Core1 Temp:
>               -13=B0C

Recent K8 CPUs have been reported to have broken thermal diodes. This
seems to be the case for you, so there's no point in using the k8temp
driver. Blacklist it to prevent it from auto-loading.

Rudolf, is it possible to detect these CPU models by their CPUID and
exclude them from the k8temp driver? This would save a lot of user
confusion.

>=20
> it8716-isa-0290
> Adapter: ISA adapter
> VCore:     +1.02 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> VDDR:      +3.31 V  (min =3D  +0.00 V, max =3D  +4.08 V)
> +3.3V:     +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
> +5V:       +4.84 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> +12V:     +11.46 V  (min =3D  +0.00 V, max =3D +16.32 V)
> in5:       +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
> in6:       +0.00 V  (min =3D  +0.00 V, max =3D  +4.08 V)   ALARM
> 5VSB:      +4.73 V  (min =3D  +0.00 V, max =3D  +6.85 V)
> VBat:      +2.90 V
> fan1:     3096 RPM  (min =3D 3245 RPM)                   ALARM
> fan2:        0 RPM  (min =3D 3245 RPM)                   ALARM
> fan3:     1646 RPM  (min =3D    0 RPM)
> temp1:       +16=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =
=3D diode
> temp2:       +31=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =
=3D thermistor
> temp3:       +25=B0C  (low  =3D    -1=B0C, high =3D  +127=B0C)   sensor =
=3D thermistor
> vid:      +0.000 V
>=20
> So I can't determine the sensor to assign the cpu fan, cause I can't see =

> which is the good cpu temperature.

Which temperature sensor corresponds to what is motherboard-dependent.
Same for fans. The easiest way to find out which is which is to take a
look in the BIOS setup screen at boot time. The numbers should somewhat
match what you see in "sensors" and the order of the values might be a
valuable hint as well.

For voltages, it appears that in2, in5 and in6 are not wired, and +3.3V
is connected to in1, so you should tweak the it8716-* section of
sensors.conf in the following way:

   label in1 "+3.3V"
   ignore in2
   ignore in5
   ignore in6

The rest looks OK, except that +5V and +12V are a bit low - maybe the
scaling factors on your board diverge a bit compared to the standard
values. Or maybe your PSU is not sufficient for your setup. Again, a
comparison with what the BIOS displays can help.

Only once the output of "sensors" looks correct, you can try pwmconfig.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
