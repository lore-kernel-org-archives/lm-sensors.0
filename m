From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Sep 2011 13:00:59 +0000
Subject: Re: [lm-sensors] Fan Divisors and RPMS
Message-Id: <20110928150059.5d80d350@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAETpAZ7nyfwXLhULmd84yrRvSAdbOc1S0LeUfJ5TPhxe9Hd-Lw@mail.gmail.com>
In-Reply-To: <CAETpAZ7nyfwXLhULmd84yrRvSAdbOc1S0LeUfJ5TPhxe9Hd-Lw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Matthew,

On Tue, 27 Sep 2011 17:37:28 -0400, Matthew Gilbride wrote:
> Hello lm-sensor type people,
>=20
> Loving lm-sensors with Gkrellm on an Asus Rampage Gene II Model CG5290
> BP007. But am very new to Linux and am having trouble setting up fans. I
> understand lm-sensor setup, pwmconfig, and the fancontrol script to a good
> degree. I know I should be able to read/ control two fans on my system (n=
ot
> including the GPU fan). I see/ hear all fans spinning, get proper rpm
> readouts in the bios, and know my fans inside out from Everest in Windows
> Vista. However, I can only control my Chasis fan and not my CPU fan in
> Ubuntu 11.04. System details and sensors output at bottom.
>=20
> I have installed lm-sensors, run sensors-detect, tried pwmconfig-failed, =
set
> linux option in grub to GRUB_CMDLINE_LINUX=3D"showopts
> acpi_enforce_resources=3Dlax" and rerun pwmconfig-partial success. pwm1-3=
 now
> shown. Can control pwm2 no problem. Fan-divisors are all 128 and rpms are=
 0
> on all fans but pwm2. pwm2 divisor is 16.

Here you make the wrong assumption of a 1:1 mapping between fan input
numbers and PWM output numbers. This doesn't have to be the case. A
chip can have more fan inputs than outputs or vice-versa. One PWM
output can control more than one fan, and we've even seen systems where
the same fan could be controlled by two PWM outputs.

> fancontrol works fine to control
> the pwm2 fan. No ability to change divisors as suggested in older threads
> but did try in my custom sensors file in sensors.d. all set statements fa=
il
> including on the working pwm. Again, these same fans are completely
> controllable in Vista.

For the w83627ehf driver which you're using, the best fan clock divisor
is set automatically by the driver so you don't have to do it. At the
maximum value (128), if readings are still 0, that means that the
corresponding fan input isn't used on your system.

Note that for best results, you have to set a proper minimum for your
fan input, otherwise the driver's algorithm to pick the best divisor
value doesn't work well. So you should add:

   set fan2_min 4000

or similar to the relevant section of your configuration file, and
apply with "sensors -s".

>=20
> Have I skipped a major step somewhere. Is there a way I can start over and
> retry the setup?
>=20
> Many thanks in advance for help.
>=20
> Matt
>=20
>=20
> Motherboard ASUS Rampage Gene II
> Chipset
> CPU: Core i7 920
> Linux Ditro: Ubuntu 11.04
> kernel version: System-Product-Name 2.6.38-11-generic #50-Ubuntu SMP Mon =
Sep
> 12 21:17:25 UTC 2011 x86_64 x86_64 x86_64 GNU/Linux
> lm_sensors version: sensors version 3.2.0 with libsensors version 3.2.0
>=20
>=20
> Chip Drivers from Sensors-detect
>=20
> adt7475

In the output below there is no trace of a device supported by that
driver. Ah, Ubuntu. I bet that you need driver i2c-i801 and they
blacklisted it. Remove the blacklist, let the i2c-i801 driver load and
it should work. Odds are that the other fans are connected to the
ADT7473 or ADT7475 monitoring chip on your system.

And please complain to Ubuntu folks about this nonsensical blacklist,
it has been hurting a lot of people already.

> coretemp
> w83627ehf
>=20
>=20
> Sensors output
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +38.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +38.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +41.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +38.0=B0C  (high =3D +78.0=B0C, crit =3D +98.0=B0C)
>=20
> w83667hg-isa-0290
> Adapter: ISA adapter
> Vcore:       +0.92 V  (min =3D  +0.00 V, max =3D  +1.74 V)
> in1:         +1.70 V  (min =3D  +0.82 V, max =3D  +0.39 V)   ALARM
> AVCC:        +3.33 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> +3.3V:       +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> in4:         +1.66 V  (min =3D  +1.60 V, max =3D  +1.66 V)
> in5:         +2.04 V  (min =3D  +0.18 V, max =3D  +1.59 V)   ALARM
> 3VSB:        +3.39 V  (min =3D  +2.98 V, max =3D  +3.63 V)
> Vbat:        +3.31 V  (min =3D  +2.70 V, max =3D  +3.30 V)   ALARM
> fan1:          0 RPM  (min =3D 7028 RPM, div =3D 128)  ALARM
> fan2:       8880 RPM  (min =3D    0 RPM, div =3D 16)  ALARM
> fan3:          0 RPM  (min =3D 42184 RPM, div =3D 128)  ALARM
> fan4:          0 RPM  (min =3D 10544 RPM, div =3D 128)  ALARM
> fan5:          0 RPM  (min =3D 21092 RPM, div =3D 128)  ALARM
> temp1:       +32.0=B0C  (high =3D  +5.0=B0C, hyst =3D  +9.0=B0C)  ALARM  =
sensor > thermistor
> temp2:       +31.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D diode
> temp3:        +7.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor =
=3D thermistor
> cpu0_vid:   +0.000 V

At first sight I'd say you can probably add "ignore" statements for
in5, fan1, fan3, fan4, fan5, temp3 and cpu0_vid. in1 and in4 could be
configured, look at what voltage values your BIOS reports (write down
every value especially if they oscillate) and we can figure them out.

--=20
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
