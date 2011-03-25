From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 25 Mar 2011 10:35:25 +0000
Subject: Re: [lm-sensors] Supermicro H8QM3-2 Sensors
Message-Id: <20110325113525.34a11cdf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU162-w49C9794A5AF1DB1F22A98A93B60@phx.gbl>
In-Reply-To: <BLU162-w49C9794A5AF1DB1F22A98A93B60@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Keith,

Please always reply to the list.

On Thu, 24 Mar 2011 23:55:18 +0000, KEITH ROMBERG wrote:
> # sensors-detect=20
> # sensors-detect revision 5861 (2010-09-21 17:21:05 +0200)
> # System: Supermicro H8QM3
> (...)
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:=20
>=20
> Driver `adt7475':
>   * Bus `NVIDIA i2c adapter '
>     Busdriver `nvidia', I2C address 0x2e
>     Chip `Analog Devices ADT7473' (confidence: 5)
>=20
> Driver `w83793':
>   * Bus `SMBus nForce2 adapter at 2e00'
>     Busdriver `i2c_nforce2', I2C address 0x2f (and 0x4b 0x4f)
>     Chip `Winbond W83793R/G' (confidence: 8)

Exactly as I expected.

>=20
> Driver `w83627hf':
>   * ISA bus, address 0x290
>     Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)
>=20
> (...)
> [root@glaurung bin]# sensors
> w83627hf-isa-0290
> Adapter: ISA adapter
> in0:         +4.08 V  (min =3D  +0.00 V, max =3D  +4.08 V)  =20
> in1:         +4.08 V  (min =3D  +2.96 V, max =3D  +3.62 V)   ALARM
> in2:         +4.08 V  (min =3D  +2.96 V, max =3D  +3.62 V)   ALARM
> in3:         +2.96 V  (min =3D  +2.67 V, max =3D  +3.26 V)  =20
> in4:         +3.09 V  (min =3D  +2.83 V, max =3D  +3.47 V)  =20
> in5:         +3.17 V  (min =3D  +0.42 V, max =3D  +0.86 V)   ALARM
> in6:         +3.25 V  (min =3D  +4.08 V, max =3D  +4.08 V)   ALARM
> in7:         +3.23 V  (min =3D  +1.87 V, max =3D  +3.74 V)  =20
> in8:         +3.15 V  (min =3D  +4.08 V, max =3D  +4.08 V)   ALARM
> fan1:          0 RPM  (min =3D  712 RPM, div =3D 8)  ALARM
> fan2:          0 RPM  (min =3D  712 RPM, div =3D 8)  ALARM
> fan3:          0 RPM  (min =3D    0 RPM, div =3D 2)
> temp1:       -48.0=B0C  (high =3D +120.0=B0C, hyst =3D +115.0=B0C)  senso=
r =3D thermistor
> temp2:       -48.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> temp3:       -48.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> cpu0_vid:   +0.775 V
> beep_enable:enabled

The sensors-detect script couldn't guess, but the W83627HF is
essentially unused as far as hardware monitoring is concerned, so you
can stop loading the w83627hf driver (remove it
from /etc/sysconfig/lm_sensors.) The w83793 below has everything you
need for monitoring.

>=20
> w83793-i2c-3-2f
> Adapter: SMBus nForce2 adapter at 2e00
> VcoreA:      +1.21 V  (min =3D  +1.07 V, max =3D  +1.62 V)  =20
> VcoreB:      +1.21 V  (min =3D  +1.07 V, max =3D  +1.62 V)  =20

Vcore of CPU1 and CPU2, respectively

> in2:         +0.00 V  (min =3D  +0.00 V, max =3D  +2.05 V)  =20

Apparently unused.

> in3:         +1.18 V  (min =3D  +1.07 V, max =3D  +1.62 V)  =20
> in4:         +1.20 V  (min =3D  +1.07 V, max =3D  +1.62 V)  =20

Vcore of CPU4 and CPU3, respectively

> in5:         +3.28 V  (min =3D  +2.96 V, max =3D  +3.63 V)  =20

+3.3V

> in6:         +0.97 V  (min =3D  +0.90 V, max =3D  +1.10 V)  =20

+12V, missing scaling factor (probably *12).

> +5V:         +4.85 V  (min =3D  +4.52 V, max =3D  +5.50 V)  =20
> 5VSB:        +4.95 V  (min =3D  +4.52 V, max =3D  +5.50 V)  =20
> Vbat:        +3.14 V  (min =3D  +2.70 V, max =3D  +3.30 V)  =20
> fan1:          0 RPM  (min =3D  712 RPM)  ALARM
> fan2:          0 RPM  (min =3D  712 RPM)  ALARM
> fan3:       3125 RPM  (min =3D  712 RPM)
> fan4:       2415 RPM  (min =3D  712 RPM)

These are CPU2 and CPU1 fans, respectively.

> fan5:          0 RPM  (min =3D  712 RPM)  ALARM
> fan6:          0 RPM  (min =3D  712 RPM)  ALARM
> fan7:          0 RPM  (min =3D  712 RPM)  ALARM
> fan8:          0 RPM  (min =3D  712 RPM)  ALARM

These are CPU4 and CPU3 fans, respectively. Apparently you have no fans
on these?

> fan9:          0 RPM  (min =3D  712 RPM)  ALARM
> temp1:       +11.8=B0C  (high =3D +72.0=B0C, hyst =3D +67.0=B0C)  sensor =
=3D thermal diode
> temp2:       +12.8=B0C  (high =3D +72.0=B0C, hyst =3D +67.0=B0C)  sensor =
=3D thermal diode
> temp3:        +2.2=B0C  (high =3D +72.0=B0C, hyst =3D +67.0=B0C)  sensor =
=3D thermal diode
> temp4:        -0.8=B0C  (high =3D +72.0=B0C, hyst =3D +67.0=B0C)  sensor =
=3D thermal diode

These are supposed to the the 4 CPU temperatures. Odd.

> temp5:       +63.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor

System temperature according to Supermicro.

> temp6:       +80.0=B0C  (high =3D +100.0=B0C, hyst =3D +95.0=B0C)  sensor=
 =3D thermistor

Undocumented, no idea if it is real.

> beep_enable:disabled

Here's the configuration section you should use:

chip "w83793-i2c-*-2f"

   # Voltages
   label  in0  "Vcore1"
   label  in1  "Vcore2"
   ignore in2
   label  in3  "Vcore4"
   label  in4  "Vcore3"
   label  in5  "+3.3V"
   label  in6  "+12V"

   compute  in6  @*12, @/12

   # Fans
   label  fan3  "CPU2 Fan"
   label  fan4  "CPU1 Fan"
   label  fan7  "CPU4 Fan"
   label  fan8  "CPU3 Fan"

   # Temperatures
   label  temp1  "CPU1 Temp"
   label  temp2  "CPU2 Temp"
   label  temp3  "CPU4 Temp"
   label  temp4  "CPU3 Temp"
   label  temp5  "Sys Temp"

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
