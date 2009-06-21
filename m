From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Jun 2009 07:40:23 +0000
Subject: Re: [lm-sensors] ASUS M3A78-CM
Message-Id: <20090621094023.6c2f5761@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <56834.1244762907@noxam.com>
In-Reply-To: <56834.1244762907@noxam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Martin,

On Thu, 11 Jun 2009 19:28:27 -0400, martind@noxam.com wrote:
> =20
> 	Hi all!=20
>  After couple hours... figured out the config for an ASUS M3A78-CM
>  motherboard
>  Here you go!

Thanks for your contribution. I've added it to the wiki.

>  chip "it87-*" "it8712-*"

"it87-*" can go away, as your board has an IT8712F.

>  # The values below have been tested on Asus M3A78-CM motherboards.
>      label in0 "VCore 1"

As there is a single Vcore, no need for the trailing "1".

>      ignore in1
>      label in2 "+3.3V"
>      ignore in3
>      label in4 "+12V"
>      label in5 "+5V"
>      ignore in6
>      ignore in7
>      label in8 "VBat"

You can probably add "ignore cpu0_vid" as apparently the VID inputs
aren't wired on your board.

>      compute in4 ((28/10) +1)*@  , @/((28/10) +1)
>      compute in5 @*(1+(22/10)),  @/(1+(22/10))
>      set in0_min  1.30 * 0.95
>      set in0_max  1.30 * 1.05
>      set in2_min  3.3 * 0.95
>      set in2_max  3.3 * 1.05
>      set in4_min   12 * 0.95
>      set in4_max   12 * 1.05
>      set in5_min    5 * 0.95
>      set in5_max    5 * 1.05
>      set temp1_type 2
>      set temp2_type 2

Do you really need to change the temperature sensor types? In most
cases the BIOS does it correctly and you don't need to change them.

>      set temp3_type 3
>      ignore temp3

It makes little sense to change the type of a sensor you're going to
ignore right away, does it?

>      label temp1       "CPU Temp"
>      label temp2       "M/B Temp"
>  _____________________________________
>  remove everything else!

This lacks labels for the fan inputs.

>  here is the output from sensors:
>  frodo:/sys/class/hwmon/hwmon1/device # sensors
>  atk0110-acpi-0

Hmm, that's odd. Normally you shouldn't use both the ACPI interface to
the monitoring chip and the native driver, they are very likely to
collide at some point. The BIOS should have reserved the I/O region for
ACPI and the it87 driver shouldn't be allowed to access it. Which
kernel are you running?

>  Adapter: ACPI interface
>  Vcore Voltage:     +1.30 V  (min =3D  +0.85 V, max =3D  +1.60 V)
>   +3.3 Voltage:     +3.28 V  (min =3D  +2.97 V, max =3D  +3.63 V)
>   +5 Voltage:       +4.97 V  (min =3D  +4.50 V, max =3D  +5.50 V)
>   +12 Voltage:     +12.22 V  (min =3D +10.20 V, max =3D +13.80 V)
>  CPU FAN Speed:    2295 RPM  (min =3D  600 RPM)
>  CHASSIS FAN Speed:   0 RPM  (min =3D  600 RPM)
>  POWER FAN Speed:  1313 RPM  (min =3D  600 RPM)
>  CPU Temperature:   +48.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
>  MB Temperature:    +35.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0C)
>  it8712-isa-0290
>  Adapter: ISA adapter
>  VCore 1:     +1.30 V  (min =3D  +1.23 V, max =3D  +1.36 V)
>  +3.3V:       +3.28 V  (min =3D  +3.14 V, max =3D  +3.47 V)
>  +12V:       +12.22 V  (min =3D +11.37 V, max =3D +12.59 V)
>  +5V:         +4.97 V  (min =3D  +4.76 V, max =3D  +5.27 V)
>  VBat:        +3.20 V
>  fan1:       2295 RPM  (min =3D    0 RPM)
>  fan2:          0 RPM  (min =3D    0 RPM)
>  fan3:       1313 RPM  (min =3D    0 RPM)
>  CPU Temp:    +48.0=B0C  (low  =3D  -1.0=B0C, high =3D  -5.0=B0C)   senso=
r =3D thermistor
>  M/B Temp:    +35.0=B0C  (low  =3D  -1.0=B0C, high =3D +127.0=B0C)   sens=
or =3D thermistor

You should set temperature limits as well.

>  cpu0_vid:   +1.550 V
>  frodo:/sys/class/hwmon/hwmon1/device #
>  Best Regards
>  Martin Desormeaux
>  a.k.a Neo2048


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
