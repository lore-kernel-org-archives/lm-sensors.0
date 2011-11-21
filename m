From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Nov 2011 21:38:33 +0000
Subject: Re: [lm-sensors] [PATCH] Drivers: hwmon: it87: Add support for ITE
Message-Id: <20111121223833.3e0a9693@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
In-Reply-To: <1320381858.22997.YahooMailNeo@web161601.mail.bf1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Gustavo,

On Mon, 14 Nov 2011 19:14:16 -0200, Gustavo De Nardin (spuk) wrote:
> > On Fri, 2011-11-04 at 00:44 -0400, Frank T. Lofaro Jr. wrote:
> > > This patch allows the ITE 8728 chip to be detected and used.
> > > The chip appears to be compatible with the 8721.
> >=20
> > Can anyone confirm that those chips are actually compatible ?
>=20
> Unlike forcing the other chips' ids, with force_id=3D0x8721 PWM control s=
eems
> to work reasonably, with pwm1_enable=3D1, pwm1=3D0 yields around 1132 RPM=
 on the
> CPU fan, and pwm1=3D255 yields around 3260 RPM.  Should pwm1=3D0 actually=
 stop
> the fan?  I get what (empirically) seem to be consistent logarithmic
> increase in RPM when increasing pwm1 value, anyway.
>=20
> But the sensors values read with 'it87 force_id=3D0x8721' don't seem ok, =
I get
> this (first 'it87 force_id=3D0x8721', then 'asus_atk0110 new_if=3D1', whi=
ch
> seems to provide good readings):
>=20
> it8721-isa-0290
> Adapter: ISA adapter
> in0:          +0.95 V  (min =3D  +2.78 V, max =3D  +1.14 V)  ALARM
> in1:          +1.50 V  (min =3D  +0.00 V, max =3D  +3.01 V)
> in2:          +1.88 V  (min =3D  +2.66 V, max =3D  +2.27 V)  ALARM
> in3:          +2.05 V  (min =3D  +2.68 V, max =3D  +0.67 V)  ALARM
> in4:          +2.03 V  (min =3D  +3.04 V, max =3D  +1.42 V)  ALARM
> in5:          +3.05 V  (min =3D  +3.04 V, max =3D  +3.01 V)  ALARM
> in6:          +2.05 V  (min =3D  +2.77 V, max =3D  +1.87 V)  ALARM
> 3VSB:         +6.07 V  (min =3D  +1.10 V, max =3D  +4.56 V)  ALARM
> Vbat:         +3.34 V
> fan1:        3292 RPM  (min =3D   10 RPM)
> fan2:           0 RPM  (min =3D   10 RPM)  ALARM
> fan3:           0 RPM  (min =3D   13 RPM)  ALARM
> temp1:        +33.0=B0C  (low  =3D -65.0=B0C, high =3D -10.0=B0C)  sensor=
 =3D thermistor
> temp2:        +40.0=B0C  (low  =3D -19.0=B0C, high =3D +127.0=B0C)  senso=
r =3D
> thermistor
> temp3:       -128.0=B0C  (low  =3D +119.0=B0C, high =3D  -2.0=B0C)  senso=
r =3D disabled
> intrusion0:  OK
>=20
> atk0110-acpi-0
> Adapter: ACPI interface
> Vcore Voltage:      +0.95 V  (min =3D  +0.80 V, max =3D  +1.60 V)
> +3.3V Voltage:      +3.34 V  (min =3D  +2.97 V, max =3D  +3.63 V)
> +5V Voltage:        +5.13 V  (min =3D  +4.50 V, max =3D  +5.50 V)
> +12V Voltage:      +12.11 V  (min =3D +10.20 V, max =3D +13.80 V)

According to the DSDT code, these are in0, in4, in3 and in2, in this
order. So we can start with:

chip "it8728-isa-0290"

   label  in0  "Vcore"
   label  in2  "+12V"
   label  in3  "+5V"
   label  in4  "+3.3V"

Then the DSDT table gives the the following scaling factors, in order:
(0+1)/1, (0x0289+0x03E8)/0x03E8, (0x0F+0x0A)/0x0A and
(0xFF+0x2F)/0x2F. This translates to:

   compute in2  @ * ( 302/  82), @ / ( 302/  47)
   compute in3  @ * (  25/  10), @ / (  25/  10)
   compute in4  @ * (1649/1000), @ / (1649/1000)

in1 could be the south bridge or memory voltage (I doubt the BIOS
prints it? If you can over- or under-clock the memory voltage, that's
one way to know.) in5 is probably unused (too close from the ADC's
limit). in6 seems to be scaled down to around 2V, so it could be -12V
or 5VSB.

   ignore in5

Then, while Vbat is reasonable, 3VSB is not. The driver applies a
scaling factor of 2 that was correct for the IT8721F, but doesn't work
for you.

> CPU Fan Speed:     3276 RPM  (min =3D  600 RPM)
> Chassis Fan Speed:    0 RPM  (min =3D  600 RPM)

Obviously the first one is fan1, and I have no reason to believe the
second isn't fan2.

   label  fan1  "CPU Fan"
   label  fan2  "Chassis Fan"

> CPU Temperature:    +33.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
> MB Temperature:     +40.0=B0C  (high =3D +45.0=B0C, crit =3D +75.0=B0C)

Obviously these are temp1 and temp2:

   label  temp1  "CPU Temp"
   label  temp2  "M/B Temp"

So all in all this means that the IT8728F indeed appears to be
compatible with the IT8721F, except for the 3VSB scaling factor (or
3VSB is incorrect on your system.) I guess we can solve this problem
later as we gather more information from several boards. Obviously,
best would be to get a datasheet, but apparently it's not going to
happen.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
